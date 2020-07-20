/*
SELECT
	name,
    unit_price AS 'unit price',
    unit_price * 1.1 AS 'new price'
FROM sql_store.products;


SELECT *
FROM products
WHERE quantity_in_stock IN (49, 38, 72);


-- Left (outer) join example
-- We get ALL the products in the p table whether the condition (ON) is true or not
SELECT
	p.product_id,
    p.name,
    oi.quantity
FROM products p
LEFT JOIN order_items oi
	ON p.product_id = oi.product_id;
*/
/*

-- Sub query
-- Here we find all products that are more expensive than lettuce.
SELECT *
FROM products
WHERE unit_price > (
	SELECT unit_price
    FROM products
    WHERE product_id = 3
    );

*/
/*

-- Find the products that have never been ordered
-- Here, our sub query will return a LIST of values
USE sql_store;
SELECT *
FROM products
WHERE product_id NOT IN (
	SELECT DISTINCT product_id
	FROM order_items
	);

*/

-- Find the products that have never been ordered
-- EXISTS
USE sql_store;
SELECT *
FROM products p
WHERE NOT EXISTS (
	SELECT product_id
    FROM order_items oi
    WHERE p.product_id = oi.product_id
	);


