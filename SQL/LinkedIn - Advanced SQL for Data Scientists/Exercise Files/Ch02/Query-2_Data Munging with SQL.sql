-- 3. Data Munging with SQL

---------------------------------------------------------------
--1) reformatting character data

SELECT DISTINCT UPPER(department), LOWER(department)
FROM staff

SELECT job_title || '-' || department AS title_dep          -- o || serve para concatenar
FROM staff

SELECT trim('   Softwaare Engineer      ')                  -- O trim retira os espaços

SELECT length(trim('   Softwaare Engineer      '))  

SELECT job_title, (job_title LIKE '%Assistant%') is_assist
FROM staff
ORDER BY is_assist DESC

--------------------------------------------------------------------------------------
--2) Extracting strings from character data

SELECT SUBSTRING('abcdefghijkl' FROM 5 FOR 3) test_String

SELECT SUBSTRING('abcdefghijkl' FROM 5) test_String  -- aqui vai por default até ao fim

-- SUBSTRING
SELECT SUBSTRING(job_title FROM 10)
FROM staff
WHERE job_title LIKE 'Assistant%'   -- aqui vai apenas dar o que vem a seguir a 'Assistant ' - 10 caracteres

-- OVERLAY
SELECT OVERLAY(job_title PLACING 'Asst. ' FROM 1 FOR 10)
FROM staff
WHERE job_title LIKE 'Assistant%'   -- aqui substitui o text 'Assistant ' pela abreviação 'Asst. '

--------------------------------------------------------------------------------------------

--3) Filtering with regular expressions
SELECT job_title
FROM staff
WHERE job_title SIMILAR TO '%Assistant%(III|IV)'     -- isto faz com que seja ou um assistente nível III ou nível IV

SELECT job_title
FROM staff
WHERE job_title SIMILAR TO '%Assistant I_'     -- isto faz com que seja ou um assistente nível I_ qualquer, i.e., II ou IV (casos possíveis)


SELECT job_title
FROM staff
WHERE job_title SIMILAR TO '[EPS]%'   -- aqui faz com que comece por uma das letras E, P ou S (em maiúsculas)

--------------------------------------------------------------------------------------------

--4) Reformatting numeric data
SELECT department, AVG(salary), trunc(AVG(salary), 2), CEIL(AVG(salary)), ROUND(AVG(salary))
FROM staff
GROUP BY department                  -- the trunc/truncate function only ignores decimal places, doesn't round. podemos pôr casas decimais tb.
                                     -- CEIL arredonda para cima. podemos pôr casas decimais tb, como no ROUND e TRUNC


