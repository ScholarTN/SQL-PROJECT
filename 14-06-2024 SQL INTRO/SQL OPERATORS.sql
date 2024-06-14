-- Create a sample database and table
CREATE DATABASE IF NOT EXISTS shop;
USE shop;

CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL
);

-- Insert some sample data
INSERT INTO products (name, category, price, stock)
VALUES
    ('Laptop', 'Electronics', 999.99, 50),
    ('Shirt', 'Clothing', 29.99, 100),
    ('Novel', 'Books', 14.99, 75),
    ('Headphones', 'Electronics', 49.99, 25),
    ('Jeans', 'Clothing', 59.99, 80),
    ('Magazine', 'Books', 4.99, 120),
    ('Smartphone', 'Electronics', 799.99, 30);

-- Query examples using various operators
-- Arithmetic Operators
SELECT name, price, price * 0.8 AS discounted_price
FROM products;

-- Comparison Operators
SELECT *
FROM products
WHERE stock < 50;

-- Logical Operators
SELECT *
FROM products
WHERE category = 'Electronics' AND price > 500
   OR category = 'Books' AND stock > 90;

-- LIKE Operator
SELECT *
FROM products
WHERE name LIKE '%phone%';

-- IN Operator
SELECT *
FROM products
WHERE category IN ('Electronics', 'Clothing');

-- BETWEEN Operator
SELECT *
FROM products
WHERE price BETWEEN 20 AND 100;

-- IS NULL / IS NOT NULL Operators
SELECT *
FROM products
WHERE stock IS NOT NULL;

-- UNION Operator
SELECT name, price
FROM products
WHERE category = 'Electronics'
UNION
SELECT name, price
FROM products
WHERE category = 'Books';

-- Operator Precedence
SELECT *
FROM products
WHERE (category = 'Electronics' OR category = 'Books') AND (price > 50 OR stock > 75);