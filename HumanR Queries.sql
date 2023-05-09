-- QUESTIONS
-- 1. What is the age distribution of employees in the company?
SELECT 
MIN(Age) As Youngest,
MAX(Age) As Oldest
From HumanR
Where Age >=18 AND termdate is null

SELECT 
CASE
  WHEN age>=18 AND age<=24 THEN '18-24'
   WHEN age>=25 AND age<=34 THEN '25-34'
    WHEN age>=35 AND age<=24 THEN '35-44'
     WHEN age>=45 AND age<=54 THEN '44-54'
      WHEN age>=55 AND age<=64 THEN '18-24'
      ELSE '65+'
      END AS age_group,
      Count(*) AS Count
       From HumanR
      Where Age >=18 AND termdate is null
GROUP BY age_group
ORDER BY age_group

SELECT 
CASE
  WHEN age>=18 AND age<=24 THEN '18-24'
   WHEN age>=25 AND age<=34 THEN '25-34'
    WHEN age>=35 AND age<=24 THEN '35-44'
     WHEN age>=45 AND age<=54 THEN '44-54'
      WHEN age>=55 AND age<=64 THEN '18-24'
      ELSE '65+'
      END AS age_group,
      Count(*) AS Count
       From HumanR
      Where Age >=18 AND termdate is null
GROUP BY age_group,gender
ORDER BY age_group,gender


-- 2. What is the gender breakdown of employees in the company?

SELECT Gender,Count(*) AS COUNT
From HumanR
Where Age >=18 AND termdate is null
Group By Gender


-- 2. What is the race/ethnicity breakdown of employees in the company? 

SELECT race,Count(*) AS COUNT
From HumanR
Where Age >=18 AND termdate is null
Group By race
Order BY Count(*) DESC

-- 4. How many employees work at headquarters versus remote locations?

SELECT location,Count(*) AS COUNT
From HumanR
Where Age >=18 AND termdate is null
Group By location

-- 5. What is the average length of employment for employees who have been terminated?
Select
round(avg(datediff(termdate, hire_date))/365,0) As  AVG_length_emplyment
from HumanR
WHERE termdate <=curdate() AND termdate is not null

-- 6. How does the gender distribution vary across departments and job titles?

SELECT department,gender,COUNT(*)AS Count
From HumanR
Where Age >=18 AND termdate is null
GROUP BY department,gender
ORDER BY department

-- 7. What is the distribution of job titles across the company?
SELECT jobtitle, COUNT(*)AS Count
From HumanR
Where Age >=18 AND termdate is null
GROUP BY jobtitle
ORDER BY jobtitle DESC

-- 8. Which department has the highest turnover rate?
Select Department,
total_count,
terminated_count,
terminated_count/total_count As termination_rate
From (
Select Department,
count(*) As total_count,
SUm(CASE WHEN termdate is not null AND termdate <= curdate() Then 1 Else 0 End) As terminated_count
from HumanR
Where age>= 18
Group By department
) As Subquery 
Order By termination_rate Desc

-- 9. What is the distribution of employees across locations by city and state?
select Location_state, Count(*) As count
From HumanR
Where Age >=18 AND termdate is null
Group by location_state
Order by Count DESC


-- 10. How has the company's employee count changed over time based on hire and term dates?
Select 
year,
hires,
terminations,
hires-terminations As net_change,
round((hires-terminations)/hires*100,2) As net_change_percent
From (
Select
YEAR(hire_date) As year,
count(*) AS hires,
SUm(CASE WHEN termdate is not null AND termdate <= curdate() Then 1 Else 0 End) As terminations
from HumanR
Where age>= 18
Group By Year(hire_date)
) As Subquery 
Order By year asc
-- 11. What is the tenure distribution for each department?

Select department,round(avg(datediff(termdate,hire_date)/365),0) AS avg_tenure
from HumanR
Where termdate <=curdate() AND termdate is not null 
Group BY department