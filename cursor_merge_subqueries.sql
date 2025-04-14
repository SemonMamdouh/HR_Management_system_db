--highest paid employee
use HR_Management
select * from Employee e
where e.ID in(select top 1 p.Emp_id from Payroll p
			order by( p.Basic_salary +p.Bonus -p.Deduction ) desc)
						
--  Employees with Above Average Salary

select  e.First_name, e.Last_name, p.Basic_salary
from Employee e  inner join Payroll p 
on e.ID = p.Emp_id
where  p.Basic_salary > (
    select AVG(Basic_salary) from Payroll)


-- Employees with Salary Above Department Average
select e. First_name , e.Last_name , e.Hire_date
from Employee e inner join Payroll p
on e.ID = p.Emp_id inner join emp_work_on_dept ewd 
on ewd.emp_id = e.ID inner join Department d 
on d.Dep_id = ewd.dept_id
where p.Basic_salary >(select avg(p1.Basic_salary) from Payroll p1
						inner join Employee ee
						on ee.ID = p1.Emp_id inner join emp_work_on_dept ewd1
						on e.ID = ewd1.emp_id
						where  ewd.dept_id = ewd1.dept_id)


--Combine Employee and Candidate Contacts
select e.First_name + e.Last_name ,e_m.Emp_email from Employee e inner join Employee_Email e_m
on e.ID = e_m.Emp_id
union 
select c.Full_name , c.Email  from Candidate c

--show the total number of projects assigned to each employee.
select  ID, e.First_name, 
(select count(*) from project_assign_to_emp pate where pate.emp_id = e.ID) as total_proj
from Employee e;


-- show the total number of phone numbers associated with each employee.
select  ID, e.First_name, 
(select count(*) from Employee_Phone ep where ep.Emp_id = e.ID) as total_phones
from Employee e;

--update the average score of performance evaluations for each employee in a separate table.

create table  Employee_AverageScores (
    Employee_id int,
    AverageScore int
);

with cte_avgscore
as
(
select p.Emp_id , avg(p.Productivity_grade + p.Collaboration_score) as avscore from Performance p
group by Emp_id
)
merge  Employee_AverageScores as t
using cte_avgscore as ca
on t.Employee_id = ca.Emp_id
when matched then
update 
set AverageScore =ca.avscore

when not matched then
insert values (ca.Emp_id , ca.avscore) ;

select * from Employee_AverageScores


--Create the cursor to calculate and insert the net salary 
ALTER TABLE Employee
ADD NetSalary float  

declare employee_cursor cursor for 
select e.id, p.basic_salary, p.bonus, p.deduction 
from employee e inner join payroll p
on e.id = p.emp_id
for update;

declare @id int, @basic_salary int, @bonus int, @deduction int, @net_salary int;

open employee_cursor;

fetch next from employee_cursor 
into @id, @basic_salary, @bonus, @deduction;

while @@fetch_status = 0
begin
    set @net_salary = @basic_salary + @bonus - @deduction;

    update employee 
    set netsalary = @net_salary
    where id = @id;

    fetch next from employee_cursor 
    into @id, @basic_salary, @bonus, @deduction;
end 

close employee_cursor;
deallocate employee_cursor;


-- create cursor to iterate through each employee and calculate the total number of email 
--addresses associated with each employee.
declare cursor_count_email cursor for 
select e.ID , e.First_name  from employee  e
for read only

declare @id int , @name varchar(30) ;

open cursor_count_email
 fetch next from cursor_count_email
 into @id , @name

 while @@FETCH_STATUS = 0
 begin
 declare @num_emails int
	select @num_emails = count(*)  from Employee_Email
	where Emp_id =@id 
	print  @name + ' total emails ' + CAST(@num_emails as varchar(50));
	fetch next from cursor_count_email
	into @id , @name

 end
 close cursor_count_email
 deallocate cursor_count_email

 --find employees who are working on more than one project.
 update project_assign_to_emp
set emp_id = 1
where proj_id =4008

select e.First_name from employee e
where (select count(pae.proj_id) from project_assign_to_emp pae
		where e.id = pae.emp_id
		group by emp_id) > 1

--calculate the total number of projects by gender and overall total.
select  e.Gender , count(pae.proj_id)
from employee e inner join project_assign_to_emp pae
on e.ID = pae.emp_id
group by rollup (e.gender)

-- calculate the total number of projects by gender and project name
select  e.Gender , p.Project_name,count(pae.proj_id)
from employee e inner join project_assign_to_emp pae
on e.ID = pae.emp_id inner join Project p
on p.Project_id = pae.proj_id
group by cube (e.Gender , p.Project_name)

-- report on the number of employees for each type of request. 

create or alter procedure num_emp_request
as 
begin
	select 
        e.First_name , s.request_status,s.request_type,
        count(s.emp_id) over (partition by s.request_type) as request_count
    from requests s  inner join  employee e on e.id = s.emp_id;
end 
exec num_emp_request

--report on the number of training sessions conducted each month.
create or alter procedure get_monthly_training_report
as
begin
    select year(t.date) as training_year,month(t.date) as training_month,
    count(t.id) as training_count
    from training t
    group by year(t.date), month(t.date)
    order by training_year, training_month;
end 

exec get_monthly_training_report

create rule check_score as @value between 1 and 10 ;

sp_bindrule 'check_score' ,'[dbo].[Performance].[Collaboration_score]'

sp_bindrule 'check_score' ,'[dbo].[Performance].[Productivity_grade]'

create rule score as @v between 1 and 100 ;
sp_bindrule 'score' ,'[dbo].[Recruitment_process].[Interview_score]'

--Calculates the actual working hours for an employee on a specific day.
create or alter function total_actual_work(@date date , @emp_id int)
returns int
as 
begin
	declare @total_hours int
	select @total_hours = datediff(hour, a.Check_in_time, a.Check_out_time)
    from attendance a
	where a.Emp_id =@emp_id and a.Date = @date
	return @total_hours
end
select dbo.total_actual_work( '2023-01-01' ,1) as total_working_hours;

-- get employee age 
create or alter function calc_age( @name varchar(30),@id int)
returns int
as
begin
    declare @age int;
    select  @age = datediff(year, e.Birth_Date, getdate())
    from employee e
    where id = @id;
    return  @age;
end;
select dbo.calc_age(2) as age;
