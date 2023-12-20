-- Remove the database named 'RealEstate' if it exists
IF EXISTS (SELECT * FROM sys.databases WHERE NAME = 'RealEstate')
BEGIN
    ALTER DATABASE RealEstate SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE RealEstate;
END;

-- Create the database named 'RealEstate'
CREATE DATABASE RealEstate;

-- Use the 'RealEstate' database
USE RealEstate; -- Corrected comment to match the database name 'RealEstate'

-- Create the Cities table
CREATE TABLE dbo.Cities (
    CityID INT IDENTITY(1,1) PRIMARY KEY,
    CityName NVARCHAR(32) NOT NULL
);

-- Create the Neighborhoods table
CREATE TABLE dbo.Neighborhoods (
    NeighborhoodID INT IDENTITY(1,1) PRIMARY KEY,
    NeighborhoodName NVARCHAR(32) NOT NULL,
    CityID INT,
    FOREIGN KEY (CityID) REFERENCES dbo.Cities (CityID)
);

-- Create the Houses table
CREATE TABLE dbo.Houses (
    HouseID INT IDENTITY(1,1) PRIMARY KEY,
    NeighborhoodID INT,
    CityID INT,
    HouseType VARCHAR(32) NOT NULL,
    Rooms INT NOT NULL,
    SquareMeters DECIMAL(5,2) NOT NULL,
    FOREIGN KEY (NeighborhoodID) REFERENCES dbo.Neighborhoods (NeighborhoodID),
    FOREIGN KEY (CityID) REFERENCES dbo.Cities (CityID)
);

-- Create Sellers table
CREATE TABLE dbo.Sellers (
    SellerID INT IDENTITY(1,1) PRIMARY KEY,
    HouseID INT,
    FirstName VARCHAR(32) NOT NULL,
    LastName VARCHAR(32) NOT NULL,
    PhoneNum VARCHAR(32) NOT NULL UNIQUE,
    RequiredPrice MONEY NOT NULL,
    FOREIGN KEY (HouseID) REFERENCES dbo.Houses (HouseID)
);

-- Create Salesmen table
CREATE TABLE dbo.Salesmen (
    SalesmanID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(32) NOT NULL,
    LastName VARCHAR(32) NOT NULL,
    SpecializesType VARCHAR(32) NULL
);

-- Create Buyers table
CREATE TABLE dbo.Buyers (
    BuyerID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(32) NOT NULL,
    LastName VARCHAR(32) NOT NULL,
    PhoneNum VARCHAR(32) NOT NULL UNIQUE,
    HouseID INT,
    SaleID INT
);

-- Add a foreign key constraint from Buyers to Houses
ALTER TABLE dbo.Buyers
ADD CONSTRAINT FK_HouseID FOREIGN KEY (HouseID) REFERENCES dbo.Houses (HouseID);

-- Create Sales table without the BuyerID constraint initially
CREATE TABLE dbo.Sales (
    SaleID INT IDENTITY(1,1) PRIMARY KEY,
    SaleDate DATE NULL,
    HouseID INT,
    HousePrice MONEY NOT NULL,
    SalesmanID INT,
    SellerID INT
);

-- Add the BuyerID constraint afterward
ALTER TABLE dbo.Sales
ADD BuyerID INT NULL;

-- Add foreign key constraints
ALTER TABLE dbo.Sales
ADD CONSTRAINT FK_BuyerID FOREIGN KEY (BuyerID) REFERENCES dbo.Buyers (BuyerID);

ALTER TABLE dbo.Sales
ADD CONSTRAINT FK_SellerID FOREIGN KEY (SellerID) REFERENCES dbo.Sellers (SellerID);

ALTER TABLE dbo.Sales
ADD CONSTRAINT FK_SalesmanID FOREIGN KEY (SalesmanID) REFERENCES dbo.Salesmen (SalesmanID);

-- Add a foreign key constraint from Sales to Houses
ALTER TABLE dbo.Sales
ADD CONSTRAINT FK_HouseID2 FOREIGN KEY (HouseID) REFERENCES dbo.Houses (HouseID);