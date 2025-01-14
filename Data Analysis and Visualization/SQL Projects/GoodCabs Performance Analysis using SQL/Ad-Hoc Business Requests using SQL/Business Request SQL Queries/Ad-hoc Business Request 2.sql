-- Business Request-2: Monthly City-Level Trips Target Performance Report

-- Generate report that evaluates the target performance for trips at the monthly and city level. For each city and month, compare the actual total trips with the target trips and categorize the performance as follows -
-- 1. If actual trips are greater than target trips, mark it as "Above Target".
-- 2. If actual trips are less than target trips, mark it as "Below Target". 
-- Calculate the % difference between actual and target trips to quantify the performance gap.

WITH monthly_performance AS (
    SELECT
        ft.city_id,
        dc.city_name,
        MONTHNAME(dd.date) AS month_name,  -- Convert date to month name
        COUNT(DISTINCT ft.trip_id) AS actual_trips
    FROM fact_trips ft
    JOIN dim_city dc ON ft.city_id = dc.city_id
    JOIN dim_date dd ON ft.date = dd.date
    GROUP BY ft.city_id, dc.city_name, MONTHNAME(dd.date)
)
SELECT
    mp.city_name,
    mp.month_name,
    mp.actual_trips,
    tmt.total_target_trips,
    CASE
        WHEN mp.actual_trips > tmt.total_target_trips THEN 'Above Target'
        ELSE 'Below Target'
    END AS performance_status,
    CONCAT(
        ROUND(((mp.actual_trips - tmt.total_target_trips) * 100.0 / tmt.total_target_trips), 2),
        '%'
    ) AS diff_pct
FROM monthly_performance mp
JOIN goodcabs.monthly_target_trips tmt
    ON mp.city_id = tmt.city_id
    AND mp.month_name = MONTHNAME(tmt.month)  -- Match the extracted month name
ORDER BY
    mp.city_name,
    FIELD(mp.month_name, 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December')
LIMIT 0, 1000;