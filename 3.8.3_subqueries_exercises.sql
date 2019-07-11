-- Create a file named 3.8.3_subqueries_exercises and craft queries to return the results for the following criteria.
USE employees;
-- 1) Find all the employees with the same hire date as employee 101010 using a sub-query.
SELECT first_name, last_name,hire_date
FROM employees
WHERE hire_date IN (
SELECT hire_date
FROM employees 
WHERE emp_no='101010');
-- 2) Find all the titles held by all employees with the first name Aamod.
-- done with a join instead of a sub-query
SELECT e.first_name,t.title
FROM titles AS t
JOIN employees AS e ON (t.emp_no=e.emp_no)
WHERE e.first_name='Aamod';

SELECT title,COUNT(*)
FROM titles
WHERE emp_no IN (
SELECT emp_no
FROM employees
WHERE first_name='Aamod') 
GROUP BY title;

-- 3) How many people in the employees table are no longer workng for the company?
SELECT COUNT(*)
FROM employees 
WHERE emp_no IN(
SELECT emp_no 
FROM dept_emp
WHERE to_date<NOW());

-- 4) Find all the current department managers that are female.
SELECT first_name,last_name
FROM employees
WHERE emp_no IN(
SELECT emp_no 
FROM dept_manager
WHERE to_date>NOW()) AND gender='F';

-- 5)Find all the employees that currently have a higher than average salary.
SELECT e.first_name,e.last_name,s.salary
FROM employees AS e
JOIN salaries AS s ON (e.emp_no=s.emp_no)
WHERE s.salary>(
SELECT AVG(salary)
FROM salaries) AND s.to_date>NOW();

-- 6) How many current salaries are within 1 standard deviation of the highest salary? (Hint you can use a built in function to calculate the standard deviation.) What percentage of
-- all salaries is this?
SELECT COUNT(*),MAX(salary) AS max_salary,STDDEV(salary) AS stdev
max_salary-stdev AS target_salary
FROM salaries
WHERE to_date>NOW();

(SELECT STDDEV(salary)
FROM salaries
WHERE to_date>NOW())
