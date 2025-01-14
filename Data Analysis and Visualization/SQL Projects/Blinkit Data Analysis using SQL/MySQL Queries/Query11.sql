-- Que11. List all orders with a total amount exceeding Rs.500.

SELECT OrderID, CustomerID, OrderDateTime, TotalAmount
FROM Orders
WHERE TotalAmount > 500;