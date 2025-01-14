-- Que21. Calculate the contribution percentage of each city to the total revenue.

SELECT C.City, SUM(O.TotalAmount) AS CityRevenue, (SUM(O.TotalAmount) / (SELECT SUM(TotalAmount) FROM Orders) * 100) AS ContributionPercentage
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.City
ORDER BY ContributionPercentage DESC;
