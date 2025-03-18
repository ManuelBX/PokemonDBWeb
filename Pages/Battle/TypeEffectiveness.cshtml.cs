using System;
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
    public class TypeEffectivenessModel : PageModel
    {
        private readonly ITypeService _typeService;
        private readonly IPokemonService _pokemonService;

        public TypeEffectivenessModel(ITypeService typeService, IPokemonService pokemonService)
        {
            _typeService = typeService;
            _pokemonService = pokemonService;
        }

        [BindProperty(SupportsGet = true)]
        public int PokemonId { get; set; }

        // For listing all Pokémon in a dropdown
        public SelectList PokemonOptions { get; set; }

        // The final dictionary: AttackingType -> combined multiplier
        public Dictionary<string, double> EffectivenessMap { get; set; }
            = new Dictionary<string, double>();

        // The name / type info of the chosen Pokémon (if any)
        public Models.Pokemon SelectedPokemon { get; set; }

        public async Task OnGetAsync()
        {
            // 1) Load all Pokemon for dropdown
            var allPokemon = await _pokemonService.SearchPokemonAsync(new SearchFilters { PageSize = 9999 });
            // Convert to a list so we can use it in a SelectList
            var allList = allPokemon.ToList();

            PokemonOptions = new SelectList(allList, "Id", "Name");

            if (PokemonId > 0)
            {
                // 2) Find chosen Pokemon by Dex Num
                SelectedPokemon = await _pokemonService.GetPokemonByIdAsync(PokemonId);
                if (SelectedPokemon == null)
                {
                    // If user typed an invalid ID, just skip
                    return;
                }

                // 3) Load the type matrix from TypeService
                var matrix = await _typeService.GetTypeMatrixAsync();

                var primaryType = CapitalizeFirst(SelectedPokemon.PrimaryType);   // e.g. "Fire"
                var secondaryType = CapitalizeFirst(SelectedPokemon.SecondaryType); // e.g. "Flying" or null

                // 4) For each attacking type in the matrix (the dictionary’s keys)
                foreach (var attackingType in matrix.Keys)
                {
                    // If the Pokemon has no secondary type, 
                    // the multiplier is just matrix[attackingType][primaryType].
                    double multiplier1 = 1.0;
                    if (!string.IsNullOrEmpty(primaryType))
                    {
                        // If the matrix or row might not have the key, guard with try/catch 
                        multiplier1 = matrix[attackingType][primaryType];
                    }

                    double multiplier2 = 1.0;
                    if (!string.IsNullOrEmpty(secondaryType))
                    {
                        multiplier2 = matrix[attackingType][secondaryType];
                    }

                    // Multiply them for the final combined effect
                    double combined = multiplier1 * multiplier2;

                    // 5) Store in your dictionary
                    EffectivenessMap[attackingType] = combined;
                }
            }
        }
        /// <summary>
        /// Converts the given string so that it has the first letter uppercase 
        /// and the rest lowercase, e.g. "gRaSS" -> "Grass".
        /// If the string is empty or null, it returns it unchanged.
        /// </summary>
        public static string CapitalizeFirst(string input)
        {
            if (string.IsNullOrEmpty(input))
                return input;

            input = input.Trim();
            if (input.Length == 1)
                return input.ToUpper();

            // First char uppercase, rest lowercase
            return char.ToUpper(input[0]) + input.Substring(1).ToLower();
        }

    }
}
