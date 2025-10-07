/*Project Title: Complete Company Management & Analytics System


Description:
This project manages employees, departments, projects, sales, and inventory. It demonstrates basic CRUD operations, joins, aggregations, ranking, transactions, and advanced SQL concepts like triggers, stored procedures, views, and functions.

1. Database Schema
Departments */



CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY IDENTITY(1,1),
    DepartmentName VARCHAR(50) NOT NULL,
    Location VARCHAR(50)
);




--Employees
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100),
    DepartmentID INT,
    JobTitle VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

SELECT * FROM Employees;



--Projects
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY IDENTITY(1,1),
    ProjectName VARCHAR(100),
    StartDate DATE,
    EndDate DATE,
    Budget DECIMAL(12,2)
);




--EmployeeProjects (Many-to-Many)
CREATE TABLE EmployeeProjects (
    EmployeeID INT,
    ProjectID INT,
    ContributionPercent DECIMAL(5,2),
    PRIMARY KEY(EmployeeID, ProjectID),
    FOREIGN KEY(EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY(ProjectID) REFERENCES Projects(ProjectID)
);
select * FROM EmployeeProjects





--Sales
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT,
    SaleDate DATE,
    ProductName VARCHAR(100),
    Amount DECIMAL(12,2),
    FOREIGN KEY(EmployeeID) REFERENCES Employees(EmployeeID)
);




--Inventory
CREATE TABLE Inventory (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(100),
    Quantity INT,
    Price DECIMAL(10,2)
);




--2. Sample Data
-- Departments
INSERT INTO Departments (DepartmentName, Location) VALUES 
('IT','Mumbai'),('HR','Pune'),('Finance','Delhi'),('Sales','Bangalore');





-- Employees
INSERT INTO Employees (FirstName, LastName, Email, DepartmentID, JobTitle, Salary, HireDate) VALUES
('Amit','Kumar','amit@company.com',1,'Software Engineer',60000,'2022-01-10'),
('Neha','Sharma','neha@company.com',2,'HR Manager',75000,'2021-03-15'),
('Ravi','Patel','ravi@company.com',3,'Accountant',70000,'2020-06-01'),
('Pooja','Desai','pooja@company.com',1,'Senior Developer',90000,'2019-09-20'),
('Suresh','Mehta','suresh@company.com',4,'Sales Executive',50000,'2023-02-01');





-- Projects
INSERT INTO Projects (ProjectName, StartDate, EndDate, Budget) VALUES
('Website Development','2023-01-01','2023-06-30',200000),
('HR Automation','2023-02-15','2023-07-15',150000),
('Financial Audit','2023-03-01','2023-08-30',100000);







-- EmployeeProjects
INSERT INTO EmployeeProjects (EmployeeID, ProjectID, ContributionPercent) VALUES
(1,1,50),(4,1,50),(2,2,100),(3,3,100);







-- Sales
INSERT INTO Sales (EmployeeID, SaleDate, ProductName, Amount) VALUES
(5,'2023-03-10','Product A',50000),(5,'2023-03-15','Product B',70000);




-- Inventory
INSERT INTO Inventory (ProductName, Quantity, Price) VALUES
('Product A',100,500),(Product B',200,700),(Product C',50,900);




--3. SQL Queries (Basic to Advanced)
--Basic Queries
-- List all employees

SELECT * FROM Employees;

-- List all departments
SELECT * FROM Departments;



-- Employees with department names
SELECT e.FirstName, e.LastName, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID;


-- Products in inventory
SELECT * FROM Inventory;

--Intermediate Queries
-- Top 3 highest salaries in each department


SELECT *
FROM (
    SELECT e.*, d.DepartmentName,
    DENSE_RANK() OVER(PARTITION BY e.DepartmentID ORDER BY e.Salary DESC) AS RankSalary
    FROM Employees e
    JOIN Departments d ON e.DepartmentID = d.DepartmentID
) t
WHERE RankSalary <=3;



-- Employees with multiple projects
SELECT e.FirstName, e.LastName, COUNT(ep.ProjectID) AS ProjectCount
FROM EmployeeProjects ep
JOIN Employees e ON ep.EmployeeID = e.EmployeeID
GROUP BY e.FirstName, e.LastName
HAVING COUNT(ep.ProjectID) >1;




-- Total sales by employee
SELECT e.FirstName, e.LastName, SUM(s.Amount) AS TotalSales
FROM Sales s
JOIN Employees e ON s.EmployeeID = e.EmployeeID
GROUP BY e.FirstName, e.LastName;



-- Average salary per department
SELECT d.DepartmentName, AVG(e.Salary) AS AvgSalary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;



--Advanced Queries
-- Employees not assigned to any project
SELECT e.FirstName, e.LastName
FROM Employees e
LEFT JOIN EmployeeProjects ep ON e.EmployeeID = ep.EmployeeID
WHERE ep.ProjectID IS NULL;




-- Employee ranking by sales
SELECT e.FirstName, e.LastName, SUM(s.Amount) AS TotalSales,
RANK() OVER(ORDER BY SUM(s.Amount) DESC) AS SalesRank
FROM Sales s
JOIN Employees e ON s.EmployeeID = e.EmployeeID
GROUP BY e.FirstName, e.LastName;


-- High performers (salary above department average)
WITH DeptAvg AS (
    SELECT DepartmentID, AVG(Salary) AS AvgSalary
    FROM Employees
    GROUP BY DepartmentID
)
SELECT e.FirstName, e.LastName, e.Salary, d.DepartmentName
FROM Employees e
JOIN DeptAvg da ON e.DepartmentID = da.DepartmentID
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > da.AvgSalary;



--4. Views
-- View for employee performance
CREATE VIEW EmployeePerformance AS
SELECT e.FirstName, e.LastName, d.DepartmentName, e.Salary,
       ISNULL(SUM(s.Amount),0) AS TotalSales,
       ISNULL(SUM(ep.ContributionPercent),0) AS TotalContribution
FROM Employees e
LEFT JOIN Sales s ON e.EmployeeID = s.EmployeeID
LEFT JOIN EmployeeProjects ep ON e.EmployeeID = ep.EmployeeID
JOIN Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY e.FirstName, e.LastName, d.DepartmentName, e.Salary;




    
--5. Stored Procedure
-- Add new employee
CREATE PROCEDURE AddEmployee
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Email VARCHAR(100),
    @DepartmentID INT,
    @JobTitle VARCHAR(50),
    @Salary DECIMAL(10,2),
    @HireDate DATE
AS
BEGIN
    INSERT INTO Employees(FirstName, LastName, Email, DepartmentID, JobTitle, Salary, HireDate)
    VALUES (@FirstName, @LastName, @Email, @DepartmentID, @JobTitle, @Salary, @HireDate)
END



--6. Trigger
-- Trigger to log salary changes
CREATE TABLE SalaryLog (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT,
    OldSalary DECIMAL(10,2),
    NewSalary DECIMAL(10,2),
    ChangeDate DATETIME DEFAULT GETDATE()
);


CREATE TRIGGER trgSalaryChange
ON Employees
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Salary)
    BEGIN
        INSERT INTO SalaryLog(EmployeeID, OldSalary, NewSalary)
        SELECT i.EmployeeID, d.Salary, i.Salary
        FROM inserted i
        JOIN deleted d ON i.EmployeeID = d.EmployeeID;
    END
END




--7. Functions
-- Calculate employee tenure in years
CREATE FUNCTION dbo.GetTenure(@HireDate DATE)
RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(YEAR, @HireDate, GETDATE())
END

