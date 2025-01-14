-- Que20. Retrieve the top 3 customers who spent the most.

SELECT C.CustomerID, C.Name, SUM(O.TotalAmount) AS TotalSpent
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.Name
ORDER BY TotalSpent DESC
LIMIT 3;