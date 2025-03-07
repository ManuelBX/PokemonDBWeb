-- Create database
CREATE DATABASE PokemonDB;
GO

USE PokemonDB;
GO

--Create Types table
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

-- Create Pokemon table - Added single-column index for Dex_Num and Name
CREATE TABLE Pokemon (
    Name VARCHAR(256),
	Regional_Form VARCHAR(256) DEFAULT('Base'),
    Dex_Num INT,
    Type1 VARCHAR(10) NOT NULL,
    Type2 VARCHAR(10), -- Can be NULL
    Ability1 VARCHAR(256) NOT NULL,
    Ability2 VARCHAR(256), -- Can be NULL
    Ability3 VARCHAR(256), -- Can be NULL
    Height VARCHAR(256) NOT NULL,
    Weight INT NOT NULL CHECK (Weight > 0),
    HP INT NOT NULL CHECK (HP > 0),
    Atk INT NOT NULL CHECK (Atk > 0),
    Def INT NOT NULL CHECK (Def > 0),
    Sp_Atk INT NOT NULL CHECK (Sp_Atk > 0),
    Sp_Def INT NOT NULL CHECK (Sp_Def > 0),
    Speed INT NOT NULL CHECK (Speed > 0),
    PRIMARY KEY (Name, Dex_Num, Regional_Form),
    FOREIGN KEY (Type1) REFERENCES Types(Name),
    FOREIGN KEY (Type2) REFERENCES Types(Name),
    FOREIGN KEY (Ability1) REFERENCES Abilities(Name),
    FOREIGN KEY (Ability2) REFERENCES Abilities(Name),
    FOREIGN KEY (Ability3) REFERENCES Abilities(Name),
    CONSTRAINT check_pokemon_name_length CHECK (LEN(Name) BETWEEN 1 AND 256),
    CONSTRAINT check_height_format CHECK (Height LIKE ' [0-9]%''[0-9][0-9] ' AND 
                                          SUBSTRING(Height, PATINDEX('%''%', Height) + 1, 2) BETWEEN '00' AND '11')
);
GO

-- Create single-column indexes for the Pokemon table to support foreign key relationships
CREATE UNIQUE INDEX IX_Pokemon_Name ON Pokemon(Name);
CREATE UNIQUE INDEX IX_Pokemon_Dex_Num ON Pokemon(Dex_Num);
GO

-- Create PokeDex table
CREATE TABLE PokeDex (
    Pokemon_Name VARCHAR(256),
    Number INT PRIMARY KEY,
    FOREIGN KEY (Pokemon_Name) REFERENCES Pokemon(Name)
);
GO

-- Create Moves table (with DROP IF EXISTS to fix duplicate error)
IF OBJECT_ID('dbo.Moves', 'U') IS NOT NULL
    DROP TABLE dbo.Moves;
GO

CREATE TABLE Moves (
    Name VARCHAR(256) PRIMARY KEY,
    Power INT CHECK (Power >= 0),
    Accuracy INT CHECK (Accuracy > 0),
    Category VARCHAR(10) NOT NULL,
    PP INT NOT NULL CHECK (PP > 0),
    Contact BIT NOT NULL, -- BIT is SQL Server's boolean type
    Type VARCHAR(10) NOT NULL,
    FOREIGN KEY (Type) REFERENCES Types(Name),
    CONSTRAINT check_move_name_length CHECK (LEN(Name) BETWEEN 1 AND 256),
    CONSTRAINT check_category CHECK (Category IN ('Special', 'Status', 'Physical'))
);
GO

-- Create LearnSet table
CREATE TABLE LearnSet (
    Dex_num INT,
    Move VARCHAR(256),
    Level_Learned INT CHECK (Level_Learned > 0),
    PRIMARY KEY (Dex_num, Move),
    FOREIGN KEY (Dex_num) REFERENCES Pokemon(Dex_Num),
    FOREIGN KEY (Move) REFERENCES Moves(Name)
);
GO

-- Create Evolutions table
CREATE TABLE Evolutions (
    Base VARCHAR(256),
    Evolutions VARCHAR(256),
    PRIMARY KEY (Base, Evolutions),
    FOREIGN KEY (Base) REFERENCES Pokemon(Name),
    FOREIGN KEY (Evolutions) REFERENCES Pokemon(Name)
);
GO