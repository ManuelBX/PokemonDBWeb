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
                SELECT Id, Name, Type, Category, Power, Accuracy, PP, Description 
                FROM Moves 
                ORDER BY Name";

            var moves = await connection.QueryAsync<PokemonMove>(query);

            return moves.AsList();
        }

        public async Task<List<PokemonMove>> GetMovesByTypeAsync(string type)
        {
            using var connection = _connectionFactory.CreateConnection();

            var query = @"
                SELECT Id, Name, Type, Category, Power, Accuracy, PP, Description 
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
                SELECT Id, Name, Type, Category, Power, Accuracy, PP, Description 
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
                SELECT p.Id, p.Name, p.PokedexNumber, p.Generation, p.PrimaryType, p.SecondaryType, p.ImageUrl
                FROM Pokemon p
                JOIN PokemonMoves pm ON p.Id = pm.PokemonId
                JOIN Moves m ON pm.MoveId = m.Id
                WHERE m.Name = @MoveName
                ORDER BY p.PokedexNumber";

            var pokemon = await connection.QueryAsync<Pokemon>(query, new { MoveName = moveName });

            return pokemon.AsList();
        }
    }
}