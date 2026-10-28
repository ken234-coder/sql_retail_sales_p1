-- sql_retail sales data analysis

-- create table

CREATE TABLE Retail_sales
               (

					transactions_id INT PRIMARY KEY,
					sale_date DATE,
					sale_time TIME,
					customer_id	INT,
					gender	VARCHAR(15),
					age	 INT,
					category VARCHAR(15),
					quantiy	 INT,
					price_per_unit	FLOAT,
					cogs	FLOAT,
					total_sale FLOAT

             );

		
SELECT count(*)
FROM Retail_sales;



-- Data cleaning

		
SELECT COUNT(*)
FROM Retail_sales;

		
SELECT*
FROM Retail_sales
WHERE transactions_id IS NULl
OR
sale_date IS NULL
OR
sale_time IS NULL
OR
customer_id IS NULL
OR
gender IS NULL
OR
age IS NULL
OR
category IS NULL
OR
quantiy IS NULL
OR
price_per_unit IS NULL
OR
cogs IS NULL
OR
total_sale IS NULL;



DELETE FROM Retail_sales
WHERE transactions_id IS NULl
OR
sale_date IS NULL
OR
sale_time IS NULL
OR
customer_id IS NULL
OR
gender IS NULL
OR
age IS NULL
OR
category IS NULL
OR
quantiy IS NULL
OR
price_per_unit IS NULL
OR
cogs IS NULL
OR
total_sale IS NULL;



-- Data exploration


-- How many sales we have?


SELECT COUNT(*)
total_sale
FROM Retail_sales;

-- How many customers we have?
-- How many unique customers do we have?

SELECT COUNT (DISTINCT customer_id) AS total_sale
FROM Retail_sales;

-- how many unique categories do we have


SELECT DISTINCT category
FROM Retail_sales;



-- Data analysis & Business key problem & answers

-- write sql query to retrieve all sales made on '2022-11-05'



SELECT *
FROM Retail_sales
WHERE sale_date='2022-11-05';

-- write an sql query to retrieve all transactions where the category "clothing " and the quantity sold is more than 10 in the month of NOV-2022

SELECT *
FROM retail_sales
WHERE category = 'Clothing'
	AND
	TO_CHAR(sale_date,'YYYY-MM')='2022-11'
	AND quantiy>=4;




-- write an sql query to calculate the total_sales (total_sale) for each category

SELECT
category,
sum(total_sale) as net_sale,
COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1;


--write an sql query to find the average age of customers that purchased items from the 'beauty' category


SELECT age, AVG(age)
FROM retail_sales
WHERE category= 'Beauty'
GROUP BY 1;



SELECT ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';


--  write an sql query to find transactions  where total_sale is above 1000

SELECT *
FROM retail_sales
WHERE total_sale>1000;

-- write an sql query to find the total transaction (transaction_id) made by each gender in each category

SELECT 
	category,
	gender,
	count(*) as total_transactions
FROM retail_sales
GROUP BY 
	category,
	gender
ORDER BY 1 ASC;

-- write an sql query to calculate the average sale for each month. find the best selling month in each year

SELECT
	year,
	month,
	avg_total_sale
FROM
( 
SELECT
	EXTRACT (YEAR FROM sale_date)as year,
	EXTRACT (MONTH FROM sale_date) as month,
	AVG (total_sale) as avg_total_sale,
	RANK() OVER(PARTITION BY EXTRACT (YEAR FROM sale_date)ORDER BY AVG (total_sale) DESC) AS rank
FROM retail_sales
GROUP BY 1,2
) as t1
WHERE rank=1;	


-- Write an sql query to find the top 5 customers based on the highest total sales

SELECT 
		customer_id,
		SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;


-- Write an sql query to find the number of unique customers who purchased items from each category


SELECT 
		category,
		COUNT(DISTINCT customer_id) as ct_unique_customers
FROM retail_sales
GROUP BY category;

-- Write an sql query to create each and number of orders (Example morning<=12, Afternoon between 12 & 17, Evening>17) 

WITH Hourly_sales
AS
(
SELECT*,
	CASE
		WHEN EXTRACT(HOUR FROM sale_time)<12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
	ELSE 'Evening' 
	END as shift
FROM retail_sales
)
SELECT
shift,
COUNT(*) AS total_orders
FROM Hourly_sales
GROUP BY shift;

SELECT EXTRACT(HOUR FROM CURRENT_TIME)

-- END OF PROJECT







