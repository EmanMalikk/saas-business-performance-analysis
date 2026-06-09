-- =============================================
-- CHURN ANALYSIS
-- SaaS Business Performance Analysis
-- =============================================

USE saas_analysis;

-- 1. Monthly Churn Count
SELECT
    DATE_FORMAT(event_date, '%Y-%m') AS month,
    COUNT(customer_id) AS churned_customers
FROM events
WHERE event_type = 'Churn'
GROUP BY DATE_FORMAT(event_date, '%Y-%m')
ORDER BY month;

-- 2. Churn by Plan
SELECT
    from_plan AS plan,
    COUNT(customer_id) AS total_churned,
    ROUND(COUNT(customer_id) * 100.0 / (SELECT COUNT(*) FROM events WHERE event_type = 'Churn'), 2) AS churn_pct
FROM events
WHERE event_type = 'Churn'
GROUP BY from_plan
ORDER BY total_churned DESC;

-- 3. Churn Reasons Breakdown
SELECT
    reason,
    COUNT(*) AS total,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM events WHERE event_type = 'Churn'), 2) AS pct
FROM events
WHERE event_type = 'Churn'
GROUP BY reason
ORDER BY total DESC;

-- 4. Monthly Churn by Plan
SELECT
    DATE_FORMAT(event_date, '%Y-%m') AS month,
    from_plan AS plan,
    COUNT(customer_id) AS churned
FROM events
WHERE event_type = 'Churn'
GROUP BY DATE_FORMAT(event_date, '%Y-%m'), from_plan
ORDER BY month, plan;

-- 5. Average Customer Lifetime by Plan
SELECT
    plan,
    ROUND(AVG(duration_months), 1) AS avg_lifetime_months,
    MIN(duration_months) AS min_months,
    MAX(duration_months) AS max_months
FROM subscriptions
GROUP BY plan
ORDER BY avg_lifetime_months DESC;