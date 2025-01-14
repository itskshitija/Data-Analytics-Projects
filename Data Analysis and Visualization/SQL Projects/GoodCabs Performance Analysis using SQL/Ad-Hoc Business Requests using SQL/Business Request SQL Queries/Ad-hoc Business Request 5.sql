-- Business Request-5: Identify Month with Highest Revenue for each city
-- Generate a report that identifies the month with the highest revenue for each city. For each city, display the month_name, the revenue amount for that month, and the percentage contribution of that month's revenue to the city's total revenue.

WITH RevenuePerCityMonth AS (
    -- Calculate total revenue for each city and month
    SELECT 
        dc.city_name,
        dd.month_name,
        SUM(ft.fare_amount) AS total_revenue
    FROM 
        goodcabs.fact_trips ft
    JOIN 
        goodcabs.dim_city dc 
    ON 
        ft.city_id = dc.city_id
    JOIN 
        goodcabs.dim_date dd 
    ON 
        ft.date = dd.start_of_month
    GROUP BY 
        dc.city_name, dd.month_name
),
CityTotalRevenue AS (
    -- Calculate total revenue for each city
    SELECT 
        dc.city_name,
        SUM(ft.fare_amount) AS total_revenue
    FROM 
        goodcabs.fact_trips ft
    JOIN 
        goodcabs.dim_city dc 
    ON 
        ft.city_id = dc.city_id
    GROUP BY 
        dc.city_name
)
SELECT 
    r.city_name,
    r.month_name AS highest_revenue_month,
    r.total_revenue AS revenue,
    CONCAT(ROUND((r.total_revenue / tr.total_revenue) * 100, 2), '%') AS percentage_contribution
FROM 
    RevenuePerCityMonth r
JOIN 
    CityTotalRevenue tr
ON 
    r.city_name = tr.city_name
WHERE 
    r.total_revenue = (
        SELECT MAX(total_revenue)
        FROM RevenuePerCityMonth
        WHERE city_name = r.city_name
    )
ORDER BY 
    r.city_name;
