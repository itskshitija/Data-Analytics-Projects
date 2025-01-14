-- Que18. Retrieve all products and their total sales (quantity × price per unit).

SELECT ProductName, sum(Quantity*PricePerUnit) AS TotalSales
FROM OrderDetails
group by ProductName;