/*

-- Aggregate functions! Can also be used on dates and strings
-- However, they only operate on non-null values! Null values are not included
-- Use DISTINCT to excluse default duplicates.
SELECT
	MAX(invoice_total) AS highest,
    MIN(invoice_total) AS lowest,
    AVG(invoice_total) AS average,
    SUM(invoice_total * 1.1) AS total,
    -- COUNT(invoice_total) AS number_of_invoices,
    COUNT(DISTINCT client_id) AS total_records
FROM invoices
WHERE invoice_date > '2019-07-01';

*/
/*

USE sql_invoicing;
SELECT
	'First half of 2019' AS date_range,
    SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
    SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date
	BETWEEN '2019-01-01' AND '2019-06-30'
UNION
SELECT
	'Second half of 2019' AS date_range,
    SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
    SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date
	BETWEEN '2019-07-01' AND '2019-12-31'
UNION
SELECT
	'Total' AS date_range,
    SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
    SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date
	BETWEEN '2019-01-01' AND '2019-12-31';

*/
/*

-- Here, we obtain the total sales for each client, with GROUP BY client_id
SELECT
	client_id,
    SUM(invoice_total) AS total_sales
FROM invoices
WHERE invoice_date >= '2019-07-01'
GROUP BY client_id
ORDER BY total_sales DESC;

-- We can also group by multiple columns
-- We can see total sales for each state and city combo
SELECT
	state,
    city,
    SUM(invoice_total) AS total_sales
FROM invoices i
JOIN clients USING (client_id) 
GROUP BY state, city;

*/
/*

-- Here, we get total payments sorted by date, and categorised by payment method.
SELECT
	date,
    pm.name AS payment_method,
    SUM(amount) AS total_payments
FROM payments p
JOIN payment_methods pm
	ON pm.payment_method_id = p.payment_method
GROUP BY date
ORDER BY date;

*/
/*

-- Imagine we want to include only clients whose total is over 500.00.
-- We can't use WHERE clause, cos we haven't grouped our data yet.
-- We use HAVING to filter data after our rows are grouped.
-- HOWEVER, the columns from HAVING must be in your SELECT clause, unlike WHERE.
SELECT
	client_id,
    SUM(invoice_total) AS total_sales,
    COUNT(*) AS number_of_invoices
FROM invoices
GROUP BY client_id
HAVING
	total_sales > 500 AND
    number_of_invoices > 5;

*/

/*

-- MySQL only feature: WITH ROLLUP operator for summarising data
-- WITH ROLLUP operator for summarising data
-- Here, we get an extra row summarising our entire result set.
-- We get the sum of total sales across ALL clients
SELECT
	client_id,
    SUM(invoice_total) AS total_sales
FROM invoices
GROUP BY client_id WITH ROLLUP;


-- When you GROUP BY multiple columns, and WITH ROLLUP, you get a summary of values for each group AND the entire result set.
SELECT
	state,
    city,
    SUM(invoice_total) AS total_sales
FROM invoices i
JOIN clients c USING (client_id)
GROUP BY state, city WITH ROLLUP;

*/
/*
-- Select invoices larger than all invoices of client 3
-- Here, we use a sub query that returns a SINGLE VALUE
USE sql_invoicing;
SELECT *
FROM invoices
WHERE invoice_total > (
	SELECT MAX(invoice_total)
	FROM invoices
	WHERE client_id = 3
	);

-- HOWEVER, this can also be done using the ALL keyword
-- Here, the sub query returns MULTIPLE VALUES, ie all values with client = 3
SELECT *
FROM invoices
WHERE invoice_total > ALL (
	SELECT invoice_total
	FROM invoices
	WHERE client_id = 3
	);

*/
/*

-- Get invoices that are larger than the client's AVG invoice amount
-- We are dealing with multiple averages, so...
-- Corr sub-query. In this, we need to find the AVG invoice amount for each client
USE sql_invoicing;
SELECT *
FROM invoices i
WHERE invoice_total > (
	SELECT AVG(invoice_total)
    FROM invoices
    WHERE client_id = i.client_id
    );

*/
/*

-- Sub queries are not limited to just the WHERE CLASS
-- They can be used in SELECT clauses too!
-- Here, our query compares each invoice with the difference between the AVG invoice total
-- NOTE, in col 4, we cannot use our alias from col 3. Instead, do SELECT invoice_average, which is another sub query!
USE sql_invoicing;
SELECT
	invoice_id,
    invoice_total,
    (SELECT AVG(invoice_total)
		FROM invoices) AS invoice_average,
	invoice_total - (SELECT invoice_average) AS difference
FROM invoices;

*/
/*

-- Create a stored PROCEDURE called get_invoices_balance
-- To return all the invoices with a balance > 0
-- You can also create a procedure from a view as well, which sometimes makes your code simpler
-- Always terminate every statement in a store procedure with a semi-colon
-- You have to change the default delimiter every time you create a stored procedure
	-- Or, you can just right-click 'Stored Procedures' and create one there
DELIMITER $$
CREATE PROCEDURE get_invoices_with_balance()
BEGIN
	SELECT *
	FROM invoices_with_balance
	WHERE balance > 0;
END$$

DELIMITER ;

*/


