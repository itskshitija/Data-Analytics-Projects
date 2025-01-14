-- Que16. Fetch the OrderID and ProductName for orders where more than 3 units of a product were purchased.

SELECT OrderId, ProductName
FROM OrderDetails
WHERE Quantity > 3;