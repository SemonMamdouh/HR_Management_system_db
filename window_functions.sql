
USE HR_Management

------------------------------------------- Aggregate Window Functions -----------------------------------------------

--This query calculates the maximum, minimum, and average productivity grades for each supervisor (Super_id) in the Performance table.
--It uses window functions with the 'OVER' clause to partition the data by supervisor and calculate the grades for each group.

SELECT
MAX(p.Productivity_grade) OVER( partition BY p.Super_id ) AS Max_Grade , 
MIN(p.Productivity_grade) OVER( partition BY p.Super_id ) AS Min_Grade , 
AVG(p.Productivity_grade) OVER( partition BY p.Super_id ) AS Avg_Grade 
FROM dbo.Performance p

--This query calculates the maximum, minimum, and count of interview scores for each hiring status in the Recruitment_process table.
--It uses window functions with the 'OVER' clause to partition the data by 'Hiring_status' and perform the calculations for each group.

SELECT
MAX (Interview_score) OVER(PARTITION BY Hiring_status ) AS Max_Score , 
MIN (Interview_score) OVER(PARTITION BY Hiring_status ) AS Min_Score , 
COUNT(Interview_score) OVER(PARTITION BY Hiring_status ) AS Count_Score 
FROM dbo.Recruitment_process

------------------------------------------- Top with ties -----------------------------------------------

--This query retrieves the top 3 records from the Payroll table, including ties, ordered by the 'Basic_salary' column.
--The 'WITH TIES' ensures that if there are multiple records with the same 'Basic_salary' value as the third-highest,
--they are also included in the result.

SELECT TOP 3 WITH TIES *
FROM dbo.Payroll
ORDER BY Basic_salary

------------------------------------------- Ranking Window Functions -----------------------------------------------

--This query retrieves all records from the Recruitment_process table and calculates a dense rank for each interview score.
--The 'DENSE_RANK()' function assigns a rank to each 'Interview_score', ensuring that no ranks are skipped if there are ties.

SELECT * ,
DENSE_RANK() OVER (ORDER BY Interview_score DESC) AS Score_Rank
FROM dbo.Recruitment_process

--This query retrieves all records from the Payroll table and assigns a row number to each record based on the 'Bonus'column in descending order.
--The ROW_NUMBER() function assigns a unique rank to each row, ensuring no ties, with the highest bonus receiving rank 1.

SELECT * ,
ROW_NUMBER() OVER (ORDER BY Bonus DESC) AS Bonus_Rank
FROM dbo.Payroll

------------------------------------------- Value Window Functions -----------------------------------------------

-- This query retrieves the candidate ID, full name, and interview score from the Recruitment_process and Candidate tables.
-- It uses the LEAD()function to get the next interview score in descending order and the LAG()function to get the previous interview score for each candidate.
-- The results allow comparison of each candidate's score with the next and previous candidate scores in the list.

select Recruitment_process.Candidate_id ,
Full_name ,
Interview_score ,
LEAD(Interview_score) over(order by Interview_score DESC) AS Next_Score ,
LAG(Interview_score) over(order by Interview_score DESC) AS Previos_Score
from dbo.Recruitment_process 
JOIN dbo.Candidate 
ON Recruitment_process.Candidate_id = Candidate.Candidate_id