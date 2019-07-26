-- 4. Filtering, Joins, and Aggreagation

-------------------------------------------------------------------------------------------------------

-- 1) Subqueries in SELECT clauses
SELECT s1.last_name, s1.salary, s1.department,
	   (SELECT ROUND(AVG(salary)) FROM staff s2 WHERE s2.department = s1.department)     -- sem o WHERE clause dava o AVG geral
FROM staff s1

--------------------------------------------------

--2) Subqueries in FROM clauses
SELECT s1.department, 
	   ROUND(AVG(s1.salary))
FROM (SELECT department, salary
	  FROM staff
	  WHERE salary > 100000) s1
GROUP BY s1.department


----------------------------------------------------

--3) Subqueries in WHERE clauses
SELECT s1.department, s1.last_name, s1.salary
FROM staff s1
WHERE s1.salary = (SELECT MAX(s2.salary) FROM staff s2)

----------------------------------------------------

--4) Joining tables
SELECT s.last_name, s.department, cd.company_division
FROM staff s
JOIN company_divisions cd ON s.department = cd.department      -- this gives 953 rows, not 1000. To see the 1000 we need an OUTER JOIN

SELECT s.last_name, s.department, cd.company_division
FROM staff s
LEFT JOIN company_divisions cd ON s.department = cd.department 

SELECT s.last_name, s.department, cd.company_division
FROM staff s
LEFT JOIN company_divisions cd ON s.department = cd.department 
WHERE cd.company_division IS NULL                               -- para saber quais as que n entram na tabela company_division (os tais 47)

-----------------------------------------------------------------------------

--5) Creating a view
CREATE VIEW staff_div_reg AS 
SELECT s.*, cd.company_division, cr.company_regions
FROM staff s
LEFT JOIN company_divisions cd ON s.department = cd.department
LEFT JOIN company_regions cr ON s.region_id = cr.region_id           -- now we have a view       

SELECT COUNT(*) FROM staff_div_reg

------------------------------------------------------------------------------

--6) Grouping and totaling
SELECT company_division, company_regions, COUNT(*)
FROM staff_div_reg
GROUP BY GROUPING SETS (company_division, company_regions)
ORDER BY company_regions, company_division

------------------------------------------------------------------------------

--7) ROLLUP and CUBE to create subtotals
CREATE OR REPLACE VIEW staff_div_reg_country AS          -- se já existir substitui, se não existir cria uma nova
 SELECT s.*, cd.company_division, cr.company_regions, cr.country
 FROM staff s
 LEFT JOIN company_divisions cd ON s.department = cd.department
 LEFT JOIN company_regions cr ON s.region_id = cr.region_id 

SELECT company_regions, country, COUNT(*)
FROM staff_div_reg_country
GROUP BY ROLLUP(country, company_regions)    -- isto faz com que calcule os subtotais
ORDER BY country, company_regions

SELECT company_division, company_regions, COUNT(*)
FROM staff_div_reg_country
GROUP BY CUBE(company_division, company_regions)    -- isto mostra os totais por company_division e company_regions

------------------------------------------------------------------------------

--8) FETCH FIRST to find top results
SELECT last_name, job_title, salary
FROM staff
ORDER BY salary DESC
FETCH FIRST 10 ROWS ONLY

SELECT company_division, COUNT(*)
FROM staff_div_reg_country
GROUP BY company_division
ORDER BY COUNT(*) DESC
FETCH FIRST 5 ROWS ONLY

