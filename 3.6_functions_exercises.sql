-- 1)Copy the order by exercise and save it as 3.6_functions_exercises.sql
USE employees;
-- 2)Update your queries for employees whose names start and end with 'E'. Use concat() to combine their first and last name together as a single column named full_name.
SELECT CONCAT(first_name,' ',last_name) AS full_name FROM employees WHERE last_name LIKE 'E%E' ORDER BY emp_no;
-- 3)Convert the names produced in your last query to all uppercase
SELECT UPPER(CONCAT(first_name,' ',last_name)) AS full_name FROM employees WHERE last_name LIKE 'E%E' ORDER BY emp_no;
-- 4) For your query of employees born on Christmas and hired in the 90s,use datediff() to find how many days they have been working at the company.
SELECT first_name,last_name,DATEDIFF(NOW(),hire_date) AS days_at_company FROM employees WHERE hire_date BETWEEN'1990-01-01' AND '1999-12-31' AND birth_date LIKE '%-12-25'
ORDER BY birth_date ASC, hire_date DESC;
-- 5) Find the smallest and largest salary from the salary table.
SELECT MIN(salary) AS minimum_salry,MAX(salary) AS maximum_salary FROM salaries;
-- 6) Use your knowledge of built in SQL functions to generate a username for all of the employees. A username should be all lowercase,and consist of the first character of the 
--  employees first name,the first 4 characters of the employees last name, an underscore,the month the employee was born, and the last two digits of the year they were born.AS
SELECT LOWER(CONCAT(SUBSTR(first_name,1,1),SUBSTR(last_name,1,4),'_',SUBSTR(birth_date,6,2),SUBSTR(birth_date,3,2))) AS username,first_name,last_name,birth_date FROM employees;

