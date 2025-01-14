-- Que4. Find the total number of orders placed.

SELECT COUNT(DISTINCT OrderID) AS TotalOrders 
FROM OrderDetails;