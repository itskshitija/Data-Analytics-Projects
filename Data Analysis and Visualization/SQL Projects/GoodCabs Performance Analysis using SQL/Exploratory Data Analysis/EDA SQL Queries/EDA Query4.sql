-- Query4. Average Ratings by City and Passenger Type
SELECT 
    dim_city.city_name,
    fact_trips.passenger_type,
    AVG(fact_trips.passenger_rating) AS avg_passenger_rating,
    AVG(fact_trips.driver_rating) AS avg_driver_rating
FROM 
    fact_trips
JOIN 
    dim_city ON fact_trips.city_id = dim_city.city_id
GROUP BY 
    dim_city.city_name, fact_trips.passenger_type;
    
 