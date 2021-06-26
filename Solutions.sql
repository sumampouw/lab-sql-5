-- 1. Drop column `picture` from `staff`.
ALTER TABLE staff 
DROP COLUMN picture;

-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
INSERT INTO staff
VALUES (3,'Tammy','Sanders',79,'Tammy.Sanders@sakilastaff.com',2,1,'Tammy','8cb2237d0679ca88db6464eac60da96345513964', '2021-06-25 19:01:20');

UPDATE customer
SET email = 'TAMMY.SANDERS@sakilastaff.com', last_update = '2021-06-25 19:03:20'
WHERE customer_id = 75;

-- SELECT * FROM customer WHERE first_name = 'TAMMY' AND last_name = 'SANDERS';

-- 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the `rental_date` column in the `rental` table.
   -- **Hint**: Check the columns in the table rental and see what information you would need to add there. 
   -- You can query those pieces of information. 
   -- For eg., you would notice that you need `customer_id` information as well.
   -- To get that you can use the following query:
INSERT INTO rental
VALUES (16050, now(), 1, 130, NULL, 1, now());

select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';

    -- Use similar method to get `inventory_id`, `film_id`, and `staff_id`.

SELECT film_id
FROM film
WHERE title REGEXP "Academy Dinosaur";

SELECT staff_id
FROM staff
WHERE first_name= "CHARLOTTE";

SELECT inventory_id 
FROM inventory
WHERE film_id = 1 AND store_id = 1;

-- 4. Delete non-active users, but first, create a _backup table_ `deleted_users` to store `customer_id`, `email`, and the `date` for the users that would be deleted. Follow these steps:

   -- 4.1 Check if there are any non-active users
SELECT *
FROM customer
WHERE active = false;
   -- 4.2 Create a table _backup table_ as suggested
CREATE TABLE new_users(
  customer_id INT(11) UNIQUE NOT NULL,
  email VARCHAR(60) DEFAULT NULL,
  date DATE DEFAULT NULL,
  CONSTRAINT PRIMARY KEY (customer_id)
);
   -- 4.3 Insert the non active users in the table _backup table_
INSERT INTO new_users (customer_id, email, date)
SELECT customer_id, email, DATE(now())
FROM customer
WHERE active = false;
   -- 4.4 Delete the non active users from the table _customer_
DELETE FROM customer
WHERE active = false;