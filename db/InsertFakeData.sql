USE PokemonDB;
GO

-- Insert Type relationships
INSERT INTO Types (Name, vs_Normal, vs_Fire, vs_Water, vs_Electric, vs_Grass, vs_Ice, vs_Fighting, vs_Poison, vs_Ground, vs_Flying, vs_Psychic, vs_Bug, vs_Rock, vs_Ghost, vs_Dragon, vs_Dark, vs_Steel, vs_Fairy)
VALUES
-- Normal: no type advantages, weak to Fighting, immune to Ghost
('NORMAL', 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 2.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 1.0),

-- Fire: resists Fire/Grass/Ice/Bug/Steel/Fairy, weak to Water/Ground/Rock
('FIRE', 1.0, 0.5, 2.0, 1.0, 0.5, 0.5, 1.0, 1.0, 2.0, 1.0, 1.0, 0.5, 2.0, 1.0, 1.0, 1.0, 0.5, 0.5),

-- Water: resists Fire/Water/Ice/Steel, weak to Electric/Grass
('WATER', 1.0, 0.5, 0.5, 2.0, 2.0, 0.5, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.5, 1.0),

-- Electric: resists Electric/Flying/Steel, weak to Ground, immune to nothing
('ELECTRIC', 1.0, 1.0, 1.0, 0.5, 0.5, 1.0, 1.0, 1.0, 2.0, 0.5, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.5, 1.0),

-- Grass: resists Water/Electric/Grass/Ground, weak to Fire/Ice/Poison/Flying/Bug
('GRASS', 1.0, 2.0, 0.5, 0.5, 0.5, 2.0, 1.0, 2.0, 0.5, 2.0, 1.0, 2.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0),

-- Ice: only resists Ice, weak to Fire/Fighting/Rock/Steel
('ICE', 1.0, 2.0, 1.0, 1.0, 1.0, 0.5, 2.0, 1.0, 1.0, 1.0, 1.0, 1.0, 2.0, 1.0, 1.0, 1.0, 2.0, 1.0),

-- Fighting: resists Bug/Rock/Dark, weak to Flying/Psychic/Fairy
('FIGHTING', 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 2.0, 2.0, 0.5, 0.5, 1.0, 1.0, 0.5, 1.0, 2.0),

-- Poison: resists Grass/Fighting/Poison/Bug/Fairy, weak to Ground/Psychic
('POISON', 1.0, 1.0, 1.0, 1.0, 0.5, 1.0, 0.5, 0.5, 2.0, 1.0, 2.0, 0.5, 1.0, 1.0, 1.0, 1.0, 1.0, 0.5),

-- Ground: resists Poison/Rock, weak to Water/Grass/Ice, immune to Electric
('GROUND', 1.0, 1.0, 2.0, 0.0, 2.0, 2.0, 1.0, 0.5, 1.0, 1.0, 1.0, 1.0, 0.5, 1.0, 1.0, 1.0, 1.0, 1.0),

-- Flying: resists Grass/Fighting/Bug, weak to Electric/Ice/Rock, immune to Ground
('FLYING', 1.0, 1.0, 1.0, 2.0, 0.5, 2.0, 0.5, 1.0, 0.0, 1.0, 1.0, 0.5, 2.0, 1.0, 1.0, 1.0, 1.0, 1.0),

-- Psychic: resists Fighting/Psychic, weak to Bug/Ghost/Dark
('PSYCHIC', 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.5, 1.0, 1.0, 1.0, 0.5, 2.0, 1.0, 2.0, 1.0, 2.0, 1.0, 1.0),

-- Bug: resists Grass/Fighting/Ground, weak to Fire/Flying/Rock
('BUG', 1.0, 2.0, 1.0, 1.0, 0.5, 1.0, 0.5, 1.0, 0.5, 2.0, 1.0, 1.0, 2.0, 1.0, 1.0, 1.0, 1.0, 1.0),

-- Rock: resists Normal/Fire/Poison/Flying, weak to Water/Grass/Fighting/Ground/Steel
('ROCK', 0.5, 0.5, 2.0, 1.0, 2.0, 1.0, 2.0, 0.5, 2.0, 0.5, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 2.0, 1.0),

-- Ghost: resists Poison/Bug, weak to Ghost/Dark, immune to Normal/Fighting
('GHOST', 0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.5, 1.0, 1.0, 1.0, 0.5, 1.0, 2.0, 1.0, 2.0, 1.0, 1.0),

-- Dragon: resists Fire/Water/Electric/Grass, weak to Ice/Dragon/Fairy, immune to nothing
('DRAGON', 1.0, 0.5, 0.5, 0.5, 0.5, 2.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 2.0, 1.0, 1.0, 2.0),

-- Dark: resists Ghost/Dark, weak to Fighting/Bug/Fairy, immune to Psychic
('DARK', 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 2.0, 1.0, 1.0, 1.0, 0.0, 2.0, 1.0, 0.5, 1.0, 0.5, 1.0, 2.0),

-- Steel: resists many types including Normal/Grass/Ice/Flying/Psychic/Bug/Rock/Dragon/Steel/Fairy, weak to Fire/Fighting/Ground, immune to Poison
('STEEL', 0.5, 2.0, 1.0, 1.0, 0.5, 0.5, 2.0, 0.0, 2.0, 0.5, 0.5, 0.5, 0.5, 1.0, 0.5, 1.0, 0.5, 0.5),

-- Fairy: resists Fighting/Bug/Dark, weak to Poison/Steel, immune to Dragon
('FAIRY', 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.5, 2.0, 1.0, 1.0, 1.0, 0.5, 1.0, 1.0, 0.0, 0.5, 2.0, 1.0);

-- Insert ALL Abilities data FIRST to avoid foreign key constraints
INSERT INTO Abilities (Name, Description) VALUES ('Overgrow', 'Powers up Grass-type moves when the Pok?mon is in trouble');
INSERT INTO Abilities (Name, Description) VALUES ('Blaze', 'Powers up Fire-type moves when the Pok?mon is in trouble');
INSERT INTO Abilities (Name, Description) VALUES ('Torrent', 'Powers up Water-type moves when the Pok?mon is in trouble');
INSERT INTO Abilities (Name, Description) VALUES ('Static', 'The Pok?mon may paralyze attacking Pok?mon on contact');
INSERT INTO Abilities (Name, Description) VALUES ('Intimidate', 'Lowers opponent''s Attack stat');
INSERT INTO Abilities (Name, Description) VALUES ('Levitate', 'Gives immunity to Ground-type moves');
INSERT INTO Abilities (Name, Description) VALUES ('Chlorophyll', 'Boosts the Pok?mon''s Speed in sunshine');
INSERT INTO Abilities (Name, Description) VALUES ('Solar Power', 'Boosts Sp. Atk but loses HP in sunshine');
INSERT INTO Abilities (Name, Description) VALUES ('Flash Fire', 'Powers up Fire-type moves if hit by one');
INSERT INTO Abilities (Name, Description) VALUES ('Sturdy', 'The Pok?mon cannot be knocked out with one hit');
INSERT INTO Abilities (Name, Description) VALUES ('Rain Dish', 'The Pok?mon gradually regains HP in rain');
INSERT INTO Abilities (Name, Description) VALUES ('Lightning Rod', 'The Pok?mon draws in all Electric-type moves');
INSERT INTO Abilities (Name, Description) VALUES ('Air Lock', 'Eliminates the effects of weather');
INSERT INTO Abilities (Name, Description) VALUES ('Flower Veil', 'Prevents lowering of ally Grass-type Pok?mon stats');
INSERT INTO Abilities (Name, Description) VALUES ('Symbiosis', 'The Pok?mon passes its item to an ally when the ally uses up an item');
INSERT INTO Abilities (Name, Description) VALUES ('Keen Eye', 'Prevents the Pok?mon from losing accuracy');
INSERT INTO Abilities (Name, Description) VALUES ('Inner Focus', 'Prevents the Pok?mon from flinching');
INSERT INTO Abilities (Name, Description) VALUES ('Swift Swim', 'Doubles Speed during rain');
INSERT INTO Abilities (Name, Description) VALUES ('Wonder Guard', 'Only super-effective moves will hit. This unique ability protects the Pok?mon from all moves except for those that are super-effective and indirect damage');
INSERT INTO Abilities (Name, Description) VALUES ('Pressure', 'The Pok?mon raises the PP cost of moves targeting it');
INSERT INTO Abilities (Name, Description) VALUES ('Unnerve', 'Makes the opposing Pok?mon nervous and unable to eat Berries');
INSERT INTO Abilities (Name, Description) VALUES ('Run Away', 'Enables sure getaway from wild Pok?mon');
INSERT INTO Abilities (Name, Description) VALUES ('Adaptability', 'Powers up moves of the same type as the Pok?mon');
INSERT INTO Abilities (Name, Description) VALUES ('Water Absorb', 'Restores HP if hit by a Water-type move');

-- Insert Pokemon data (now that all Abilities exist)
INSERT INTO Pokemon (Name, Dex_Num, Type1, Type2, Ability1, Ability2, Ability3, Height, Weight, HP, Atk, Def, Sp_Atk, Sp_Def, Speed)
VALUES ('Bulbasaur', 1, 'Grass', 'Poison', 'Overgrow', 'Chlorophyll', NULL, ' 2''04 ', 15, 45, 49, 49, 65, 65, 45);

INSERT INTO Pokemon (Name, Dex_Num, Type1, Type2, Ability1, Ability2, Ability3, Height, Weight, HP, Atk, Def, Sp_Atk, Sp_Def, Speed)
VALUES ('Ivysaur', 2, 'Grass', 'Poison', 'Overgrow', 'Chlorophyll', NULL, ' 3''03 ', 29, 60, 62, 63, 80, 80, 60);

INSERT INTO Pokemon (Name, Dex_Num, Type1, Type2, Ability1, Ability2, Ability3, Height, Weight, HP, Atk, Def, Sp_Atk, Sp_Def, Speed)
VALUES ('Venusaur', 3, 'Grass', 'Poison', 'Overgrow', 'Chlorophyll', NULL, ' 6''07 ', 220, 80, 82, 83, 100, 100, 80);

INSERT INTO Pokemon (Name, Dex_Num, Type1, Type2, Ability1, Ability2, Ability3, Height, Weight, HP, Atk, Def, Sp_Atk, Sp_Def, Speed, Regional_Form)
VALUES ('Venusaur', 3, 'Grass', 'Poison', 'Overgrow', 'Chlorophyll', NULL, ' 6''07 ', 220, 80, 100, 123, 122, 120, 80, 'Mega');

INSERT INTO Pokemon (Name, Dex_Num, Type1, Type2, Ability1, Ability2, Ability3, Height, Weight, HP, Atk, Def, Sp_Atk, Sp_Def, Speed)
VALUES ('Charmander', 4, 'Fire', NULL, 'Blaze', 'Solar Power', NULL, ' 2''00 ', 19, 39, 52, 43, 60, 50, 65);

INSERT INTO Pokemon (Name, Dex_Num, Type1, Type2, Ability1, Ability2, Ability3, Height, Weight, HP, Atk, Def, Sp_Atk, Sp_Def, Speed)
VALUES ('Charmeleon', 5, 'Fire', NULL, 'Blaze', 'Solar Power', NULL, ' 3''07 ', 42, 58, 64, 58, 80, 65, 80);

INSERT INTO Pokemon (Name, Dex_Num, Type1, Type2, Ability1, Ability2, Ability3, Height, Weight, HP, Atk, Def, Sp_Atk, Sp_Def, Speed, Regional_Form)
VALUES ('Charizard', 6, 'Fire', 'Flying', 'Blaze', 'Solar Power', NULL, ' 5''07 ', 200, 78, 84, 78, 109, 85, 100, 'Gigantamax');

INSERT INTO Pokemon (Name, Dex_Num, Type1, Type2, Ability1, Ability2, Ability3, Height, Weight, HP, Atk, Def, Sp_Atk, Sp_Def, Speed)
VALUES ('Squirtle', 7, 'Water', NULL, 'Torrent', 'Rain Dish', NULL, ' 1''08 ', 20, 44, 48, 65, 50, 64, 43);

INSERT INTO Pokemon (Name, Dex_Num, Type1, Type2, Ability1, Ability2, Ability3, Height, Weight, HP, Atk, Def, Sp_Atk, Sp_Def, Speed)
VALUES ('Wartortle', 8, 'Water', NULL, 'Torrent', 'Rain Dish', NULL, ' 3''03 ', 50, 59, 63, 80, 65, 80, 58);

INSERT INTO Pokemon (Name, Dex_Num, Type1, Type2, Ability1, Ability2, Ability3, Height, Weight, HP, Atk, Def, Sp_Atk, Sp_Def, Speed, Regional_Form)
VALUES ('Blastoise', 9, 'Water', NULL, 'Torrent', 'Rain Dish', NULL, ' 5''03 ', 188, 79, 83, 100, 85, 105, 78, 'Gigantamax');

INSERT INTO Pokemon (Name, Dex_Num, Type1, Type2, Ability1, Ability2, Ability3, Height, Weight, HP, Atk, Def, Sp_Atk, Sp_Def, Speed, Regional_Form)
VALUES ('Pikachu', 25, 'Electric', NULL, 'Static', 'Lightning Rod', NULL, ' 1''04 ', 13, 35, 55, 40, 50, 50, 90, 'Gigantamax');

-- Testing Pokemon with maximum values
INSERT INTO Pokemon (Name, Dex_Num, Type1, Type2, Ability1, Ability2, Ability3, Height, Weight, HP, Atk, Def, Sp_Atk, Sp_Def, Speed, Regional_Form)
VALUES ('Mega Rayquaza', 384, 'Dragon', 'Flying', 'Air Lock', NULL, NULL, ' 35''05 ', 999, 105, 180, 100, 180, 100, 115, 'Mega');

-- Pokemon with minimum values
INSERT INTO Pokemon (Name, Dex_Num, Type1, Type2, Ability1, Ability2, Ability3, Height, Weight, HP, Atk, Def, Sp_Atk, Sp_Def, Speed, Regional_Form)
VALUES ('Flab?b?', 669, 'Fairy', NULL, 'Flower Veil', 'Symbiosis', NULL, ' 0''04 ', 1, 44, 38, 39, 61, 79, 42, NULL);

-- Pokemon with special characters in name
INSERT INTO Pokemon (Name, Dex_Num, Type1, Type2, Ability1, Ability2, Ability3, Height, Weight, HP, Atk, Def, Sp_Atk, Sp_Def, Speed, Regional_Form)
VALUES ('Farfetch''d', 83, 'Normal', 'Flying', 'Keen Eye', 'Inner Focus', NULL, ' 2''07 ', 33, 52, 90, 55, 58, 62, 60, 'Galarian');

-- Testing foreign key constraints with additional Pokemon
INSERT INTO Pokemon (Name, Dex_Num, Type1, Type2, Ability1, Ability2, Ability3, Height, Weight, HP, Atk, Def, Sp_Atk, Sp_Def, Speed, Regional_Form)
VALUES ('Mewtwo', 150, 'Psychic', NULL, 'Pressure', 'Unnerve', NULL, ' 6''07 ', 269, 106, 110, 90, 154, 90, 130, 'Mega X');

-- Testing additional evolution chain
INSERT INTO Pokemon (Name, Dex_Num, Type1, Type2, Ability1, Ability2, Ability3, Height, Weight, HP, Atk, Def, Sp_Atk, Sp_Def, Speed, Regional_Form)
VALUES ('Eevee', 133, 'Normal', NULL, 'Run Away', 'Adaptability', NULL, ' 1''00 ', 14, 55, 55, 50, 45, 65, 55, 'Gigantamax');

INSERT INTO Pokemon (Name, Dex_Num, Type1, Type2, Ability1, Ability2, Ability3, Height, Weight, HP, Atk, Def, Sp_Atk, Sp_Def, Speed)
VALUES ('Vaporeon', 134, 'Water', NULL, 'Water Absorb', NULL, NULL, ' 3''03 ', 64, 130, 65, 60, 110, 95, 65);

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
INSERT INTO PokeDex (Pokemon_Name, Number) VALUES ('Flab?b?', 669);

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