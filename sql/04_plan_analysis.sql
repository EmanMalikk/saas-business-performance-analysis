-- =============================================
-- PLAN ANALYSIS
-- SaaS Business Performance Analysis
-- =============================================

USE saas_analysis;

-- 1. Customer Distribution by Plan
SELECT
    initial_plan AS plan,
    COUNT(customer_id) AS total_customers,
    ROUND(COUNT(customer_id) * 100.0 / (SELECT COUNT(*) FROM customers), 2) AS pct
FROM customers
GROUP BY initial_plan
ORDER BY total_customers DESC;

-- 2. Revenue Contribution by Plan
SELECT
    plan,
    SUM(amount) AS total_revenue,
    ROUND(SUM(amount) * 100.0 / (SELECT SUM(amount) FROM transactions WHERE payment_status = 'Paid'), 2) AS revenue_pct,
    COUNT(DISTINCT customer_id) AS customers,
    ROUND(SUM(amount) / COUNT(DISTINCT customer_id), 2) AS revenue_per_customer
FROM transactions
WHERE payment_status = 'Paid'
GROUP BY plan
ORDER BY total_revenue DESC;

-- 3. Plan Upgrade Flow
SELECT
    from_plan,
    to_plan,
    COUNT(*) AS total_upgrades,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM events WHERE event_type = 'Upgrade'), 2) AS pct
FROM events
WHERE event_type = 'Upgrade'
GROUP BY from_plan, to_plan
ORDER BY total_upgrades DESC;

-- 4. Plan Downgrade Flow
SELECT
    from_plan,
    to_plan,
    COUNT(*) AS total_downgrades,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM events WHERE event_type = 'Downgrade'), 2) AS pct
FROM events
WHERE event_type = 'Downgrade'
GROUP BY from_plan, to_plan
ORDER BY total_downgrades DESC;

-- 5. Plan Performance Summary
SELECT
    plan,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(amount) AS total_revenue,
    ROUND(SUM(amount) * 100.0 / (SELECT SUM(amount) FROM transactions WHERE payment_status = 'Paid'), 2) AS revenue_pct,
    ROUND(AVG(amount), 2) AS avg_monthly_payment
FROM transactions
WHERE payment_status = 'Paid'
GROUP BY plan
ORDER BY total_revenue DESC;