--Q1. List all employees along with the names of departments they work in, even if the employee is not 
--assigned to any department.

SELECT e.First_name, d.Dep_name
FROM Employee e
LEFT JOIN emp_work_on_dept ed ON e.ID = ed.Emp_ID
LEFT JOIN Department d ON ed.dept_id = d.Dep_ID

--Q2. Show each employee with the projects they are working on and the name of each project.

select e.First_name , p.Project_name
from  Employee e 
inner join project_assign_to_emp pe on e.ID = pe.emp_id 
inner join Project p on pe.proj_id = p.Project_id

--Q3. List all employees and their phone numbers. Include employees who do not have phone numbers yet.


select e.First_name , EP.Emp_phone
from Employee e 
left join [Employee_Phone] ep on e.ID = ep.Emp_id

--Q4. Find the average salary for each department.

SELECT d.Dep_name, AVG(p.Basic_salary) AS Avg_Salary
FROM Department d
JOIN emp_work_on_dept ed ON d.Dep_ID = ed.dept_id
JOIN Employee e ON ed.Emp_ID = e.ID
JOIN Payroll p ON e.ID = p.Emp_ID
GROUP BY d.Dep_name 

--Q5. Show the number of employees assigned to each project.

SELECT p.Project_name, COUNT(pe.Emp_ID) AS Num_Employees
FROM Project p
LEFT JOIN project_assign_to_emp pe ON p.Project_ID = pe.proj_id
GROUP BY p.Project_name


--Q6. Create a stored procedure that returns all employees in a specific department when given the
--department name as input.

CREATE PROCEDURE GetEmployeesByDepartment(@DepName VARCHAR(50))
AS
BEGIN
    SELECT e.First_name, d.Dep_name
    FROM Employee e
    JOIN emp_work_on_dept ed ON e.ID = ed.Emp_ID
    JOIN Department d ON ed.dept_id = d.Dep_ID
    WHERE d.Dep_name = @DepName
END

exec GetEmployeesByDepartment 'IT Department'

--Q7. Create a stored procedure to calculate and return the total payroll cost for a given month.

ALTER PROCEDURE GetTotalPayrollForMonth(@MonthName VARCHAR(20))
AS
BEGIN
    SELECT DATENAME(MONTH, Payroll_Date) AS Month_Name,
           SUM(Bonus + Basic_Salary) AS Total_Payroll
    FROM Payroll
    WHERE DATENAME(MONTH, Payroll_Date) = @MonthName
    GROUP BY DATENAME(MONTH, Payroll_Date)
END

EXEC GetTotalPayrollForMonth 'April'

--Q8. Create a trigger that prevents inserting a salary greater than 20,000 into the Payroll table. 
--If someone tries, it should raise an error message.

CREATE  OR ALTER TRIGGER trg_PreventHighSalary
ON Payroll
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted WHERE Basic_salary > 20000)
    BEGIN
        RAISERROR('Salary cannot be greater than 20,000.', 16, 1);
    END
    ELSE
    BEGIN
         INSERT INTO Payroll (Emp_ID, Payroll_Date, Deduction, Bonus, Basic_Salary)
        SELECT Emp_ID, Payroll_Date, Deduction, Bonus, Basic_Salary
        FROM inserted
    END
END

INSERT INTO Payroll (Emp_ID, Payroll_Date, Deduction, Bonus, Basic_Salary)
VALUES (55, '2025-04-07', '115.01', 5000, 17000)

--Q9. Create a trigger that prevents deleting a payroll record if the basic salary is above 15,000.


CREATE TRIGGER trg_PreventHighSalaryDelete
ON Payroll
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (
        SELECT * FROM deleted WHERE Basic_Salary > 15000
    )
    BEGIN
        RAISERROR('Cannot delete payroll records with Basic Salary above 15,000.', 16, 1);
    END
    ELSE
    BEGIN
        DELETE FROM Payroll
        WHERE Payroll_ID IN (SELECT Payroll_ID FROM deleted)
    END
END

DELETE FROM Payroll
WHERE Payroll_ID = 1

--Q10. Create a stored procedure to increase an employee's salary by a percentage.

CREATE PROCEDURE IncreaseSalary 
    @EmpID INT,
    @Percentage FLOAT
AS
BEGIN
    UPDATE payroll
    SET Basic_salary = Basic_salary + (Basic_salary * @Percentage / 100)
    WHERE Emp_id = @EmpID
END

EXEC IncreaseSalary @EmpID = 101, @Percentage = 10

