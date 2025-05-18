use adashi_staging;

SELECT 
    uc.id AS customer_id,concat(uc.first_name, " ", uc.last_name) name,
    TIMESTAMPDIFF(MONTH, uc.date_joined, CURDATE()) AS tenure_months,
    COUNT(sa.id) AS total_transactions,
    ROUND(
        (COUNT(sa.id) / NULLIF(TIMESTAMPDIFF(MONTH, uc.date_joined, CURDATE()), 0)) 
        * 12 
        * (0.001 * AVG(sa.confirmed_amount)), 
        2
    ) AS estimated_clv
FROM 
    users_customuser uc
LEFT JOIN 
    savings_savingsaccount sa ON uc.id = sa.owner_id
GROUP BY 
    uc.id, uc.date_joined
ORDER BY 
    estimated_clv DESC;

