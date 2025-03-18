
    using System.Collections.Generic;

    namespace PokeDex.Models
    {
        public class Pokemon
        {
            public int Id { get; set; }
            public string Name { get; set; }
            public int PokedexNumber { get; set; }
            // public int Generation { get; set; }
            public string PrimaryType { get; set; }
            public string SecondaryType { get; set; }
            // public string Description { get; set; }
            public string RegionalForm { get; set; }
            public string Height { get; set; }
            public int Weight { get; set; }

            public string ImageUrl { get; set; }
            public List<PokemonAbility> Abilities { get; set; } = new List<PokemonAbility>();
            public BaseStats Stats { get; set; }
            public List<PokemonMove> Moves { get; set; } = new List<PokemonMove>();
        }

        public class BaseStats
        {
            public int HP { get; set; }
            public int Attack { get; set; }
            public int Defense { get; set; }
            public int SpecialAttack { get; set; }
            public int SpecialDefense { get; set; }
            public int Speed { get; set; }
            public int Total => HP + Attack + Defense + SpecialAttack + SpecialDefense + Speed;
        }

        public class PokemonAbility
        {
            // public int Id { get; set; } = 0; 
            public string Name { get; set; }
            public string Description { get; set; }
            public bool IsHidden { get; set; }
        }

        public class PokemonMove
        {
            // public int Id { get; set; }
            public string Name { get; set; }
            public string Type { get; set; }
            public string Category { get; set; }
            public int Power { get; set; }
            public int Accuracy { get; set; }
            public int PP { get; set; }
            public string Description { get; set; }
        }

        public class PokemonType
        {
            public int Id { get; set; }
            public string Name { get; set; }
        }

        public class TypeEffectiveness
        {
            public string AttackingType { get; set; }
            public string DefendingType { get; set; }
            public double Multiplier { get; set; }
        }

        //public class EvolutionInfo
        //{
        //    public int ChainId { get; set; }
        //    public List<EvolutionStage> Chain { get; set; } = new List<EvolutionStage>();
        //}

        //public class EvolutionStage
        //{
        //    public int PokemonId { get; set; }
        //    public string PokemonName { get; set; }
        //    public string ImageUrl { get; set; }
        //    public List<EvolutionMethod> EvolvesTo { get; set; } = new List<EvolutionMethod>();
        //}

        //public class EvolutionMethod
        //{
        //    public int ToPokemonId { get; set; }
        //    public string ToPokemonName { get; set; }
        //    public string ImageUrl { get; set; }
        //    public string Method { get; set; }
        //    public string Condition { get; set; }
        //    public int? MinLevel { get; set; }
        //    public string Item { get; set; }
        //    public string TimeOfDay { get; set; }
        //    public string Location { get; set; }
        //}

        //public class EvolutionItem
        //{
        //    public int Id { get; set; }
        //    public string Name { get; set; }
        //    public string Description { get; set; }
        //    public string ImageUrl { get; set; }
        //    public List<string> PokemonUses { get; set; } = new List<string>();
        //}

        //public class Generation
        //{
        //    public int Id { get; set; }
        //    public string Name { get; set; }
        //    public int StartYear { get; set; }
        //    public int EndYear { get; set; }
        //    public string Region { get; set; }
        //}

        public class SearchFilters
        {
            public string NameOrNumber { get; set; }
            public List<int> Generations { get; set; } = new List<int>();
            public List<string> Types { get; set; } = new List<string>();
            public List<string> Abilities { get; set; } = new List<string>();
            public List<string> Moves { get; set; } = new List<string>();
            public int? MinStat { get; set; }
            public int? MaxStat { get; set; }
            public string StatType { get; set; }
            public string SortBy { get; set; } = "id";
            public bool SortDescending { get; set; } = false;
            public int Page { get; set; } = 1;
            public int PageSize { get; set; } = 20;
        }
    }
