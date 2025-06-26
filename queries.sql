--questions to use/model sql queries around
------------------------------------------------------
------------------------------------------------------
--1) Various rows of data in the csv contain 'Unknown'. How many transactions have an Unknown (NULL)? What is the NULL count of each column in Transactions? 
--answer) Transactions where any field is NULL: 6766
        --item_id NULL Count: 1448, payment_id NULL COUNT: 3178, location_id NULL COUNT: 3961, transaction_date NULL COUNT: 460, total_spent NULL COUNT: 40, quantity NULL COUNT: 479

    --Transactions that have Unknown (NULL)
    SELECT COUNT(*) AS "Transactions With Null"
    FROM Transactions
    WHERE item_id IS NULL 
        OR payment_id IS NULL 
        OR location_id IS NULL
        OR transaction_date IS NULL
        OR total_spent IS NULL
        OR quantity IS NULL;

    --NULL Count of each column in Transactions
    WITH unknowns AS (
        SELECT 'transaction_id' AS "Column Name", COUNT(*) AS "Null Count"
        FROM Transactions WHERE transaction_id IS NULL
            UNION ALL
        SELECT 'item_id', COUNT(*)
        FROM Transactions WHERE item_id IS NULL 
            UNION ALL
        SELECT 'payment_id', COUNT(*)
        FROM Transactions WHERE payment_id IS NULL 
            UNION ALL
        SELECT 'location_id', COUNT(*)
        FROM Transactions WHERE location_id IS NULL 
            UNION ALL
        SELECT 'transaction_date', COUNT(*)
        FROM Transactions WHERE transaction_date IS NULL 
            UNION ALL
        SELECT 'total_spent', COUNT(*)
        FROM Transactions WHERE total_spent IS NULL 
            UNION ALL
        SELECT 'quantity', COUNT(*)
        FROM Transactions WHERE quantity IS NULL 
    )
    SELECT * FROM unknowns
    ORDER BY "Null Count" DESC;
    

----------------------------------------------------------------------------
----------------------------------------------------------------------------
--2) Which month had the highest amount of sales, and what was the most popular item that month (based on quantity sold)?
--answer) June 2023 has the highest amount of sales, with Juice being the most popular item with 279 sold

    WITH highest AS (
        SELECT strftime('%Y-%m', transaction_date) AS month,
            SUM(total_spent) AS sale
        FROM Transactions
        GROUP BY month
        ORDER BY sale DESC
        LIMIT 1
    )
    SELECT highest.month AS "Month with Highest Sales",
        Items.item_name AS "Most Popular Item",
        SUM(Transactions.quantity) AS "Total Quantity Sold"
    FROM Transactions
    INNER JOIN Items on Transactions.item_id = Items.item_id
    INNER JOIN highest ON strftime('%Y-%m', Transactions.transaction_date) = highest.month
    GROUP BY Items.item_name
    ORDER BY SUM(Transactions.quantity) DESC
    LIMIT 1;


----------------------------------------------------------------------------
----------------------------------------------------------------------------
--3) What is the average quantity sold of each item?
--answer) Coffee: 3.06, Smoothie: 3.05, Cake: 3.05, Tea: 3.04, Salad: 3.03, Sandwich: 3.01, Juice: 3.0, Cookie: 2.97

    SELECT Items.item_name AS "Item",
        ROUND(AVG(Transactions.quantity), 2) AS "Average Quantity Sold"
    FROM Items
    INNER JOIN Transactions ON Transactions.item_id = Items.item_id
    GROUP BY "Item"
    ORDER BY "Average Quantity Sold" DESC;


----------------------------------------------------------------------------
----------------------------------------------------------------------------
--4) What are the top three most popular items based on quantity sold?
--answer) First: Coffee with 3212 sold, Second: Juice with 3187 sold, Third: Cake with 3180 sold

    SELECT Items.item_name AS "Top 3 Items",
        SUM(Transactions.quantity) AS "Total Sold"
    FROM Transactions
    INNER JOIN Items on Transactions.item_id = Items.item_id
    GROUP BY "Top 3 Items"
    ORDER BY "Total Sold" DESC
    LIMIT 3;

----------------------------------------------------------------------------
----------------------------------------------------------------------------
--5) What is the average item spending based on payment method?
--answer) Cash is 9.06, Credit Card is 9.01, Digital Wallet is 8.93

    SELECT Payment.payment_method AS "Payment Method",
        ROUND(AVG(Transactions.total_spent), 2) AS "Average Item Spending"
    FROM Payment
    INNER JOIN Transactions ON Transactions.payment_id = Payment.payment_id
    WHERE Transactions.total_spent IS NOT NULL
    GROUP BY "Payment Method"
    ORDER BY "Average Item Spending" DESC;

----------------------------------------------------------------------------
----------------------------------------------------------------------------
--6) What are the amount of transactions at each location type?
--answer) In-store has a total of 3017 transactions, Takeaway has a total of 3022 Transactions

    SELECT Location.location_type AS "Location Type",
        COUNT(*) AS "Total Transactions"
    FROM Transactions
    INNER JOIN Location on Location.location_id = Transactions.location_id
    GROUP BY "Location Type";

----------------------------------------------------------------------------
----------------------------------------------------------------------------
--7) What is the average number of items purchased during a transaction?
--answer) 3.03 is the average number of items purchased during a transaction

    SELECT ROUND(AVG(quantity), 2) AS "Average Number of Items Per Transaction"
    FROM Transactions
    WHERE quantity IS NOT NULL;

----------------------------------------------------------------------------
----------------------------------------------------------------------------
--8) How many transactions are done each month of 2023 (chose 2023 since it is most prominent year in csv)?
--answer) January: 818, February: 727, March: 827, April: 774, May: 777, June: 818, July: 791, August: 803, September: 788, October: 838, November: 784, December: 795

    SELECT strftime('%Y-%m', transaction_date) AS "Month",
        COUNT(*) AS "Number of Transactions"
    FROM Transactions
    WHERE transaction_date BETWEEN '2023-01-01' AND '2024-01-01'
    GROUP BY "Month"
    ORDER BY "Month" ASC;

----------------------------------------------------------------------------
----------------------------------------------------------------------------
--9) Which payment method is most popular, and how many transactions and money has been spent with that method?
--answer) Digital Wallet with 2282 transactions and $20383.50 spent

    SELECT Payment.payment_method AS "Payment Method",
        COUNT(Transactions.transaction_id) AS "Number of Transactions",
        SUM(Transactions.total_spent) AS "Total Spent"
    FROM Transactions
    INNER JOIN Payment ON Transactions.payment_id = Payment.payment_id
    WHERE Transactions.total_spent IS NOT NULL
    GROUP BY "Payment Method"
    ORDER BY "Number of Transactions" DESC
    LIMIT 1;

----------------------------------------------------------------------------
----------------------------------------------------------------------------
--10) How much has the cafe made in the year 2023 (chose 2023 since it is the most prominent year in csv)?
--answer) $84,786.50

    SELECT SUM(total_spent) AS "2023 Total Sales"
    FROM Transactions
    WHERE strftime('%Y', transaction_date) = '2023';

