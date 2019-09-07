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
 SELECT 
 title,
 COUNT(f.film_id) AS copies
 FROM inventory AS i
 JOIN film AS f ON (i.film_id=f.film_id)
 WHERE f.title='Hunchback Impossible'
 GROUP BY title;
 
 -- 13)The music of Queen and Kris Kristofferson have seen an unlikely resurgence.
 -- As an unintended consequence, films starting with the letters K and Q have also soared in popularity. 
 -- Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
 SELECT title
 FROM film
 WHERE (title LIKE '%q%' OR title LIKE '%k%')
 AND language_id IN (SELECT language_id FROM language WHERE name='English');
 

 -- 14)Use subqueries to display all actors who appear in the film Alone Trip.
 SELECT first_name,last_name
 FROM actor
 WHERE actor_id IN(
 SELECT actor_id
 FROM film
 LEFT JOIN
 film_actor ON (film.film_id=film_actor.film_id)
 WHERE film.title='Alone Trip');
 
 
-- 15)You want to run an email marketing campaign in Canada,
-- for which you will need the names and email addresses of all Canadian customers.
SELECT
first_name,
last_name,
email
FROM customer
LEFT JOIN address ON (customer.address_id=address.address_id)
LEFT JOIN city ON (address.city_id=city.city_id)
LEFT JOIN country ON (city.country_id=country.country_id)
WHERE country='Canada';

-- 16)Sales have been lagging among young families,
 -- and you wish to target all family movies for a promotion.
 -- Identify all movies categorized as famiy films.
SELECT title
FROM film
LEFT JOIN film_category ON (film.film_id=film_category.film_id)
LEFT JOIN category ON (film_category.category_id=category.category_id)
WHERE category.name='Family';

-- 17)Write a query to display how much business, in dollars, each store brought in.
SELECT SUM(payment.amount)AS store_revenue,staff.store_id
FROM payment
LEFT JOIN staff ON (payment.staff_id=staff.staff_id)
GROUP BY staff.store_id;

-- 18) Write a query to display for each store its store ID, city, and country.
SELECT
store.store_id,
city.city,
country.country
FROM store
LEFT JOIN address ON (store.address_id=address.address_id)
LEFT JOIN city ON (address.city_id=city.city_id)
LEFT JOIN country ON (city.country_id=country.country_id);

-- 19)List the top five genres in gross revenue in descending order.
-- (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
SELECT 
category.name AS genre,
SUM(payment.amount) AS gross_revenue
FROM payment
LEFT JOIN rental ON (payment.rental_id=rental.rental_id)
LEFT JOIN inventory ON (rental.inventory_id=inventory.inventory_id)
LEFT JOIN film_category ON (inventory.film_id=film_category.film_id)
LEFT JOIN category ON (film_category.category_id=category.category_id)
GROUP BY category.name
ORDER BY gross_revenue DESC
LIMIT 5;
