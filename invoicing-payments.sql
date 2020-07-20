/*

-- Another self join example to retrieve invoice, customer and payment data
USE sql_invoicing;
SELECT
	p.date,
    p.invoice_id,
    p.amount,
    c.name,
    pm.name
FROM payments p
JOIN payment_methods pm
	ON pm.payment_method_id = p.payment_method
JOIN clients c
	ON c.client_id = p.client_id;


USE sql_invoicing;
SELECT
	p.date,
    c.name AS client,
    p.amount,
    pm.name AS payment_method
FROM payments p
JOIN clients c
	USING (client_id)
JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id;

*/


-- When using ROLLUP, you cannot use an alias in the group by clause, hence pm.name
SELECT
	pm.name AS payment_method,
    SUM(p.amount) AS total
FROM payments p
JOIN payment_methods pm
	ON pm.payment_method_id = p.payment_method
GROUP BY pm.name WITH ROLLUP;





