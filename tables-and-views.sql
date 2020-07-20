-- Creating and updating tables!
-- Creating and updating views!


/*

-- If a primary key is auto-incremented, DEFAULT should be the value you enter
-- If a column is not assigned 'not null' (nn), you can either put a value or DEFAULT/NULL
INSERT INTO customers
VALUES (
	DEFAULT,
    'John',
    'Smith',
    '1991-04-23',
    NULL,
    '26 Jefferson Avenue',
    'Burlington',
    'MA',
    DEFAULT
    );
  
-- Alternative method of above
-- If you want to select individual columns, you can:
INSERT INTO customers (
	first_name,
    last_name,
    birth_date,
    address,
    city,
    state)
VALUES (	
    'John',
    'Smith',
    '1991-04-23',
    '26 Jefferson Avenue',
    'Burlington',
    'MA'
    );


-- Insert multiple rows (no need to add shipper_id, as it's auto incremented)
INSERT INTO shippers (name)
VALUES ('Shipper1'),
	   ('Shipper2'),
       ('Shipper3');

INSERT INTO products
VALUES (DEFAULT, 'Fries', 65, 1.49),
	   (DEFAULT, 'Jalapeño poppers', 69, 4.39),
       (DEFAULT, 'Onion rings', 95, 3.49);

*/
/*
-- Here we insert an order
INSERT INTO orders (customer_id, order_date, status)
VALUES (1, '2020-01-02', 1);

-- A built-in function to check the ID that MySQL generates when inserting a new row
	-- SELECT LAST_INSERT_ID();

-- Now we have to insert the items of the order
INSERT INTO order_items
VALUES (LAST_INSERT_ID(), 1, 1, 2.95),
	   (LAST_INSERT_ID(), 2, 3, 4.95);

-- Now we have inserted hierarchical data into MySQL!



-- Creating a copy of a table: First, CREATE the new table
-- You need to set a primary key in the new table
-- The select statement is known as a SUB QUERY: part of another SQL statement
CREATE TABLE orders_archive AS
SELECT * FROM orders

-- We can then truncate the new table, deleting all the entries, and then...

-- Here we're using a SELECT statement as a subquery in an INSERT statement
-- We copy some data from 'orders' into 'orders_archive'
INSERT INTO orders_archive
SELECT *
FROM orders
WHERE order_date < '2019-01-01'


*/
/*
-- Before copying to a new table, query the data you want first
-- Then do CREATE TABLE.... AS
USE sql_invoicing;

CREATE TABLE invoices_archive AS
SELECT
	i.invoice_id,
    i.number,
    c.name AS client,
    i.invoice_total,
    i.payment_total,
    i.invoice_date,
    i.due_date,
    i.payment_date
FROM invoices i
JOIN clients c
	USING (client_id)
WHERE payment_date IS NOT NULL;


*/
-- THESE QUERIES UPDATE THE TABLES!

/*
-- Here, we updated a single invoices entry
-- We set the payment_total column to the value of another column * 0.5.
-- We set another column to the value of another column
USE sql_invoicing;
UPDATE invoices
SET
	payment_total = invoice_total * 0.5,
	payment_date = due_date
WHERE invoice_id = 3;


-- To update multiple records, same syntax, but WHERE condition needs to be more general.
-- You could update all the invoices of one client.
-- HOWEVER, you have to turn off "Safe Updates", and close and open local.
UPDATE invoices
SET
	payment_total = invoice_total * 0.5,
	payment_date = due_date
WHERE client_id IN (3, 4);

*/
/*

-- Here we give 50 points to customers born before a certain date
UPDATE customers
SET points = points + 50
WHERE birth_date < '1990-01-01';

*/
/*

-- Using subqueries in an update statement
-- Imagine we don't know the client_id off hand. We can use a subquery in WHERE
UPDATE invoices
SET
	payment_total = invoice_total * 0.5,
	payment_date = due_date
WHERE client_id = 
		(SELECT client_id
        FROM clients
        WHERE name = 'Myworks');

-- We can also do an update to MULTIPLE CLIENTS rather than just one
-- For example, all clients in California and New York
-- Because this subquery returns multiple records, we have to use IN, not =
UPDATE invoices
SET
	payment_total = invoice_total * 0.5,
	payment_date = due_date
WHERE client_id IN
		(SELECT client_id
        FROM clients
        WHERE state IN ('CA', 'NY'));
*/

-- Before executing an UPDATE statement, run your subquery to check what records will be updated.

/*
-- Here, we updated the comments in the orders table
-- Again, IN, because we updating multiple entries (we can check this before executing the UPDATE).

UPDATE orders
SET comments = 'Gold customer'
WHERE customer_id IN (
	SELECT customer_id
	FROM customers
	WHERE points >= 3000)

*/
/*

-- VIEWS

-- CREATE VIEWS creates a view object. It doesn't execute a query.
-- Views are reusable saved queries. We might have future queries that will be based on this query
-- For instance, we might what our top clients, or clients with least sales
-- You can select data from a view. Views can be used like a table!
USE sql_invoicing;
CREATE VIEW clients_balance AS
	SELECT
		c.client_id,
		c.name,
		SUM(invoice_total - payment_total) AS balance
	FROM clients c
	JOIN invoices i USING (client_id)
	GROUP BY 1, 2;

-- Altering or dropping views
-- Perhaps we encounter a problem. You can drop a view and recreate it.
-- Or you can use the REPLACE keyword: CREATE OR REPLACE VIEW view_name
-- BUT what if you don't have access to the query behind the view?
	-- You can save your views under SQL files and put them under source control and then in a Git repos.


-- If you don't have in our view, then it is an UPDATABLE VIEW, meaning, we can update data through it:
	-- DISTINCT, Agg functions (MIN, MAX, SUM..), GROUP BY / HAVING, UNION
-- As a result, we can use this view in INSERT, UPDATE or DELETE statements
-- NOTE: Updating a view will ALSO UPDATE THE ORIGINAL TABLE!!!


-- When you update or delete data through a VIEW, some of the rows may disappear
-- But you won't always want this.
-- WITH CHECK OPTION prevents exclusion of rows from an updated view.
CREATE OR REPLACE VIEW invoices_with_balance AS
SELECT
	invoice_id,
    number,
    client_id,
    invoice_total,
    payment_total,
    invoice_total - payment_total AS balance,
    invoice_date,
    due_date,
    payment_date
FROM invoices
WHERE (invoice_total - payment_total) > 0
WITH CHECK OPTION;

-- Now, if we try to update our view, we'll get an error, because of the WITH CHECK OPTION
UPDATE invoices_with_balance
SET payment_total = invoice_total
WHERE invoice_id = 3;

*/



