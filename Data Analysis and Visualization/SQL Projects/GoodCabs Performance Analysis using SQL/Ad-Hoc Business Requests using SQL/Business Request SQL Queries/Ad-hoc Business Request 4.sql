-- Business Request-4: Identify Cities with Highest and Lowest Total New Passengers

-- Generate the report that calculates the total new passengers for each city and ranks them based on this value. Identify the top3 cities with the highest number of new passengers as well as bottom3 cities with the lowest number of new passengers, categorizing them as "Top3" and "Bottom3" accordingly.

WITH city_ranking AS (
    SELECT 
        city_name, 
        SUM(new_passengers) AS total_new_passengers,  -- Replace 'new_passengers' with the actual column name
        DENSE_RANK() OVER (ORDER BY SUM(new_passengers) DESC) AS top_ranking,
        DENSE_RANK() OVER (ORDER BY SUM(new_passengers) ASC) AS bottom_ranking
    FROM fact_passenger_summary fps
    JOIN dim_city dc 
        ON fps.city_id = dc.city_id
    GROUP BY city_name
)

SELECT 
    city_name, 
    total_new_passengers, 
    CASE 
        WHEN top_ranking <= 3 THEN 'Top 3'
        WHEN bottom_ranking <= 3 THEN 'Bottom 3'
        ELSE NULL
    END AS city_category
FROM city_ranking
WHERE top_ranking <= 3 OR bottom_ranking <= 3
ORDER BY total_new_passengers DESC;