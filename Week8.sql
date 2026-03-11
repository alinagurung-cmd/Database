create database TechSolutionsDB;

use TechSolutionsDB;

Create table Department(
DeptID Int primary key auto_increment,
DeptName Varchar(50) Not Null,
Location Varchar(250)
);

Create Table Employee(
empID Int primary key auto_increment,
FirstName varchar(20),
LastName varchar(30),
Gender Varchar(20),
Salary float,
HireDate Date,
DeptID int,
Foreign Key(DeptID) references Department(DeptID)
);

create table Project(
ProjectID int primary key auto_increment,
ProjectName varchar(50),
StartDate Date,
EndDate date,
Budget float
);

create table Works_On(
empID int,
ProjectID int,
HoursWorked decimal(10,2),
Primary key(empID, ProjectID),
Foreign Key(empID) references Employee(empID),
Foreign Key(ProjectID) references Project(ProjectID)
);

INSERT INTO Department (DeptName, Location) VALUES
('Human Resources', 'New York'),
('Finance', 'Chicago'),
('IT', 'San Francisco'),
('Marketing', 'Los Angeles'),
('Operations', 'Boston');

INSERT INTO Employee (FirstName, LastName, Gender, Salary, HireDate, DeptID) VALUES
('John', 'Smith', 'Male', 55000, '2022-01-15', 1),
('Emily', 'Johnson', 'Female', 62000, '2021-06-10', 2),
('Michael', 'Brown', 'Male', 70000, '2020-03-20', 3),
('Sophia', 'Davis', 'Female', 58000, '2023-02-05', 4),
('Daniel', 'Wilson', 'Male', 65000, '2019-11-12', 3);

INSERT INTO Project (ProjectName, StartDate, EndDate, Budget) VALUES
('Website Development', '2024-01-10', '2024-06-30', 50000),
('Mobile App', '2024-02-01', '2024-08-15', 75000),
('Marketing Campaign', '2024-03-05', '2024-07-20', 40000),
('Database Upgrade', '2024-04-01', '2024-09-30', 60000),
('Cloud Migration', '2024-05-10', '2024-12-15', 90000);

INSERT INTO Works_On (empID, ProjectID, HoursWorked) VALUES
(1,1,35.5),
(2,2,40.0),
(3,3,25.75),
(4,4,30.5),
(5,5,45.0);


SELECT * FROM Department;
SELECT * FROM Employee;
SELECT * FROM Project;
SELECT * FROM Works_On;

#Update the salary of an employee whose empID=102 byincreasing it by 10 percent.
UPDATE Employee
SET Salary = Salary + (Salary * 0.10)
WHERE empID = 102;

#Delete a project whose projectID=5
Delete from Works_On
Where ProjectID=5;

Delete from Project
Where ProjectID= 5;

#Part C: Basic Queries
#DIsplay all employee who earns more than 50000

Select * from employee where salary >50000;

#Display firstName, LastName and Salary of EMployees sorted by salary in decending order
Select FirstName, LastName, Salary
From employee
order by Salary DESC;

#Display EMployee who belong to IT department
SELECT Employee.FirstName, Employee.LastName, Department.DeptName
FROM Employee
JOIN Department
ON Employee.DeptID = Department.DeptID
WHERE Department.DeptName = 'IT';

#Show the total number of employees in each department
SELECT Department.DeptName, COUNT(Employee.empID) AS TotalEmployees
FROM Department
LEFT JOIN Employee
ON Department.DeptID = Employee.DeptID
GROUP BY Department.DeptName;

#display employes who were hired after January 1,2022
SELECT *
FROM Employee
WHERE HireDate > '2022-01-01';

#Part D: Join Query

#Display employee name along with their department names
SELECT E.FirstName,E.LastName,D.DeptName
FROM Employee E
JOIN Department D ON E.DeptID = D.DeptID;

#Show employees and the projects they are working on alter
SELECT E.FirstName,E.LastName,P.ProjectName
FROM Employee E
JOIN Works_On W ON E.empID = W.empID
JOIN Project P ON W.ProjectID = P.ProjectID;
    
#Part E: Aggregate and advance Queries

#Find the average salary of employees in each department.
SELECT D.DeptName,AVG(E.Salary) AS AvgSalary
FROM Employee E
JOIN Department D ON E.DeptID = D.DeptID
GROUP BY D.DeptName;
    
#Display the department with the highest number of employees.
SELECT D.DeptName,COUNT(E.empID) AS NumEmployees
FROM Department D
LEFT JOIN Employee E ON D.DeptID = E.DeptID
GROUP BY D.DeptName
ORDER BY NumEmployees DESC
LIMIT 1;

#Find employees whose salary to greater than the average salary of all employees.
SELECT FirstName,LastName,Salary
FROM Employee
WHERE Salary > (SELECT AVG(Salary) FROM Employee);

#Part F: Additional Task
#Create a view named HighSalaryEmployees that shows employees with salary greater than 60,000
CREATE VIEW HighSalaryEmployees AS
SELECT empID,FirstName,LastName,Salary
FROM Employee
WHERE Salary > 60000;
    
#Create an index on the LastName column of the Employee Table
CREATE INDEX idx_LastName ON Employee(LastName);
