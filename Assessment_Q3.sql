USE adashi_staging;



SELECT 
    sa.id AS plan_id,                      -- Savings Part
    sa.owner_id,
    'Savings' AS type,
    sa.transaction_date AS last_transaction_date,
    DATEDIFF(CURDATE(), sa.transaction_date) AS inactivity_days
FROM 
    savings_savingsaccount sa
WHERE 
    sa.transaction_date <= CURDATE() - INTERVAL 365 DAY

UNION

SELECT 
    p.id AS plan_id,					-- Investment Part
    p.owner_id,
    'Investment' AS type,
    p.created_on AS last_transaction_date,
    DATEDIFF(CURDATE(), p.created_on) AS inactivity_days
FROM 
    plans_plan p
WHERE 
    p.status_id = 1
    AND p.created_on <= CURDATE() - INTERVAL 365 DAY;

