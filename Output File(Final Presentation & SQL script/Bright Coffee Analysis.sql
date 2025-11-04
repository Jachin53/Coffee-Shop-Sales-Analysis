-- Shows all the columns
SELECT *
FROM case_study.bright_learn.coffee_shop;

-- Revenue per transaction 
SELECT transaction_id,
       transaction_qty*unit_price AS revenue
FROM case_study.bright_learn.coffee_shop;

 
-- This is the total number of sales|transactions made.
SELECT COUNT(transaction_id) AS number_of_transactions
FROM case_study.bright_learn.coffee_shope;

--COUNT's the number of different shops we have within this data 
SELECT COUNT(DISTINCT store_id) AS number_of_shops
FROM case_study.bright_learn.coffee_shope;

-- Show's us the name of different store location's, which are mainly 3.
SELECT DISTINCT store_location, store_id
FROM case_study.bright_learn.coffee_shop;

--Revenue by store location 
SELECT store_location,
       SUM(transaction_qty*unit_price) AS Revenue
FROM case_study.bright_learn.coffee_shop
GROUP BY store_location;

-- What time does the shop open
SELECT MIN(transaction_time) opening_time
FROM case_study.bright_learn.coffee_shope;

-- Time when the shop closes
SELECT MAX(transaction_time) closing_time
FROM case_study.bright_learn.coffee_shop;

-- The first day of operation
SELECT MAX(transaction_date) AS first_day_of_operation
FROM CASE_STUDY.BRIGHT_LEARN.COFFEE_SHOP;

-- Main line of code.

SELECT  product_category,
       product_type,
       product_detail,
       SUM(transaction_qty*unit_price) AS Revenue,
       store_location,
       transaction_date,
       transaction_time,
       HOUR(transaction_time) AS hour_of_the_Day,
       DAYNAME(transaction_date)AS day_name,
        MONTHNAME(transaction_date) AS month_name,
        COUNT(DISTINCT transaction_id) AS number_of_transactions,
       CASE
            WHEN transaction_time BETWEEN '6:00:00' AND '11:00:00' THEN '6:00 AM-11:59 AM Morning'
            WHEN transaction_time BETWEEN '12:00:00' AND '15:00:00' THEN '12:00 PM-15:59 PM Aftenoon'
            WHEN transaction_time BETWEEN '16:00:00' AND '19:00:00' THEN '16:00 PM-19:59 PM Evening'
            WHEN transaction_time >='20:00:00'  THEN '20:00 PM-OO:00 PM Night'
        END AS time_bucket,
        CASE 
            WHEN DAYNAME(transaction_date) IN ('Sat', 'Sun') THEN 'Weekend'
            ELSE 'Weekday'
            END AS day_classification,
FROM case_study.bright_learn.coffee_shop
WHERE transaction_date>'2023-01-01'
GROUP BY  product_category,
         product_type,
         product_detail,
         store_location,
         transaction_date,
         time_bucket,
         transaction_time
ORDER BY revenue DESC;
