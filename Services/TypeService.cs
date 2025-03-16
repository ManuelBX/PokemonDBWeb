using System.Collections.Generic;
using System.Threading.Tasks;
using System.Linq;
using Dapper;
using PokeDex.Models;

namespace PokeDex.Services
{
    public interface ITypeService
    {
        Task<List<TypeEffectiveness>> GetTypeEffectivenessChartAsync();
        Task<List<TypeEffectiveness>> GetTypeEffectivenessForPokemonAsync(int pokemonId);
        Task<Dictionary<string, double>> CalculateTypeEffectivenessAgainstPokemonAsync(int pokemonId);
    }

    public class TypeService : ITypeService
    {
        private readonly IDatabaseConnectionFactory _connectionFactory;

        public TypeService(IDatabaseConnectionFactory connectionFactory)
        {
            _connectionFactory = connectionFactory;
        }

        public async Task<List<TypeEffectiveness>> GetTypeEffectivenessChartAsync()
        {
            using var connection = _connectionFactory.CreateConnection();

            var query = @"
                SELECT AttackingType, DefendingType, Multiplier
                FROM TypeEffectiveness";

            var effectiveness = await connection.QueryAsync<TypeEffectiveness>(query);

            return effectiveness.AsList();
        }

        public async Task<List<TypeEffectiveness>> GetTypeEffectivenessForPokemonAsync(int pokemonId)
        {
            using var connection = _connectionFactory.CreateConnection();

            var query = @"
                SELECT te.AttackingType, te.DefendingType, te.Multiplier
                FROM TypeEffectiveness te
                JOIN Pokemon p ON te.DefendingType = p.PrimaryType OR te.DefendingType = p.SecondaryType
                WHERE p.Id = @PokemonId AND p.SecondaryType IS NOT NULL
                UNION
                SELECT te.AttackingType, te.DefendingType, te.Multiplier
                FROM TypeEffectiveness te
                JOIN Pokemon p ON te.DefendingType = p.PrimaryType
                WHERE p.Id = @PokemonId AND p.SecondaryType IS NULL";

            var effectiveness = await connection.QueryAsync<TypeEffectiveness>(query, new { PokemonId = pokemonId });

            return effectiveness.AsList();
        }

        public async Task<Dictionary<string, double>> CalculateTypeEffectivenessAgainstPokemonAsync(int pokemonId)
        {
            using var connection = _connectionFactory.CreateConnection();

            // Get Pokemon's types
            var pokemonQuery = @"
                SELECT PrimaryType, SecondaryType
                FROM Pokemon
                WHERE Id = @PokemonId";

            var pokemon = await connection.QueryFirstOrDefaultAsync<dynamic>(pokemonQuery, new { PokemonId = pokemonId });

            if (pokemon == null)
                return new Dictionary<string, double>();

            // Get type effectiveness for primary type
            var primaryEffectivenessQuery = @"
                SELECT AttackingType, Multiplier
                FROM TypeEffectiveness
                WHERE DefendingType = @DefendingType";

            var primaryEffectiveness = await connection.QueryAsync<dynamic>(
                primaryEffectivenessQuery,
                new { DefendingType = pokemon.PrimaryType });

            var result = primaryEffectiveness
                .ToDictionary(
                    x => (string)x.AttackingType,
                    x => (double)x.Multiplier
                );

            // If pokemon has secondary type, multiply effectiveness
            if (pokemon.SecondaryType != null)
            {
                var secondaryEffectivenessQuery = @"
                    SELECT AttackingType, Multiplier
                    FROM TypeEffectiveness
                    WHERE DefendingType = @DefendingType";

                var secondaryEffectiveness = await connection.QueryAsync<dynamic>(
                    secondaryEffectivenessQuery,
                    new { DefendingType = pokemon.SecondaryType });

                foreach (var effectiveness in secondaryEffectiveness)
                {
                    string attackingType = effectiveness.AttackingType;
                    double multiplier = effectiveness.Multiplier;

                    if (result.ContainsKey(attackingType))
                    {
                        result[attackingType] *= multiplier;
                    }
                }
            }

            return result;
        }
    }
}