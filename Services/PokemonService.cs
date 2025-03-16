using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Dapper;
using PokeDex.Models;

namespace PokeDex.Services
{
    public interface IPokemonService
    {
        Task<IEnumerable<Pokemon>> SearchPokemonAsync(SearchFilters filters);
        Task<Pokemon> GetPokemonByIdAsync(int id);
        Task<Pokemon> GetPokemonByNameAsync(string name);
        Task<List<PokemonType>> GetAllTypesAsync();
        Task<List<Generation>> GetAllGenerationsAsync();
        Task<List<PokemonAbility>> GetAllAbilitiesAsync();
        Task<int> GetTotalPokemonCountAsync(SearchFilters filters);
    }

    public class PokemonService : IPokemonService
    {
        private readonly IDatabaseConnectionFactory _connectionFactory;

        public PokemonService(IDatabaseConnectionFactory connectionFactory)
        {
            _connectionFactory = connectionFactory;
        }

        /// <summary>
        /// SEARCH: Uses the same filtering style, 
        /// but we adapt columns to your actual DB schema 
        /// (PokeDex + Pokemon + Pokemon_Stats + LearnSet).
        /// </summary>
        public async Task<IEnumerable<Pokemon>> SearchPokemonAsync(SearchFilters filters)
        {
            using var connection = _connectionFactory.CreateConnection();

            var whereClauses = new List<string>();
            var parameters = new DynamicParameters();

            // Basic search on Dex_Num or Name from PokeDex
            if (!string.IsNullOrEmpty(filters.NameOrNumber))
            {
                if (int.TryParse(filters.NameOrNumber, out int dexNum))
                {
                    whereClauses.Add("pd.Dex_Num = @DexNum");
                    parameters.Add("DexNum", dexNum);
                }
                else
                {
                    whereClauses.Add("pd.Name LIKE @NamePattern");
                    parameters.Add("NamePattern", $"%{filters.NameOrNumber}%");
                }
            }

            // Because your model has a Generations list but 
            // there's no generation in DB, we skip it or set to always 0.
            // If you do add a Generation column later, you'd handle it here.

            // Filter by Types if needed
            //   - DB: "Type1", "Type2"
            //   - filters.Types is a list of strings
            if (filters.Types != null && filters.Types.Any())
            {
                whereClauses.Add("(pk.Type1 IN @Types OR pk.Type2 IN @Types)");
                parameters.Add("Types", filters.Types);
            }

            // Filter by Abilities 
            //   - DB: "Ability1", "Ability2", "Ability3"
            //   - Model: "filters.Abilities" is a list of strings
            if (filters.Abilities != null && filters.Abilities.Any())
            {
                whereClauses.Add(@"(
                    pk.Ability1 IN @Abilities OR
                    pk.Ability2 IN @Abilities OR
                    pk.Ability3 IN @Abilities
                )");
                parameters.Add("Abilities", filters.Abilities);
            }

            // Filter by moves using LearnSet
            if (filters.Moves != null && filters.Moves.Any())
            {
                whereClauses.Add(@"
                    EXISTS (
                        SELECT 1 
                        FROM LearnSet ls
                        JOIN Moves m ON ls.Move = m.Name
                        WHERE ls.Pokemon_Id = pk.Pokemon_Id
                          AND m.Name IN @Moves
                    )
                ");
                parameters.Add("Moves", filters.Moves);
            }

            // Filter by stats
            //   - DB columns: HP, Atk, Def, Sp_Atk, Sp_Def, Speed
            //   - Model uses "Attack", "Defense", etc.
            //   - The user can pick "hp", "attack", "defense", "special-attack", ...
            if (filters.MinStat.HasValue || filters.MaxStat.HasValue)
            {
                var statColumn = filters.StatType?.ToLower() switch
                {
                    "hp" => "ps.HP",
                    "attack" => "ps.Atk",
                    "defense" => "ps.Def",
                    "special-attack" => "ps.Sp_Atk",
                    "special-defense" => "ps.Sp_Def",
                    "speed" => "ps.Speed",
                    "total" => "(ps.HP + ps.Atk + ps.Def + ps.Sp_Atk + ps.Sp_Def + ps.Speed)",
                    _ => "ps.HP"
                };

                if (filters.MinStat.HasValue)
                {
                    whereClauses.Add($"{statColumn} >= @MinStat");
                    parameters.Add("MinStat", filters.MinStat.Value);
                }

                if (filters.MaxStat.HasValue)
                {
                    whereClauses.Add($"{statColumn} <= @MaxStat");
                    parameters.Add("MaxStat", filters.MaxStat.Value);
                }
            }

            // Build final WHERE
            var whereSql = whereClauses.Any()
                ? "WHERE " + string.Join(" AND ", whereClauses)
                : string.Empty;

            // Sorting
            var sortCol = filters.SortBy?.ToLower() switch
            {
                "name" => "pd.Name",
                "pokedex" => "pd.Dex_Num",
                "type" => "pk.Type1",
                "hp" => "ps.HP",
                "attack" => "ps.Atk",
                "defense" => "ps.Def",
                "special-attack" => "ps.Sp_Atk",
                "special-defense" => "ps.Sp_Def",
                "speed" => "ps.Speed",
                "total" => "(ps.HP + ps.Atk + ps.Def + ps.Sp_Atk + ps.Sp_Def + ps.Speed)",
                // fallback
                _ => "pd.Dex_Num"  // treat Dex_Num as "Id" in sorting
            };
            var sortDir = filters.SortDescending ? "DESC" : "ASC";

            // Paging
            var offset = (filters.Page - 1) * filters.PageSize;

            // Main query:
            //   We join PokeDex + Pokemon + Pokemon_Stats 
            //   to gather all needed columns.
            var query = $@"
                SELECT 
                    pd.Dex_Num     AS DexNum,
                    pd.Name        AS DexName,
                    pd.Id          AS PokeDexGuid,   -- not used in the model, but we can keep it
                    pk.Pokemon_Id  AS PokemonGuid,
                    pk.Type1,
                    pk.Type2,
                    pk.Ability1,
                    pk.Ability2,
                    pk.Ability3,
                    ps.HP,
                    ps.Atk,
                    ps.Def,
                    ps.Sp_Atk,
                    ps.Sp_Def,
                    ps.Speed
                FROM PokeDex pd
                JOIN Pokemon pk       ON pd.Id = pk.Pokemon_Id
                JOIN Pokemon_Stats ps ON pk.Pokemon_Id = ps.Pokemon_Id
                {whereSql}
                ORDER BY {sortCol} {sortDir}
                OFFSET @Offset ROWS
                FETCH NEXT @PageSize ROWS ONLY;
            ";

            parameters.Add("Offset", offset);
            parameters.Add("PageSize", filters.PageSize);

            var rows = await connection.QueryAsync(query, parameters);

            // Build up the result list
            var pokemonList = new List<Pokemon>();
            foreach (var row in rows)
            {
                // We'll treat DexNum as the .Id (int) in your model
                var poke = new Pokemon
                {
                    Id = row.DexNum,
                    Name = row.DexName,                 // from PokeDex.Name
                    PokedexNumber = row.DexNum,         // duplicates .Id for you
                    Generation = 0,                     // no generation in DB
                    PrimaryType = row.Type1,
                    SecondaryType = row.Type2,
                    // Since DB doesn't have these columns:
                    Description = "",
                    ImageUrl = "",

                    Stats = new BaseStats
                    {
                        HP = row.HP,
                        Attack = row.Atk,
                        Defense = row.Def,
                        SpecialAttack = row.Sp_Atk,
                        SpecialDefense = row.Sp_Def,
                        Speed = row.Speed
                    },
                    // We'll fill abilities and moves later if we want, 
                    // but that requires more queries. For big lists, 
                    // you might want a separate step or left join approach.
                    Abilities = new List<PokemonAbility>(),
                    Moves = new List<PokemonMove>(),
                    Evolution = null  // or a placeholder
                };

                // Populate abilities from the three columns:
                var abilityNames = new List<string>();
                if (row.Ability1 != null) abilityNames.Add((string)row.Ability1);
                if (row.Ability2 != null) abilityNames.Add((string)row.Ability2);
                if (row.Ability3 != null) abilityNames.Add((string)row.Ability3);

                if (abilityNames.Count > 0)
                {
                    // Look up descriptions from the Abilities table
                    var abilitySql = @"
                        SELECT Name, Description
                        FROM Abilities
                        WHERE Name IN @AbilityNames;
                    ";
                    var abilityRows = await connection.QueryAsync(abilitySql,
                        new { AbilityNames = abilityNames });

                    foreach (var ab in abilityRows)
                    {
                        // Our model has an int Id, so just set 0 or any placeholder
                        poke.Abilities.Add(new PokemonAbility
                        {
                            Id = 0,
                            Name = ab.Name,
                            Description = ab.Description,
                            IsHidden = false // we have no separate "hidden" in the schema
                        });
                    }
                }

                // If you want to fill Moves for each record:
                var movesSql = @"
                    SELECT m.Name, m.Type, m.Power, m.Accuracy, m.Category, m.PP, m.Contact
                    FROM LearnSet ls
                    JOIN Moves m ON ls.Move = m.Name
                    WHERE ls.Pokemon_Id = @PokemonGuid
                    ORDER BY ls.Level_Learned;
                ";
                var movesData = await connection.QueryAsync(movesSql,
                    new { PokemonGuid = (Guid)row.PokemonGuid });

                foreach (var mv in movesData)
                {
                    poke.Moves.Add(new PokemonMove
                    {
                        Id = 0,       // again, no int PK in Moves table
                        Name = mv.Name,
                        Type = mv.Type,
                        Category = mv.Category,
                        Power = mv.Power,
                        Accuracy = mv.Accuracy,
                        PP = mv.PP,
                        Description = "" // DB has no "Description" col
                    });
                }

                pokemonList.Add(poke);
            }

            return pokemonList;
        }

        /// <summary>
        /// Get by "Id" in your model, which we’ll treat as Dex_Num in the DB.
        /// If you prefer a different approach, adjust accordingly.
        /// </summary>
        public async Task<Pokemon> GetPokemonByIdAsync(int id)
        {
            using var connection = _connectionFactory.CreateConnection();

            // Step 1: Fetch the main row (PokeDex + Pokemon + Stats)
            var sql = @"
                SELECT 
                    pd.Dex_Num     AS DexNum,
                    pd.Name        AS DexName,
                    pd.Id          AS PokeDexGuid,
                    pk.Pokemon_Id  AS PokemonGuid,
                    pk.Type1,
                    pk.Type2,
                    pk.Ability1,
                    pk.Ability2,
                    pk.Ability3,
                    ps.HP,
                    ps.Atk,
                    ps.Def,
                    ps.Sp_Atk,
                    ps.Sp_Def,
                    ps.Speed
                FROM PokeDex pd
                JOIN Pokemon pk       ON pd.Id = pk.Pokemon_Id
                JOIN Pokemon_Stats ps ON pk.Pokemon_Id = ps.Pokemon_Id
                WHERE pd.Dex_Num = @DexNum;
            ";

            var row = await connection.QueryFirstOrDefaultAsync(sql, new { DexNum = id });
            if (row == null) return null;

            // Build the Pokemon object
            var pokemon = new Pokemon
            {
                Id = row.DexNum,
                Name = row.DexName,
                PokedexNumber = row.DexNum,
                Generation = 0, // no generation col
                PrimaryType = row.Type1,
                SecondaryType = row.Type2,
                Description = "",
                ImageUrl = "",
                Stats = new BaseStats
                {
                    HP = row.HP,
                    Attack = row.Atk,
                    Defense = row.Def,
                    SpecialAttack = row.Sp_Atk,
                    SpecialDefense = row.Sp_Def,
                    Speed = row.Speed
                },
                Abilities = new List<PokemonAbility>(),
                Moves = new List<PokemonMove>(),
                Evolution = null
            };

            // Step 2: Fill abilities
            var abilityNames = new List<string>();
            if (row.Ability1 != null) abilityNames.Add((string)row.Ability1);
            if (row.Ability2 != null) abilityNames.Add((string)row.Ability2);
            if (row.Ability3 != null) abilityNames.Add((string)row.Ability3);

            if (abilityNames.Any())
            {
                var abilitySql = @"
                    SELECT Name, Description
                    FROM Abilities
                    WHERE Name IN @Names;
                ";
                var abilityRows = await connection.QueryAsync(abilitySql, new { Names = abilityNames });
                foreach (var ab in abilityRows)
                {
                    pokemon.Abilities.Add(new PokemonAbility
                    {
                        Id = 0,
                        Name = ab.Name,
                        Description = ab.Description,
                        IsHidden = false
                    });
                }
            }

            // Step 3: Fill moves
            var movesSql = @"
                SELECT m.Name, m.Type, m.Power, m.Accuracy, m.Category, m.PP, m.Contact
                FROM LearnSet ls
                JOIN Moves m ON ls.Move = m.Name
                WHERE ls.Pokemon_Id = @PokeGuid
                ORDER BY ls.Level_Learned;
            ";
            var movesData = await connection.QueryAsync(movesSql, new { PokeGuid = (Guid)row.PokemonGuid });
            foreach (var mv in movesData)
            {
                pokemon.Moves.Add(new PokemonMove
                {
                    Id = 0,
                    Name = mv.Name,
                    Type = mv.Type,
                    Category = mv.Category,
                    Power = mv.Power,
                    Accuracy = mv.Accuracy,
                    PP = mv.PP,
                    Description = "" // not in DB
                });
            }

            // Step 4: Evolution data is not trivially mapped; return null or do custom logic
            pokemon.Evolution = null;

            return pokemon;
        }

        /// <summary>
        /// Find by exact name from PokeDex.Name, then re-use GetPokemonByIdAsync.
        /// </summary>
        public async Task<Pokemon> GetPokemonByNameAsync(string name)
        {
            using var connection = _connectionFactory.CreateConnection();

            var sql = "SELECT Dex_Num FROM PokeDex WHERE Name = @Name;";
            var dexNum = await connection.QueryFirstOrDefaultAsync<int?>(sql, new { Name = name });
            if (!dexNum.HasValue) return null;

            // Reuse the "GetPokemonByIdAsync" since we treat Dex_Num as "Id"
            return await GetPokemonByIdAsync(dexNum.Value);
        }

        /// <summary>
        /// Return all Types from the `Types` table, 
        /// mapping them to your PokemonType model (Id + Name).
        /// The DB has Name as the PK. It does NOT have an integer `Id`.
        /// We can set `Id=0` or we can’t fill it meaningfully.
        /// </summary>
        public async Task<List<PokemonType>> GetAllTypesAsync()
        {
            using var connection = _connectionFactory.CreateConnection();
            var sql = "SELECT Name FROM Types ORDER BY Name;";
            // The DB also has vs_Fire, vs_Water, etc. columns, 
            // but your model only has `Id`, `Name`.
            var rows = await connection.QueryAsync(sql);

            var result = new List<PokemonType>();
            foreach (var r in rows)
            {
                result.Add(new PokemonType
                {
                    Id = 0,     // because we only have a string PK in the DB
                    Name = r.Name
                });
            }
            return result;
        }

        /// <summary>
        /// The DB schema you posted has no real "Generations" table.
        /// But your interface demands it. If you want to keep code consistent,
        /// just return an empty list or implement your own logic if you add such a table.
        /// </summary>
        public async Task<List<Generation>> GetAllGenerationsAsync()
        {
            // Return an empty list by default
            return new List<Generation>();

            // If you later add a table, you'd do something like:
            /*
            using var connection = _connectionFactory.CreateConnection();
            var sql = "SELECT ... FROM Generations ...";
            var rows = await connection.QueryAsync<Generation>(sql);
            return rows.ToList();
            */
        }

        /// <summary>
        /// Return all Abilities from the `Abilities` table, 
        /// matching your PokemonAbility model as best we can.
        /// The DB has (Name PK, Description). 
        /// Your model has (int Id, string Name, string Description, bool IsHidden).
        /// So we can set Id=0, IsHidden=false for now.
        /// </summary>
        public async Task<List<PokemonAbility>> GetAllAbilitiesAsync()
        {
            using var connection = _connectionFactory.CreateConnection();
            var sql = "SELECT Name, Description FROM Abilities ORDER BY Name;";

            var rows = await connection.QueryAsync(sql);

            var result = new List<PokemonAbility>();
            foreach (var r in rows)
            {
                result.Add(new PokemonAbility
                {
                    Id = 0,               // No int PK in the DB
                    Name = r.Name,
                    Description = r.Description,
                    IsHidden = false
                });
            }
            return result;
        }

        /// <summary>
        /// Counts how many total Pokemon match the same filter logic 
        /// as SearchPokemonAsync (but does a COUNT(*)).
        /// </summary>
        public async Task<int> GetTotalPokemonCountAsync(SearchFilters filters)
        {
            using var connection = _connectionFactory.CreateConnection();

            var whereClauses = new List<string>();
            var parameters = new DynamicParameters();

            // Same logic as SearchPokemonAsync:
            if (!string.IsNullOrEmpty(filters.NameOrNumber))
            {
                if (int.TryParse(filters.NameOrNumber, out int dexNum))
                {
                    whereClauses.Add("pd.Dex_Num = @DexNum");
                    parameters.Add("DexNum", dexNum);
                }
                else
                {
                    whereClauses.Add("pd.Name LIKE @NamePattern");
                    parameters.Add("NamePattern", $"%{filters.NameOrNumber}%");
                }
            }

            if (filters.Types != null && filters.Types.Any())
            {
                whereClauses.Add("(pk.Type1 IN @Types OR pk.Type2 IN @Types)");
                parameters.Add("Types", filters.Types);
            }

            if (filters.Abilities != null && filters.Abilities.Any())
            {
                whereClauses.Add(@"(
                    pk.Ability1 IN @Abilities OR
                    pk.Ability2 IN @Abilities OR
                    pk.Ability3 IN @Abilities
                )");
                parameters.Add("Abilities", filters.Abilities);
            }

            if (filters.Moves != null && filters.Moves.Any())
            {
                whereClauses.Add(@"
                    EXISTS (
                        SELECT 1 
                        FROM LearnSet ls
                        JOIN Moves m ON ls.Move = m.Name
                        WHERE ls.Pokemon_Id = pk.Pokemon_Id
                          AND m.Name IN @Moves
                    )
                ");
                parameters.Add("Moves", filters.Moves);
            }

            if (filters.MinStat.HasValue || filters.MaxStat.HasValue)
            {
                var statColumn = filters.StatType?.ToLower() switch
                {
                    "hp" => "ps.HP",
                    "attack" => "ps.Atk",
                    "defense" => "ps.Def",
                    "special-attack" => "ps.Sp_Atk",
                    "special-defense" => "ps.Sp_Def",
                    "speed" => "ps.Speed",
                    "total" => "(ps.HP + ps.Atk + ps.Def + ps.Sp_Atk + ps.Sp_Def + ps.Speed)",
                    _ => "ps.HP"
                };

                if (filters.MinStat.HasValue)
                {
                    whereClauses.Add($"{statColumn} >= @MinStat");
                    parameters.Add("MinStat", filters.MinStat.Value);
                }
                if (filters.MaxStat.HasValue)
                {
                    whereClauses.Add($"{statColumn} <= @MaxStat");
                    parameters.Add("MaxStat", filters.MaxStat.Value);
                }
            }

            var whereSql = whereClauses.Any()
                ? "WHERE " + string.Join(" AND ", whereClauses)
                : string.Empty;

            var countSql = $@"
                SELECT COUNT(*)
                FROM PokeDex pd
                JOIN Pokemon pk       ON pd.Id = pk.Pokemon_Id
                JOIN Pokemon_Stats ps ON pk.Pokemon_Id = ps.Pokemon_Id
                {whereSql};
            ";

            int total = await connection.ExecuteScalarAsync<int>(countSql, parameters);
            return total;
        }
    }
}
