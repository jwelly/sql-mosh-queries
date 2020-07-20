/*

SELECT *
FROM sql_store.customers
WHERE birth_date > '1990-01-01' OR
	  (points > 1000 AND state = 'VA');

      
SELECT *
FROM customers
WHERE state IN ('VA', 'FL', 'GA');
-- This is an alternative to doing: WHERE state = 'VA' OR state = 'FL' OR state = 'GA'


SELECT *
FROM customers
WHERE points BETWEEN 1000 AND 3000;
-- You can use BETWEEN with dates too, as strings (inside '')
-- WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01';


-- This query selects customers whose last name CONTAINS the letter b anywhere, beginning, middle or end, anywhere
-- % represents ANY number of characters
-- _ represents a single character
SELECT *
FROM customers
WHERE last_name LIKE '%b%';


SELECT *
FROM customers
WHERE address LIKE '%trail%' OR
	  address LIKE '%avenue%';


SELECT *
FROM customers
WHERE last_name LIKE '%field';
-- Alternatively, in "WHERE last_name REGEXP 'field$'", the $ means the last_name must END in 'field'
-- A ^ before means it must BEGIN with field


SELECT *
FROM customers
WHERE last_name REGEXP 'field|mac|rose';
-- This query selects last names containing EITHER of these words at any position


SELECT *
FROM customers
WHERE last_name REGEXP '[gim]e';
-- This query selects last names containing EITHER 'ge' 'ie' or 'me'


SELECT *
FROM customers
WHERE last_name REGEXP '^my|se';
-- Here we want the last names that EITHER start with 'my' or just contain 'se'


USE sql_store;
SELECT first_name, last_name
FROM customers
ORDER BY birth_date;
-- In MySQL you can sort data by ANY COLUMNS, whether that col is in the select clause or not
-- You can also sort data, by an alias you give in the select clause


SELECT *
FROM customers
ORDER BY points DESC
LIMIT 3;


-- Here we list every order of ALL the customers, inc those WITH no order history, hence the LEFT JOIN (outer)
-- In this example, LEFT refers to the first table we mention, FROM customers c
SELECT
	c.customer_id,
    c.first_name,
    o.order_id,
    sh.name AS shipper
FROM customers c
LEFT JOIN orders o
	ON c.customer_id = o.customer_id
LEFT JOIN shippers sh
	ON o.shipper_id = sh.shipper_id
ORDER BY c.customer_id;


-- Multiple joins, both inner and outer, connecting 4 tables
SELECT
    o.order_id,
	o.order_date,
    c.first_name AS customer,
    sh.name AS shipper,
    os.name AS status
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
LEFT JOIN shippers sh
	ON o.shipper_id = sh.shipper_id
JOIN order_statuses os
	ON os.order_status_id = o.status
ORDER BY order_id;
*/

/*

-- In MySQL if the column name is exactly the same in both tables in an ON clause, you can use USING instead
USE sql_store;
SELECT
	o.order_id,
    c.first_name,
    sh.name
FROM orders o
JOIN customers c
	USING (customer_id)
LEFT JOIN shippers sh
	USING (shipper_id);
	-- ON sh.shipper_id = o.shipper_id

*/

/*

-- Find customers from VA who have spent over 100.00.
-- Break up bigger problems into smallers ones first
-- Remember, we use WHERE before grouping data, HAVING after grouping data
USE sql_store;

SELECT
	c.customer_id,
    c.first_name,
    c.last_name,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM customers c
JOIN orders o USING (customer_id)
JOIN order_items oi USING (order_id)
WHERE state = 'VA'
GROUP BY
	c.customer_id,
    c.first_name,
    c.last_name
HAVING total_sales > 100

*/

/*

-- Find customers who have ordered lettuce (id = 3)
-- Here we've used a sub query
USE sql_store;
SELECT
	customer_id,
    first_name,
    last_name
FROM customers
WHERE customer_id IN (
	SELECT o.customer_id
	FROM order_items oi
	JOIN orders o USING (order_id)
	WHERE product_id = 3
	);

-- ALTERNATIVELY, you can use a join (twice)
SELECT DISTINCT
	customer_id,
    first_name,
    last_name
FROM customers c
JOIN orders o USING (customer_id)
JOIN order_items oi USING (order_id)
WHERE oi.product_id = 3;

*/

/*

-- Here, we CONCAT first and last names, and get their phone number, marked 'Unknown' if null.
USE sql_store;
SELECT
	CONCAT(first_name, ' ', last_name) AS customer,
    COALESCE(phone, 'Unknown') AS phone
FROM customers;

*/

/*

-- Here, we use CASE.. WHEN to categorise customers depending on their no. of points
-- DON'T FORGET: CASE, WHEN THEN, (ELSE), END AS
USE sql_store;
SELECT
	CONCAT(first_name, ' ', last_name) AS customer,
    points,
    CASE
		WHEN points >= 3000 THEN 'Gold'
        WHEN points BETWEEN 2000 AND 2999 THEN 'Silver'
        ELSE 'Bronze'
	END AS category
FROM customers;

*/


