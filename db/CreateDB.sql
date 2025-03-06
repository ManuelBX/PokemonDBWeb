-- Create database
CREATE DATABASE PokemonDB;
GO

USE PokemonDB;
GO

-- Create Types table
CREATE TABLE Types (
    Name VARCHAR(10) PRIMARY KEY,
    CONSTRAINT check_type_name_length CHECK (LEN(Name) BETWEEN 1 AND 10)
);
GO

-- Create junction tables for type relationships
CREATE TABLE TypeWeakTo (
    TypeName VARCHAR(10),
    WeakToType VARCHAR(10),
    PRIMARY KEY (TypeName, WeakToType),
    FOREIGN KEY (TypeName) REFERENCES Types(Name),
    FOREIGN KEY (WeakToType) REFERENCES Types(Name)
);
GO

CREATE TABLE TypeWeakAgainst (
    TypeName VARCHAR(10),
    WeakAgainstType VARCHAR(10),
    PRIMARY KEY (TypeName, WeakAgainstType),
    FOREIGN KEY (TypeName) REFERENCES Types(Name),
    FOREIGN KEY (WeakAgainstType) REFERENCES Types(Name)
);
GO

CREATE TABLE TypeStrongTo (
    TypeName VARCHAR(10),
    StrongToType VARCHAR(10),
    PRIMARY KEY (TypeName, StrongToType),
    FOREIGN KEY (TypeName) REFERENCES Types(Name),
    FOREIGN KEY (StrongToType) REFERENCES Types(Name)
);
GO

CREATE TABLE TypeStrongAgainst (
    TypeName VARCHAR(10),
    StrongAgainstType VARCHAR(10),
    PRIMARY KEY (TypeName, StrongAgainstType),
    FOREIGN KEY (TypeName) REFERENCES Types(Name),
    FOREIGN KEY (StrongAgainstType) REFERENCES Types(Name)
);
GO

CREATE TABLE TypeImmuneTo (
    TypeName VARCHAR(10),
    ImmuneToType VARCHAR(10),
    PRIMARY KEY (TypeName, ImmuneToType),
    FOREIGN KEY (TypeName) REFERENCES Types(Name),
    FOREIGN KEY (ImmuneToType) REFERENCES Types(Name)
);
GO

CREATE TABLE TypeIneffectiveAgainst (
    TypeName VARCHAR(10),
    IneffectiveAgainstType VARCHAR(10),
    PRIMARY KEY (TypeName, IneffectiveAgainstType),
    FOREIGN KEY (TypeName) REFERENCES Types(Name),
    FOREIGN KEY (IneffectiveAgainstType) REFERENCES Types(Name)
);
GO

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
    Regional_Forms VARCHAR(256),
    PRIMARY KEY (Name, Dex_Num, Height),
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