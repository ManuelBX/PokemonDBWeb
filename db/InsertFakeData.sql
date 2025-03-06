USE PokemonDB;
GO

-- Insert Types data (18 Pokemon types)
INSERT INTO Types (Name) VALUES ('Normal');
INSERT INTO Types (Name) VALUES ('Fire');
INSERT INTO Types (Name) VALUES ('Water');
INSERT INTO Types (Name) VALUES ('Grass');
INSERT INTO Types (Name) VALUES ('Electric');
INSERT INTO Types (Name) VALUES ('Ice');
INSERT INTO Types (Name) VALUES ('Fighting');
INSERT INTO Types (Name) VALUES ('Poison');
INSERT INTO Types (Name) VALUES ('Ground');
INSERT INTO Types (Name) VALUES ('Flying');
INSERT INTO Types (Name) VALUES ('Psychic');
INSERT INTO Types (Name) VALUES ('Bug');
INSERT INTO Types (Name) VALUES ('Rock');
INSERT INTO Types (Name) VALUES ('Ghost');
INSERT INTO Types (Name) VALUES ('Dragon');
INSERT INTO Types (Name) VALUES ('Dark');
INSERT INTO Types (Name) VALUES ('Steel');
INSERT INTO Types (Name) VALUES ('Fairy');

-- Insert Type relationships (sample)
INSERT INTO TypeWeakTo (TypeName, WeakToType) VALUES ('Normal', 'Fighting');
INSERT INTO TypeStrongAgainst (TypeName, StrongAgainstType) VALUES ('Fire', 'Grass');
INSERT INTO TypeWeakAgainst (TypeName, WeakAgainstType) VALUES ('Water', 'Grass');
INSERT INTO TypeImmuneTo (TypeName, ImmuneToType) VALUES ('Ghost', 'Normal');
INSERT INTO TypeIneffectiveAgainst (TypeName, IneffectiveAgainstType) VALUES ('Normal', 'Rock');

-- Insert ALL Abilities data FIRST to avoid foreign key constraints
INSERT INTO Abilities (Name, Description) VALUES ('Overgrow', 'Powers up Grass-type moves when the Pokémon is in trouble');
INSERT INTO Abilities (Name, Description) VALUES ('Blaze', 'Powers up Fire-type moves when the Pokémon is in trouble');
INSERT INTO Abilities (Name, Description) VALUES ('Torrent', 'Powers up Water-type moves when the Pokémon is in trouble');
INSERT INTO Abilities (Name, Description) VALUES ('Static', 'The Pokémon may paralyze attacking Pokémon on contact');
INSERT INTO Abilities (Name, Description) VALUES ('Intimidate', 'Lowers opponent''s Attack stat');
INSERT INTO Abilities (Name, Description) VALUES ('Levitate', 'Gives immunity to Ground-type moves');
INSERT INTO Abilities (Name, Description) VALUES ('Chlorophyll', 'Boosts the Pokémon''s Speed in sunshine');
INSERT INTO Abilities (Name, Description) VALUES ('Solar Power', 'Boosts Sp. Atk but loses HP in sunshine');
INSERT INTO Abilities (Name, Description) VALUES ('Flash Fire', 'Powers up Fire-type moves if hit by one');
INSERT INTO Abilities (Name, Description) VALUES ('Sturdy', 'The Pokémon cannot be knocked out with one hit');
INSERT INTO Abilities (Name, Description) VALUES ('Rain Dish', 'The Pokémon gradually regains HP in rain');
INSERT INTO Abilities (Name, Description) VALUES ('Lightning Rod', 'The Pokémon draws in all Electric-type moves');
INSERT INTO Abilities (Name, Description) VALUES ('Air Lock', 'Eliminates the effects of weather');
INSERT INTO Abilities (Name, Description) VALUES ('Flower Veil', 'Prevents lowering of ally Grass-type Pokémon stats');
INSERT INTO Abilities (Name, Description) VALUES ('Symbiosis', 'The Pokémon passes its item to an ally when the ally uses up an item');
INSERT INTO Abilities (Name, Description) VALUES ('Keen Eye', 'Prevents the Pokémon from losing accuracy');
INSERT INTO Abilities (Name, Description) VALUES ('Inner Focus', 'Prevents the Pokémon from flinching');
INSERT INTO Abilities (Name, Description) VALUES ('Swift Swim', 'Doubles Speed during rain');
INSERT INTO Abilities (Name, Description) VALUES ('Wonder Guard', 'Only super-effective moves will hit. This unique ability protects the Pokémon from all moves except for those that are super-effective and indirect damage');
INSERT INTO Abilities (Name, Description) VALUES ('Pressure', 'The Pokémon raises the PP cost of moves targeting it');
INSERT INTO Abilities (Name, Description) VALUES ('Unnerve', 'Makes the opposing Pokémon nervous and unable to eat Berries');
INSERT INTO Abilities (Name, Description) VALUES ('Run Away', 'Enables sure getaway from wild Pokémon');
INSERT INTO Abilities (Name, Description) VALUES ('Adaptability', 'Powers up moves of the same type as the Pokémon');
INSERT INTO Abilities (Name, Description) VALUES ('Water Absorb', 'Restores HP if hit by a Water-type move');

-- Insert Pokemon data (now that all Abilities exist)
INSERT INTO Pokemon (Name, Dex_Num, Type1, Type2, Ability1, Ability2, Ability3, Height, Weight, HP, Atk, Def, Sp_Atk, Sp_Def, Speed, Regional_Forms)
VALUES ('Bulbasaur', 1, 'Grass', 'Poison', 'Overgrow', 'Chlorophyll', NULL, ' 2''04 ', 15, 45, 49, 49, 65, 65, 45, NULL);

INSERT INTO Pokemon (Name, Dex_Num, Type1, Type2, Ability1, Ability2, Ability3, Height, Weight, HP, Atk, Def, Sp_Atk, Sp_Def, Speed, Regional_Forms)
VALUES ('Ivysaur', 2, 'Grass', 'Poison', 'Overgrow', 'Chlorophyll', NULL, ' 3''03 ', 29, 60, 62, 63, 80, 80, 60, NULL);

INSERT INTO Pokemon (Name, Dex_Num, Type1, Type2, Ability1, Ability2, Ability3, Height, Weight, HP, Atk, Def, Sp_Atk, Sp_Def, Speed, Regional_Forms)
VALUES ('Venusaur', 3, 'Grass', 'Poison', 'Overgrow', 'Chlorophyll', NULL, ' 6''07 ', 220, 80, 82, 83, 100, 100, 80, 'Gigantamax');

INSERT INTO Pokemon (Name, Dex_Num, Type1, Type2, Ability1, Ability2, Ability3, Height, Weight, HP, Atk, Def, Sp_Atk, Sp_Def, Speed, Regional_Forms)
VALUES ('Charmander', 4, 'Fire', NULL, 'Blaze', 'Solar Power', NULL, ' 2''00 ', 19, 39, 52, 43, 60, 50, 65, NULL);

INSERT INTO Pokemon (Name, Dex_Num, Type1, Type2, Ability1, Ability2, Ability3, Height, Weight, HP, Atk, Def, Sp_Atk, Sp_Def, Speed, Regional_Forms)
VALUES ('Charmeleon', 5, 'Fire', NULL, 'Blaze', 'Solar Power', NULL, ' 3''07 ', 42, 58, 64, 58, 80, 65, 80, NULL);

INSERT INTO Pokemon (Name, Dex_Num, Type1, Type2, Ability1, Ability2, Ability3, Height, Weight, HP, Atk, Def, Sp_Atk, Sp_Def, Speed, Regional_Forms)
VALUES ('Charizard', 6, 'Fire', 'Flying', 'Blaze', 'Solar Power', NULL, ' 5''07 ', 200, 78, 84, 78, 109, 85, 100, 'Gigantamax');

INSERT INTO Pokemon (Name, Dex_Num, Type1, Type2, Ability1, Ability2, Ability3, Height, Weight, HP, Atk, Def, Sp_Atk, Sp_Def, Speed, Regional_Forms)
VALUES ('Squirtle', 7, 'Water', NULL, 'Torrent', 'Rain Dish', NULL, ' 1''08 ', 20, 44, 48, 65, 50, 64, 43, NULL);

INSERT INTO Pokemon (Name, Dex_Num, Type1, Type2, Ability1, Ability2, Ability3, Height, Weight, HP, Atk, Def, Sp_Atk, Sp_Def, Speed, Regional_Forms)
VALUES ('Wartortle', 8, 'Water', NULL, 'Torrent', 'Rain Dish', NULL, ' 3''03 ', 50, 59, 63, 80, 65, 80, 58, NULL);

INSERT INTO Pokemon (Name, Dex_Num, Type1, Type2, Ability1, Ability2, Ability3, Height, Weight, HP, Atk, Def, Sp_Atk, Sp_Def, Speed, Regional_Forms)
VALUES ('Blastoise', 9, 'Water', NULL, 'Torrent', 'Rain Dish', NULL, ' 5''03 ', 188, 79, 83, 100, 85, 105, 78, 'Gigantamax');

INSERT INTO Pokemon (Name, Dex_Num, Type1, Type2, Ability1, Ability2, Ability3, Height, Weight, HP, Atk, Def, Sp_Atk, Sp_Def, Speed, Regional_Forms)
VALUES ('Pikachu', 25, 'Electric', NULL, 'Static', 'Lightning Rod', NULL, ' 1''04 ', 13, 35, 55, 40, 50, 50, 90, 'Gigantamax');

-- Testing Pokemon with maximum values
INSERT INTO Pokemon (Name, Dex_Num, Type1, Type2, Ability1, Ability2, Ability3, Height, Weight, HP, Atk, Def, Sp_Atk, Sp_Def, Speed, Regional_Forms)
VALUES ('Mega Rayquaza', 384, 'Dragon', 'Flying', 'Air Lock', NULL, NULL, ' 35''05 ', 999, 105, 180, 100, 180, 100, 115, 'Mega');

-- Pokemon with minimum values
INSERT INTO Pokemon (Name, Dex_Num, Type1, Type2, Ability1, Ability2, Ability3, Height, Weight, HP, Atk, Def, Sp_Atk, Sp_Def, Speed, Regional_Forms)
VALUES ('Flabébé', 669, 'Fairy', NULL, 'Flower Veil', 'Symbiosis', NULL, ' 0''04 ', 1, 44, 38, 39, 61, 79, 42, NULL);

-- Pokemon with special characters in name
INSERT INTO Pokemon (Name, Dex_Num, Type1, Type2, Ability1, Ability2, Ability3, Height, Weight, HP, Atk, Def, Sp_Atk, Sp_Def, Speed, Regional_Forms)
VALUES ('Farfetch''d', 83, 'Normal', 'Flying', 'Keen Eye', 'Inner Focus', NULL, ' 2''07 ', 33, 52, 90, 55, 58, 62, 60, 'Galarian');

-- Testing foreign key constraints with additional Pokemon
INSERT INTO Pokemon (Name, Dex_Num, Type1, Type2, Ability1, Ability2, Ability3, Height, Weight, HP, Atk, Def, Sp_Atk, Sp_Def, Speed, Regional_Forms)
VALUES ('Mewtwo', 150, 'Psychic', NULL, 'Pressure', 'Unnerve', NULL, ' 6''07 ', 269, 106, 110, 90, 154, 90, 130, 'Mega X');

-- Testing additional evolution chain
INSERT INTO Pokemon (Name, Dex_Num, Type1, Type2, Ability1, Ability2, Ability3, Height, Weight, HP, Atk, Def, Sp_Atk, Sp_Def, Speed, Regional_Forms)
VALUES ('Eevee', 133, 'Normal', NULL, 'Run Away', 'Adaptability', NULL, ' 1''00 ', 14, 55, 55, 50, 45, 65, 55, 'Gigantamax');

INSERT INTO Pokemon (Name, Dex_Num, Type1, Type2, Ability1, Ability2, Ability3, Height, Weight, HP, Atk, Def, Sp_Atk, Sp_Def, Speed, Regional_Forms)
VALUES ('Vaporeon', 134, 'Water', NULL, 'Water Absorb', NULL, NULL, ' 3''03 ', 64, 130, 65, 60, 110, 95, 65, NULL);

-- Insert Moves data
INSERT INTO Moves (Name, Power, Accuracy, Category, PP, Contact, Type)
VALUES ('Tackle', 40, 100, 'Physical', 35, 1, 'Normal');

INSERT INTO Moves (Name, Power, Accuracy, Category, PP, Contact, Type)
VALUES ('Vine Whip', 45, 100, 'Physical', 25, 1, 'Grass');

INSERT INTO Moves (Name, Power, Accuracy, Category, PP, Contact, Type)
VALUES ('Ember', 40, 100, 'Special', 25, 0, 'Fire');

INSERT INTO Moves (Name, Power, Accuracy, Category, PP, Contact, Type)
VALUES ('Water Gun', 40, 100, 'Special', 25, 0, 'Water');

INSERT INTO Moves (Name, Power, Accuracy, Category, PP, Contact, Type)
VALUES ('Thunderbolt', 90, 100, 'Special', 15, 0, 'Electric');

INSERT INTO Moves (Name, Power, Accuracy, Category, PP, Contact, Type)
VALUES ('Solar Beam', 120, 100, 'Special', 10, 0, 'Grass');

INSERT INTO Moves (Name, Power, Accuracy, Category, PP, Contact, Type)
VALUES ('Flamethrower', 90, 100, 'Special', 15, 0, 'Fire');

INSERT INTO Moves (Name, Power, Accuracy, Category, PP, Contact, Type)
VALUES ('Hydro Pump', 110, 80, 'Special', 5, 0, 'Water');

INSERT INTO Moves (Name, Power, Accuracy, Category, PP, Contact, Type)
VALUES ('Thunder', 110, 70, 'Special', 10, 0, 'Electric');

INSERT INTO Moves (Name, Power, Accuracy, Category, PP, Contact, Type)
VALUES ('Growl', 0, 100, 'Status', 40, 0, 'Normal');

INSERT INTO Moves (Name, Power, Accuracy, Category, PP, Contact, Type)
VALUES ('Hyper Beam', 150, 90, 'Special', 5, 0, 'Normal');

INSERT INTO Moves (Name, Power, Accuracy, Category, PP, Contact, Type)
VALUES ('Swords Dance', 0, 100, 'Status', 20, 0, 'Normal');

INSERT INTO Moves (Name, Power, Accuracy, Category, PP, Contact, Type)
VALUES ('Psychic', 90, 100, 'Special', 10, 0, 'Psychic');

-- Insert PokeDex data
INSERT INTO PokeDex (Pokemon_Name, Number) VALUES ('Bulbasaur', 1);
INSERT INTO PokeDex (Pokemon_Name, Number) VALUES ('Ivysaur', 2);
INSERT INTO PokeDex (Pokemon_Name, Number) VALUES ('Venusaur', 3);
INSERT INTO PokeDex (Pokemon_Name, Number) VALUES ('Charmander', 4);
INSERT INTO PokeDex (Pokemon_Name, Number) VALUES ('Charmeleon', 5);
INSERT INTO PokeDex (Pokemon_Name, Number) VALUES ('Charizard', 6);
INSERT INTO PokeDex (Pokemon_Name, Number) VALUES ('Squirtle', 7);
INSERT INTO PokeDex (Pokemon_Name, Number) VALUES ('Wartortle', 8);
INSERT INTO PokeDex (Pokemon_Name, Number) VALUES ('Blastoise', 9);
INSERT INTO PokeDex (Pokemon_Name, Number) VALUES ('Pikachu', 25);
INSERT INTO PokeDex (Pokemon_Name, Number) VALUES ('Mewtwo', 150);
INSERT INTO PokeDex (Pokemon_Name, Number) VALUES ('Eevee', 133);
INSERT INTO PokeDex (Pokemon_Name, Number) VALUES ('Vaporeon', 134);
INSERT INTO PokeDex (Pokemon_Name, Number) VALUES ('Farfetch''d', 83);
INSERT INTO PokeDex (Pokemon_Name, Number) VALUES ('Mega Rayquaza', 384);
INSERT INTO PokeDex (Pokemon_Name, Number) VALUES ('Flabébé', 669);

-- Insert LearnSet data
INSERT INTO LearnSet (Dex_num, Move, Level_Learned) VALUES (1, 'Tackle', 1);
INSERT INTO LearnSet (Dex_num, Move, Level_Learned) VALUES (1, 'Vine Whip', 3);
INSERT INTO LearnSet (Dex_num, Move, Level_Learned) VALUES (4, 'Tackle', 1);
INSERT INTO LearnSet (Dex_num, Move, Level_Learned) VALUES (4, 'Ember', 4);
INSERT INTO LearnSet (Dex_num, Move, Level_Learned) VALUES (7, 'Tackle', 1);
INSERT INTO LearnSet (Dex_num, Move, Level_Learned) VALUES (7, 'Water Gun', 3);
INSERT INTO LearnSet (Dex_num, Move, Level_Learned) VALUES (25, 'Thunderbolt', 26);
INSERT INTO LearnSet (Dex_num, Move, Level_Learned) VALUES (25, 'Thunder', 50);
INSERT INTO LearnSet (Dex_num, Move, Level_Learned) VALUES (3, 'Solar Beam', 32);
INSERT INTO LearnSet (Dex_num, Move, Level_Learned) VALUES (6, 'Flamethrower', 36);
INSERT INTO LearnSet (Dex_num, Move, Level_Learned) VALUES (150, 'Psychic', 1);
INSERT INTO LearnSet (Dex_num, Move, Level_Learned) VALUES (9, 'Hydro Pump', 42);
INSERT INTO LearnSet (Dex_num, Move, Level_Learned) VALUES (384, 'Hyper Beam', 75);
INSERT INTO LearnSet (Dex_num, Move, Level_Learned) VALUES (133, 'Tackle', 1);

-- Insert Evolution data
INSERT INTO Evolutions (Base, Evolutions) VALUES ('Bulbasaur', 'Ivysaur');
INSERT INTO Evolutions (Base, Evolutions) VALUES ('Ivysaur', 'Venusaur');
INSERT INTO Evolutions (Base, Evolutions) VALUES ('Charmander', 'Charmeleon');
INSERT INTO Evolutions (Base, Evolutions) VALUES ('Charmeleon', 'Charizard');
INSERT INTO Evolutions (Base, Evolutions) VALUES ('Squirtle', 'Wartortle');
INSERT INTO Evolutions (Base, Evolutions) VALUES ('Wartortle', 'Blastoise');
INSERT INTO Evolutions (Base, Evolutions) VALUES ('Eevee', 'Vaporeon');