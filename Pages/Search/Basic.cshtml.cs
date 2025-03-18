using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using PokeDex.Models;
using PokeDex.Services;

namespace PokemonDBWeb2.Pages.Search
{
    public class BasicModel : PageModel
    {
        private readonly IPokemonService _pokemonService;

        public BasicModel(IPokemonService pokemonService)
        {
            _pokemonService = pokemonService;
        }

        [BindProperty(SupportsGet = true)]
        public string SearchTerm { get; set; }

        [BindProperty(SupportsGet = true)]
        public string SelectedType { get; set; }

        [BindProperty(SupportsGet = true)]
        public string SelectedGeneration { get; set; }

        [BindProperty(SupportsGet = true)]
        public string SortBy { get; set; } = "pokedex";

        [BindProperty(SupportsGet = true)]
        public string SortDirection { get; set; } = "asc";

        [BindProperty(SupportsGet = true)]
        public int Page { get; set; } = 1;

        public IEnumerable<PokeDex.Models.Pokemon> Results { get; set; }
        public int TotalResults { get; set; }
        public int TotalPages { get; set; }
        public int CurrentPage { get; set; }
        public int PageSize { get; set; } = 12;
        public bool IsSearchPerformed { get; set; }

        public SelectList TypeOptions { get; set; }
        public SelectList GenerationOptions { get; set; }

        public async Task OnGetAsync()
        {
            // Load filter options
            await LoadFilterOptionsAsync();

            // Check if search is performed
            IsSearchPerformed = !string.IsNullOrEmpty(SearchTerm) || !string.IsNullOrEmpty(SelectedType) || !string.IsNullOrEmpty(SelectedGeneration);

            if (Page < 1) Page = 1;
            CurrentPage = Page;

            // Perform search
            if (IsSearchPerformed || Page > 1)
            {
                var filters = new SearchFilters
                {
                    NameOrNumber = SearchTerm,
                    Types = !string.IsNullOrEmpty(SelectedType) ? new List<string> { SelectedType } : new List<string>(),
                    Generations = !string.IsNullOrEmpty(SelectedGeneration) ? new List<int> { int.Parse(SelectedGeneration) } : new List<int>(),
                    SortBy = SortBy,
                    SortDescending = SortDirection == "desc",
                    Page = Page,
                    PageSize = PageSize
                };

                Results = await _pokemonService.SearchPokemonAsync(filters);
                TotalResults = await _pokemonService.GetTotalPokemonCountAsync(filters);
                TotalPages = (int)Math.Ceiling((double)TotalResults / PageSize);
            }
        }

        private async Task LoadFilterOptionsAsync()
        {
            // Load type options
            var types = await _pokemonService.GetAllTypesAsync();
            TypeOptions = new SelectList(types, "Name", "Name");

            // Load generation options
            // var generations = await _pokemonService.GetAllGenerationsAsync();
            // GenerationOptions = new SelectList(generations, "Id", "Name");
        }
    }
}