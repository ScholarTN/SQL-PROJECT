-- Create a new database
CREATE DATABASE IF NOT EXISTS my_database;
USE my_database;

-- Create the "categories" table
CREATE TABLE IF NOT EXISTS categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Create the "products" table
CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    category_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- Insert some initial data into the "categories" table
INSERT INTO categories (name) VALUES
    ('Electronics'),
    ('Clothing'),
    ('Books');

-- Insert some initial data into the "products" table
INSERT INTO products (name, price, category_id) VALUES
    ('Laptop', 999.99, 1),
    ('Shirt', 29.99, 2),
    ('Novel', 14.99, 3);

-- Update the price of a product
UPDATE products
SET price = 24.99
WHERE id = 3;

-- Add a new column to the "products" table
ALTER TABLE products
ADD description TEXT;

-- Update the description for a product
UPDATE products
SET description = 'A best-selling novel by a renowned author'
WHERE id = 3;

-- Truncate the "products" table (remove all data)
TRUNCATE TABLE products;

-- Insert new products
INSERT INTO products (name, price, category_id, description) VALUES
    ('Smartphone', 699.99, 1, 'The latest smartphone model'),
    ('Jeans', 49.99, 2, 'Stylish and comfortable jeans'),
    ('Cookbook', 19.99, 3, 'Recipes for delicious meals');

-- Delete a category and its associated products
DELETE FROM products WHERE category_id = (
    SELECT id FROM categories WHERE name = 'Books'
);
DELETE FROM categories WHERE name = 'Books';