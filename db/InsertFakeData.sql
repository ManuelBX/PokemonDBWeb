USE PokemonDB;
GO

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

-- Make sure Abilities exist
INSERT INTO Abilities (Name, Description)
VALUES 
    ('Overgrow', 'Powers up Grass-type moves when the Pokémon is in trouble'),
    ('Chlorophyll', 'Boosts the Pokémon''s Speed in sunshine'),
    ('Blaze', 'Powers up Fire-type moves when the Pokémon is in trouble'),
    ('Solar Power', 'Boosts Sp. Atk but loses HP in sunshine'),
    ('Torrent', 'Powers up Water-type moves when the Pokémon is in trouble'),
    ('Rain Dish', 'The Pokémon gradually regains HP in rain'),
    ('Static', 'The Pokémon may paralyze attacking Pokémon on contact'),
    ('Lightning Rod', 'The Pokémon draws in all Electric-type moves'),
    ('Delta Stream', 'Changes the weather to strong air current'),
    ('Flower Veil', 'Prevents lowering of ally Grass-type Pokémon stats'),
    ('Symbiosis', 'The Pokémon passes its item to an ally when the ally uses up an item'),
    ('Steadfast', 'Raises Speed each time the Pokémon flinches'),
    ('Scrappy', 'Enables the Pokémon to hit Ghost types with Normal- and Fighting-type moves'),
    ('Run Away', 'Enables sure getaway from wild Pokémon'),
    ('Adaptability', 'Powers up moves of the same type as the Pokémon'),
    ('Anticipation', 'Senses an opponent''s dangerous moves'),
    ('Water Absorb', 'Restores HP if hit by a Water-type move'),
    ('Hydration', 'Heals status conditions if it''s raining'),
    ('Thick Fat', 'Raises resistance to Fire- and Ice-type moves');

-- First insert into PokeDex
INSERT INTO PokeDex (Id, Dex_Num, Name, Regional_Form)
VALUES 
    (NEWID(), 1, 'Bulbasaur', 'Base'),
    (NEWID(), 2, 'Ivysaur', 'Base'),
    (NEWID(), 3, 'Venusaur', 'Base'),
    (NEWID(), 3, 'Venusaur', 'Mega'),
    (NEWID(), 4, 'Charmander', 'Base'),
    (NEWID(), 5, 'Charmeleon', 'Base'),
    (NEWID(), 6, 'Charizard', 'Gigantamax'),
    (NEWID(), 7, 'Squirtle', 'Base'),
    (NEWID(), 8, 'Wartortle', 'Base'),
    (NEWID(), 9, 'Blastoise', 'Gigantamax'),
    (NEWID(), 25, 'Pikachu', 'Gigantamax'),
    (NEWID(), 384, 'Rayquaza', 'Mega'),
    (NEWID(), 669, 'Flabébé', 'Base'),
    (NEWID(), 83, 'Farfetch''d', 'Galarian'),
    (NEWID(), 150, 'Mewtwo', 'Mega X'),
    (NEWID(), 133, 'Eevee', 'Gigantamax'),
    (NEWID(), 134, 'Vaporeon', 'Base');

-- Now retrieve the generated IDs
DECLARE @Bulbasaur_Id UNIQUEIDENTIFIER;
DECLARE @Ivysaur_Id UNIQUEIDENTIFIER;
DECLARE @Venusaur_Id UNIQUEIDENTIFIER;
DECLARE @Venusaur_Mega_Id UNIQUEIDENTIFIER;
DECLARE @Charmander_Id UNIQUEIDENTIFIER;
DECLARE @Charmeleon_Id UNIQUEIDENTIFIER;
DECLARE @Charizard_Gmax_Id UNIQUEIDENTIFIER;
DECLARE @Squirtle_Id UNIQUEIDENTIFIER;
DECLARE @Wartortle_Id UNIQUEIDENTIFIER;
DECLARE @Blastoise_Gmax_Id UNIQUEIDENTIFIER;
DECLARE @Pikachu_Gmax_Id UNIQUEIDENTIFIER;
DECLARE @MegaRayquaza_Id UNIQUEIDENTIFIER;
DECLARE @Flabebe_Id UNIQUEIDENTIFIER;
DECLARE @Farfetchd_Galarian_Id UNIQUEIDENTIFIER;
DECLARE @Mewtwo_MegaX_Id UNIQUEIDENTIFIER;
DECLARE @Eevee_Gmax_Id UNIQUEIDENTIFIER;
DECLARE @Vaporeon_Id UNIQUEIDENTIFIER;

-- Get the IDs from the PokeDex table
SELECT @Bulbasaur_Id = Id FROM PokeDex WHERE Dex_Num = 1 AND Name = 'Bulbasaur' AND Regional_Form = 'Base';
SELECT @Ivysaur_Id = Id FROM PokeDex WHERE Dex_Num = 2 AND Name = 'Ivysaur' AND Regional_Form = 'Base';
SELECT @Venusaur_Id = Id FROM PokeDex WHERE Dex_Num = 3 AND Name = 'Venusaur' AND Regional_Form = 'Base';
SELECT @Venusaur_Mega_Id = Id FROM PokeDex WHERE Dex_Num = 3 AND Name = 'Venusaur' AND Regional_Form = 'Mega';
SELECT @Charmander_Id = Id FROM PokeDex WHERE Dex_Num = 4 AND Name = 'Charmander' AND Regional_Form = 'Base';
SELECT @Charmeleon_Id = Id FROM PokeDex WHERE Dex_Num = 5 AND Name = 'Charmeleon' AND Regional_Form = 'Base';
SELECT @Charizard_Gmax_Id = Id FROM PokeDex WHERE Dex_Num = 6 AND Name = 'Charizard' AND Regional_Form = 'Gigantamax';
SELECT @Squirtle_Id = Id FROM PokeDex WHERE Dex_Num = 7 AND Name = 'Squirtle' AND Regional_Form = 'Base';
SELECT @Wartortle_Id = Id FROM PokeDex WHERE Dex_Num = 8 AND Name = 'Wartortle' AND Regional_Form = 'Base';
SELECT @Blastoise_Gmax_Id = Id FROM PokeDex WHERE Dex_Num = 9 AND Name = 'Blastoise' AND Regional_Form = 'Gigantamax';
SELECT @Pikachu_Gmax_Id = Id FROM PokeDex WHERE Dex_Num = 25 AND Name = 'Pikachu' AND Regional_Form = 'Gigantamax';
SELECT @MegaRayquaza_Id = Id FROM PokeDex WHERE Dex_Num = 384 AND Name = 'Rayquaza' AND Regional_Form = 'Mega';
SELECT @Flabebe_Id = Id FROM PokeDex WHERE Dex_Num = 669 AND Name = 'Flabébé' AND Regional_Form = 'Base';
SELECT @Farfetchd_Galarian_Id = Id FROM PokeDex WHERE Dex_Num = 83 AND Name = 'Farfetch''d' AND Regional_Form = 'Galarian';
SELECT @Mewtwo_MegaX_Id = Id FROM PokeDex WHERE Dex_Num = 150 AND Name = 'Mewtwo' AND Regional_Form = 'Mega X';
SELECT @Eevee_Gmax_Id = Id FROM PokeDex WHERE Dex_Num = 133 AND Name = 'Eevee' AND Regional_Form = 'Gigantamax';
SELECT @Vaporeon_Id = Id FROM PokeDex WHERE Dex_Num = 134 AND Name = 'Vaporeon' AND Regional_Form = 'Base';

-- Insert into Pokemon
INSERT INTO Pokemon (Pokemon_Id, Type1, Type2, Ability1, Ability2, Ability3, Height, Weight)
VALUES 
    (@Bulbasaur_Id, 'GRASS', 'POISON', 'Overgrow', NULL, 'Chlorophyll', '2''04"', 15),
    (@Ivysaur_Id, 'GRASS', 'POISON', 'Overgrow', NULL, 'Chlorophyll', '3''03"', 29),
    (@Venusaur_Id, 'GRASS', 'POISON', 'Overgrow', NULL, 'Chlorophyll', '6''07"', 220),
    (@Venusaur_Mega_Id, 'GRASS', 'POISON', 'Thick Fat', NULL, NULL, '8''02"', 342),
    (@Charmander_Id, 'FIRE', NULL, 'Blaze', NULL, 'Solar Power', '2''00"', 19),
    (@Charmeleon_Id, 'FIRE', NULL, 'Blaze', NULL, 'Solar Power', '3''07"', 42),
    (@Charizard_Gmax_Id, 'FIRE', 'FLYING', 'Blaze', NULL, 'Solar Power', '8''00"', 2000),
    (@Squirtle_Id, 'WATER', NULL, 'Torrent', NULL, 'Rain Dish', '1''08"', 20),
    (@Wartortle_Id, 'WATER', NULL, 'Torrent', NULL, 'Rain Dish', '3''03"', 50),
    (@Blastoise_Gmax_Id, 'WATER', NULL, 'Torrent', NULL, 'Rain Dish', '8''05"', 9999),
    (@Pikachu_Gmax_Id, 'ELECTRIC', NULL, 'Static', NULL, 'Lightning Rod', '6''09"', 9999),
    (@MegaRayquaza_Id, 'DRAGON', 'FLYING', 'Delta Stream', NULL, NULL, '10''08"', 864),
    (@Flabebe_Id, 'FAIRY', NULL, 'Flower Veil', NULL, 'Symbiosis', '0''04"', 1),
    (@Farfetchd_Galarian_Id, 'FIGHTING', NULL, 'Steadfast', NULL, 'Scrappy', '2''07"', 92),
    (@Mewtwo_MegaX_Id, 'PSYCHIC', 'FIGHTING', 'Steadfast', NULL, NULL, '7''07"', 280),
    (@Eevee_Gmax_Id, 'NORMAL', NULL, 'Run Away', 'Adaptability', 'Anticipation', '7''05"', 9999),
    (@Vaporeon_Id, 'WATER', NULL, 'Water Absorb', NULL, 'Hydration', '3''03"', 64);

-- Now insert into Pokemon_Stats
INSERT INTO Pokemon_Stats (Pokemon_Id, HP, Atk, Def, Sp_Atk, Sp_Def, Speed)
VALUES 
    (@Bulbasaur_Id, 45, 49, 49, 65, 65, 45),
    (@Ivysaur_Id, 60, 62, 63, 80, 80, 60),
    (@Venusaur_Id, 80, 82, 83, 100, 100, 80),
    (@Venusaur_Mega_Id, 80, 100, 123, 122, 120, 80),
    (@Charmander_Id, 39, 52, 43, 60, 50, 65),
    (@Charmeleon_Id, 58, 64, 58, 80, 65, 80),
    (@Charizard_Gmax_Id, 78, 84, 78, 109, 85, 100),
    (@Squirtle_Id, 44, 48, 65, 50, 64, 43),
    (@Wartortle_Id, 59, 63, 80, 65, 80, 58),
    (@Blastoise_Gmax_Id, 79, 83, 100, 85, 105, 78),
    (@Pikachu_Gmax_Id, 35, 55, 40, 50, 50, 90),
    (@MegaRayquaza_Id, 105, 180, 100, 180, 100, 115),
    (@Flabebe_Id, 44, 38, 39, 61, 79, 42),
    (@Farfetchd_Galarian_Id, 52, 90, 55, 58, 62, 60),
    (@Mewtwo_MegaX_Id, 106, 110, 90, 154, 90, 130),
    (@Eevee_Gmax_Id, 55, 55, 50, 45, 65, 55),
    (@Vaporeon_Id, 130, 65, 60, 110, 95, 65);

-- Make sure Moves exist before inserting into LearnSet
INSERT INTO Moves (Name, Power, Accuracy, Category, PP, Contact, Type)
VALUES 
    ('Tackle', 40, 100, 'Physical', 35, 1, 'NORMAL'),
    ('Vine Whip', 45, 100, 'Physical', 25, 1, 'GRASS'),
    ('Ember', 40, 100, 'Special', 25, 0, 'FIRE'),
    ('Water Gun', 40, 100, 'Special', 25, 0, 'WATER'),
    ('Thunderbolt', 90, 100, 'Special', 15, 0, 'ELECTRIC'),
    ('Thunder', 110, 70, 'Special', 10, 0, 'ELECTRIC'),
    ('Solar Beam', 120, 100, 'Special', 10, 0, 'GRASS'),
    ('Flamethrower', 90, 100, 'Special', 15, 0, 'FIRE'),
    ('Psychic', 90, 100, 'Special', 10, 0, 'PSYCHIC'),
    ('Hydro Pump', 110, 80, 'Special', 5, 0, 'WATER'),
    ('Hyper Beam', 150, 90, 'Special', 5, 0, 'NORMAL');

-- Insert LearnSet data - now working with Pokemon_Id instead of Dex_num
INSERT INTO LearnSet (Pokemon_Id, Move, Level_Learned)
VALUES (@Bulbasaur_Id, 'Tackle', 1);

INSERT INTO LearnSet (Pokemon_Id, Move, Level_Learned)
VALUES (@Bulbasaur_Id, 'Vine Whip', 3);

INSERT INTO LearnSet (Pokemon_Id, Move, Level_Learned)
VALUES (@Charmander_Id, 'Tackle', 1);

INSERT INTO LearnSet (Pokemon_Id, Move, Level_Learned)
VALUES (@Charmander_Id, 'Ember', 4);

INSERT INTO LearnSet (Pokemon_Id, Move, Level_Learned)
VALUES (@Squirtle_Id, 'Tackle', 1);

INSERT INTO LearnSet (Pokemon_Id, Move, Level_Learned)
VALUES (@Squirtle_Id, 'Water Gun', 3);

INSERT INTO LearnSet (Pokemon_Id, Move, Level_Learned)
VALUES (@Pikachu_Gmax_Id, 'Thunderbolt', 26);

INSERT INTO LearnSet (Pokemon_Id, Move, Level_Learned)
VALUES (@Pikachu_Gmax_Id, 'Thunder', 50);

INSERT INTO LearnSet (Pokemon_Id, Move, Level_Learned)
VALUES (@Venusaur_Id, 'Solar Beam', 32);

INSERT INTO LearnSet (Pokemon_Id, Move, Level_Learned)
VALUES (@Charizard_Gmax_Id, 'Flamethrower', 36);

INSERT INTO LearnSet (Pokemon_Id, Move, Level_Learned)
VALUES (@Mewtwo_MegaX_Id, 'Psychic', 1);

INSERT INTO LearnSet (Pokemon_Id, Move, Level_Learned)
VALUES (@Blastoise_Gmax_Id, 'Hydro Pump', 42);

INSERT INTO LearnSet (Pokemon_Id, Move, Level_Learned)
VALUES (@MegaRayquaza_Id, 'Hyper Beam', 75);

INSERT INTO LearnSet (Pokemon_Id, Move, Level_Learned)
VALUES (@Eevee_Gmax_Id, 'Tackle', 1);

-- Insert Evolution data with Pokemon_Id foreign keys
INSERT INTO Evolutions (Base_Pokemon_Id, Evolved_Pokemon_Id, Evolution_Method)
VALUES (@Bulbasaur_Id, @Ivysaur_Id, 'Level 16');

INSERT INTO Evolutions (Base_Pokemon_Id, Evolved_Pokemon_Id, Evolution_Method)
VALUES (@Ivysaur_Id, @Venusaur_Id, 'Level 32');

INSERT INTO Evolutions (Base_Pokemon_Id, Evolved_Pokemon_Id, Evolution_Method)
VALUES (@Charmander_Id, @Charmeleon_Id, 'Level 16');

INSERT INTO Evolutions (Base_Pokemon_Id, Evolved_Pokemon_Id, Evolution_Method)
VALUES (@Charmeleon_Id, @Charizard_Gmax_Id, 'Level 36');

INSERT INTO Evolutions (Base_Pokemon_Id, Evolved_Pokemon_Id, Evolution_Method)
VALUES (@Squirtle_Id, @Wartortle_Id, 'Level 16');

INSERT INTO Evolutions (Base_Pokemon_Id, Evolved_Pokemon_Id, Evolution_Method)
VALUES (@Wartortle_Id, @Blastoise_Gmax_Id, 'Level 36');

INSERT INTO Evolutions (Base_Pokemon_Id, Evolved_Pokemon_Id, Evolution_Method)
VALUES (@Eevee_Gmax_Id, @Vaporeon_Id, 'Water Stone');