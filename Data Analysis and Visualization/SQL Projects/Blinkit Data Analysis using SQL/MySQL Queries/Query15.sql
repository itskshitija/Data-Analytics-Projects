-- Que15. Identify the customer who placed the maximum number of orders.

SELECT C.Name, COUNT(O.OrderID) AS MaxOrders
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.Name
ORDER BY MaxOrders DESC
LIMIT 1;
