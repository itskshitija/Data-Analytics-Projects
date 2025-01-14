-- Que.17 Identify the cities with the highest number of customers.

SELECT City, count(*) AS CustomerCount
FROM Customers
group by City 
order by CustomerCount DESC;