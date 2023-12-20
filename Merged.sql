/***********************************
SQL Project - RealEstate - DataBase Creation
Project made by: Michael Taxsian
***********************************/
CREATE DATABASE RealEstate;
USE RealEstate; 
CREATE TABLE dbo.Cities (
 CityID INT IDENTITY(1,1) PRIMARY KEY,
 CityName NVARCHAR(32) NOT NULL
);

-- Neighborhoods table
CREATE TABLE dbo.Neighborhoods (
 NeighborhoodID INT IDENTITY(1,1) PRIMARY KEY,
 NeighborhoodName NVARCHAR(32) NOT NULL,
 CityID INT,
 FOREIGN KEY (CityID) REFERENCES dbo.Cities (CityID)
);

-- Houses table
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

-- Sellers table
CREATE TABLE dbo.Sellers (
 SellerID INT IDENTITY(1,1) PRIMARY KEY,
 HouseID INT,
 FirstName VARCHAR(32) NOT NULL,
 LastName VARCHAR(32) NOT NULL,
 PhoneNum VARCHAR(32) NOT NULL UNIQUE,
 RequiredPrice MONEY NOT NULL,
 FOREIGN KEY (HouseID) REFERENCES dbo.Houses (HouseID)
);

-- Salesmen table
CREATE TABLE dbo.Salesmen (
 SalesmanID INT IDENTITY(1,1) PRIMARY KEY,
 FirstName VARCHAR(32) NOT NULL,
 LastName VARCHAR(32) NOT NULL,
 SpecializesType VARCHAR(32) NULL
);

-- Buyers table
CREATE TABLE dbo.Buyers (
 BuyerID INT IDENTITY(1,1) PRIMARY KEY,
 FirstName VARCHAR(32) NOT NULL,
 LastName VARCHAR(32) NOT NULL,
 PhoneNum VARCHAR(32) NOT NULL UNIQUE,
 HouseID INT,
 SaleID INT
);

-- Foreign key constraint from Buyers to Houses
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

-- Added BuyerID constraint afterward
ALTER TABLE dbo.Sales
ADD BuyerID INT NULL;
-- Added foreign key constraints
ALTER TABLE dbo.Sales
ADD CONSTRAINT FK_BuyerID FOREIGN KEY (BuyerID) REFERENCES dbo.Buyers (BuyerID);
ALTER TABLE dbo.Sales
ADD CONSTRAINT FK_SellerID FOREIGN KEY (SellerID) REFERENCES dbo.Sellers 
(SellerID);
ALTER TABLE dbo.Sales
ADD CONSTRAINT FK_SalesmanID FOREIGN KEY (SalesmanID) REFERENCES dbo.Salesmen 
(SalesmanID);
-- Added foreign key constraint from Sales to Houses
ALTER TABLE dbo.Sales
ADD CONSTRAINT FK_HouseID2 FOREIGN KEY (HouseID) REFERENCES dbo.Houses (HouseID);

-- Inserted realistic cities
INSERT INTO Cities (CityName)
VALUES
 ('New York'),
 ('Los Angeles'),
 ('Chicago'),
 ('Houston'),
 ('Miami'),
 ('San Francisco'),
 ('Boston'),
 ('Dallas'),
 ('Atlanta'),
 ('Seattle'),
 ('Denver'),
 ('Phoenix'),
 ('Philadelphia'),
 ('Las Vegas'),
 ('Miami');

-- Inserted realistic neighborhoods within the respective cities
INSERT INTO Neighborhoods (NeighborhoodName, CityID)
VALUES
 ('Downtown', 1),
 ('Beverly Hills', 2),
 ('Lincoln Park', 3),
 ('Downtown', 4),
 ('South Beach', 5),
 ('Nob Hill', 6),
 ('Back Bay', 7),
 ('Uptown', 8),
 ('Midtown', 9),
 ('Belltown', 10),
 ('Cherry Creek', 11),
 ('Scottsdale', 12),
 ('Center City', 13),
 ('The Strip', 14),
 ('Little Havana', 15);

-- Inserted 15 rows into the Houses table with varying prices and types
INSERT INTO Houses (NeighborhoodID, CityID, HouseType, Rooms, SquareMeters)
VALUES
 (1, 1, 'Apartment', 3, 80.5),
 (2, 2, 'Penthouse', 5, 150.0),
 (3, 3, 'Villa', 2, 200.0),
 (4, 4, 'Villa', 4, 220.0),
 (5, 5, 'Apartment', 1, 55.0),
 (6, 6, 'Penthouse', 6, 180.0),
 (7, 7, 'Apartment', 2, 70.0),
 (8, 8, 'Penthouse', 3, 120.0),
 (9, 9, 'Villa', 4, 190.0),
 (10, 10, 'Penthouse', 5, 140.0),
 (11, 11, 'Apartment', 2, 65.0),
 (12, 12, 'Penthouse', 4, 130.0),
 (13, 13, 'Villa', 3, 190.0),
 (14, 14, 'Penthouse', 5, 160.0),
 (15, 15, 'Apartment', 2, 65.0),
(8, 8, 'Villa', 10, 190);

-- Inserted 15 rows into the Sellers table with unique phone numbers and prices
INSERT INTO Sellers (HouseID, FirstName, LastName, PhoneNum, RequiredPrice)
VALUES
 (1, 'John', 'Doe', '111-111-1111', 250000),
 (2, 'Jane', 'Smith', '222-222-2222', 600000),
 (3, 'David', 'Brown', '333-333-3333', 1175000),
 (4, 'Sarah', 'Johnson', '444-444-4444', 1320000),
 (5, 'Michael', 'Wilson', '555-555-5555', 80000),
 (6, 'Emily', 'Davis', '666-666-6666', 1550000),
 (7, 'Daniel', 'Miller', '777-777-7777', 150000),
 (8, 'Olivia', 'Garcia', '888-888-8888', 200000),
 (9, 'Matthew', 'Martinez', '999-999-9999', 225000),
 (10, 'Ava', 'Lopez', '101-101-1010', 1000000),
 (11, 'William', 'Harris', '121-121-1212', 100000),
 (12, 'Sophia', 'Lee', '131-131-1313', 370000),
 (13, 'James', 'Clark', '141-141-1414', 220000),
 (14, 'Lily', 'White', '151-151-1515', 370000),
 (15, 'Daniel', 'Johnson', '161-161-1616', 160000),
(16, 'Johnny', 'Stewarts', '243-321-3901', 1200000);
-- Inserted 15 rows into the Salesmen table

INSERT INTO Salesmen (FirstName, LastName, SpecializesType)
VALUES
 ('John', 'Smith', 'Villas, Apartments'),
 ('Jane', 'Doe', 'Penthouses, Villas'),
 ('David', 'Brown', 'Apartments, Penthouses'),
 ('Sarah', 'Johnson', 'Penthouses'),
 ('Michael', 'Wilson', 'Villas, Apartments'),
 ('Emily', 'Davis', 'Apartments'),
 ('Daniel', 'Miller', 'Villas'),
 ('Olivia', 'Garcia', 'Villas, Apartments, Penthouses'),
 ('Matthew', 'Martinez', 'Penthouses'),
 ('Ava', 'Lopez', 'Villas, Penthouses'),
 ('William', 'Harris', 'Apartments'),
 ('Sophia', 'Lee', 'Penthouses'),
 ('James', 'Clark', 'Villas'),
 ('Lily', 'White', 'Villas, Apartments'),
 ('Daniel', 'Johnson', 'Penthouses');

-- Inserted 15 rows into the Buyers table with unique phone numbers
INSERT INTO Buyers (FirstName, LastName, PhoneNum, HouseID, SaleID)
VALUES
 ('Benjamin', 'Smith', '171-171-1717', 1, 1),
 ('Olivia', 'Johnson', '181-181-1818', 2, 2),
 ('Liam', 'Wilson', '191-191-1919', 3, 3),
 ('Emma', 'Martin', '202-202-2020', 4, 4),
 ('Noah', 'Miller', '212-212-2121', 5, 5),
 ('Jane', 'Smith', '222-222-2222', 6, 6),
 ('Elijah', 'Garcia', '232-232-2323', 7, 7),
 ('Mia', 'Hernandez', '242-242-2424', 8, 8),
 ('Lucas', 'Lopez', '252-252-2525', 9, 9),
 ('Sarah', 'Johnson', '444-444-4444', 10, 10), 
 ('Mason', 'Johnson', '272-272-2727', 11, 11),
 ('Isabella', 'Lee', '282-282-2828', 12, 12),
 ('Liam', 'Clark', '292-292-2929', 13, 13),
 ('Olivia', 'White', '303-303-3030', 14, 14),
 ('Ethan', 'Brown', '313-313-3131', 15, 15);

-- Inserted 15 rows into the Sales table with varying HousePrice
INSERT INTO Sales (SaleDate, HouseID, HousePrice, SalesmanID, SellerID, BuyerID)
VALUES
 ('2022-09-10', 1, 300000, 1, 1, 1),
 ('2021-10-11', 2, 700000, 1, 2, 2),
 ('2023-11-12', 3, 1300000, 1, 3, 3),
 ('2022-02-13', 4, 1500000, 5, 4, 4),
 ('2023-04-14', 5, 110000, 4, 5, 5),
 ('2020-09-15', 6, 1600000, 7, 6, 6),
 ('2023-08-16', 7, 190000, 7, 7, 7),
 ('2019-01-17', 8, 260000, 10, 8, 8),
 ('2018-04-18', 9, 310000, 11, 9, 9),
 ('2023-02-20', 10, 1450000, 12, 10, 10),
 ('2022-09-24', 11, 120000, 13, 11, 11),
 ('2023-06-27', 12, 400000, 13, 12, 12),
 ('2023-03-22', 13, 250000, 15, 13, 13),
 ('2023-02-23', 14, 410000, 4, 14, 14),
 ('2023-01-24', 15, 180000, 6, 15, 15),
(NULL, 16, 1400000, 13, 16, NULL);
--Project Queries

-- Start Query 1 
SELECT HouseType, YEAR(SaleDate) AS SaleYear, SUM(HousePrice - RequiredPrice) AS 
CompanyProfit
FROM Houses
JOIN Sales ON Houses.HouseID = Sales.HouseID
JOIN Sellers ON Sellers.SellerID = Sales.SellerID
JOIN Buyers ON Buyers.HouseID = Sales.HouseID -- Add this join condition
WHERE YEAR(SaleDate) = YEAR(GETDATE()) 
 AND Buyers.BuyerID IS NOT NULL -- Add this condition to exclude houses with 
NULL BuyerID
GROUP BY HouseType, YEAR(SaleDate);
-- End of Query 1 

-- Start Query 2 

SELECT B.FirstName, B.LastName, S.RequiredPrice AS SoldOldHouse, Bought.HousePrice 
AS BuyNewHouse
FROM Sellers S
JOIN Buyers B ON S.PhoneNum = B.PhoneNum
JOIN Sales ON S.SellerID = Sales.SellerID
JOIN Sales Bought ON B.BuyerID = Bought.BuyerID
WHERE Bought.HousePrice > S.RequiredPrice;
-- End of Query 2 

-- Start Query 3

SELECT TOP 1 N.NeighborhoodName, C.CityName, AVG(S.HousePrice) AS AveragePrice
FROM Neighborhoods N
JOIN Cities C ON N.CityID = C.CityID
JOIN Houses H ON N.NeighborhoodID = H.NeighborhoodID
JOIN Sales S ON H.HouseID = S.HouseID
WHERE S.BuyerID IS NOT NULL -- Ensure that BuyerID is NOT NULL
GROUP BY N.NeighborhoodName, C.CityName
ORDER BY AveragePrice DESC;
-- End of Query 3 

-- Start Query 4 

WITH EmployeeYearlyProfit AS
(
 SELECT
 SM.SalesmanID,
 YEAR(SaleDate) AS SaleYear,
 SUM(HousePrice - RequiredPrice) AS YearlyProfit,
 RANK() OVER (PARTITION BY YEAR(SaleDate) ORDER BY SUM(HousePrice - 
RequiredPrice) DESC) AS Rank
 FROM
 Sales
 JOIN Salesmen SM ON Sales.SalesmanID = SM.SalesmanID
 JOIN Houses ON Sales.HouseID = Houses.HouseID
 JOIN Sellers ON Sales.SellerID = Sellers.SellerID
 JOIN Buyers ON Sales.BuyerID = Buyers.BuyerID -- Ensure BuyerID is not NULL
 WHERE
 Sales.BuyerID IS NOT NULL -- Ensure BuyerID is not NULL
 GROUP BY
 SM.SalesmanID,
 YEAR(SaleDate)
)
SELECT
 SM.SalesmanID,
 FirstName,
 SM.LastName,
 EYP.SaleYear,
 EYP.YearlyProfit
FROM
 EmployeeYearlyProfit EYP
JOIN Salesmen SM ON EYP.SalesmanID = SM.SalesmanID
WHERE
 EYP.Rank = 1;
-- End of Query 4 

-- Start Query 5 

SELECT DISTINCT B.BuyerID, B.FirstName, B.LastName, S1.SaleDate AS HouseBoughtDate,
H2.HouseID, H2.HouseType, H2.SquareMeters
FROM dbo.Buyers B
INNER JOIN dbo.Sales S1 ON B.BuyerID = S1.BuyerID
INNER JOIN dbo.Houses H1 ON H1.HouseID = S1.HouseID
LEFT JOIN (
SELECT H.* 
FROM dbo.Houses H
LEFT JOIN dbo.Sales S2 ON H.HouseID = S2.HouseID
WHERE S2.BuyerID IS NULL
) H2 ON H1.CityID = H2.CityID AND H1.NeighborhoodID = H2.NeighborhoodID
WHERE S1.SaleDate <= DATEADD(YEAR, -2, GETDATE()) AND (H2.Rooms > H1.Rooms OR 
H2.SquareMeters > H1.SquareMeters);
-- End of Query 5
