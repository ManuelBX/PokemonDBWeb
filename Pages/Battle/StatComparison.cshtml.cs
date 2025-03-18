using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using PokeDex.Models;
using PokeDex.Services;

namespace PokeDex.Pages.Battle
{
    public class StatComparisonModel : PageModel
    {
        private readonly IPokemonService _pokemonService;

        public StatComparisonModel(IPokemonService pokemonService)
        {
            _pokemonService = pokemonService;
        }

        [BindProperty(SupportsGet = true)]
        public int PokemonId1 { get; set; }

        [BindProperty(SupportsGet = true)]
        public int PokemonId2 { get; set; }

        public SelectList PokemonOptions { get; set; }
        public Models.Pokemon Pokemon1 { get; set; }
        public Models.Pokemon Pokemon2 { get; set; }

        public async Task OnGetAsync()
        {
            // Pre-load a bunch of Pokémon for the dropdown
            var allPokemon = await _pokemonService.SearchPokemonAsync(new SearchFilters
            {
                PageSize = 9999
            });
            PokemonOptions = new SelectList(allPokemon, "Id", "Name");

            if (PokemonId1 > 0)
            {
                Pokemon1 = await _pokemonService.GetPokemonByIdAsync(PokemonId1);
            }
            if (PokemonId2 > 0)
            {
                Pokemon2 = await _pokemonService.GetPokemonByIdAsync(PokemonId2);
            }
        }
    }
}
