using System.Collections.Generic;
using System.Threading.Tasks;
using System.Linq;
using Dapper;
using PokeDex.Models;

namespace PokeDex.Services
{
    public interface ITypeService
    {
        // You could do something like:
        Task<Dictionary<string, Dictionary<string, double>>> GetTypeMatrixAsync();
    }

    public class TypeService : ITypeService
    {
        private readonly IDatabaseConnectionFactory _connectionFactory;

        public TypeService(IDatabaseConnectionFactory connectionFactory)
        {
            _connectionFactory = connectionFactory;
        }

        /// <summary>
        /// Example: returns a nested dictionary. 
        /// Outer key = type name (the row in Types),
        /// Inner keys = "Normal", "Fire", "Water", etc., with the float multiplier.
        /// Then you can interpret that as "AttackingType vs_Defending" in code.
        /// </summary>
        public async Task<Dictionary<string, Dictionary<string, double>>> GetTypeMatrixAsync()
        {
            using var connection = _connectionFactory.CreateConnection();
            var sql = @"
                SELECT 
                    Name,
                    vs_Normal,
                    vs_Fire,
                    vs_Water,
                    vs_Electric,
                    vs_Grass,
                    vs_Ice,
                    vs_Fighting,
                    vs_Poison,
                    vs_Ground,
                    vs_Flying,
                    vs_Psychic,
                    vs_Bug,
                    vs_Rock,
                    vs_Ghost,
                    vs_Dragon,
                    vs_Dark,
                    vs_Steel,
                    vs_Fairy
                FROM Types
                ORDER BY Name;
            ";
            var rows = await connection.QueryAsync(sql);
            var result = new Dictionary<string, Dictionary<string, double>>();

            foreach (var r in rows)
            {
                var rowDict = new Dictionary<string, double>
                {
                    ["Normal"]   = r.vs_Normal,
                    ["Fire"]     = r.vs_Fire,
                    ["Water"]    = r.vs_Water,
                    ["Electric"] = r.vs_Electric,
                    ["Grass"]    = r.vs_Grass,
                    ["Ice"]      = r.vs_Ice,
                    ["Fighting"] = r.vs_Fighting,
                    ["Poison"]   = r.vs_Poison,
                    ["Ground"]   = r.vs_Ground,
                    ["Flying"]   = r.vs_Flying,
                    ["Psychic"]  = r.vs_Psychic,
                    ["Bug"]      = r.vs_Bug,
                    ["Rock"]     = r.vs_Rock,
                    ["Ghost"]    = r.vs_Ghost,
                    ["Dragon"]   = r.vs_Dragon,
                    ["Dark"]     = r.vs_Dark,
                    ["Steel"]    = r.vs_Steel,
                    ["Fairy"]    = r.vs_Fairy
                };

                result[r.Name] = rowDict;
            }

            return result;
        }
    }
}
