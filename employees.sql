/*

-- self-join (OUTER) exercise. Here we show employees and their manager (who is also an employee)
-- with LEFT join, we include also include the manager whose manager is null
SELECT 
		e.employee_id,
		e.first_name,
		e.last_name,
        m.first_name AS manager
FROM employees e
LEFT JOIN employees m
	ON e.reports_to = m.employee_id;

*/
/*

-- Find employees who earn more than average
USE sql_hr;
SELECT
	employee_id,
    first_name,
    last_name,
    salary
FROM employees
WHERE salary > (
	SELECT AVG(salary)
    FROM employees
    );

*/
/*

-- Select employees whose salary is above their office average
-- CORRELATED SUBQUERY - We reference the alias from the outer query.
-- Correlated subqueries get executed for EACH ROW in the main query, not just once.
-- For each employee, MySQL will execute the sub query.
-- It will calculate the AVG salary for employees in the same office.

USE sql_hr;
SELECT *
FROM employees e
WHERE salary > (
	SELECT AVG(salary)
    FROM employees
    WHERE office_id = e.office_id;
	)

*/


