-- SQL Retail sales Analysis-p1

CREATE DATABASE sql_project_p1;
USE sql_project_p1;

-- create table
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
(
	transactions_id	INT PRIMARY KEY,
	sale_date DATE,	
	sale_time TIME,
	customer_id	INT,
	gender	VARCHAR(25),
	age	INT,
	category VARCHAR(25),	
	quantiy	INT,
	price_per_unit FLOAT,	
	cogs INT,
	total_sale FLOAT
);

SELECT *FROM retail_sales;

SELECT 
COUNT(*)
FROM retail_sales;

-- DATA CLEARNING

SELECT * FROM retail_sales
WHERE
transactions_id	IS NULL
OR
sale_date	IS NULL
OR
sale_time	IS NULL
OR
customer_id	IS NULL
OR
gender	IS NULL
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

-- DATA EXPLORATION

-- HOW MANY SALES WE HAVE?

SELECT COUNT(*) FROM retail_sales;

-- HOW MANY UNIQUE CUSTOMERS WE HAVE?
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;

-- HOW MANY UNIQUE category Name WE HAVE?
SELECT DISTINCT category FROM retail_sales;

-- DATA ANALYSIS & ANSWER
-- 1 Write a SQL query to retrieve all columns for sales made on '2022-11-05:
-- 2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
-- 3 Write a SQL query to calculate the total sales (total_sale) for each category.:
-- 4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
-- 5 Write a SQL query to find all transactions where the total_sale is greater than 1000.:
-- 6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
-- 7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
-- 8 Write a SQL query to find the top 5 customers based on the highest total sales
-- 9 Write a SQL query to find the number of unique customers who purchased items from each category
-- 10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

-- 1 Write a SQL query to retrieve all columns for sales made on '2022-11-05:

	SELECT *
    FROM retail_sales
    WHERE sale_date = '2022-11-05';

-- 2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022:
            
            SELECT *
				FROM retail_sales
				WHERE category = 'Clothing'
				  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
				  AND quantiy >= 3;
                  
-- 3 Write a SQL query to calculate the total sales (total_sale) for each category.:

	SELECT 
		category,
        SUM(total_sale) AS net_sales,
		COUNT(*) AS total_orders
     FROM retail_sales
     GROUP BY 1;
     
 -- 4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

	SELECT
		ROUND(AVG(age),2) AS avg_age
	FROM retail_sales
    WHERE category = 'Beauty';
                  
-- 5 Write a SQL query to find all transactions where the total_sale is greater than 1000.:

	SELECT * FROM retail_sales
    WHERE  total_sale >1000;
   
-- 6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
    
    SELECT
    category,
    gender,
    COUNT(*) AS total_trans
    FROM retail_sales
   GROUP BY category,
    gender 
    ORDER BY 1;
    
-- 7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

	SELECT
    YEAR(sale_date) AS sale_year,
    MONTH(sale_date) AS sale_month,
    AVG(total_sale) AS average_sale
FROM
    retail_sales
GROUP BY
    YEAR(sale_date), MONTH(sale_date)
ORDER BY
    sale_year, average_sale DESC;

-- 8 Write a SQL query to find the top 5 customers based on the highest total sales

SELECT
    customer_id,
    SUM(total_sale) AS total_sales
FROM
    retail_sales
GROUP BY
    customer_id 
ORDER BY
    total_sales DESC
LIMIT 5;


-- 9 Write a SQL query to find the number of unique customers who purchased items from each category

SELECT 
    category, 
    COUNT(DISTINCT customer_id) AS unique_customers
FROM 
    retail_sales
GROUP BY 
    category;
    
 -- 10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

SELECT
    CASE
        WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) >= 12 AND HOUR(sale_time) < 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS number_of_orders
FROM
    retail_sales
GROUP BY
    shift;   