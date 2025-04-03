use dummy;

/* Q1) Solution*/

create table employees
(	emp_id int not null primary key,
	emp_name varchar(20) not null,
    age int check(age >= 18),
    email varchar(50) unique,
    salary decimal default 30000
);


-- 2. Purpose of Constraints in Databases
/* 
Constraints help maintain data integrity and enforce rules to ensure that data remains accurate and consistent. Common types of constraints include:
NOT NULL: Ensures a column cannot have NULL values (e.g., an employee's name must always be provided).
UNIQUE: Ensures all values in a column are unique (e.g., email addresses must be unique).
PRIMARY KEY: Uniquely identifies each record in a table (e.g., emp_id in the employees table).
FOREIGN KEY: Ensures referential integrity by linking tables (e.g., department_id referencing a departments table).
CHECK: Ensures a column satisfies a specific condition (e.g., age must be at least 18).
DEFAULT: Assigns a default value if no value is provided (e.g., salary defaults to 30,000).
*/

-- 3. Why Use NOT NULL? Can a Primary Key Contain NULL?
/*

The NOT NULL constraint ensures that a column cannot store NULL values, which is useful for required fields like emp_name where every employee must have a name.

A Primary Key cannot contain NULL values because it uniquely identifies records in a table. If it had NULL values, uniqueness could not be guaranteed.

*/

/* Q4) Solution*/
# Adding Constraints
alter table employees add constraint chk_age CHECK (age >= 18);
# Removing constraints
alter table employees DROP CONSTRAINT chk_age;

/* Q6) Solution*/
CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(50),
    price DECIMAL(10, 2));
    
alter table products add primary key (product_id);
alter table products alter column price set default 50.00;

/* Q7) Solution*/
select students.student_name, classes.class_name from students
inner join classes on students.class_id = classes.class_id;

/* Q8) Solution*/
select orders.order_id, customers.customer_name, products.product_name
from orders
left join order_details on orders.order_id = order_details.order_id
left join products on order_details.product_id = products.product_id
inner join customers on orders.customer_id = customers.customer_id;

/* Q9) Solution*/
select products.product_id, products.product_name, sum(order_details.quantity * order_details.price) as total_sales from products
inner join order_details on products.product_id = order_details.product_id
group by products.product_id, products.product_name;

/* Q10) Solution*/
select orders.order_id, customers.customer_name, sum(order_details.quantity) as total_quantity from orders
inner join customers on orders.customer_id = customers.customer_id
inner join order_details on orders.order_id = order_details.order_id
group by orders.order_id, customers.customer_name;

# SQL Commands 
use mavenmovies;
-- 1. Identify primary and foreign keys in maven movies database
show create table actor;
show create table film;
show create table customer;
show create table rental;

-- 2. List all details of actors
select * from actor;

-- 3. List all customer information from DB
select * from customer;

-- 4. List different countries
select distinct country from country;

-- 5. Display all active customers
select * from customer where active = 1;

-- 6. List all rental IDs for customer with ID 1
select rental_id from rental where customer_id = 1;

-- 7. Display all the films whose rental duration is greater than 5
select * from film where rental_duration > 5;

-- 8. List the total number of films whose replacement cost is greater than $15 and less than $20
select COUNT(*) from film where replacement_cost > 15 and replacement_cost < 20;

-- 9. Display the count of unique first names of actors
select COUNT(distinct first_name) from actor;

-- 10. Display the first 10 records from the customer table
select * from customer limit 10;

-- 11. Display the first 3 records from the customer table whose first name starts with 'b'
select * from customer where first_name like 'b%' limit 3;

-- 12. Display the names of the first 5 movies which are rated as 'G'
select title from film where rating = 'G' limit 5;

-- 13. Find all customers whose first name starts with "a"
select * from customer where first_name like 'a%';

-- 14. Find all customers whose first name ends with "a"
select * from customer where first_name like '%a';

-- 15. Display the list of first 4 cities which start and end with 'a'
select city from city where city like 'a%a' limit 4;

-- 16. Find all customers whose first name have "NI" in any position
select * from customer where first_name like '%NI%';

-- 17. Find all customers whose first name has "r" in the second position
select * from customer where first_name like '_r%';

-- 18. Find all customers whose first name starts with "a" and are at least 5 characters in length
select * from customer where first_name like 'a%' and LENGTH(first_name) >= 5;

-- 19. Find all customers whose first name starts with "a" and ends with "o"
select * from customer where first_name like 'a%o';

-- 20. Get the films with PG and PG-13 rating using IN operator
select * from film where rating in ('PG', 'PG-13');

-- 21. Get the films with length between 50 to 100 using BETWEEN operator
select * from film where length between 50 and 100;

-- 22. Get the top 50 actors using LIMIT operator
select * from actor limit 50;

-- 23. Get the distinct film ids from inventory table
select distinct film_id from inventory;


/*     Function Sloution        */
-- 1. Retrieve the total number of rentals made in the Sakila database. Hint: Use the COUNT() function.
SELECT COUNT(*) AS total_rentals FROM rental;

-- 2. Find the average rental duration (in days) of movies rented from the Sakila database.
SELECT AVG(rental_duration) AS avg_rental_duration FROM film;

-- 3. Display the first name and last name of customers in uppercase.
SELECT UPPER(first_name) AS first_name_upper, UPPER(last_name) AS last_name_upper FROM customer;

-- 4. Extract the month from the rental date and display it alongside the rental ID.
SELECT rental_id, MONTH(rental_date) AS rental_month FROM rental;

-- 5.  Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
SELECT customer_id, COUNT(*) AS rental_count
FROM rental
GROUP BY customer_id;

-- 6.  Find the total revenue generated by each store.
SELECT store_id, SUM(amount) AS total_revenue
FROM payment
JOIN customer ON payment.customer_id = customer.customer_id
JOIN store ON customer.store_id = store.store_id
GROUP BY store_id;

-- 7.  Determine the total number of rentals for each category of movies.
SELECT category.name AS category_name, COUNT(rental.rental_id) AS total_rentals
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name;

-- 8. Find the average rental rate of movies in each language.
SELECT language.name AS language_name, AVG(film.rental_rate) AS avg_rental_rate
FROM film
JOIN language ON film.language_id = language.language_id
GROUP BY language.name;

-- 9. Display the title of the movie, customer's first name, and last name who rented it.
SELECT film.title, customer.first_name, customer.last_name
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN customer ON rental.customer_id = customer.customer_id;

-- 10. Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
SELECT actor.first_name, actor.last_name
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
WHERE film.title = 'Gone with the Wind';

-- 11. Retrieve the customer names along with the total amount they've spent on rentals.
SELECT customer.first_name, customer.last_name, SUM(payment.amount) AS total_spent
FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id;

-- 12. List the titles of movies rented by each customer in a particular city (e.g., 'London').
SELECT film.title, customer.first_name, customer.last_name, city.city
FROM rental
JOIN customer ON rental.customer_id = customer.customer_id
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
WHERE city.city = 'London'
GROUP BY film.title, customer.first_name, customer.last_name, city.city;

-- 13. Display the top 5 rented movies along with the number of times they've been rented.
SELECT film.title, COUNT(rental.rental_id) AS rental_count
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
GROUP BY film.title
ORDER BY rental_count DESC
LIMIT 5;

-- 14. Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
SELECT customer.customer_id, customer.first_name, customer.last_name
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN store ON inventory.store_id = store.store_id
JOIN customer ON rental.customer_id = customer.customer_id
WHERE store.store_id IN (1, 2)
GROUP BY customer.customer_id
HAVING COUNT(DISTINCT store.store_id) = 2;



/*              Window Function Solutions           */

-- 1. Rank the customers based on the total amount they've spent on rentals.
SELECT customer_id, first_name, last_name, SUM(amount) AS total_spent,
       RANK() OVER (ORDER BY SUM(amount) DESC) AS ranking
FROM payment
JOIN customer ON payment.customer_id = customer.customer_id
GROUP BY customer.customer_id;

-- 2.  Calculate the cumulative revenue generated by each film over time.
SELECT film.title, rental_date, SUM(payment.amount) OVER (PARTITION BY film.film_id ORDER BY rental_date) AS cumulative_revenue
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN payment ON rental.rental_id = payment.rental_id;

-- 3. Determine the average rental duration for each film, considering films with similar lengths.
SELECT film_id, title, length, AVG(rental_duration) OVER (PARTITION BY length) AS avg_rental_duration
FROM film;

-- 4: Identify the top 3 films in each category based on their rental counts.
SELECT category.name AS category_name, film.title, COUNT(rental.rental_id) AS rental_count,
       RANK() OVER (PARTITION BY category.name ORDER BY COUNT(rental.rental_id) DESC) AS ranking
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name, film.title
HAVING ranking <= 3;

-- 5. Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers.
SELECT c.customer_id, c.first_name, c.last_name, 
       COUNT(rental_id) AS total_rentals, 
       COUNT(rental_id) - AVG(COUNT(rental_id)) OVER () AS rental_difference
FROM rental
JOIN customer c ON rental.customer_id = c.customer_id
GROUP BY customer_id;


-- 6. Find the monthly revenue trend for the entire rental store over time.
SELECT MONTH(payment_date) AS month, YEAR(payment_date) AS year,
       SUM(amount) AS monthly_revenue
FROM payment
GROUP BY YEAR(payment_date), MONTH(payment_date)
ORDER BY year, month;

-- 7. Identify the customers whose total spending on rentals falls within the top 20% of all customers.
WITH CustomerSpending AS (
    SELECT c.customer_id, c.first_name, c.last_name, SUM(amount) AS total_spent
    FROM payment
    JOIN customer c ON payment.customer_id = c.customer_id
    GROUP BY customer_id
),
RankedCustomers AS (
    SELECT customer_id, first_name, last_name, total_spent,
           NTILE(5) OVER (ORDER BY total_spent DESC) AS spending_rank
    FROM CustomerSpending
)
SELECT customer_id, first_name, last_name, total_spent
FROM RankedCustomers
WHERE spending_rank = 1  -- Select top 20% of customers
ORDER BY total_spent DESC;
