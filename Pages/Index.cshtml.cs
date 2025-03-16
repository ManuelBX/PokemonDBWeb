using System.Collections.Generic;
using System.Threading.Tasks;
using Dapper;
using Microsoft.AspNetCore.Mvc.RazorPages;
using PokeDex.Models;
using PokeDex.Services;

namespace PokeDex.Pages
{
    public class IndexModel : PageModel
    {
        private readonly IPokemonService _pokemonService;

        public List<Pokemon> FeaturedPokemon { get; set; } = new List<Pokemon>();

        public IndexModel(IPokemonService pokemonService)
        {
            _pokemonService = pokemonService;
        }

        public async Task OnGetAsync()
        {
            // Get some featured Pokemon (could be random, newly added, etc.)
            var filters = new SearchFilters
            {
                Page = 1,
                PageSize = 6,
                SortBy = "pokedex"
            };

            FeaturedPokemon = (await _pokemonService.SearchPokemonAsync(filters)).AsList();
        }

        public string GetTypeColor(string type)
        {
            return type?.ToLower() switch
            {
                "normal" => "secondary",
                "fire" => "danger",
                "water" => "primary",
                "electric" => "warning",
                "grass" => "success",
                "ice" => "info",
                "fighting" => "danger",
                "poison" => "dark",
                "ground" => "warning",
                "flying" => "info",
                "psychic" => "pink",
                "bug" => "success",
                "rock" => "secondary",
                "ghost" => "dark",
                "dragon" => "dark",
                "dark" => "dark",
                "steel" => "secondary",
                "fairy" => "pink",
                _ => "secondary"
            };
        }
    }
}