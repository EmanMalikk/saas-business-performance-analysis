-- =============================================
-- COHORT ANALYSIS
-- SaaS Business Performance Analysis
-- =============================================

USE saas_analysis;

-- 1. Customer Cohorts by Signup Month
SELECT
    DATE_FORMAT(signup_date, '%Y-%m') AS cohort_month,
    initial_plan,
    COUNT(customer_id) AS cohort_size
FROM customers
GROUP BY DATE_FORMAT(signup_date, '%Y-%m'), initial_plan
ORDER BY cohort_month, initial_plan;

-- 2. Revenue by Cohort Month
SELECT
    DATE_FORMAT(c.signup_date, '%Y-%m') AS cohort_month,
    COUNT(DISTINCT c.customer_id) AS cohort_size,
    SUM(t.amount) AS total_revenue,
    ROUND(SUM(t.amount) / COUNT(DISTINCT c.customer_id), 2) AS revenue_per_customer
FROM customers c
JOIN transactions t ON c.customer_id = t.customer_id
WHERE t.payment_status = 'Paid'
GROUP BY DATE_FORMAT(c.signup_date, '%Y-%m')
ORDER BY cohort_month;

-- 3. Cohort Churn Rate
SELECT
    DATE_FORMAT(c.signup_date, '%Y-%m') AS cohort_month,
    COUNT(DISTINCT c.customer_id) AS cohort_size,
    COUNT(DISTINCT e.customer_id) AS churned,
    ROUND(COUNT(DISTINCT e.customer_id) * 100.0 / 
    COUNT(DISTINCT c.customer_id), 2) AS churn_pct
FROM customers c
LEFT JOIN events e ON c.customer_id = e.customer_id
    AND e.event_type = 'Churn'
GROUP BY DATE_FORMAT(c.signup_date, '%Y-%m')
ORDER BY cohort_month;

-- 4. Upgrade Rate by Cohort
SELECT
    DATE_FORMAT(c.signup_date, '%Y-%m') AS cohort_month,
    COUNT(DISTINCT c.customer_id) AS cohort_size,
    COUNT(DISTINCT e.customer_id) AS upgraded,
    ROUND(COUNT(DISTINCT e.customer_id) * 100.0 / 
    COUNT(DISTINCT c.customer_id), 2) AS upgrade_pct
FROM customers c
LEFT JOIN events e ON c.customer_id = e.customer_id
    AND e.event_type = 'Upgrade'
GROUP BY DATE_FORMAT(c.signup_date, '%Y-%m')
ORDER BY cohort_month;