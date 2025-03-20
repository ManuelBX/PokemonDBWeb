-- Create database
CREATE DATABASE PokemonDB;
GO

USE PokemonDB;
GO

-- Create Types table
CREATE TABLE Types (
    Name VARCHAR(10) PRIMARY KEY,
    vs_Normal FLOAT CHECK (vs_Normal >= 0 AND vs_Normal <= 4) NOT NULL,
    vs_Fire FLOAT CHECK (vs_Fire >= 0 AND vs_Fire <= 4) NOT NULL,
    vs_Water FLOAT CHECK (vs_Water >= 0 AND vs_Water <= 4) NOT NULL,
    vs_Electric FLOAT CHECK (vs_Electric >= 0 AND vs_Electric <= 4) NOT NULL,
    vs_Grass FLOAT CHECK (vs_Grass >= 0 AND vs_Grass <= 4) NOT NULL,
    vs_Ice FLOAT CHECK (vs_Ice >= 0 AND vs_Ice <= 4) NOT NULL,
    vs_Fighting FLOAT CHECK (vs_Fighting >= 0 AND vs_Fighting <= 4) NOT NULL,
    vs_Poison FLOAT CHECK (vs_Poison >= 0 AND vs_Poison <= 4) NOT NULL,
    vs_Ground FLOAT CHECK (vs_Ground >= 0 AND vs_Ground <= 4) NOT NULL,
    vs_Flying FLOAT CHECK (vs_Flying >= 0 AND vs_Flying <= 4) NOT NULL,
    vs_Psychic FLOAT CHECK (vs_Psychic >= 0 AND vs_Psychic <= 4) NOT NULL,
    vs_Bug FLOAT CHECK (vs_Bug >= 0 AND vs_Bug <= 4) NOT NULL,
    vs_Rock FLOAT CHECK (vs_Rock >= 0 AND vs_Rock <= 4) NOT NULL,
    vs_Ghost FLOAT CHECK (vs_Ghost >= 0 AND vs_Ghost <= 4) NOT NULL,
    vs_Dragon FLOAT CHECK (vs_Dragon >= 0 AND vs_Dragon <= 4) NOT NULL,
    vs_Dark FLOAT CHECK (vs_Dark >= 0 AND vs_Dark <= 4) NOT NULL,
    vs_Steel FLOAT CHECK (vs_Steel >= 0 AND vs_Steel <= 4) NOT NULL,
    vs_Fairy FLOAT CHECK (vs_Fairy >= 0 AND vs_Fairy <= 4) NOT NULL,
    CONSTRAINT check_type_name_length CHECK (LEN(Name) BETWEEN 1 AND 10)
);

-- Create Abilities table
CREATE TABLE Abilities (
    Name VARCHAR(256) PRIMARY KEY,
    Description VARCHAR(256) NOT NULL,
    CONSTRAINT check_ability_name_length CHECK (LEN(Name) BETWEEN 1 AND 256)
);
GO

-- Create PokeDex table
CREATE TABLE PokeDex (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    Dex_Num INT NOT NULL,
    Name VARCHAR(256) NOT NULL,
    Regional_Form VARCHAR(256) DEFAULT('Base'),
    CONSTRAINT check_pokedex_name_length CHECK (LEN(Name) BETWEEN 1 AND 256),
    -- Ensure combination of Dex_Num, Name, and Regional_Form is unique
    CONSTRAINT UK_Pokedex_DexNum_Name_Form UNIQUE (Dex_Num, Name, Regional_Form)
);
GO

-- Create Pokemon table using PokeDex.Id as reference
CREATE TABLE Pokemon (
    Pokemon_Id UNIQUEIDENTIFIER PRIMARY KEY,
    Type1 VARCHAR(10) NOT NULL,
    Type2 VARCHAR(10), -- Can be NULL
    Ability1 VARCHAR(256) NOT NULL,
    Ability2 VARCHAR(256), -- Can be NULL
    Ability3 VARCHAR(256), -- Can be NULL
    Height INT NOT NULL CHECK (Height > 0),
    Weight INT NOT NULL CHECK (Weight > 0),
    
    FOREIGN KEY (Pokemon_Id) REFERENCES PokeDex(Id),
    FOREIGN KEY (Type1) REFERENCES Types(Name),
    FOREIGN KEY (Type2) REFERENCES Types(Name),
    FOREIGN KEY (Ability1) REFERENCES Abilities(Name),
    FOREIGN KEY (Ability2) REFERENCES Abilities(Name),
    FOREIGN KEY (Ability3) REFERENCES Abilities(Name),
);
GO

-- Create Moves table

CREATE TABLE Moves (
    Name VARCHAR(256) PRIMARY KEY,
    Power INT CHECK (Power >= 0),
    Accuracy INT CHECK (Accuracy >= 0),
    Category VARCHAR(10) NOT NULL,
    PP INT NOT NULL CHECK (PP > 0),
<<<<<<< Updated upstream
    -- Contact BIT NOT NULL, -- BIT is SQL Server's boolean type REMOVED
=======
>>>>>>> Stashed changes
    Type VARCHAR(10) NOT NULL,
    FOREIGN KEY (Type) REFERENCES Types(Name),
    CONSTRAINT check_move_name_length CHECK (LEN(Name) BETWEEN 1 AND 256),
    CONSTRAINT check_category CHECK (Category IN ('Special', 'Status', 'Physical'))
);
GO

-- Create LearnSet table with Pokemon_Id
CREATE TABLE LearnSet (
    Pokemon_Id UNIQUEIDENTIFIER,
    Move VARCHAR(256),
    Level_Learned INT CHECK (Level_Learned >= 0),
    PRIMARY KEY (Pokemon_Id, Move, Level_Learned),
    FOREIGN KEY (Pokemon_Id) REFERENCES Pokemon(Pokemon_Id),
    FOREIGN KEY (Move) REFERENCES Moves(Name)
);
GO

-- Create Evolutions table with Pokemon_Id
CREATE TABLE Evolutions (
    Base_Pokemon_Id UNIQUEIDENTIFIER,
    Evolved_Pokemon_Id UNIQUEIDENTIFIER,
    Evolution_Method VARCHAR(256) NOT NULL,
    PRIMARY KEY (Base_Pokemon_Id, Evolved_Pokemon_Id),
    FOREIGN KEY (Base_Pokemon_Id) REFERENCES Pokemon(Pokemon_Id),
    FOREIGN KEY (Evolved_Pokemon_Id) REFERENCES Pokemon(Pokemon_Id),
    CONSTRAINT check_different_pokemon CHECK (Base_Pokemon_Id <> Evolved_Pokemon_Id)
);
GO

-- Create Pokemon_Stats table
CREATE TABLE Pokemon_Stats (
    Pokemon_Id UNIQUEIDENTIFIER PRIMARY KEY,
    HP INT NOT NULL CHECK (HP > 0),
    Atk INT NOT NULL CHECK (Atk > 0),
    Def INT NOT NULL CHECK (Def > 0),
    Sp_Atk INT NOT NULL CHECK (Sp_Atk > 0),
    Sp_Def INT NOT NULL CHECK (Sp_Def > 0),
    Speed INT NOT NULL CHECK (Speed > 0),
    FOREIGN KEY (Pokemon_Id) REFERENCES Pokemon(Pokemon_Id)
);
GO

-- Create useful indexes
CREATE INDEX idx_pokedex_dexnum ON PokeDex(Dex_Num);
CREATE INDEX idx_pokedex_name ON PokeDex(Name);
CREATE INDEX idx_pokedex_form ON PokeDex(Regional_Form);
GO