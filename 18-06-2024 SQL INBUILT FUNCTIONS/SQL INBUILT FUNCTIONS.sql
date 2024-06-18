
-- 1.Aggregate Functions:
   -- `SUM()`: Returns the sum of all values in a specified column.
   -- `AVG()`: Returns the average value of a specified column.
   -- `COUNT()`: Returns the number of rows that match a specified condition.
   -- `MAX()`: Returns the maximum value in a specified column.
   -- `MIN()`: Returns the minimum value in a specified column.

-- 2.String Functions:
   -- `CONCAT()`: Concatenates two or more strings.
   -- `SUBSTRING()`: Extracts a substring from a string.
   -- `LENGTH()`: Returns the length of a string.
   -- `UPPER()`: Converts a string to uppercase.
   -- `LOWER()`: Converts a string to lowercase.
   -- `TRIM()`: Removes leading and trailing spaces from a string.

-- 3.Date and Time Functions:
   -- `CURRENT_DATE()`: Returns the current date.
   -- `CURRENT_TIME()`: Returns the current time.
   -- `CURRENT_TIMESTAMP()`: Returns the current date and time.
   -- `DATE_FORMAT()`: Formats a date according to a specified pattern.
   -- `DATEDIFF()`: Returns the difference between two dates in days.
   -- `YEAR()`, `MONTH()`, `DAY()`: Extracts the year, month, or day from a date.

-- 4.Numeric Functions:
   -- `ABS()`: Returns the absolute value of a number.
   -- `ROUND()`: Rounds a number to a specified number of decimal places.
   -- `FLOOR()`: Returns the largest integer value that is less than or equal to a number.
   -- `CEILING()` or `CEIL()`: Returns the smallest integer value that is greater than or equal to a number.

-- 5.Conditional Functions:
   -- `CASE`: Evaluates a list of conditions and returns a value based on the first condition that is true.
   -- `COALESCE()`: Returns the first non-null value in a list.
   -- `NULLIF()`: Returns NULL if the two arguments are equal, otherwise returns the first argument.

-- 6.Other Functions:
   -- `CAST()`: Converts a value from one data type to another.
   -- `REPLACE()`: Replaces all occurrences of a substring within a string with a new substring.
   -- `LIKE`: Used for pattern matching in strings.
   -- `IN` and `NOT IN`: Used to check if a value matches any value in a list.



-- USAGE OF THE FUNCTIONS
-- 1)
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    product_category,
    SUM(quantity) AS total_quantity,
    SUM(quantity * unit_price) AS total_sales,
    ROUND(AVG(unit_price), 2) AS avg_price,
    MAX(unit_price) AS max_price,
    MIN(unit_price) AS min_price
FROM
    orders
    INNER JOIN order_details ON orders.order_id = order_details.order_id
    INNER JOIN products ON order_details.product_id = products.product_id
WHERE
    order_date BETWEEN CAST('2022-01-01' AS DATE) AND CAST('2022-12-31' AS DATE)
GROUP BY
    YEAR(order_date),
    MONTH(order_date),
    product_category
ORDER BY
    order_year,
    order_month,
    total_sales DESC;
    
    -- 2)
    SELECT
    CONCAT(first_name, ' ', last_name) AS full_name,
    department,
    UPPER(job_title) AS job_title,
    DATE_FORMAT(hire_date, '%M %d, %Y') AS hire_date,
    DATEDIFF(CURRENT_DATE(), hire_date) AS days_employed,
    COALESCE(manager_id, 'No Manager') AS manager,
    CASE
        WHEN salary < 50000 THEN 'Low'
        WHEN salary BETWEEN 50000 AND 100000 THEN 'Average'
        ELSE 'High'
    END AS salary_range
FROM
    employees
LEFT JOIN
    departments ON employees.department_id = departments.department_id
WHERE
    last_name LIKE 'S%'
    OR job_title LIKE '%Manager%'
ORDER BY
    department, salary DESC;



