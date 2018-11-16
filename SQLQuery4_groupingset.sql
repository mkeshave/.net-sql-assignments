
CREATE TABLE Employee_302
(
Employee_Number INT NOT NULL PRIMARY
KEY,
Employee_Name VARCHAR(30) NULL,
Salary FLOAT NULL,
Department_Number INT NULL,
Region VARCHAR(30) NULL
)

SELECT Region, Department_Number, AVG (Salary) as
Average_Salary
From Employee
Group BY GROUPING SETS
( (Region, Department_Number),
(Region),
(Department_Number)
)