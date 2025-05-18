Question 1 - High-Value Customers with Multiple Products
Approach: The business wants to identify customers who have both savings and an investment plan.

Three tables are needed to achieve this (users_customuser,savings_savingsaccount,plans_plan)

I decided to use a JOin to link all three tables.

Used SELECT to return all expected columns, i used a count of all transactions in both the savings table & plans table to represent savings_count & investment_count respectively assuming every row is a transaction.

Use concat to combine first_name & last_name to fill in the name column

Used to two conditions as filters:
- Only include investment plans where this column "is_a_fund" is = 1
- Only include savings accounts where this column "maturity_start_date" is not null

Finally i grouped by users_customuser id, this is to group/aggregate on the user level since thats the reference.

Challenges: There was no "is_regular_savings" column in the savings table, the second filter should've been is_regular_savings = 1 but that column was missing, so I used maturity_start_date is not null because a active regular savings plan would have a maturity start date.