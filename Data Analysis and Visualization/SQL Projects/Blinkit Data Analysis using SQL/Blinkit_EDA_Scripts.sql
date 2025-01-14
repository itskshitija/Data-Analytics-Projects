-- Exploratory Data Analysis 

-- Que1. How many unique customers are their in the database?
SELECT COUNT(DISTINCT CustomerID) AS TotalCustomers
FROM customers;

-- Que2. Retrieve all the customer names from the Customers table.
SELECT Name FROM customers;

-- Que3. List all distinct cities where customers are located.
SELECT DISTINCT City FROM customers;

-- Que4. Find the total number of orders placed.
SELECT COUNT(DISTINCT OrderID) AS TotalOrders 
FROM OrderDetails;


-- Que5. Get the details of orders that are “Delivered.”
SELECT * FROM orders
WHERE DeliveryStatus = 'Delivered';

-- Que6.Display the total amount for each order along with the OrderID.
SELECT OrderID, TotalAmount from Orders;

-- Que7. Count how many products are in the OrderDetails table.
SELECT count(DISTINCT ProductName) FROM OrderDetails;

-- Que8. Retrieve customers’ names and phone numbers from Customers whose city is “Jaipur.”
SELECT Name, Phone FROM customers
WHERE City = "Jaipur";

-- Que9. Fetch all orders placed after 2024–11–01.
SELECT * FROM Orders
WHERE OrderDateTime > '2024-11-01';

-- Que10.Find the products that cost more than Rs.100 per unit.
SELECT ProductName, PricePerUnit FROM Orderdetails
WHERE PricePerUnit > 100;

-- Que11. List all orders with a total amount exceeding Rs.500.
SELECT OrderID, CustomerID, OrderDateTime, TotalAmount
FROM Orders
WHERE TotalAmount > 500;


-- Que12. Find the total revenue (sum of TotalAmount) generated from all orders.
SELECT SUM(TotalAmount) AS TotalRevenue
FROM Orders;


-- Que13. List the top 5 most frequently ordered products.
SELECT ProductName, COUNT(*) AS OrderCount
FROM OrderDetails
GROUP BY ProductName
ORDER BY OrderCount DESC
LIMIT 5;

-- Que14. Calculate the total quantity sold for each product.
SELECT ProductName, SUM(Quantity) AS TotalQuantitySold
FROM OrderDetails
GROUP BY ProductName;


-- Que15. Identify the customer who placed the maximum number of orders.
SELECT C.Name, COUNT(O.OrderID) AS MaxOrders
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.Name
ORDER BY MaxOrders DESC
LIMIT 1;


-- Que16. Fetch the OrderID and ProductName for orders where more than 3 units of a product were purchased.
SELECT OrderId, ProductName
FROM OrderDetails
WHERE Quantity > 3;

-- Que.17 Identify the cities with the highest number of customers.
SELECT City, count(*) AS CustomerCount
FROM Customers
group by City 
order by CustomerCount DESC;


-- Que18. Retrieve all products and their total sales (quantity × price per unit).
SELECT ProductName, sum(Quantity*PricePerUnit) AS TotalSales
FROM OrderDetails
group by ProductName;


-- Que19. Find the most expensive single order based on the TotalAmount.
SELECT OrderID, CustomerID, TotalAmount
FROM Orders
ORDER BY TotalAmount DESC
LIMIT 1;

-- Que20. Retrieve the top 3 customers who spent the most.
SELECT C.CustomerID, C.Name, SUM(O.TotalAmount) AS TotalSpent
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.Name
ORDER BY TotalSpent DESC
LIMIT 3;

-- Que21. Calculate the contribution percentage of each city to the total revenue.
SELECT C.City, SUM(O.TotalAmount) AS CityRevenue, (SUM(O.TotalAmount) / (SELECT SUM(TotalAmount) FROM Orders) * 100) AS ContributionPercentage
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.City
ORDER BY ContributionPercentage DESC;

