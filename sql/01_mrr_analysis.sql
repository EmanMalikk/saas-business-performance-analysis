-- =============================================
-- MRR ANALYSIS
-- SaaS Business Performance Analysis
-- =============================================

USE saas_analysis;

-- 1. Total MRR by Month
SELECT 
    DATE_FORMAT(transaction_date, '%Y-%m') AS month,
    SUM(amount) AS total_mrr,
    COUNT(DISTINCT customer_id) AS paying_customers,
    ROUND(SUM(amount) / COUNT(DISTINCT customer_id), 2) AS avg_revenue_per_customer
FROM transactions
WHERE payment_status = 'Paid'
GROUP BY DATE_FORMAT(transaction_date, '%Y-%m')
ORDER BY month;

-- 2. MRR Breakdown -- New vs Expansion vs Churned
SELECT
    DATE_FORMAT(t.transaction_date, '%Y-%m') AS month,
    SUM(CASE WHEN s.status = 'Active' THEN t.amount ELSE 0 END) AS active_mrr,
    SUM(CASE WHEN e.event_type = 'Upgrade' THEN e.mrr_impact ELSE 0 END) AS expansion_mrr,
    SUM(CASE WHEN e.event_type = 'Churn' THEN e.mrr_impact ELSE 0 END) AS churned_mrr
FROM transactions t
LEFT JOIN subscriptions s ON t.subscription_id = s.subscription_id
LEFT JOIN events e ON t.customer_id = e.customer_id 
    AND DATE_FORMAT(t.transaction_date, '%Y-%m') = DATE_FORMAT(e.event_date, '%Y-%m')
WHERE t.payment_status = 'Paid'
GROUP BY DATE_FORMAT(t.transaction_date, '%Y-%m')
ORDER BY month;

-- 3. Revenue by Plan per Month
SELECT 
    DATE_FORMAT(transaction_date, '%Y-%m') AS month,
    plan,
    SUM(amount) AS plan_mrr,
    COUNT(DISTINCT customer_id) AS customers
FROM transactions
WHERE payment_status = 'Paid'
GROUP BY DATE_FORMAT(transaction_date, '%Y-%m'), plan
ORDER BY month, plan;

-- 4. Net Revenue Retention (NRR) by Month
SELECT
    DATE_FORMAT(transaction_date, '%Y-%m') AS month,
    SUM(amount) AS current_mrr,
    LAG(SUM(amount)) OVER (ORDER BY DATE_FORMAT(transaction_date, '%Y-%m')) AS prev_mrr,
    ROUND(
        (SUM(amount) - LAG(SUM(amount)) OVER (ORDER BY DATE_FORMAT(transaction_date, '%Y-%m'))) 
        / LAG(SUM(amount)) OVER (ORDER BY DATE_FORMAT(transaction_date, '%Y-%m')) * 100, 2
    ) AS mrr_growth_rate
FROM transactions
WHERE payment_status = 'Paid'
GROUP BY DATE_FORMAT(transaction_date, '%Y-%m')
ORDER BY month;

SELECT
    DATE_FORMAT(transaction_date, '%Y-%m') AS month,
    SUM(amount) AS current_mrr,
    LAG(SUM(amount)) OVER (ORDER BY DATE_FORMAT(transaction_date, '%Y-%m')) AS prev_mrr,
    ROUND(
        (SUM(amount) - LAG(SUM(amount)) OVER (ORDER BY DATE_FORMAT(transaction_date, '%Y-%m'))) 
        / LAG(SUM(amount)) OVER (ORDER BY DATE_FORMAT(transaction_date, '%Y-%m')) * 100, 2
    ) AS mrr_growth_rate
FROM transactions
WHERE payment_status = 'Paid'
GROUP BY DATE_FORMAT(transaction_date, '%Y-%m')
ORDER BY month DESC
LIMIT 6;