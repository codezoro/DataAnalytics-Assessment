Question 1 - High-Value Customers with Multiple Products
Approach: The business wants to identify customers who have both savings and an investment plan.

Three tables are needed to achieve this (users_customuser,savings_savingsaccount,plans_plan)

I decided to use a JOin to link all three tables.

Used SELECT to return all expected columns, i used a count of all transactions in both the savings table & plans table to represent savings_count & investment_count respectively assuming every row is a transaction.

Used concat to combine first_name & last_name to fill in the name column

Used to two conditions as filters:
- Only include investment plans where this column "is_a_fund" is = 1
- Only include savings accounts where this column "maturity_start_date" is not null

Finally i grouped by users_customuser id, this is to group/aggregate on the user level since thats the reference.

Challenges: There was no "is_regular_savings" column in the savings table, the second filter should've been is_regular_savings = 1 but that column was missing, so I used "maturity_start_date is not null" assuming every active regular savings plan would have a maturity start date.


Question 2 -Transaction Frequency Analysis
Approach: I used Common Table Expressions to breakdown the problem into 3 steps:
- transaction_counts 
- avg_transactions_per_month
- categorized users

Used count to count the number of transactions assuming each row is a transaction and got active months by using a timestampdiff to see the number of months between the timestamp of first transaction and the most recent transaction (MIN & MAX)

I calculated the average by dividing total customer count by number of active months.

Next I used CASE to categorized the users based on the average number of transactions
I used COLLASCE so the query would return only non-null values.

Challenges: No challenges to mention.

Question 3 - Account Inactivity Alert
Approach: Did two queries for savings & investment and used a UNION to join the two.
For the savings part, used DATEDIFF to get difference between current date and last transaction date(column: transaction_date) to get inactivity_days.
Labelled the transaction type as "savings"

Used a condition (WHERE ... <= CURDATE() - INTERVAL 365 DAY) to filter for accounts with no transactions in the past 365 days.

Used similar approach for Investments but used "created_on" column in plans_plan table

Challenges: The plans_plan table didn't have a transactions_date column so I used opted to use "created_on" assuming that the day a particular plan is created is similar to date of a transaction.

Question 4 - Customer Lifetime Value (CLV) Estimation
Approach: Used concat to combine first_name & last_name to fill in the name column
CLV is calculated using total number of transactions, tenure, average transaction value

Used a COUNT to count all ids to get number of trnsactions assuming each row is transaction.
Used TIMESTAMPDIFF to get difference between date joined & current date, thats tenure_months
Average transaction value is the average of "confirmed_amount" column.

had to use a left join to connect the users table and savings table so we could have access to the confirmed_amount column

ordered by the estimated CLV to sort it from highest to lowest.

Challenges: No challenges to mention.















