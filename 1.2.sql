--1. Identify all the system and user defined database in your system
select * from sys.databases

 --2.Make master database as your current database
 use master

 --3.Find out if your active database is master
 Select DB_NAME()

 --4.Now make Training database as your active database
 use Training
 use Northwind
  
--5.Find out the content of the database Employee
exec sp_help 'Employee'

--6.Repeat the above steps for master database and Northwind database
use master
exec sp_help 'spt_fallback_db'

--7. Find out the version of your SQL Server
select @@version

--8. Find out the server date
Select getdate()

--9. Make Northwind as your current database , find out information about tables using the command - Categories ,Products , Orders, Order Details , Employees
use Northwind
exec sp_help 'Categories'
exec sp_help 'Products'
exec sp_help 'Orders'
exec sp_help 'Order Details'
exec sp_help 'Employees'

--1.3 
--1. Create a Table called Customer_<empid>
create table Customer_9066
(
Customerid Int  NOT NULL Unique,
CustomerName varchar(20) Not Null,
Address1 varchar(30),
Address2 varchar(30),
ContactNumber varchar(12) Not Null,
PostalCode varchar(10)
)

--2
CREATE TABLE Employees_9066
(
EmployeeId INT NOT NULL PRIMARY KEY,
Name NVARCHAR(255) NULL
);


--3
CREATE TABLE Contractors_9066
(
ContractorId INT NOT NULL PRIMARY KEY,
Name NVARCHAR(255) NULL
);

--4
USE Training;
CREATE TABLE dbo.TestRethrow
(
ID INT PRIMARY KEY
);

