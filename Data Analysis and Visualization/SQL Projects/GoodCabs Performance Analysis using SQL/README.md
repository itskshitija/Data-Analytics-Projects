# 🚒Insights into Transportation operations : GoodCabs Performance Analysis
### Domain:  Transportation & Mobility          
### Function: Operations 

## 📜Table of Contents
- [Overview](#overview)
- [Data Summary and Understanding](#data-summary-and-understanding)
- [Exploratory Data Analysis](#exploratory-data-analysis)
  
## 🔍Overview
Goodcabs, a cab service company established two years ago, has emerged as a prominent player in India’s transportation sector by focusing on tier-2 cities. Unlike traditional cab service providers, Goodcabs prioritizes empowering local drivers, enabling them to earn a sustainable livelihood while delivering exceptional service to passengers. Currently operating in ten tier-2 cities across India, the company has set ambitious goals for 2024 to enhance growth and elevate passenger satisfaction.

To achieve these objectives, Goodcabs’ management is undertaking a comprehensive performance analysis. This project focuses on evaluating key metrics such as trip volume, passenger satisfaction, repeat passenger rate, trip distribution, and the balance between new and repeat passengers. The insights derived will guide strategic decision-making and help shape Goodcabs' future growth trajectory.

## 🔨Data Summary and Understanding
[Find Attached File Here](https://github.com/itskshitija/Insights-into-Transportation-operations/blob/main/meta_data.txt)

## 📊Exploratory Data Analysis
```
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



-- Query2. Bottom 3 Performing Cities by Total Trips
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
    total_trips ASC
LIMIT 3;




-- Query3. Average Fare per Trip by City
SELECT 
    dim_city.city_name,
    AVG(fact_trips.fare_amount) AS average_fare,
    AVG(fact_trips.distance_travelled_km) AS average_trip_distance
FROM 
    fact_trips
JOIN 
    dim_city ON fact_trips.city_id = dim_city.city_id
GROUP BY 
    dim_city.city_name;
    


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
    
 
 
    
-- Query5. Peak Demand Month by City
SELECT 
    dim_city.city_name,
    DATE_FORMAT(fact_passenger_summary.month, '%Y-%m') AS month,
    SUM(fact_passenger_summary.total_passengers) AS total_trips
FROM 
    fact_passenger_summary
JOIN 
    dim_city ON fact_passenger_summary.city_id = dim_city.city_id
GROUP BY 
    dim_city.city_name, month
ORDER BY 
    total_trips DESC
LIMIT 1;


-- Query6. Low Demand Month by City
SELECT 
    dim_city.city_name,
    DATE_FORMAT(fact_passenger_summary.month, '%Y-%m') AS month,
    SUM(fact_passenger_summary.total_passengers) AS total_trips
FROM 
    fact_passenger_summary
JOIN 
    dim_city ON fact_passenger_summary.city_id = dim_city.city_id
GROUP BY 
    dim_city.city_name, month
ORDER BY 
    total_trips ASC
LIMIT 1;



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
```
