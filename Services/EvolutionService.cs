using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Dapper;
using PokeDex.Models;

namespace PokeDex.Services
{
    public interface IEvolutionService
    {
        // Minimal: get direct evolutions for a given Dex number:
        Task<List<(int EvolvedDexNum, string EvolvedName, string Method)>> GetEvolutionsAsync(int baseDexNum);
        // Or reverse: find what evolves into baseDexNum
        Task<List<(int BaseDexNum, string BaseName, string Method)>> GetPreEvolutionsAsync(int evolvedDexNum);
    }

    public class EvolutionService : IEvolutionService
    {
        private readonly IDatabaseConnectionFactory _connectionFactory;

        public EvolutionService(IDatabaseConnectionFactory connectionFactory)
        {
            _connectionFactory = connectionFactory;
        }

        public async Task<List<(int EvolvedDexNum, string EvolvedName, string Method)>> GetEvolutionsAsync(int baseDexNum)
        {
            // 1) Look up the GUID for that base DexNum
            using var connection = _connectionFactory.CreateConnection();
            var baseSql = @"
                SELECT Id
                FROM PokeDex
                WHERE Dex_Num = @DexNum;
            ";
            var baseGuid = await connection.QueryFirstOrDefaultAsync<Guid?>(baseSql, new { DexNum = baseDexNum });
            if (!baseGuid.HasValue) return new List<(int, string, string)>();

            // 2) Join Evolutions to find who evolves from baseGuid
            var evoSql = @"
                SELECT 
                    evo.Evolved_Pokemon_Id,
                    evo.Evolution_Method
                FROM Evolutions evo
                WHERE evo.Base_Pokemon_Id = @BaseId;
            ";
            var evoRows = await connection.QueryAsync(evoSql, new { BaseId = baseGuid.Value });

            // 3) For each Evolved_Pokemon_Id, get DexNum + Name
            var result = new List<(int, string, string)>();
            foreach (var row in evoRows)
            {
                var dexSql = @"
                    SELECT pd.Dex_Num, pd.Name
                    FROM PokeDex pd
                    WHERE pd.Id = @EvolvedGuid;
                ";
                var dexData = await connection.QueryFirstOrDefaultAsync(dexSql, new { EvolvedGuid = (Guid)row.Evolved_Pokemon_Id });
                if (dexData != null)
                {
                    result.Add(((int)dexData.Dex_Num, (string)dexData.Name, (string)row.Evolution_Method));
                }
            }
            return result;
        }

        public async Task<List<(int BaseDexNum, string BaseName, string Method)>> GetPreEvolutionsAsync(int evolvedDexNum)
        {
            using var connection = _connectionFactory.CreateConnection();
            // 1) Find the GUID for the 'evolved' DexNum
            var evolvedSql = "SELECT Id FROM PokeDex WHERE Dex_Num = @DexNum;";
            var evolvedGuid = await connection.QueryFirstOrDefaultAsync<Guid?>(evolvedSql, new { DexNum = evolvedDexNum });
            if (!evolvedGuid.HasValue) return new List<(int, string, string)>();

            // 2) Find all base forms from Evolutions
            var baseSql = @"
                SELECT
                    evo.Base_Pokemon_Id,
                    evo.Evolution_Method
                FROM Evolutions evo
                WHERE evo.Evolved_Pokemon_Id = @EvolvedId;
            ";
            var baseRows = await connection.QueryAsync(baseSql, new { EvolvedId = evolvedGuid.Value });

            var result = new List<(int, string, string)>();
            foreach (var row in baseRows)
            {
                var dexSql = @"
                    SELECT pd.Dex_Num, pd.Name
                    FROM PokeDex pd
                    WHERE pd.Id = @BaseGuid;
                ";
                var baseData = await connection.QueryFirstOrDefaultAsync(dexSql, new { BaseGuid = (Guid)row.Base_Pokemon_Id });
                if (baseData != null)
                {
                    result.Add(((int)baseData.Dex_Num, (string)baseData.Name, (string)row.Evolution_Method));
                }
            }
            return result;
        }
    }
}