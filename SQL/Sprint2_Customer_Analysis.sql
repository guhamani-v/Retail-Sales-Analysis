-- Regional & Category Performance Analysis

-- Top 10 highest profit orders

SELECT * FROM orders
ORDER BY profit DESC
limit 10;

-- total sales

SELECT sum(sales) as total_sales from orders;

-- Average discount

SELECT avg(discount) as average_discount FROM orders;

-- Orders from California

SELECT * FROM orders
WHERE state_province = 'California';

-- Furniture orders

SELECT * FROM orders
WHERE category = 'Furniture';

-- How many different categories are there?

SELECT DISTINCT COUNT(category) as count_of_category, category FROM orders
GROUP BY category;

-- Total sales by category

SELECT category, sum(sales) AS total_sales FROM orders
GROUP BY category;

-- Total profit by category

SELECT category, sum(profit) AS total_profit FROM orders
GROUP BY category;

-- Average sales by segment

SELECT segment, avg(sales) AS average_sales FROM orders
GROUP BY segment; 

-- Number of orders per region

SELECT COUNT(*) as count_per_region, region FROM orders
GROUP BY region;

-- States with total sales above 100,000

SELECT state_province, sum(sales) as total_sales FROM orders
GROUP BY state_province
HAVING sum(sales) > 100000;

-- Categories whose average profit is above 50

SELECT category, avg(profit) as average_profit FROM orders
GROUP BY category
HAVING avg(profit) > 50;

-- Customers who placed more than 5 orders

SELECT DISTINCT customer_name, COUNT(*) AS count_of_customers FROM orders
GROUP BY customer_name
HAVING COUNT(*) > 5;

-- Products with profit less than 0

SELECT * FROM orders
WHERE profit < 0;

-- Orders between 2020-01-01 and 2020-06-30

SELECT * FROM orders
WHERE order_date BETWEEN '2020-01-01' AND '2020-06-30';

-- "Which category is making us the most money?"

SELECT 
	category,
	sum(profit) AS total_profit
FROM orders
GROUP BY category
ORDER BY total_profit DESC;
