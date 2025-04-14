
USE HR_Management

----------------------------------------------------Rules And Default ----------------------------------------

-- This code ensures that the 'Request_status' column in the 'Requests' table only accepts specific values ('Approved', 'Denied', 'Pending') 
-- and sets the default value to 'Pending' if no value is provided during data insertion.

create rule rule1 as @value IN ('Approved' , 'Denied' , 'Pending')
sp_bindrule rule1 , 'Requests.Request_status'

create default def1 as 'Pending'
sp_bindefault def1 , 'Requests.Request_status'

---------------------------------------

-- This code enforces that the 'Hiring_status' column in the 'Recruitment_process' table can only contain the values 'Hired', 'Rejected', or 'Pending',
-- and sets its default value to 'Pending' when no value is explicitly provided.

create rule rule2 as @value IN ('Hired' , 'Rejected' , 'Pending')
sp_bindrule rule2 , 'Recruitment_process.Hiring_status'

create default def2 as 'Pending'
sp_bindefault def2 , 'Recruitment_process.Hiring_status'

---------------------------------------

-- This rule restricts the 'Basic_salary' column in the 'Payroll' table to accept values only between 2000 and 15000.

create rule rule3 as @value between 2000 AND 15000
sp_bindrule rule3 , 'Payroll.Basic_salary'

---------------------------------------

-- This rule restricts the 'Gender' column in the 'Employee' table to accept only 'Male' or 'Female' as valid values.

create rule rule4 as @value IN ( 'Male' , 'Female')
sp_bindrule rule4 , 'Employee.Gender'

---------------------------------------------------- Functions ----------------------------------------

	--scalar--

--This function takes an employee ID and returns the full name (First_name + Last_name) of the corresponding employee.

CREATE FUNCTION FUNCTION_1 (@ID int)
RETURNS varchar(50)
AS 
BEGIN
DECLARE @Name varchar(50)
SELECT  @Name = e.First_name + ' ' + e.Last_name
FROM dbo.Employee e
WHERE e.ID = @ID
RETURN @Name
END 

--DROP FUNCTION FUNCTION_1

SELECT dbo.FUNCTION_1 (10)

---------------------------------------

	--In line--

--This table-valued function returns the ID, full name, and job title of the employee with the specified ID.

CREATE FUNCTION function_2 (@ID int)
RETURNS TABLE
AS
RETURN
(SELECT e.ID , e.First_name + ' ' + e.Last_name AS 'Full Name' , e.Job_title
FROM Employee e
WHERE e.ID = @ID )

--DROP FUNCTION dbo.function_2

SELECT * FROM dbo.function_2 (12)

---------------------------------------

	--Multi--

--This table-valued function returns the full name, department, and project of all employees based on the specified gender ('Male' or 'Female').
--It joins the Employee, Department, and Project tables through the emp_work_on_dept relationship to retrieve the relevant data.

CREATE FUNCTION function_3 (@Gender varchar(10))
RETURNS @taple table (Full_Name varchar(50) , Department varchar(50) , Project varchar(50) )
AS 
BEGIN 
	IF @Gender = 'Male'
BEGIN
	INSERT INTO @taple
	SELECT e.First_name + ' ' + e.Last_name , d.Dep_name , p.Project_name
	        FROM dbo.Employee e
        JOIN dbo.emp_work_on_dept ed ON ed.emp_id = e.ID
        JOIN dbo.Department d ON ed.dept_id = d.Dep_id
        JOIN dbo.Project p ON p.Dep_id = d.Dep_id
        WHERE e.Gender = 'Male'
END 
	ELSE
BEGIN 
	INSERT INTO @taple
	SELECT e.First_name + ' ' + e.Last_name , d.Dep_name , p.Project_name
        FROM dbo.Employee e
        JOIN dbo.emp_work_on_dept ed ON ed.emp_id = e.ID
        JOIN dbo.Department d ON ed.dept_id = d.Dep_id
        JOIN dbo.Project p ON p.Dep_id = d.Dep_id
        WHERE e.Gender = 'Female'
END
    RETURN 
END

--DROP FUNCTION dbo.function_3

SELECT * FROM dbo.function_3('Male')

