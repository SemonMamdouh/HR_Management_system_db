use HR_Management

--..........................................................................................

insert into Employee  (ID, First_name,Last_name)
select c.Candidate_id,
	LEFT(Full_name, CHARINDEX(' ', Full_name) - 1) AS First_Name,
    RIGHT(Full_name, LEN(Full_name) - CHARINDEX(' ', Full_name)) AS Last_Name

from Candidate c
where  c.Candidate_id =11002 and CHARINDEX(' ', Full_name) > 0;



update Employee
set Gender = 'female', Hire_date='2019-07-15'
where id=11001;


select*from Candidate
select*from Employee

--....................................................................................................


INSERT INTO Employee  (id, First_Name, Last_Name, Job_Title,  Hire_Date)
VALUES 
(102, 'Mona', 'Ali', 'Recruiter', '2023-12-01'),
(103, 'Youssef', 'Omar', 'Payroll Officer', '2022-06-15');
--........................................................................................................

UPDATE Employee
SET job_title = 'SWE'
WHERE job_title = 'Software Engineer';
--.........................................................................................................


/*..............................................schema....................................................*/

create schema HRMS

alter schema HRMS transfer dbo.training


select @@SERVERNAME

select* from [DESKTOP-VHL3O7P].[hr_management].[hrms].[account]
..............................................................................................................

/*----------------------------------------------------Indexes---------------------------------------------*/



CREATE NONCLUSTERED INDEX ix_emp_dept
ON employee(id);


CREATE UNIQUE INDEX ix_emp_email
ON employee_email(emp_email);

/*---------------------------------------VIEWs---------------------------------------------------------*/
--can't write insert update delete in it///// No DML

--ActiveEmployees-----------------------
CREATE or alter VIEW ActiveEmployees AS
SELECT e.id, e.First_Name, e.Last_Name, p.Productivity_grade
FROM Employee e join performance p on e.id=p.emp_id
WHERE p.Productivity_grade > 6 ;

select*from performance
select* from ActiveEmployees



-----------------------------------------------------------Hired candidates
CREATE or alter VIEW HiredCandidate AS
SELECT c.Candidate_id, c.Full_name, c.Job_applied_for, r.Hiring_status, r.Job_title
FROM candidate c join recruitment_process r on c.Candidate_id= r.Candidate_id
WHERE Hiring_status = 'hired';



select*from recruitment_process
select* from HiredCandidate
sp_helptext HiredCandidate


--------------------------- Account Details with encryption -------------
CREATE or alter VIEW AccountDetails with encryption AS
SELECT e.id, e.first_name, e.last_name, t.username, t.password, t.role
FROM employee e join Hrms.account t on e.id=t.emp_id

select* from AccountDetails

sp_helptext AccountDetails

------------------View DML-------------------------------------------------------------
CREATE TABLE recruiters (recruiterId INT PRIMARY KEY, rec_name NVARCHAR(100));

CREATE VIEW recruiter_view AS
SELECT recruiterId,rec_name
FROM recruiters;

INSERT INTO recruiter_view (recruiterId,rec_name)
VALUES (987, 'Omar');

select*from recruiter_view

------------------------------------With check----------------------------------------------------------
CREATE or alter VIEW recruiter_view_wcheck AS
SELECT recruiterId,rec_name
FROM recruiters
WHERE recruiterId >500
WITH CHECK OPTION;

INSERT INTO recruiter_view_wcheck (recruiterId,rec_name)
VALUES (400, 'Omar');

INSERT INTO recruiter_view_wcheck (recruiterId,rec_name)
VALUES (777, 'hala');

select*from recruiter_view


--------------------------Partationed view-----------------------------------------
SELECT * INTO new_projects
FROM project
WHERE 1 = 0;


Create or alter view projects_allview
as
	select * from project
	union all
	select * from new_projects




