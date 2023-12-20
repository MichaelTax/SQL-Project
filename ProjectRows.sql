USE RealEstate
-- Insert realistic cities
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

-- Insert realistic neighborhoods within the respective cities
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

-- Insert 15 rows into the Houses table with varying prices and types
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

-- Insert 15 rows into the Sellers table with unique phone numbers and prices
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

-- Insert 15 rows into the Salesmen table
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

-- Insert 15 rows into the Buyers table with unique phone numbers
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

-- Insert 15 rows into the Sales table with varying HousePrice
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