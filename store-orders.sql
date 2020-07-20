/*
SELECT *
FROM orders
WHERE shipped_date IS NULL; 
-- This gets the entries where the order has not been shipped yet

SELECT order_id, o.customer_id, first_name, last_name
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id;


-- A nice report here, joining THREE tables
USE sql_store;
SELECT
	o.order_id,
    o.order_date,
    c.first_name,
    c.last_name,
    os.name AS order_status
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
JOIN order_statuses os
	ON os.order_status_id = o.status;


-- Implicit join syntax. DON'T FORGET WHERE CLAUSE, otherwise, a cross join will be executed, resulting in far too many results
-- AVOID IMPLICIT, in general. Explicit join is best practice
SELECT *
FROM orders o, customers c
WHERE o.customer_id = c.customer_id;


-- An example of a NATURAL JOIN. The database engine guesses the join, based on the common columns.
-- We have no control. Not always advisable.
USE sql_store;
SELECT
	o.order_id,
    c.first_name
FROM orders o
NATURAL JOIN customers c


-- CROSS JOIN combines everything from one table with everything from another
USE sql_store;
SELECT
	c.first_name AS customer,
    p.name AS product
FROM customers c
CROSS JOIN products p
ORDER BY 1, 2;


-- An example of UNION. The no of columns must be the same in both SELECT statements
-- In this case, it's a 'self union' (all between customers table)
SELECT
	customer_id,
    first_name,
    points,
    'Bronze' AS type
FROM customers
WHERE points < 2000
UNION
SELECT
	customer_id,
    first_name,
    points,
    'Silver' AS type
FROM customers
WHERE points BETWEEN 2000 AND 3000
UNION
SELECT
	customer_id,
    first_name,
    points,
    'Gold' AS type
FROM customers
WHERE points > 3000
ORDER BY 2;
*/
/*

-- Instead of hard-coding a data value we use EXTRACT to get this current year
-- We pass order_date to the YEAR function, then do EXTRACT to get this current year.
-- Our results are NULL because no orders have been made in 2020.
SELECT *
FROM orders
WHERE YEAR(order_date) >= EXTRACT(YEAR FROM NOW());


-- Instead of returning the default null value, you can customise it using IFNULL
-- Here, we substituted a null value with 'Not assigned'
USE sql_store;
SELECT
	order_id,
    IFNULL(shipper_id, 'Not assigned') AS shipper
FROM orders;


-- Slightly different to IFNULL
-- With COALESCE, if shipper_id is null, return the value in the comments column
-- If comments is also null, return 'Not assigned'
USE sql_store;
SELECT
	order_id,
    COALESCE(shipper_id, comments, 'Not assigned') AS shipper
FROM orders;

*/
/*

-- IF statement
-- Here, if an order_date has year 2019, it goes in 'Active' category, otherwise, 'Archive'
SELECT
	order_id,
    order_date,
	IF(YEAR(order_date) = 2019, 'Active', 'Archive') AS category
FROM orders;

*/
/*

-- Because we used an agg function (COUNT), we need to group our data by p_id and name
-- NOTE we can't use our alias to reference in our IF column, so we write COUNT(*) again.
-- IF allows ONLY ONE test expression
SELECT
	product_id,
    name,
    COUNT(*) AS orders,
    IF(COUNT(*) > 1, 'Many times', 'Once') AS frequency
FROM products
JOIN order_items USING (product_id)
GROUP BY product_id, name;


-- CASE operator allows MULTIPLE test expressions which return unique values for each one.
-- ELSE is optional
USE sql_store;
SELECT
	order_id,
    CASE
		WHEN YEAR(order_date) = YEAR(NOW()) THEN 'Active'
        WHEN YEAR(order_date) = YEAR(NOW()) - 1 THEN 'Last Year'
        WHEN YEAR(order_date) < YEAR(NOW()) - 1 THEN 'Archive'
		ELSE 'Future'
	END AS category
FROM orders;

*/



