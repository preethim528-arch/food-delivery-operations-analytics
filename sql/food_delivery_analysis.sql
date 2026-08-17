-- KPI MEASURES
-- Food Delivery Operations & Customer Analytics

-- 1. Find Top 5 Revenue Restaurants
SELECT
    r.restaurant_name,
    SUM(o.order_amount) AS Total_Revenue
FROM restaurants r
JOIN Orders o
    ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_name
ORDER BY Total_Revenue DESC
LIMIT 5;

-- 2. Total Revenue
SELECT
    ROUND(SUM(order_amount), 0)
FROM Orders;

-- 3. Total Orders
SELECT
    COUNT(order_id)
FROM Orders;

-- 4. Total Customers
SELECT
    COUNT(DISTINCT Customer_id)
FROM Customers;

-- 5. On-Time Delivery %
SELECT
    COUNT(*) FILTER (WHERE deliverystatus = 'On Time') * 100.0
    / COUNT(*) AS On_time_delivery_pct
FROM Orders;

-- 6. Repeat Customer %
SELECT
    COUNT(DISTINCT Customer_id) FILTER (WHERE Order_Count > 1) * 100.0
    / COUNT(DISTINCT Customer_id) AS Repeat_pct
FROM (
    SELECT
        Customer_id,
        COUNT(Order_id) AS Order_Count
    FROM Orders
    GROUP BY Customer_id
) AS CustomerOrders;
