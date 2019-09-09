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

-- 1)SELECT statements
-- a)Select all columns from the actor table.
-- b)Select only the last_name column from the actor table.
-- c)Select only the following columns from the film table.

USE sakila;
SELECT * FROM actor;
SELECT last_name FROM actor;

-- 2)DISTINCT operator
-- a)Select all distinct (different) last names from the actor table.
-- b)Select all distinct (different) postal codes from the address table.
-- c)Select all distinct (different) ratings from the film table.

USE sakila;
SELECT DISTINCT last_name FROM actor;
SELECT DISTINCT postal_code FROM address;
SELECT DISTINCT rating FROM film;


-- 3)WHERE clause

-- Select the title, description, rating, movie length columns from the films table that last 3 hours or longer.
-- Select the payment id, amount, and payment date columns from the payments table for payments made on or after 05/27/2005.
-- Select the primary key, amount, and payment date columns from the payment table for payments made on 05/27/2005.
-- Select all columns from the customer table for rows that have a last names beginning with S and a first names ending with N.
-- Select all columns from the customer table for rows where the customer is inactive or has a last name beginning with "M".
-- Select all columns from the category table for rows where the primary key is greater than 4 and the name field begins with either C, S or T.
-- Select all columns minus the password column from the staff table for rows that contain a password.
-- Select all columns minus the password column from the staff table for rows that do not contain a password.

USE sakila;
SELECT title,description,rating,length FROM film
WHERE length>180;

SELECT 
payment_id,
amount,
payment_date
FROM payment
WHERE payment_date>='05-07-2005';

SELECT
payment_id,
amount,
payment_date
FROM payment
WHERE payment_date='05-07-2005';

SELECT *
FROM customer
WHERE last_name LIKE 'S%' AND first_name LIKE '%N';

SELECT *
FROM customer
WHERE active=0 OR last_name LIKE 'M%';

SELECT *
FROM customer
WHERE customer_id>4 OR
 (first_name LIKE 'C%' OR first_name LIKE 'S%' OR first_name LIKE 'T%');
 
SELECT
staff_id,
first_name,
last_name,
address_id,
picture,
email,
store_id,
active,
username,
last_update
FROM staff
WHERE password IS NOT NULL;

SELECT
staff_id,
first_name,
last_name,
address_id,
picture,
email,
store_id,
active,
username,
last_update
FROM staff
WHERE password IS NULL;

-- 4)IN operator

-- Select the phone and district columns from the address table for addresses in California, England, Taipei, or West Java.
-- Select the payment id, amount, and payment date columns from the payment table for payments made on 05/25/2005, 05/27/2005, and 05/29/2005. (Use the IN operator and the DATE function, instead of the AND operator as in previous exercises.)
-- Select all columns from the film table for films rated G, PG-13 or NC-17. 
SELECT
phone,
district
FROM address
WHERE district IN ('California','England','Tapei','West Java');

SELECT
payment_id,
amount,
DATE(payment_date) AS only_date
FROM payment
WHERE only_date IN ('2005-05-25','2005-05-27','2005-05-29');

SELECT *
FROM film
WHERE rating IN ('G','PG-13','NC-17');

-- 5)BETWEEN operator
-- Select all columns from the payment table for payments made between midnight 05/25/2005 and 1 second before midnight 05/26/2005.
-- Select the following columns from the film table for films where the length of the description is between 100 and 120.
SELECT * FROM 
payment
WHERE payment_date BETWEEN '2005-05-25 23:59:59' AND '2005-05-26 23:59:59';

SELECT *
FROM film
WHERE LENGTH(description) BETWEEN 100 AND 120;


-- 6)LIKE operator
-- a)Select the following columns from the film table for rows where the description begins with "A Thoughtful".
-- b)Select the following columns from the film table for rows where the description ends with the word "Boat".
-- c)Select the following columns from the film table where the description contains the word "Database" and the length of the film is greater than 3 hours.

SELECT *
FROM film
WHERE description LIKE 'A Thoughtful%';

SELECT *
FROM film
WHERE description LIKE '%Boat';

SELECT *
FROM film
WHERE description LIKE '%Database%' AND length>180;

-- 7)LIMIT Operator
-- a)Select all columns from the payment table and only include the first 20 rows.
-- b)Select the payment date and amount columns from the payment table for rows where the payment amount is greater than 5, and only select rows whose zero-based index in the result set is between 1000-2000.
-- c)Select all columns from the customer table, limiting results to those where the zero-based index is between 101-200.


 
