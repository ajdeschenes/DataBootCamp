use sakila;
SET SQL_SAFE_UPDATES = 0;

#1a
SELECT first_name, last_name FROM actor;

#1b
SELECT CONCAT(first_name, ' ' ,last_name) 
AS 'Actor Name' 
FROM actor;

#2a
SELECT actor_id, first_name, last_name 
FROM actor
WHERE first_name = "Joe";

#2b
SELECT * FROM actor
WHERE last_name LIKE '%gen%';

#2c
SELECT * FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name, first_name;

#2d
SELECT country_id, country FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

/*
#3a
ALTER TABLE actor
ADD description BLOB; 

#3b
ALTER TABLE actor
DROP description;
*/

#4a 
SELECT last_name, count(last_name) FROM actor
GROUP BY last_name;

#4b
SELECT last_name, count(last_name) FROM actor
GROUP BY last_name
HAVING count(last_name) >2;

#4c
UPDATE actor
SET first_name = "HARPO"
WHERE first_name = "GROUCHO" AND last_name = "WILLIAMS";

#4d
UPDATE actor 
SET first_name = "GROUCHO" 
WHERE first_name = "HARPO";

#5a
DESCRIBE address;

#6a
select first_name, last_name, address 
FROM staff s
JOIN address a
ON a.address_id = s.address_id;

#6b
select sum(amount), s.staff_id
FROM staff s
JOIN payment p
ON s.staff_id = p.staff_id
WHERE p.payment_date BETWEEN CAST('2005-08-01' AS DATE) AND CAST('2005-08-31' AS DATE)
group by s.staff_id;

#6c
select title, count(*) from film_actor as fa
inner join film as f
on f.film_id = fa.film_id
group by f.title;

#6d
SELECT COUNT(*), title From inventory i
JOIN film f 
ON f.film_id = i.film_id
GROUP BY f.title
HAVING f.title = "Hunchback Impossible";

#6e
SELECT first_name, last_name, SUM(amount) as "Total Amount Paid" FROM payment p
JOIN customer c
ON c.customer_id = p.customer_id
GROUP BY p.customer_id
ORDER BY last_name;

#7a
SELECT 
    title
FROM
    film
WHERE
    (title LIKE 'Q%' OR title LIKE 'K%')
        AND language_id IN (SELECT 
            language_id
        FROM
            language
        WHERE
            name = 'English'); 
            
#7b
SELECT 
    first_name, last_name
FROM
    actor
WHERE
    actor_id IN (SELECT 
            actor_id
        FROM
            film_actor
        WHERE
            film_id IN (SELECT 
                    film_id
                FROM
                    film
                WHERE
                    title = 'Alone Trip'));
                    
#7c
SELECT first_name, last_name, email FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ON city.city_id = a.address_id
JOIN country ON city.country_id = country.country_id
WHERE country.country = "Canada";

#7d
SELECT 
    title
FROM
    film
WHERE
    film_id IN (SELECT 
            film_id
        FROM
            film_category
        WHERE
            category_id IN (SELECT 
                    category_id
                FROM
                    category
                WHERE
                    name = 'family'));
                    
#7e
SELECT 
    (SELECT 
            title
        FROM
            film
        WHERE
            film_id IN (SELECT 
                    film_id
                FROM
                    inventory
                WHERE
                    inventory_id = rental.inventory_id)) AS title,
    COUNT(*)
FROM
    rental
GROUP BY title
ORDER BY COUNT(*) DESC;

#7f
SELECT 
    SUM(amount),
    (SELECT 
            store_id
        FROM
            staff
        WHERE
            staff_id = (SELECT 
                    staff_id
                FROM
                    staff
                WHERE
                    payment.staff_id = staff.staff_id)) as store
FROM
    payment
GROUP BY store;

#7g
SELECT 
    store_id,
    (SELECT 
            city
        FROM
            city
        WHERE
            city_id IN (SELECT 
                    city_id
                FROM
                    address
                WHERE
                    address.address_id = store.address_id)) AS city,
    (SELECT 
            country
        FROM
            country
        WHERE
            country_id IN (SELECT 
                    country_id
                FROM
                    city
                WHERE
                    city.city_id = (SELECT 
                            city_id
                        FROM
                            address
                        WHERE
                            address.address_id = store.address_id))) AS country
FROM
    store;

#7h

SELECT 
    SUM(amount),
    (SELECT 
            name
        FROM
            category
        WHERE
            category_id IN (SELECT 
                    category_id
                FROM
                    film_category
                WHERE
                    film_id IN (SELECT 
                            film_id
                        FROM
                            inventory
                        WHERE
                            inventory_id IN (SELECT 
                                    inventory_id
                                FROM
                                    rental
                                WHERE
                                    rental_id IN (SELECT 
                                            rental_id
                                        FROM
                                            rental
                                        WHERE
                                            rental.rental_id = payment.rental_id))))) AS genre
FROM
    payment
GROUP BY genre
ORDER BY SUM(amount) DESC
LIMIT 5; 

#8a

CREATE VIEW top_five_genres AS SELECT 
    SUM(amount),
    (SELECT 
            name
        FROM
            category
        WHERE
            category_id IN (SELECT 
                    category_id
                FROM
                    film_category
                WHERE
                    film_id IN (SELECT 
                            film_id
                        FROM
                            inventory
                        WHERE
                            inventory_id IN (SELECT 
                                    inventory_id
                                FROM
                                    rental
                                WHERE
                                    rental_id IN (SELECT 
                                            rental_id
                                        FROM
                                            rental
                                        WHERE
                                            rental.rental_id = payment.rental_id))))) AS genre
FROM
    payment
GROUP BY genre
ORDER BY SUM(amount) DESC
LIMIT 5;

#8b		

SELECT * FROM top_five_genres;

#8c 

DROP VIEW top_five_genres;