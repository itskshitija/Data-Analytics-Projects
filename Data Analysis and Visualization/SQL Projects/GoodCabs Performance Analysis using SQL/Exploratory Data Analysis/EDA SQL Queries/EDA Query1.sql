-- Exploratory Data Analysis

-- Query1. Top 3 Performing Cities by Total Trips
SELECT 
    dim_city.city_name,
    SUM(fact_passenger_summary.total_passengers) AS total_trips
FROM 
    fact_passenger_summary
JOIN 
    dim_city ON fact_passenger_summary.city_id = dim_city.city_id
GROUP BY 
    dim_city.city_name
ORDER BY 
    total_trips DESC
LIMIT 3;