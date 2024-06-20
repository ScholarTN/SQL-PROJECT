
--                                  DATE-TIME FUNCTIONS


-- 1.CURRENT_DATE()
--   - Returns the current date.
--   - Example: `SELECT CURRENT_DATE();`


-- 2.CURRENT_TIME()
--   - Returns the current time.
--   - Example: `SELECT CURRENT_TIME();`


-- 3.CURRENT_TIMESTAMP()
--   - Returns the current date and time.
--   - Example: `SELECT CURRENT_TIMESTAMP();`


-- 4.DATE()
--   - Extracts the date part from a date/time expression.
--   - Example: `SELECT DATE('2023-05-15 10:30:00');` (Output: `2023-05-15`)



-- 5.TIME()
--   - Extracts the time part from a date/time expression.
--   - Example: `SELECT TIME('2023-05-15 10:30:00');` (Output: `10:30:00`)


-- 6.YEAR()
--   - Extracts the year from a date.
--   - Example: `SELECT YEAR('2023-05-15');` (Output: `2023`)


-- 7.MONTH()
--   - Extracts the month from a date.
--   - Example: `SELECT MONTH('2023-05-15');` (Output: `5`)


-- 8.DAY()
--  - Extracts the day from a date.
--   - Example: `SELECT DAY('2023-05-15');` (Output: `15`)


-- 9.DATE_ADD()
--   - Adds an interval to a date.
--   - Example: `SELECT DATE_ADD('2023-05-15', INTERVAL 10 DAY);` (Output: `2023-05-25`)


-- 10.DATE_SUB()
--    - Subtracts an interval from a date.
--    - Example: `SELECT DATE_SUB('2023-05-15', INTERVAL 1 MONTH);` (Output: `2023-04-15`)


-- 11.DATEDIFF()
--    - Returns the number of days between two dates.
--    - Example: `SELECT DATEDIFF('2023-05-20', '2023-05-15');` (Output: `5`)


-- 12.TIMEDIFF()
--   - Returns the difference between two time values.
--    - Example: `SELECT TIMEDIFF('10:30:00', '09:15:00');` (Output: `01:15:00`)


-- 13.DATE_FORMAT()
--    - Formats a date according to a specified pattern.
--    - Example: `SELECT DATE_FORMAT('2023-05-15', '%M %d, %Y');` (Output: `May 15, 2023`)


-- 14.EXTRACT()
--   - Extracts a specific part (e.g., year, month, day, hour, minute, second) from a date/time value.
--    - Example: `SELECT EXTRACT(YEAR FROM '2023-05-15');` (Output: `2023`)



-- COMBINING THE DATE-TIME FUNCTIONS


SELECT
    order_id,
    order_date,
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    DATE_FORMAT(order_date, '%M %d, %Y') AS formatted_date,
    DATEDIFF(CURRENT_DATE(), order_date) AS days_since_order,
    CASE
        WHEN DATEDIFF(CURRENT_DATE(), order_date) <= 7 THEN 'This Week'
        WHEN DATEDIFF(CURRENT_DATE(), order_date) <= 30 THEN 'This Month'
        ELSE 'Older'
    END AS order_age
FROM
    orders;


-- This query retrieves order information from the `orders` table and includes the following date-time operations:

-- Extracts the year and month from the `order_date` using `YEAR()` and `MONTH()`.
-- Formats the `order_date` using `DATE_FORMAT()` with a custom pattern.
-- Calculates the number of days since the order date using `DATEDIFF()` and `CURRENT_DATE()`.
-- Categorizes the orders based on their age (this week, this month, or older) using a `CASE` statement and `DATEDIFF()`.
