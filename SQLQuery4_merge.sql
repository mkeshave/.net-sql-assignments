use training_24oct18_pune

--1.Merge  query
--source table
CREATE TABLE Products_302
(
ProductID INT PRIMARY KEY,
ProductName VARCHAR(100),
Rate MONEY
)

select * from products_302

--Targate Table
CREATE TABLE UpdatedProducts_302
(
ProductID INT PRIMARY KEY,
ProductName VARCHAR(100),
Rate MONEY
)

--insert into source
INSERT INTO Products_302
VALUES
(1,'Tea', 10.00),
(2, 'Coffee', 20.00),
(3, 'Muffin', 30.00),
(4, 'Biscuit', 40.00)

--insert into targate table
INSERT INTO UpdatedProducts_302
VALUES
(1, 'Tea', 10.00),
(2, 'Coffee', 25.00),
(3, 'Muffin', 35.00),
(5, 'Pizza', 60.00)


--Synchronize the target table with
--refreshed data from source table

--When records are matched, update
--the records if there is any change

--When no records are matched, insert
--the incoming records from source
--table to target table

--When there is a row that exists in target table and
--same record does not exist in source table
--then delete this record from target table

--$action specifies a column of type nvarchar(10)
--in the OUTPUT clause that returns one of three
--values for each row: 'INSERT', 'UPDATE', or 'DELETE',
--according to the action that was performed on that row

MERGE Products_302 AS TARGET
USING UpdatedProducts_302 AS SOURCE
ON (TARGET.ProductID = SOURCE.ProductID)


WHEN MATCHED AND TARGET.ProductName <> SOURCE.ProductName
OR TARGET.Rate <> SOURCE.Rate THEN
UPDATE SET TARGET.ProductName = SOURCE.ProductName,
TARGET.Rate = SOURCE.Rate

WHEN NOT MATCHED BY TARGET THEN
INSERT (ProductID, ProductName, Rate)
VALUES (SOURCE.ProductID, SOURCE.ProductName, SOURCE.Rate)

WHEN NOT MATCHED BY SOURCE THEN Delete

OUTPUT $action,
DELETED.ProductID AS TargetProductID,
DELETED.ProductName AS TargetProductName,
DELETED.Rate AS TargetRate,
INSERTED.ProductID AS SourceProductID,
INSERTED.ProductName AS SourceProductName,
INSERTED.Rate AS SourceRate;
SELECT @@Rowcount;