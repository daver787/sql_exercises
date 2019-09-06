-- Use the world database for the questions below.
-- What languages are spoken in Santa Monica?
USE world;
SELECT cl.language,cl.percentage
FROM city AS c
LEFT JOIN countrylanguage AS cl ON (c.CountryCode=cl.CountryCode)
WHERE c.Name='Santa Monica'
ORDER BY cl.percentage,cl.language;

-- How many different countries are in each region?
SELECT region,COUNT(*) AS num_countries
FROM country
GROUP BY region
ORDER BY num_countries;

-- What is the population for each region?
SELECT region,SUM(population) AS population
FROM country
GROUP BY region
ORDER BY population DESC;

-- What is the average life expectancy globally?
SELECT AVG(LifeExpectancy) FROM country;

-- What is the average life expectancy for each region, each continent? Sort the results from shortest to longest
SELECT region, AVG(LifeExpectancy) AS life_expectancy FROM country
GROUP BY region
ORDER BY life_expectancy;


SELECT continent, AVG(LifeExpectancy) AS life_expectancy FROM country
GROUP BY continent
ORDER BY life_expectancy;

-- SAKILA database
 -- 1)Display the first and last names in all lowercase of all the actors.
 USE sakila;
 SELECT 
 LOWER(first_name) AS first_name,
 LOWER(last_name) AS last_name
 FROM actor;
 
 -- 2)You need to find the ID number, first name, and last name of an actor, 
 -- of whom you know only the first name, "Joe." What is one query would you could use to obtain this information?
 USE sakila;
 SELECT 
 actor_id,
 first_name AS first_name,
 last_name AS last_name
 FROM actor
 WHERE first_name='Joe';
 
 -- 3) Find all actors whose last name contain the letters "gen".
 USE sakila;
 SELECT 
 actor_id,
 first_name AS first_name,
 last_name AS last_name
 FROM actor
 WHERE last_name LIKE'%gen%';
 
 -- 4) Find all actors whose last names contain the letters "li". 
 -- This time, order the rows by last name and first name, in that order.
USE sakila;
 SELECT 
 actor_id,
 first_name AS first_name,
 last_name AS last_name
 FROM actor
 WHERE last_name LIKE'%li%'
 ORDER BY last_name,first_name;
 
 -- 6)List the last names of all the actors, as well as how many actors have that last name.
USE sakila;
SELECT 
 last_name AS last_name,
 COUNT(*) AS actor_count
 FROM actor
 GROUP BY last_name;
 
 -- 7)List last names of actors and the number of actors who have that last name,
 -- but only for names that are shared by at least two actors
USE sakila;
SELECT 
 last_name AS last_name,
 COUNT(*) AS actor_count
 FROM actor
 GROUP BY last_name
 HAVING actor_count>1; 
 
-- 8) You cannot locate the schema of the address table. Which query would you use to re-create it?
USE sakila;
SHOW CREATE TABLE address;

-- 9)Use JOIN to display the first and last names, as well as the address, of each staff member.
 SELECT 
 s.first_name,
 s.last_name,
 a.address
 FROM staff AS s
 LEFT JOIN address AS a on (s.address_id=a.address_id);
 
-- 10) Use JOIN to display the total amount rung up by each staff member in August of 2005
SELECT 
staff_id,
SUM(amount) 
FROM payment
WHERE payment_date LIKE '2005-08%'
GROUP BY staff_id; 

-- 11) List each film and the number of actors who are listed for that film.
 SELECT f.title,COUNT(fa.actor_id) AS actor_count
 FROM 
 film AS f
 JOIN film_actor AS fa ON (f.film_id=fa.film_id)
 GROUP BY f.title;
 
 -- 12)How many copies of the film Hunchback Impossible exist in the inventory system?
 
 
