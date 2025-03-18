using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using PokeDex.Models;
using PokeDex.Services;

namespace PokeDex.Pages.Search
{
    public class AdvancedModel : PageModel
    {
        private readonly IPokemonService _pokemonService;
        private readonly IAbilityService _abilityService;
        private readonly IMoveService _moveService;

        public AdvancedModel(IPokemonService pokemonService,
                             IAbilityService abilityService,
                             IMoveService moveService)
        {
            _pokemonService = pokemonService;
            _abilityService = abilityService;
            _moveService = moveService;
        }

        [BindProperty(SupportsGet = true)]
        public SearchFilters Filters { get; set; } = new SearchFilters();

        public IEnumerable<Models.Pokemon> Results { get; set; }
        public int TotalResults { get; set; }
        public int TotalPages { get; set; }
        public int CurrentPage { get; set; }

        // For dropdowns
        public SelectList TypeOptions { get; set; }
        public SelectList AbilityOptions { get; set; }
        public SelectList MoveOptions { get; set; }
        public SelectList StatTypeOptions { get; set; }

        public async Task OnGetAsync()
        {
            await LoadFilterOptions();

            // Ensure valid page number
            if (Filters.Page < 1) Filters.Page = 1;
            CurrentPage = Filters.Page;

            // Perform advanced search only if any filter is set,
            // or if page > 1 (for pagination).
            bool anyFilterSet =
                !string.IsNullOrEmpty(Filters.NameOrNumber) ||
                (Filters.Types != null && Filters.Types.Any()) ||
                (Filters.Abilities != null && Filters.Abilities.Any()) ||
                (Filters.Moves != null && Filters.Moves.Any()) ||
                Filters.MinStat.HasValue || Filters.MaxStat.HasValue;

            if (anyFilterSet || Filters.Page > 1)
            {
                Results = await _pokemonService.SearchPokemonAsync(Filters);
                TotalResults = await _pokemonService.GetTotalPokemonCountAsync(Filters);
                TotalPages = (int)Math.Ceiling((double)TotalResults / Filters.PageSize);
            }
            else
            {
                // No search yet => no results
                Results = Enumerable.Empty<Models.Pokemon>();
                TotalResults = 0;
                TotalPages = 0;
            }
        }

        private async Task LoadFilterOptions()
        {
            var types = await _pokemonService.GetAllTypesAsync();
            TypeOptions = new SelectList(types, "Name", "Name");

            var abilities = await _abilityService.GetAllAbilitiesAsync();
            // For demonstration, we’ll just sort them by name
            AbilityOptions = new SelectList(abilities.OrderBy(a => a.Name), "Name", "Name");

            var moves = await _moveService.GetAllMovesAsync();
            MoveOptions = new SelectList(moves.OrderBy(m => m.Name), "Name", "Name");

            // Commonly used stat labels
            StatTypeOptions = new SelectList(new List<string>
            {
                "HP", "Attack", "Defense", "Special-Attack", "Special-Defense", "Speed", "Total"
            });
        }
    }
}
