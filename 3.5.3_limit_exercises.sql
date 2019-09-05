-- 1) Create a new SQL script named 3.5.3_limit_exercises.sql 
USE employees;
-- 2) List the first 10 distinct last names sorted in descending order.
SELECT DISTINCT last_name FROM employees
ORDER BY last_name DESC LIMIT 10;
-- 3) Find your query for employees born on Christmas and hired in the 90s from the order_by_exercises.sql.Update it to find just the first 5 employees.
SELECT * FROM employees WHERE hire_date BETWEEN'1990-01-01' AND '1999-12-31' AND birth_date LIKE '%-12-25'
ORDER BY birth_date ASC, hire_date DESC
LIMIT 5;
/* 4) Try to think of your results as batches, sets, or pages. The first five results are your first page. 
The five after that would be your second page, etc. Update the query to find the tenth page of results. LIMIT and OFFSET can be used to create multiple pages of data. 
What is the relationship between OFFSET (number of results to skip), LIMIT (number of results per page), and the page number? */
SELECT first_name, last_name FROM employees WHERE hire_date BETWEEN'1990-01-01' AND '1999-12-31' AND birth_date LIKE '%-12-25'
ORDER BY birth_date ASC, hire_date DESC
LIMIT 5 OFFSET 45;