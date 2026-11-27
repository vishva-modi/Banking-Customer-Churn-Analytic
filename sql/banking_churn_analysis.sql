-- Banking Customer Churn & Retention Analysis
-- Database: banking_churn_db
-- Table: public.customers

-- 1. Total Customers
SELECT COUNT(*) AS total_customers
FROM public.customers;

-- 2. Churned vs Retained Customers
SELECT
    exited,
    COUNT(*) AS customer_count
FROM public.customers
GROUP BY exited;

-- 3. Overall Churn Rate
SELECT
    ROUND(
        COUNT(*) FILTER (WHERE exited = 1) * 100.0 / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM public.customers;

-- 4. Geography-wise Churn
SELECT
    geography,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE exited = 1) AS churned_customers,
    ROUND(
        COUNT(*) FILTER (WHERE exited = 1) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM public.customers
GROUP BY geography
ORDER BY churn_rate DESC;

-- 5. Gender-wise Churn
SELECT
    gender,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE exited = 1) AS churned_customers
FROM public.customers
GROUP BY gender;

-- 6. Age Group-wise Churn
SELECT
    CASE
        WHEN age < 30 THEN 'Below 30'
        WHEN age BETWEEN 30 AND 40 THEN '30-40'
        WHEN age BETWEEN 41 AND 50 THEN '41-50'
        ELSE 'Above 50'
    END AS age_group,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE exited = 1) AS churned_customers
FROM public.customers
GROUP BY age_group
ORDER BY age_group;

-- 7. Active vs Inactive Members
SELECT
    is_active_member,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE exited = 1) AS churned_customers
FROM public.customers
GROUP BY is_active_member;

-- 8. Products-wise Churn
SELECT
    num_of_products,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE exited = 1) AS churned_customers
FROM public.customers
GROUP BY num_of_products
ORDER BY num_of_products;

-- 9. Credit Card-wise Churn
SELECT
    has_cr_card,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE exited = 1) AS churned_customers
FROM public.customers
GROUP BY has_cr_card;

-- 10. Tenure-wise Churn
SELECT
    tenure,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE exited = 1) AS churned_customers
FROM public.customers
GROUP BY tenure
ORDER BY tenure;

-- 11. Customer Balance Analysis
SELECT
    exited,
    ROUND(AVG(balance), 2) AS average_balance
FROM public.customers
GROUP BY exited;

-- 12. Overall Customer Summary
SELECT
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE exited = 1) AS churned_customers,
    COUNT(*) FILTER (WHERE exited = 0) AS retained_customers,
    ROUND(
        COUNT(*) FILTER (WHERE exited = 1) * 100.0 / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM public.customers;