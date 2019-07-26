-- 2. Basic Statistics  with SQL

-----------------------------------------------------------
--1)

SELECT *
FROM company_divisions

SELECT *
FROM company_regions

SELECT *
FROM staff

-------------------------------------
--2) 

SELECT department, gender, COUNT(department), MIN(salary), MAX(salary)
FROM staff
GROUP BY department, gender
ORDER BY MAX(salary) DESC

---------------------------------------
--3) 

SELECT department, SUM(salary) AS total_salary, ROUND(AVG(salary), 0) AS average_salary, 
	   ROUND(VAR_POP(salary), 2) as var_pop, ROUND(STDDEV_POP(salary), 2) as stddev_pop
FROM staff
GROUP BY department

---------------------------------------
--4) 

SELECT department, sum(salary)
FROM staff
WHERE salary > 100000 
AND department LIKE 'B%y'
GROUP BY department

---------------------------------------






