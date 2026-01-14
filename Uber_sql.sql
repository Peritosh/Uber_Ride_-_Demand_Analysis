-- =====================================
-- Uber Dataset - SQL Queries
-- =====================================

-- Selecting the database where the uber dataset is stored
USE uber_db;


-- 1. Total Ride Requests
SELECT COUNT(*) AS total_ride_requests
FROM uber_data;


-- 2. Ride Status Distribution
SELECT status, COUNT(*) AS total_rides
FROM uber_data
GROUP BY status;


-- 3. Ride Completion Rate (%)
SELECT 
    ROUND(
        SUM(CASE WHEN status = 'Trip Completed' THEN 1 ELSE 0 END)
        / COUNT(*) * 100, 2
    ) AS completion_rate_percent
FROM uber_data;


-- 4. Requests by Hour (Demand Pattern)
SELECT 
    request_hour,
    COUNT(*) AS total_requests
FROM uber_data
GROUP BY request_hour
ORDER BY request_hour;


-- 5. Failure Rate by Hour (Supply–Demand Gap)
SELECT 
    request_hour,
    ROUND(
        SUM(CASE WHEN status <> 'Trip Completed' THEN 1 ELSE 0 END)
        / COUNT(*) * 100, 2
    ) AS failure_rate_percent
FROM uber_data
GROUP BY request_hour
ORDER BY failure_rate_percent DESC;


-- 6. Requests by Pickup Point
SELECT 
    pickup_point,
    COUNT(*) AS total_requests
FROM uber_data
GROUP BY pickup_point;


-- 7. Completion Rate by Pickup Point
SELECT 
    pickup_point,
    ROUND(
        SUM(CASE WHEN status = 'Trip Completed' THEN 1 ELSE 0 END)
        / COUNT(*) * 100, 2
    ) AS completion_rate_percent
FROM uber_data
GROUP BY pickup_point;


-- 8. Requests with No Driver Assigned
SELECT COUNT(*) AS no_driver_requests
FROM uber_data
WHERE driver_id IS NULL;


-- 9. Average Ride Duration (Completed Trips)
SELECT 
    ROUND(AVG(ride_duration_min), 2) AS avg_ride_duration_min
FROM uber_data
WHERE status = 'Trip Completed';


-- 10. Peak Demand Hours
SELECT 
    request_hour,
    COUNT(*) AS total_requests
FROM uber_data
GROUP BY request_hour
ORDER BY total_requests DESC
LIMIT 5;
