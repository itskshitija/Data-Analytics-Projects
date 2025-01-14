-- Que19. Find the most expensive single order based on the TotalAmount.

SELECT OrderID, CustomerID, TotalAmount
FROM Orders
ORDER BY TotalAmount DESC
LIMIT 1;