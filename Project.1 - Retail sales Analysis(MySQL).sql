-- SQL Retail sales Analysis
CREATE TABLE retail_sales_analysis (
transactions_id INT PRIMARY KEY,
 sale_date DATE, 
 sale_time TIME, 
 customer_id INT, 
 gender VARCHAR(20),	
 age INT, 
 category VARCHAR(20),
 quantity INT,	
 price_per_unit FLOAT,
 cogs FLOAT, 
 total_sale FLOAT
);
SELECT * 
FROM retail_sales_analysis
LIMIT 100;


/* Step 1: Understand the Data
-- 🗂 Identify the database and tables */
SHOW DATABASES;
USE retail_sales_analysis_;
SHOW TABLES;
DESCRIBE retail_sales_analysis;

-- 🔍 Look at the structure and sample rows
SELECT *
FROM  retail_sales_analysis
LIMIT 10;


/* Step 2: Clean the Data
 ✅ Remove duplicates */
SELECT 
DISTINCT *
FROM retail_sales_analysis;
-- ❓ Find NULLs or blanks
SELECT *
FROM retail_sales_analysis
WHERE 
transactions_id IS NULL
OR sale_date IS NULL
OR sale_time IS NULL
OR customer_id IS NULL
OR gender IS NULL
OR age IS NULL
OR category IS NULL
OR quantity IS NULL 
OR price_per_unit IS NULL
OR cogs IS NULL 
OR total_sale
;-- THERE is no ANY NULL values

-- 🔄 Replace NULLs with default values
UPDATE table_name 
SET column_name = 'Read iT in pdf'
WHERE column_name IS NULL; 
-- =============================================================================================
-- 🔹 Step 3: Perform Exploratory Data Analysis (EDA)
-- =============================================================================================
-- 🔸 A. Summarize Data
SELECT COUNT(*) AS total_rows FROM table_name;
SELECT AVG(column1), MIN(column2), MAX(column3), STDDEV(column4) FROM table_name;

-- =============================================================================================
-- 🔸 B. Group and Aggregate
-- =============================================================================================
SELECT gender, COUNT(*) AS total, AVG(age) AS avg_age
FROM employee_demographics
GROUP BY gender;

-- ==========================================================================================
-- 🔸 C. Filter Data (WHERE clause)
-- ===========================================================================================
SELECT * FROM sales WHERE region = 'East' AND amount > 1000;

-- ===========================================================================================
-- 🔸 D. Sort Data
-- ===========================================================================================
SELECT * FROM sales ORDER BY amount DESC LIMIT 5;

-- ===========================================================================================
-- 🔹 Step 4: Join Tables (Relational Analysis)
-- ==============================================================================================
SELECT a.customer_name, b.order_date, b.amount
FROM customers a
JOIN orders b ON a.customer_id = b.customer_id;

-- ============================================================================================
-- 🔹 Step 5: Time-Based Analysis
-- ============================================================================================
-- Total sales per month
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(amount) AS total_sales
FROM orders
GROUP BY month;

-- =============================================================================================
-- 🔹 Step 6: Create Views or Reports
-- =============================================================================================
CREATE VIEW sales_summary AS
SELECT region, SUM(amount) AS total_sales
FROM sales
GROUP BY region;

-- ===============================================================================================
-- 🔹 Step 7: Export or Visualize
-- ===============================================================================================
-- Use MySQL Workbench, Excel, Power BI, or Python (pandas + matplotlib) to visualize
 -- or export the results.
-- #####################################################################################################
-- #####################################################################################################
-- #####################################################################################################
# Data Exploration
-- how many sales we have
SELECT 
COUNT(total_sale)
FROM retail_sales_analysis;

-- How many Unique customer we have 
SELECT 
COUNT(DISTINCT customer_id)
FROM retail_sales_analysis;


-- Data Analysis and Business key Problem & Answer
-- Q.1 Write SQL Query to rettrieve all columns for sales made on '2022-11-05'
SELECT *
FROM retail_sales_analysis
WHERE sale_date = '2022-11-05';
-- ###################################################################
-- Q.2 Write SQL Query to retrieve all transaction where the category is clothing and the Quantity sold more than =  4 in the month of Nov 2011
SELECT *
FROM retail_sales_analysis 
WHERE category = 'Clothing' 
AND quantity >= 4 
AND MONTH(sale_date) = 11 
AND YEAR(sale_date) = 2022
GROUP BY category;
-- #############################################################
-- Q.3 Write a MySQL Query to calculate the total sales for each category
SELECT
category,
SUM(total_sale)
FROM retail_sales_analysis
GROUP BY category ;
-- #######################################################################
-- Q.4 Write a Query to find the average of customer who puchase items from the Beauty' category
SELECT 
AVG(age) AS avg_age
FROM retail_sales_analysis
WHERE category = 'Beauty'
;
-- ###############################################################################################
-- Q.5 Write MySQL query to find all transaction where the total_sale is greater than 1000.
SELECT *
FROM retail_sales_analysis
WHERE total_sale > 1000;
-- ####################################################################
-- Q.6 Write MySQL Query to find total number of transaction made by each gender in each category
SELECT 
gender,
category,
COUNT(transactions_id)
FROM retail_sales_analysis
GROUP BY gender, category
ORDER BY gender; -- arange the order according to alphabet
-- #############################################################
-- Q.7 Write a Query to calculate the average sale for eacht month. Find out best selling month in each year
SELECT 
  year,
  month,
  avg_sale
FROM (
SELECT
EXTRACT(MONTH FROM sale_date) AS month,
EXTRACT(YEAR FROM sale_date) AS year,
AVG(total_sale) AS avg_sale,
 RANK() OVER (
      PARTITION BY EXTRACT(YEAR FROM sale_date)
      ORDER BY AVG(total_sale) DESC
    ) AS rnk
FROM retail_sales_analysis
GROUP BY month, year) as t1 -- we can write here 1,2 refer to month and year
WHERE rnk = 1
ORDER BY year;
-- ###########################################################
-- Q.8 Write query to find the top 5 cutomers based on the highest sale.
SELECT 
customer_id, -- tells a customer purchase 
SUM(total_sale) AS total_sales, -- add total purchase by a single customer 
RANK () OVER (ORDER BY SUM(total_sale) DESC) AS sales_rank-- only for rank we can remove it that not effect outpu
FROM retail_sales_analysis
GROUP BY customer_id
ORDER BY sales_rank 
LIMIT 5;
-- ############################################################
-- Q.9 Write a query to find the number of unique custoemr who purchased items from each category
SELECT 
category,
COUNT( DISTINCT(customer_id)) as unique_cust
FROM retail_sales_analysis
GROUP BY category
-- ###################################################################
-- Q.10 Write Query to create each shift and number of orders(Exp. Morning<= 12, Afternoon BETWEEN 12 & 17, Evening>17)
WITH hourly_sale
AS ( SELECT *,
             CASE 
                 WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
                 WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
                 ELSE 'Evening'
              END shift
	 FROM retail_sales_analysis
      )
SELECT shift,
COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;

-- End The Project 







