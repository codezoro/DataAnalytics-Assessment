use adashi_staging;

SELECT uc.id,concat(uc.first_name, " ", uc.last_name) name, count(sa.owner_id) savings_count, count(p.owner_id) investment_count,SUM(sa.confirmed_amount) total_deposits
FROM users_customuser uc
JOIN plans_plan p on uc.id = p.owner_id
JOIN savings_savingsaccount sa on uc.id = sa.owner_id
WHERE p.is_a_fund = 1 AND sa.maturity_start_date is not null
group by uc.id;




