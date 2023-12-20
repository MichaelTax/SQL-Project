USE RealEstate
--Project Queries

-- Exercise 1 Project:
SELECT HouseType, YEAR(SaleDate) AS SaleYear, SUM(HousePrice - RequiredPrice) AS CompanyProfit
FROM Houses
JOIN Sales ON Houses.HouseID = Sales.HouseID
JOIN Sellers ON Sellers.SellerID = Sales.SellerID
JOIN Buyers ON Buyers.HouseID = Sales.HouseID  -- Add this join condition
WHERE YEAR(SaleDate) = YEAR(GETDATE()) 
      AND Buyers.BuyerID IS NOT NULL  -- Add this condition to exclude houses with NULL BuyerID
GROUP BY HouseType, YEAR(SaleDate);

-- Exercise 2 Project:
SELECT B.FirstName, B.LastName, S.RequiredPrice AS SoldOldHouse, Bought.HousePrice AS BuyNewHouse
FROM Sellers S
JOIN Buyers B ON S.PhoneNum = B.PhoneNum
JOIN Sales ON S.SellerID = Sales.SellerID
JOIN Sales Bought ON B.BuyerID = Bought.BuyerID
WHERE Bought.HousePrice > S.RequiredPrice;

--Exercise 3 Project:
SELECT TOP 1 N.NeighborhoodName, C.CityName, AVG(S.HousePrice) AS AveragePrice
FROM Neighborhoods N
JOIN Cities C ON N.CityID = C.CityID
JOIN Houses H ON N.NeighborhoodID = H.NeighborhoodID
JOIN Sales S ON H.HouseID = S.HouseID
WHERE S.BuyerID IS NOT NULL  -- Ensure that BuyerID is NOT NULL
GROUP BY N.NeighborhoodName, C.CityName
ORDER BY AveragePrice DESC;

-- Exercise 4 Project:
WITH EmployeeYearlyProfit AS
(
    SELECT
        SM.SalesmanID,
        YEAR(SaleDate) AS SaleYear,
        SUM(HousePrice - RequiredPrice) AS YearlyProfit,
        RANK() OVER (PARTITION BY YEAR(SaleDate) ORDER BY SUM(HousePrice - RequiredPrice) DESC) AS Rank
    FROM
        Sales
    JOIN Salesmen SM ON Sales.SalesmanID = SM.SalesmanID
    JOIN Houses ON Sales.HouseID = Houses.HouseID
    JOIN Sellers ON Sales.SellerID = Sellers.SellerID
    JOIN Buyers ON Sales.BuyerID = Buyers.BuyerID -- Ensure BuyerID is not NULL
    WHERE
        Sales.BuyerID IS NOT NULL  -- Ensure BuyerID is not NULL
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

-- Exercise 5
SELECT DISTINCT B.BuyerID, B.FirstName, B.LastName, S1.SaleDate AS HouseBoughtDate, H2.HouseID, H2.HouseType, H2.SquareMeters
FROM dbo.Buyers B
INNER JOIN dbo.Sales S1 ON B.BuyerID = S1.BuyerID
INNER JOIN dbo.Houses H1 ON H1.HouseID = S1.HouseID
LEFT JOIN (
SELECT H.* 
FROM dbo.Houses H
LEFT JOIN dbo.Sales S2 ON H.HouseID = S2.HouseID
WHERE S2.BuyerID IS NULL
) H2 ON H1.CityID = H2.CityID AND H1.NeighborhoodID = H2.NeighborhoodID
WHERE S1.SaleDate <= DATEADD(YEAR, -2, GETDATE()) AND (H2.Rooms > H1.Rooms OR H2.SquareMeters > H1.SquareMeters);