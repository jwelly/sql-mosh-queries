-- String and time functions!

/*

-- String functions
-- These remove unnecessary spaces
SELECT LTRIM('     Sky');
SELECT RTRIM('Sky    ');
SELECT TRIM('   Sky  ');

-- These select certain characters
SELECT LEFT('Kindergarten', 4); -- We get 'Kind'
SELECT RIGHT('Kindergarten', 6); -- We get 'garten'
SELECT SUBSTRING('Kindergarten', 3, 5); -- Starts at character 3, finishes after 5 (inc. char 3). We get 'nderg'
SELECT LOCATE('n', 'Kindergarten'); -- returns the pos of a first occurence of a character. Not case-sensitive.

-- This replaces characters
SELECT REPLACE('Kindergarten', 'garten', 'garden') -- Replaces 'garten' with 'garden' in 'Kindergarten'.


-- This concatenates. MUST put an alias.
-- We get full_name by combining first_ and last_
USE sql_store;
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM customers;

*/
/*

-- Functions with date and time
SELECT NOW(); -- Selects current date and exact time
SELECT CURDATE(); -- Does the above, but only date
SELECT CURTIME();
SELECT YEAR(NOW()); -- same can be done with MONTH, DAY, HOUR, MINUTE, SECOND. They return integer vals.
SELECT DAYNAME(NOW()); -- same with MONTHNAME. These return strings.

-- EXTRACT is more universal, good when exporting to other RDBS'.
SELECT EXTRACT(YEAR FROM NOW()); -- same with MONTH, DAY etc..


-- You can format dates and times. More user-friendly.
-- Check dev.mysql.com for more specificers, e.g. %D = 29th
SELECT DATE_FORMAT(NOW(), '%M %d %Y'); -- we get: 'June 29 2020'
SELECT TIME_FORMAT(NOW(), '%H:%i'); -- we get: 15:27


-- Performing calculations on dates and times
SELECT DATEDIFF(NOW(), '2020-01-16'); -- calculates diff between two dates. Returns no. of days.
SELECT TIME_TO_SEC(CURTIME()); -- calculates no. of hours since MIDNIGHT. Can also subtract times.

*/





