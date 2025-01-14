
-- Query7. Repeat Passenger Frequency and City Contribution Analysis
SELECT 
    dim_city.city_name,
    dim_repeat_trip_distribution.trip_count,
    SUM(dim_repeat_trip_distribution.repeat_passenger_count) AS repeat_passenger_count
FROM 
    dim_repeat_trip_distribution
JOIN 
    dim_city ON dim_repeat_trip_distribution.city_id = dim_city.city_id
GROUP BY 
    dim_city.city_name, dim_repeat_trip_distribution.trip_count
ORDER BY 
    SUM(dim_repeat_trip_distribution.repeat_passenger_count) DESC;
    

-- Query8. Monthly Target Achievement Analysis for Key Metrics
SELECT 
    d.month_name AS Month_Name,  
    gbs.target_new_passengers AS Target_New_Passengers,  -- Target number of new passengers
    COUNT(CASE WHEN f.passenger_type = 'new' THEN 1 END) AS Actual_New_Passengers,  -- Count actual new passengers
    (COUNT(CASE WHEN f.passenger_type = 'new' THEN 1 END) / tgt.target_new_passengers) * 100 AS Achievement_Rate_New_Passengers,  -- Achievement rate for new passengers
    CASE 
        WHEN (COUNT(CASE WHEN f.passenger_type = 'new' THEN 1 END) / gbs.target_new_passengers) * 100 > 100 THEN 'Exceeded'  -- If achievement > 100%, mark as Exceeded
        ELSE 'Missed'  -- If achievement < 100%, mark as Missed
    END AS Status
FROM 
    goodcabs.monthly_target_new_passengers gbs
JOIN 
    goodcabs.fact_trips f ON gbs.city_id = f.city_id
JOIN 
    goodcabs.dim_date d ON f.date = d.date
WHERE 
    d.date BETWEEN '2024-01-01' AND '2024-03-31'  -- Filtering for just Q1 2024 (reduce the date range temporarily)
GROUP BY 
    d.month_name, gbs.target_new_passengers
ORDER BY 
    FIELD(d.month_name, 'January', 'February', 'March')  -- Ordering by months for just Q1
LIMIT 100;  -- Limit to 100 results for testing

SELECT 
    c.city_name AS City,  -- Shortened city name column
    gbs.target_avg_passenger_rating AS Target_Rating,  -- Shortened target average passenger rating column
    AVG(f.passenger_rating) AS Actual_Rating,  -- Shortened actual average passenger rating column
    (AVG(f.passenger_rating) / gbs.target_avg_passenger_rating) * 100 AS Achievement_Rate,  -- Shortened achievement rate column
    CASE 
        WHEN (AVG(f.passenger_rating) / gbs.target_avg_passenger_rating) * 100 >= 100 THEN 'Exceeded'  -- If achievement rate is >= 100%, it's exceeded
        WHEN (AVG(f.passenger_rating) / gbs.target_avg_passenger_rating) * 100 = 100 THEN 'Achieved'   -- If achievement rate is exactly 100%, it's achieved
        ELSE 'Missed'  -- If achievement rate is < 100%, it's missed
    END AS Status  -- Shortened achievement status column
FROM 
    goodcabs.city_target_passenger_rating gbs
JOIN 
    goodcabs.fact_trips f ON gbs.city_id = f.city_id
JOIN 
    goodcabs.dim_city c ON f.city_id = c.city_id  -- Joining with dim_city to get city names
WHERE 
    f.date BETWEEN '2024-01-01' AND '2024-06-30'  -- Filtering by the first half of 2024
GROUP BY 
    c.city_name, gbs.target_avg_passenger_rating
ORDER BY 
    Achievement_Rate DESC;  -- Ordering by Achievement Rate in descending order