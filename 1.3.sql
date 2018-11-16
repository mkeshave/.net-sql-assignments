use training
--1. Create a user defined data type called Region, which would store a character string of size 15.
Create Type Region_90 from varchar(15)

--2. Create a Default which would store the value ‘NA’ (North America’)
create default nothamerica as 'NA'

--3.Bind the default to the Alias Data Type of Q1 i.e. region
EXEC sp_bindefault nothamerica, Region_90


--4
alter table customer add  Customer_Region region;

--5
alter table customer add Gender char(1);

--6
alter table customer add constraint ck_gendercheck check(Gender in('M','F','T'))

--7
create table Orders_164302
(OrdersID Int NOT NULL IDENTITY (1000,1) ,
Customerld Int Not Null,
OrdersDate Datetime,
Order_State char(1) constraint char_ck check(Order_State in('P','C'))
)

--8. Add referential integrity constraint for Orders & Customer


alter table customer add constraint pk_customer primary key(customerid)

alter table Orders_164302 add constraint fk_custorder_1 foreign key(Customerld) references Customer_90661(customerId)
exec sp_help Orders_164302
exec sp_help Customer_90661

--9 Creating the Sequence
USE Training;
CREATE SEQUENCE IdSequence_164302 AS INT
START WITH 10000
INCREMENT BY 1;

select * from Employees_9066

--10 Using the Sequence to Insert New Rows
USE Training;
INSERT INTO Employees_9066 (EmployeeId, Name)
VALUES (NEXT VALUE FOR IdSequence, 'Shashank');
INSERT INTO Contractors (ContractorId, Name)
VALUES (NEXT VALUE FOR IdSequence, 'Aditya');
SELECT * FROM Employees_9066;
SELECT * FROM Contractors;