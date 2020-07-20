/*

SELECT *
FROM order_items
WHERE order_id = 6 AND quantity * unit_price > 30;


SELECT *, quantity * unit_price AS total_price
FROM order_items
WHERE order_id = 2
ORDER BY total_price DESC;


SELECT order_id, oi.product_id, quantity, oi.unit_price as order_items_unit_price
FROM order_items oi
JOIN products p
	ON oi.product_id = p.product_id;


USE sql_store;
-- compound join conditions. When tables have more than one primary key
-- The result is empty as there are no entries with matching combos of BOTH order_id and product_id, only for order_id
-- By using USING our code is cleaner than with ON AND in this case
SELECT *
FROM order_items oi
JOIN order_item_notes oin
	USING (order_id, product_id);
	-- ON oi.order_id = oin.order_id
    -- AND oi.product_id = oin.product_id;    
    
*/ 


    
    