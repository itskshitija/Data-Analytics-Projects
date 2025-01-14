-- Que14. Calculate the total quantity sold for each product.

SELECT ProductName, SUM(Quantity) AS TotalQuantitySold
FROM OrderDetails
GROUP BY ProductName;