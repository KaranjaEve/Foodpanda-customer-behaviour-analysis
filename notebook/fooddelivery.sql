DROP DATABASE IF EXISTS fooddelivery;

CREATE DATABASE fooddelivery;

USE fooddelivery;

DROP TABLE IF EXISTS fastfood_delivery;

CREATE TABLE fastfood_delivery (
	customer_id VARCHAR(10) PRIMARY KEY,
    gender VARCHAR(10),
    age INT,
    city VARCHAR(20),
    signup_date DATE,
    order_id VARCHAR(10),
    order_date DATE,
    day_of_the_week VARCHAR(15),
    restaurant_name VARCHAR(20),
    dish_name VARCHAR(20),
    quantity INT,
    price DECIMAL(10,2),
    payment_method VARCHAR(20),
    order_frequency INT,
    last_order_date DATE,
    loyalty_points INT,
    churned VARCHAR(20), 
    rating INT,
    rating_date DATE,
    status VARCHAR(20)
    );

-- view data
SELECT * FROM fastfood_delivery;

SHOW COLUMNS FROM fastfood_delivery;

-- check & delete empty rows 
SELECT * FROM fastfood_delivery
	WHERE age IS NULL OR age ='';

-- add a column for total_price
ALTER TABLE fastfood_delivery
	ADD COLUMN total_price DECIMAL(10,2);

UPDATE fastfood_delivery
	SET total_price = quantity*price
	WHERE 1;


-- Ensure dateformart is correct
SELECT order_id, order_date
	FROM fastfood_delivery
	WHERE STR_TO_DATE(order_date, '%Y-%m-%d') IS NULL
		AND order_date IS NOT NULL;

-- EXPLORATORY QUERIES
-- set age range
ALTER TABLE fastfood_delivery
ADD COLUMN age_group VARCHAR(10) AS (
	CASE 
		when age between 18 AND 20 then '18-20'
		when age between 21 AND 30 then '21-30'
		when age between 31 AND 40 then '31-40'
		when age between 41 AND 50 then '41-50'
		when age between 51 AND 60 then '51-60'
		else 'Over 60'
END
);

-- 2.Age,gender distribution amongst cities 
SELECT age_group,gender,city, COUNT(order_id) AS total_orders
	FROM fastfood_delivery
    GROUP BY  gender,age_group,city
    ORDER BY gender,age_group,city;


-- 3. total orders per food item
SELECT dish_name, COUNT(order_id) AS ordered
	FROM fastfood_delivery
    GROUP BY dish_name
    ORDER BY dish_name;

-- orders of each food item per restaurant
SELECT dish_name, restaurant_name, COUNT(dish_name)
	FROM fastfood_delivery
    GROUP BY dish_name,restaurant_name
    ORDER BY restaurant_name;

-- total revenue/restaurant


-- days with most orders
SELECT day_of_the_week, COUNT(order_id) AS orders
	FROM fastfood_delivery
    GROUP BY day_of_the_week
    ORDER BY orders DESC;
    
-- How many orders were delayed. 

-- rating vs delayed delivery

-- age group and gender with most orders
