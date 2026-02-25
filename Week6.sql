use week5;

create table Dept(
DebtNo int primary key ,
DName varchar(20),
LOC varchar(255)
);
select*from Dept;
rename table Dept to Deparment;
select * from Department;
Alter table Department
Add column PinCode int not null default 0;

Alter table Department
change Dname Dept_name varchar(20);

Alter table department 
modify LOC Varchar(255);

drop table Department;


create database COMPANYDB;
use COMPANYDB;
create table DEPARTMENT(
DNAME varchar(20),
DNUMBER int primary key,
MGRSSN varchar(15),
MGRSTARTDATE date
);
create table EMPLOYEE(
FNAME VARCHAR(20),
MINIT char(1),
LNAME varchar(15),
SSN varchar(15) primary key,
BDATE date,
ADDRESS varchar(100),
SEX char(1),
SALARY int,
SUPERSSN varchar(15),
DNO int,
foreign key(DNO)
references DEPARTMENT (DNUMBER)
);
INSERT INTO DEPARTMENT (DNUMBER, DNAME)
VALUES
(1,'HR'),
(2,'IT'),
(3,'Finance'),
(4,'Marketing'),
(5,'Operations');
INSERT INTO EMPLOYEE 
(FNAME, MINIT, LNAME, SSN, BDATE, ADDRESS, SEX, SALARY, SUPERSSN, DNO)
VALUES
('Noah','U','Lewis','100000021','1993-02-12','Detroit, USA','M',56000,'100000011',3),
('Lily','V','Lee','100000022','1997-05-23','Memphis, USA','F',44000,'100000021',3),
('David','W','Walker','100000023','1990-08-08','Nashville, USA','M',63000,'100000007',4),
('Grace','X','Hall','100000024','1998-09-14','Baltimore, USA','F',43000,'100000023',4),
('Joseph','Y','Allen','100000025','1988-12-01','Louisville, USA','M',78000,NULL,1);

select * from DEPARTMENT;
select * from EMPLOYEE;

-- #Q1. 10% sALARY RAISE FOR RESEARCH DEPARTMENT

select E.FNAME, E.LNAME,
E.SALARY *1.1 AS increased_salary
from EMPLOYEE E
join DEPARTMENT D ON E.DNO= D.DNUMBER
where D.DNAME= 'Research';

#QN 2 Salary Statistics of Accounts Department
#sum. max, min, avg for department administrations
select
sum(E.SALARY) as Total,
	max(E.SALARY) as max,
    min(E.SALARY) as min,
    avg(E.SALARY) as average
from EMPLOYEE E
join DEPARTMENT D ON E.DNO= D.DNUMBER
where D.DNAME= 'Research';

-- #Q3 Employees controlled by department no 5
select FNAME, LNAME from EMPLOYEE
where exists( 
select * from EMPLOYEE e
where e.DNO = 5 and E.SSN= e.SSN) ;

#Q4. Department Having At Least 2 Employees
 select D.DNAME, count(*) as Emp_count
 from EMPLOYEE E
 join DEPARTMENT D ON E.DNO= D.DNUMBER
 group by D.DNUMBER, D.DNAME
 having count(*) >= 2;
 
 #Q5. EMPLOYEES BORN IN 1990'S
 SELECT FNAME, LNAME, BDATE
 FROM EMPLOYEE
 WHERE year(BDATE) between 1990 AND 1999;