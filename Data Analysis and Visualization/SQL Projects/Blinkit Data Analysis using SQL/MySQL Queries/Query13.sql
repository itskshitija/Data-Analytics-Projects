-- Que13. List the top 5 most frequently ordered products.

SELECT ProductName, COUNT(*) AS OrderCount
FROM OrderDetails
GROUP BY ProductName
ORDER BY OrderCount DESC
LIMIT 5;