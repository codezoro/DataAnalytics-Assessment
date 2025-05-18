USE adashi_staging;

WITH transaction_counts AS (
    SELECT
        sa.owner_id,
        COUNT(*) AS customer_count,  
        TIMESTAMPDIFF(MONTH, MIN(sa.transaction_date), MAX(sa.transaction_date)) + 1 AS active_months
    FROM savings_savingsaccount sa
    GROUP BY sa.owner_id
),
avg_transactions_per_month AS (
    SELECT
        tc.owner_id,
        tc.customer_count,              
        tc.active_months,
        ROUND(tc.customer_count / tc.active_months, 2) AS avg_transactions_per_month
    FROM transaction_counts tc
),
categorized_users AS (
    SELECT
        u.id AS user_id,
        COALESCE(a.avg_transactions_per_month, 0) AS avg_transactions_per_month,
        a.customer_count,              
        CASE
            WHEN COALESCE(a.avg_transactions_per_month, 0) >= 10 THEN 'High Frequency'
            WHEN COALESCE(a.avg_transactions_per_month, 0) BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM users_customuser u
    LEFT JOIN avg_transactions_per_month a ON u.id = a.owner_id
)

SELECT 
    frequency_category,
    customer_count,                 
    avg_transactions_per_month
FROM categorized_users;

