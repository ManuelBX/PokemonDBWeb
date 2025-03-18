using System.Collections.Generic;
using System.Threading.Tasks;
using Dapper;
using PokeDex.Models;

namespace PokeDex.Services
{
    public interface IMoveService
    {
        Task<List<PokemonMove>> GetAllMovesAsync();
        Task<List<PokemonMove>> GetMovesByTypeAsync(string type);
        Task<List<PokemonMove>> GetMovesByCategoryAsync(string category);
        Task<List<Pokemon>> GetPokemonByMoveAsync(string moveName);
    }

    public class MoveService : IMoveService
    {
        private readonly IDatabaseConnectionFactory _connectionFactory;

        public MoveService(IDatabaseConnectionFactory connectionFactory)
        {
            _connectionFactory = connectionFactory;
        }

        public async Task<List<PokemonMove>> GetAllMovesAsync()
        {
            using var connection = _connectionFactory.CreateConnection();

            var query = @"
                SELECT Name, Type, Category, Power, Accuracy, PP 
                FROM Moves 
                ORDER BY Name";

            var moves = await connection.QueryAsync<PokemonMove>(query);

            return moves.AsList();
        }

        public async Task<List<PokemonMove>> GetMovesByTypeAsync(string type)
        {
            using var connection = _connectionFactory.CreateConnection();

            var query = @"
                SELECT Name, Type, Category, Power, Accuracy, PP 
                FROM Moves 
                WHERE Type = @Type 
                ORDER BY Name";

            var moves = await connection.QueryAsync<PokemonMove>(query, new { Type = type });

            return moves.AsList();
        }

        public async Task<List<PokemonMove>> GetMovesByCategoryAsync(string category)
        {
            using var connection = _connectionFactory.CreateConnection();

            var query = @"
                SELECT Name, Type, Category, Power, Accuracy, PP 
                FROM Moves 
                WHERE Category = @Category 
                ORDER BY Name";

            var moves = await connection.QueryAsync<PokemonMove>(query, new { Category = category });

            return moves.AsList();
        }

        public async Task<List<Pokemon>> GetPokemonByMoveAsync(string moveName)
        {
            using var connection = _connectionFactory.CreateConnection();
            var query = @"
                SELECT
                    pd.Dex_Num AS DexNum,
                    pd.Name AS DexName,
                    pd.Regional_Form AS RegionalForm,
                    pk.Type1,
                    pk.Type2,
                    pk.Height,
                    pk.Weight
                FROM PokeDex pd
                JOIN Pokemon pk ON pd.Id = pk.Pokemon_Id
                JOIN LearnSet ls ON pk.Pokemon_Id = ls.Pokemon_Id
                JOIN Moves m ON ls.Move = m.Name
                WHERE m.Name = @MoveName
                ORDER BY pd.Dex_Num;
            ";

            var data = await connection.QueryAsync(query, new { MoveName = moveName });
            var result = new List<Pokemon>();

            foreach (var row in data)
            {
                result.Add(new Pokemon
                {
                    Id = row.DexNum,
                    Name = row.DexName,
                    PokedexNumber = row.DexNum,
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