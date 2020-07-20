/*

-- Sub query. Find clients without any invoices
USE sql_invoicing;
SELECT *
FROM clients
WHERE client_id NOT IN (
	SELECT DISTINCT client_id
    FROM invoices
    );

-- The same as above can be done with a LEFT JOIN
-- Which method you choose should depend on its READABILITY
SELECT *
FROM clients
LEFT JOIN invoices USING (client_id)
WHERE invoice_id IS NULL;

*/
/*

-- Select clients with at least 2 invoices
-- We use HAVING because we filter AFTER grouping
SELECT *
FROM clients
WHERE client_id IN (
	SELECT client_id
    FROM invoices
    GROUP BY client_id
    HAVING COUNT(*) >= 2
	);

-- '= ANY' is the same as IN
-- If client_id = ANY of the values returned in the subquery....
-- that client will be returned in the final result
SELECT *
FROM clients
WHERE client_id = ANY (
	SELECT client_id
    FROM invoices
    GROUP BY client_id
    HAVING COUNT(*) >= 2
	)

*/
/*

-- Select clients that have an invoice
-- Using IN
SELECT *
FROM clients
WHERE client_id IN (
	SELECT DISTINCT client_id
    FROM invoices
	);

-- Alternative
-- This is a Correlated subquery! Because we're correlating the inner query with the outer
-- I.e. we're referencing the clients table in our subquery.
-- HOWEVER, in our WHERE clause, we're not referencing a column.
-- We're using EXISTS to see if there's an row in the invoices table that matches our criteria (client_id = c.client_id)
-- So, when MySQL executes this query, for each client in the clients table, it will check to see if there EXISTS a record that matches our criteria
SELECT *
FROM clients c
WHERE EXISTS (
	SELECT client_id
    FROM invoices
    WHERE client_id = c.client_id
    );
    
-- But which to use? IN or EXISTS?
-- If the subquery we wrote after the IN operator produces a large result set it is more efficient to use the EXISTS operator.
-- Because, using the EXISTS operator, the subquery doesn't return a result set to the outer query.

*/
/*

-- Here, we get the total_sales, avg and diff for EACH customer
-- We create subqueries in the SELECT clause, some correlated!
SELECT
	client_id,
    name,
    (SELECT SUM(invoice_total)
		FROM invoices
        WHERE client_id = c.client_id) AS total_sales,
	(SELECT AVG(invoice_total)
		FROM invoices) AS average,
	(SELECT total_sales - average) AS difference
FROM clients c;

*/

/*

-- You can even use subqueries in the FROM clause!
-- Subqueries in the FROM clause MUST HAVE AN ALIAS.
-- They're useful for saving for later use.
-- HOWEVER, FROM clause subqueries should be reserved for simple queries.
SELECT *
FROM (
	SELECT
		client_id,
		name,
		(SELECT SUM(invoice_total)
			FROM invoices
			WHERE client_id = c.client_id) AS total_sales,
		(SELECT AVG(invoice_total)
			FROM invoices) AS average,
		(SELECT total_sales - average) AS difference
	FROM clients c)
AS sales_summary
WHERE total_sales IS NOT NULL;

*/




