using System.Collections.Generic;
using System.Threading.Tasks;
using System.Linq;
using Dapper;
using PokeDex.Models;

namespace PokeDex.Services
{
    public interface IEvolutionService
    {
        Task<EvolutionInfo> GetEvolutionChainByPokemonIdAsync(int pokemonId);
        Task<List<Pokemon>> GetPokemonByEvolutionConditionAsync(string condition);
        Task<List<EvolutionItem>> GetAllEvolutionItemsAsync();
        Task<List<Pokemon>> GetPokemonByEvolutionItemAsync(string itemName);
    }

    public class EvolutionService : IEvolutionService
    {
        private readonly IDatabaseConnectionFactory _connectionFactory;

        public EvolutionService(IDatabaseConnectionFactory connectionFactory)
        {
            _connectionFactory = connectionFactory;
        }

        public async Task<EvolutionInfo> GetEvolutionChainByPokemonIdAsync(int pokemonId)
        {
            using var connection = _connectionFactory.CreateConnection();

            // First get the evolution chain ID for this pokemon
            var chainIdQuery = @"
                SELECT ec.Id
                FROM EvolutionChains ec
                JOIN PokemonEvolutionChains pec ON ec.Id = pec.EvolutionChainId
                WHERE pec.PokemonId = @PokemonId";

            var chainId = await connection.QueryFirstOrDefaultAsync<int?>(chainIdQuery, new { PokemonId = pokemonId });

            if (!chainId.HasValue)
                return null;

            // Then get all pokemon in the evolution chain
            var pokemonQuery = @"
                SELECT p.Id, p.Name, p.ImageUrl
                FROM Pokemon p
                JOIN PokemonEvolutionChains pec ON p.Id = pec.PokemonId
                WHERE pec.EvolutionChainId = @ChainId
                ORDER BY p.PokedexNumber";

            var pokemonInChain = await connection.QueryAsync<dynamic>(pokemonQuery, new { ChainId = chainId.Value });

            // Get evolution methods
            var evolutionsQuery = @"
                SELECT FromPokemonId, ToPokemonId, Method, Condition, MinLevel, Item, TimeOfDay, Location
                FROM EvolutionMethods
                WHERE FromPokemonId IN @PokemonIds";

            var pokemonIds = pokemonInChain.Select(p => (int)p.Id).ToArray();
            var evolutions = await connection.QueryAsync<dynamic>(evolutionsQuery, new { PokemonIds = pokemonIds });

            // Build evolution tree
            var result = new EvolutionInfo
            {
                ChainId = chainId.Value,
                Chain = new List<EvolutionStage>()
            };

            foreach (var pokemon in pokemonInChain)
            {
                var stage = new EvolutionStage
                {
                    PokemonId = pokemon.Id,
                    PokemonName = pokemon.Name,
                    ImageUrl = pokemon.ImageUrl,
                    EvolvesTo = new List<EvolutionMethod>()
                };

                foreach (var evolution in evolutions.Where(e => e.FromPokemonId == (int)pokemon.Id))
                {
                    var toPokemon = pokemonInChain.FirstOrDefault(p => p.Id == (int)evolution.ToPokemonId);

                    if (toPokemon != null)
                    {
                        stage.EvolvesTo.Add(new EvolutionMethod
                        {
                            ToPokemonId = evolution.ToPokemonId,
                            ToPokemonName = toPokemon.Name,
                            ImageUrl = toPokemon.ImageUrl,
                            Method = evolution.Method,
                            Condition = evolution.Condition,
                            MinLevel = evolution.MinLevel,
                            Item = evolution.Item,
                            TimeOfDay = evolution.TimeOfDay,
                            Location = evolution.Location
                        });
                    }
                }

                result.Chain.Add(stage);
            }

            return result;
        }

        public async Task<List<Pokemon>> GetPokemonByEvolutionConditionAsync(string condition)
        {
            using var connection = _connectionFactory.CreateConnection();

            var query = @"
                SELECT p.Id, p.Name, p.PokedexNumber, p.Generation, p.PrimaryType, p.SecondaryType, p.ImageUrl
                FROM Pokemon p
                JOIN EvolutionMethods em ON p.Id = em.FromPokemonId
                WHERE em.Condition LIKE @Condition
                ORDER BY p.PokedexNumber";

            var pokemon = await connection.QueryAsync<Pokemon>(query, new { Condition = $"%{condition}%" });

            return pokemon.AsList();
        }

        public async Task<List<EvolutionItem>> GetAllEvolutionItemsAsync()
        {
            using var connection = _connectionFactory.CreateConnection();

            var query = @"
                SELECT Id, Name, Description, ImageUrl
                FROM Items
                WHERE IsEvolutionItem = 1
                ORDER BY Name";

            var items = await connection.QueryAsync<EvolutionItem>(query);

            foreach (var item in items)
            {
                var usesQuery = @"
                    SELECT DISTINCT p.Name
                    FROM Pokemon p
                    JOIN EvolutionMethods em ON p.Id = em.FromPokemonId
                    WHERE em.Item = @ItemName
                    ORDER BY p.Name";

                var uses = await connection.QueryAsync<string>(usesQuery, new { ItemName = item.Name });
                item.PokemonUses = uses.AsList();
            }

            return items.AsList();
        }

        public async Task<List<Pokemon>> GetPokemonByEvolutionItemAsync(string itemName)
        {
            using var connection = _connectionFactory.CreateConnection();

            var query = @"
                SELECT p.Id, p.Name, p.PokedexNumber, p.Generation, p.PrimaryType, p.SecondaryType, p.ImageUrl
                FROM Pokemon p
                JOIN EvolutionMethods em ON p.Id = em.FromPokemonId
                WHERE em.Item = @ItemName
                ORDER BY p.PokedexNumber";

            var pokemon = await connection.QueryAsync<Pokemon>(query, new { ItemName = itemName });

            return pokemon.AsList();
        }
    }
}