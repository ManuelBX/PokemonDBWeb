using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using PokeDex.Models;
using PokeDex.Services;

namespace PokeDex.Pages.Pokemon
{
    public class DetailModel : PageModel
    {
        private readonly IPokemonService _pokemonService;
        private readonly IEvolutionService _evolutionService;

        public DetailModel(IPokemonService pokemonService, IEvolutionService evolutionService)
        {
            _pokemonService = pokemonService;
            _evolutionService = evolutionService;
        }

        public Models.Pokemon Pokemon { get; set; }
        public List<Models.Pokemon> Evolutions { get; set; }
        public List<Models.Pokemon> PreEvolutions { get; set; }

        public async Task<IActionResult> OnGetAsync(int id)
        {
            // Retrieve the single Pokemon
            Pokemon = await _pokemonService.GetPokemonByIdAsync(id);
            if (Pokemon == null)
            {
                return NotFound();
            }

            // Retrieve evolution chain
            var evoInfo = await _evolutionService.GetEvolutionsAsync(Pokemon.Id);
            var preEvoInfo = await _evolutionService.GetPreEvolutionsAsync(Pokemon.Id);

            Evolutions = new List<Models.Pokemon>();
            PreEvolutions = new List<Models.Pokemon>();

            foreach (var evo in evoInfo)
            {
                var evolvedPokemon = await _pokemonService.GetPokemonByNameAsync(evo.EvolvedName);
                if (evolvedPokemon != null)
                {
                    Evolutions.Add(evolvedPokemon);
                }
            }

            foreach (var preEvo in preEvoInfo)
            {
                var preEvolvedPokemon = await _pokemonService.GetPokemonByNameAsync(preEvo.BaseName);
                if (preEvolvedPokemon != null)
                {
                    PreEvolutions.Add(preEvolvedPokemon);
                }
            }

            return Page();
        }
    }
}
