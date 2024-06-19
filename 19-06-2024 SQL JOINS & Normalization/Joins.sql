-- 1.INNER JOIN:


SELECT Customers.CustomerName, Orders.OrderDate, Orders.OrderAmount
FROM Customers
INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;


-- 2.LEFT JOIN:


SELECT Customers.CustomerName, Orders.OrderDate, Orders.OrderAmount
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;


-- 3.RIGHT JOIN:

SELECT Customers.CustomerName, Orders.OrderDate, Orders.OrderAmount
FROM Customers
RIGHT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;


-- 4.FULL OUTER JOIN:

SELECT Customers.CustomerName, Orders.OrderDate, Orders.OrderAmount
FROM Customers
FULL OUTER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;


-- 5.CROSS JOIN:

SELECT Customers.CustomerName, Orders.OrderDate, Orders.OrderAmount
FROM Customers
CROSS JOIN Orders;

-- 6.SELF JOIN:

SELECT e.EmployeeName as Employee, m.EmployeeName as Manager
FROM Employees e
INNER JOIN Employees m
ON e.ManagerId = m.EmployeeId;

