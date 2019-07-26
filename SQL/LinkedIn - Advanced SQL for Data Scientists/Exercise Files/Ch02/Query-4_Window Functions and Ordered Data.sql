-- 5. Window Functions and Ordered Data

--------------------------------------------------------------------------------------------------------------------------

-- 1) Window functions: OVER PARTITION
SELECT department, last_name, salary, AVG(salary) OVER (PARTITION BY department)  -- em vez de uma subquery podemos usar uma window function
FROM staff

SELECT department, last_name, salary, MAX(salary) OVER (PARTITION BY department)
FROM staff

SELECT company_regions, last_name, salary, MIN(salary) OVER (PARTITION BY company_regions)
FROM staff_div_reg

--------------------------------------------------------------

--2) Window functions: FIRST_VALUE
SELECT department, last_name, salary, FIRST_VALUE(salary) OVER (PARTITION BY department ORDER BY salary DESC)
FROM staff                            -- salário da pessoa q recebe mais (Sanchez) do departamento. depois qd muda o departamento muda o valor

SELECT department, last_name, salary, FIRST_VALUE(salary) OVER (PARTITION BY department ORDER BY last_name)  
FROM staff                            -- agora é o salário da 1ª pessoa/nome ordem alfabética (ORDER BY last_name), do departamento

-----------------------------------------------------------------------------------------------------

--3) Window functions: RANK
SELECT department, last_name, salary, RANK() OVER (PARTITION BY department ORDER BY salary DESC)
FROM staff


-----------------------------------------------------------------------------------------------------

--4) LAG and LEAD
SELECT department, last_name, salary, LAG(salary) OVER (PARTITION BY department ORDER BY salary DESC)   -- mostra o anterior
FROM staff

SELECT department, last_name, salary, LEAD(salary) OVER (PARTITION BY department ORDER BY salary DESC)   -- mostra o seguinte
FROM staff


-----------------------------------------------------------------------------------------------------

--5) NTILE functions
SELECT department, last_name, salary, NTILE(4) OVER (PARTITION BY department ORDER BY salary DESC)    -- quartiles of 4 
FROM staff                              -- divide em 4 quantis por cada departamento, por ordem de salário


