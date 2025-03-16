using System.Collections.Generic;
using System.Threading.Tasks;
using Dapper;
using PokeDex.Models;

namespace PokeDex.Services
{
    public interface IAbilityService
    {
        Task<List<PokemonAbility>> GetAllAbilitiesAsync();
        Task<PokemonAbility> GetAbilityByNameAsync(string name);
        Task<List<Pokemon>> GetPokemonByAbilityAsync(string abilityName);
    }

    public class AbilityService : IAbilityService
    {
        private readonly IDatabaseConnectionFactory _connectionFactory;

        public AbilityService(IDatabaseConnectionFactory connectionFactory)
        {
            _connectionFactory = connectionFactory;
        }

        public async Task<List<PokemonAbility>> GetAllAbilitiesAsync()
        {
            using var connection = _connectionFactory.CreateConnection();

            var query = @"
                SELECT Id, Name, Description 
                FROM Abilities 
                ORDER BY Name";

            var abilities = await connection.QueryAsync<PokemonAbility>(query);

            return abilities.AsList();
        }

        public async Task<PokemonAbility> GetAbilityByNameAsync(string name)
        {
            using var connection = _connectionFactory.CreateConnection();

            var query = @"
                SELECT Id, Name, Description 
                FROM Abilities 
                WHERE Name = @Name";

            var ability = await connection.QueryFirstOrDefaultAsync<PokemonAbility>(query, new { Name = name });

            return ability;
        }

        public async Task<List<Pokemon>> GetPokemonByAbilityAsync(string abilityName)
        {
            using var connection = _connectionFactory.CreateConnection();

            var query = @"
                SELECT p.Id, p.Name, p.PokedexNumber, p.Generation, p.PrimaryType, p.SecondaryType, p.ImageUrl, pa.IsHidden
                FROM Pokemon p
                JOIN PokemonAbilities pa ON p.Id = pa.PokemonId
                JOIN Abilities a ON pa.AbilityId = a.Id
                WHERE a.Name = @AbilityName
                ORDER BY p.PokedexNumber";

            var pokemon = await connection.QueryAsync<dynamic>(query, new { AbilityName = abilityName });

            var result = new List<Pokemon>();

            foreach (var row in pokemon)
            {
                var poke = new Pokemon
                {
                    Id = row.Id,
                    Name = row.Name,
                    PokedexNumber = row.PokedexNumber,
                    Generation = row.Generation,
                    PrimaryType = row.PrimaryType,
                    SecondaryType = row.SecondaryType,
                    ImageUrl = row.ImageUrl,
                    Abilities = new List<PokemonAbility>
                    {
                        new PokemonAbility
                        {
                            Name = abilityName,
                            IsHidden = row.IsHidden
                        }
                    }
                };

                result.Add(poke);
            }

            return result;
        }
    }
}