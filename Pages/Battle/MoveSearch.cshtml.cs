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
    public class MoveSearchModel : PageModel
    {
        private readonly IMoveService _moveService;
        private readonly IPokemonService _pokemonService;

        public MoveSearchModel(IMoveService moveService, IPokemonService pokemonService)
        {
            _moveService = moveService;
            _pokemonService = pokemonService;
        }

        [BindProperty(SupportsGet = true)]
        public string MoveName { get; set; }

        [BindProperty(SupportsGet = true)]
        public string SelectedType { get; set; }

        [BindProperty(SupportsGet = true)]
        public string SelectedCategory { get; set; }

        public SelectList MoveOptions { get; set; }
        public SelectList TypeOptions { get; set; }
        public List<string> Categories { get; set; } = new List<string> { "Physical", "Special", "Status" };

        public IEnumerable<PokemonMove> Moves { get; set; } = new List<PokemonMove>();
        public IEnumerable<Models.Pokemon> PokemonResults { get; set; } = new List<Models.Pokemon>();

        public async Task OnGetAsync()
        {
            // Load possible moves, types
            var allMoves = await _moveService.GetAllMovesAsync();
            MoveOptions = new SelectList(allMoves, "Name", "Name");

            var allTypes = await _pokemonService.GetAllTypesAsync();
            TypeOptions = new SelectList(allTypes, "Name", "Name");

            // If searching by MoveName:
            if (!string.IsNullOrEmpty(MoveName))
            {
                PokemonResults = await _moveService.GetPokemonByMoveAsync(MoveName);
                Moves = allMoves.Where(m => m.Name == MoveName);
            }
            // Else searching by Type
            else if (!string.IsNullOrEmpty(SelectedType))
            {
                Moves = await _moveService.GetMovesByTypeAsync(SelectedType);
            }
            // Else searching by Category
            else if (!string.IsNullOrEmpty(SelectedCategory))
            {
                Moves = await _moveService.GetMovesByCategoryAsync(SelectedCategory);
            }
        }
    }
}
