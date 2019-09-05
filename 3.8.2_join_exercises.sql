-- 1) Use the join_example_db. Select all the records from both the users and roles tables.
USE join_example_db;
SELECT * FROM users;
SELECT * FROM roles;
-- 2) Use join, left join, and right join to combine from the users and roles tables as we did in the lesson. Before you run each query,guess the expected number of results.
-- inner join
SELECT u.*,r.*
FROM users AS u
JOIN roles AS r 
ON u.role_id=r.id;
-- left join
SELECT u.*,r.*
FROM users AS u
LEFT JOIN roles AS r 
ON u.role_id=r.id;
-- right join
SELECT u.*,r.*
FROM users AS u
RIGHT JOIN roles AS r 
ON u.role_id=r.id;
-- 3) Although not explicitly covered in the lesson,aggregate functions like count can be used with join queries. Use count and the appropriate join type to get list of roles
-- along with the number of users that role has. Hint: You will also need to use group by in the query.
 
-- 1) Use the employees database.
USE employees;
-- 2) Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.
SELECT d.dept_name as 'Department Name', CONCAT(e.first_name,' ',e.last_name) AS 'Department Manager'
FROM departments as d
JOIN dept_manager as dm ON (dm.dept_no=d.dept_no)
JOIN employees AS e ON (dm.emp_no=e.emp_no)
WHERE dm.to_date='9999-01-01'
ORDER BY d.dept_name ASC;
-- 3) Find the name of all departments currently managed by women.
SELECT d.dept_name as 'Department Name', CONCAT(e.first_name,' ',e.last_name) AS 'Department Manager'
FROM departments as d
JOIN dept_manager as dm ON (dm.dept_no=d.dept_no)
JOIN employees AS e ON (dm.emp_no=e.emp_no)
WHERE dm.to_date='9999-01-01' AND e.gender='F'
ORDER BY d.dept_name ASC;
-- 4) Find the current titles of employees currently working in the Customer Service department.
SELECT t.title AS Title
FROM departments as d
JOIN dept_emp AS de ON d.dept_no=de.dept_no
JOIN titles AS t ON de.emp_no=t.emp_no
WHERE d.dept_name='Customer Service' AND t.to_date='9999-01-01' AND de.to_date='9999-01-01'
GROUP BY t.title
ORDER BY t.title ASC;
-- 5) Find the current salary of all current managers.
SELECT d.dept_name as 'Department Name', CONCAT(e.first_name,' ',e.last_name) AS 'Department Manager', s.salary AS Salary
FROM departments as d
JOIN dept_manager as dm ON (dm.dept_no=d.dept_no)
JOIN employees AS e ON (dm.emp_no=e.emp_no)
JOIN salaries AS s ON (e.emp_no=s.emp_no)
WHERE dm.to_date='9999-01-01' AND s.to_date='9999-01-01'
ORDER BY d.dept_name ASC;
-- 6) Find the number of employees in each department.
SELECT d.dept_no,d.dept_name as 'Department Name' ,COUNT(*) AS num_employees
FROM departments as d
JOIN dept_emp as de ON (d.dept_no=de.dept_no)
JOIN employees AS e ON (de.emp_no=e.emp_no)
WHERE de.to_date='9999-01-01'
GROUP BY d.dept_no,d.dept_name;
-- 7) Which department has the highest average salary?
SELECT d.dept_name, AVG(s.salary) AS average_salary
FROM departments as d
JOIN dept_emp AS de ON (d.dept_no=de.dept_no)
JOIN employees AS e ON (de.emp_no=e.emp_no)
JOIN salaries AS s ON (e.emp_no=s.emp_no)
WHERE de.to_date='9999-01-01' AND s.to_date='9999-01-01'
GROUP BY d.dept_name
ORDER BY average_salary DESC
LIMIT 1;
-- 8) Who is the highest paid employee in the marketing department?
SELECT e.first_name,e.last_name
FROM departments as d
JOIN dept_emp AS de ON (d.dept_no=de.dept_no)
JOIN employees AS e ON (de.emp_no=e.emp_no)
JOIN salaries AS s ON (e.emp_no=s.emp_no)
WHERE de.to_date='9999-01-01' AND s.to_date='9999-01-01' AND d.dept_name='Marketing'
ORDER BY s.salary DESC
LIMIT 1;
-- 9) Which current department manager has the highest salary?
SELECT e.first_name,e.last_name,s.salary,d.dept_name 
FROM departments as d
JOIN dept_manager as dm ON (dm.dept_no=d.dept_no)
JOIN employees AS e ON (dm.emp_no=e.emp_no)
JOIN salaries AS s ON(e.emp_no=s.emp_no)
WHERE dm.to_date='9999-01-01' AND s.to_date='9999-01-01'
ORDER BY s.salary DESC
LIMIT 1;
-- 10) Bonus Find the names of all current employees,their department name and their current manager's name.
SELECT CONCAT(e.first_name,' ',e.last_name) AS 'Employee Name',d.dept_name AS 'Department Name',a.manager_name
FROM  employees AS e
LEFT JOIN dept_emp AS de ON (e.emp_no=de.emp_no)
LEFT JOIN departments as d ON (d.dept_no=de.dept_no)
LEFT JOIN
(SELECT CONCAT(e.first_name,' ',e.last_name) AS manager_name,dm.dept_no
FROM dept_manager AS dm
JOIN employees AS e ON(dm.emp_no=e.emp_no)
WHERE dm.to_date='9999-01-01') AS a ON (a.dept_no=d.dept_no)
WHERE de.to_date='9999-01-01';
-- 11) Bonus Find the highest paid employee in each department.
SELECT 
 e.first_name,
 e.last_name,
 d.dept_name,
 s.salary
FROM employees AS e
JOIN dept_emp AS de ON (e.emp_no=de.emp_no)
JOIN departments AS d ON(d.dept_no=de.dept_no)
JOIN salaries AS s ON (s.emp_no=e.emp_no) AND s.to_date='9999-01-01'
WHERE de.to_date='9999-01-01' AND s.to_date='9999-01-01' AND s.salary IN
(SELECT MAX(s.salary) as max_salary
FROM departments as d
JOIN dept_emp AS de ON (d.dept_no=de.dept_no)
JOIN employees AS e ON (de.emp_no=e.emp_no)
JOIN salaries AS s ON (e.emp_no=s.emp_no)
WHERE de.to_date='9999-01-01' AND s.to_date='9999-01-01'
GROUP BY d.dept_name)



