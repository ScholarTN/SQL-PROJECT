-- Change delimiter to allow for procedure and function creation
DELIMITER //

-- Create a sample table
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    salary DECIMAL(10, 2),
    performance_rating INT
)//

-- Insert sample data
INSERT INTO employees (id, name, salary, performance_rating)
VALUES 
    (1, 'John Doe', 50000, 4),
    (2, 'Jane Smith', 60000, 5),
    (3, 'Bob Johnson', 55000, 3),
    (4, 'Alice Brown', 52000, 4)//

-- Create a function to calculate salary raise percentage
CREATE FUNCTION calculate_raise_percentage(performance INT)
RETURNS DECIMAL(5, 2)
DETERMINISTIC
BEGIN
    DECLARE raise_percentage DECIMAL(5, 2);
    
    SET raise_percentage = 
        CASE
            WHEN performance = 5 THEN 10.00
            WHEN performance = 4 THEN 7.00
            WHEN performance = 3 THEN 5.00
            ELSE 2.00
        END;
    
    RETURN raise_percentage;
END//

-- Create a procedure to apply salary raises
CREATE PROCEDURE apply_salary_raises()
BEGIN
    DECLARE employee_id INT;
    DECLARE employee_salary DECIMAL(10, 2);
    DECLARE employee_performance INT;
    DECLARE raise_percentage DECIMAL(5, 2);
    DECLARE done INT DEFAULT FALSE;
    
    -- Declare cursor
    DECLARE employee_cursor CURSOR FOR
        SELECT id, salary, performance_rating
        FROM employees;
    
    -- Declare handler for cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    -- Open cursor
    OPEN employee_cursor;
    
    -- Start loop
    salary_raise_loop: LOOP
        -- Fetch data from cursor
        FETCH employee_cursor INTO employee_id, employee_salary, employee_performance;
        
        -- Exit loop if no more rows
        IF done THEN
            LEAVE salary_raise_loop;
        END IF;
        
        -- Calculate raise percentage using the function
        SET raise_percentage = calculate_raise_percentage(employee_performance);
        
        -- Apply raise
        UPDATE employees
        SET salary = salary * (1 + raise_percentage / 100)
        WHERE id = employee_id;
        
    END LOOP;
    
    -- Close cursor
    CLOSE employee_cursor;
    
    -- Print summary
    SELECT 'Salary raises applied successfully' AS result;
END//

-- Change delimiter back to default
DELIMITER ;

-- Execute the procedure
CALL apply_salary_raises();

-- View updated employee data
SELECT * FROM employees;