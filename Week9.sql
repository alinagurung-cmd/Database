#1. Create a database name BankDB and create a table accounts with the fields: account_id, account_holder,balance

create database BankDB;
use BankDB;
create table accounts(
account_id int primary key auto_increment,
account_holder varchar(255),
balance float
);

INSERT INTO accounts
VALUES
(1,'Alina Gurung', 5000000000),
(2,'Anisha Shrestha', 600000000),
(3,'Luna Pariyar', 800000000),
(4,'Dristi Maharjan', 450000000);

#Write a transaction that transfers Rs. 5000 from Alina's account to Anisha's account
start transaction;

update accounts
set balance= balance-5000
where account_id= 1;

update accounts
set balance= balance+ 5000
where account_id= 2;

commit;

select * from accounts;

#write a transaction that transfers Rs. 10000 from shyam's account to sita's account and demonstrate the use of roll backk
update accounts
set balance= balance-10000
where account_id= 3;

update accounts
set balance= balance+10000
where account_id= 3;

rollback;
commit;

#Write a trasaction that demonstrtes the use of savepoint while updating account balances.

start transaction;
update accounts
set balance= balance-2000
where account_id= 1;
savepoint sp1;

update accounts
set balance= balance+2000
where account_id= 2;
rollback to sp1;
commit;

select * from accounts;

#Triggers
#1. Create a tables employees with the fields: emp_id,name, salary
create table employyees(
emp_id int  primary key,
name varchar(100),
salary decimal(10, 2));

#2 Create another table salary_log to record employee salary changes with fields: log_id, emo_id, old_salary, new_salary, updated_at.alter
create table salary_log(
log_id int auto_increment primary key,
emp_id int,
old_salary decimal(10, 2),
new_salary decimal(10,2),
updated_at timestamp default current_timestamp
);

#3 Create a BEFORE INSERT trigger on employees that prevents inserting employees whose salary is than 10000.
Delimiter $$
create trigger check_salary
before insert on employyees
for each row
begin
if new.salary <10000 then
signal sqlstate '45000'
set message_text= "salary must be atleast 10000";

end if;
end $$

Delimiter ;

Delimiter $$
create trigger log_salary_update
after update on employees
for each row
begin
insert into salary_log(emp_id, old_salary, new_salary)
values(old.emp_id, old.salary, new.salary);
end $$
Delimiter ;

# Stored Procedure
#Create a stored procedure that retrieves all records from the employees table.

Delimiter $$
create procedure getEmployees()
begin
select * from employyees ;
end $$
Delimiter ;

call getEmployees();

#Create a stored procedure that inserts a new employee into the employees table using parameters

Delimiter $$
create procedure addEmployyees(
IN p_id int,
IN p_name varchar(100),
IN p_salary decimal (10, 2))
begin
insert into employyees values(p_id, p_name,p_salary);
end $$
Delimiter ;
call addEmployee(5, 'Hari', 20000);

#Create a stored procedure that updates the salary of an employee based on employee ID
Delimiter $$
create procedure updateSalary(
in p_id int,
in new_salary decimal(10,2))
begin
update employee
set salary= new_salary
where emp_id= p_id;
end $$
delimiter ;

#create a stored procedure that transfers money between two accounts using a transaction
Delimiter $$
create procedure transferMoney(
in from_accout int, in to_account int,
in amount decimal)
begin
start transaction;
update accounts
set balance= balance- amount
where account_id= from_account;
update accounts
set balance= balance + amount
where account_id= to_account;
COMMIT;
end $$
Delimiter ;
call transferMoney(1,2,5000);

end $$
Delimiter ;
