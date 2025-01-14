-- Que10.Find the products that cost more than Rs.100 per unit.

SELECT ProductName, PricePerUnit FROM Orderdetails
WHERE PricePerUnit > 100;