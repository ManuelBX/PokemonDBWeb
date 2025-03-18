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
                SELECT Name, Description 
                FROM Abilities 
                ORDER BY Name";

            var abilities = await connection.QueryAsync<PokemonAbility>(query);

            return abilities.AsList();
        }

        public async Task<PokemonAbility> GetAbilityByNameAsync(string name)
        {
            using var connection = _connectionFactory.CreateConnection();

            var query = @"
                SELECT Name, Description 
                FROM Abilities 
                WHERE Name = @Name";

            var ability = await connection.QueryFirstOrDefaultAsync<PokemonAbility>(query, new { Name = name });

            return ability;
        }

        public async Task<List<Pokemon>> GetPokemonByAbilityAsync(string abilityName)
        {
            using var connection = _connectionFactory.CreateConnection();
            var query = @"
                SELECT
                    pd.Dex_Num,
                    pd.Name AS DexName,
                    pd.Regional_Form AS RegionalForm,
                    pk.Type1,
                    pk.Type2,
                    pk.Height,
                    pk.Weight
                FROM PokeDex pd
                JOIN Pokemon pk ON pd.Id = pk.Pokemon_Id
                WHERE pk.Ability1 = @AbilityName
                   OR pk.Ability2 = @AbilityName
                   OR pk.Ability3 = @AbilityName
                ORDER BY pd.Dex_Num;
            ";

            var data = await connection.QueryAsync(query, new { AbilityName = abilityName });
            var result = new List<Pokemon>();
            foreach (var row in data)
            {
                result.Add(new Pokemon
                {
                    Id = row.Dex_Num,
                    Name = row.DexName,
                    PokedexNumber = row.Dex_Num,
                    RegionalForm = row.RegionalForm,
                    PrimaryType = row.Type1,
                    SecondaryType = row.Type2,
                    Height = row.Height,
                    Weight = row.Weight
                });
            }
            return result;
        }
    }
}