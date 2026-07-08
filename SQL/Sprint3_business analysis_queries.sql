-- Create a new column called order_size.
-- Business rules:
-- Sales < 100 → Low
-- Sales between 100 and 500 → Medium
-- Sales > 500 → High

SELECT 
	order_id,
	sales,
	CASE 
		WHEN sales < 100 THEN 'Low'
		WHEN sales BETWEEN 100 AND 500 THEN 'Medium'
		ELSE 'High'
		END AS order_size
FROM orders;

-- Using the order size categories (Low/Medium/High), 
--count how many orders fall into each category.

SELECT 
	COUNT(*) AS num_of_orders,
	CASE 
		WHEN sales < 100 THEN 'Low'
		WHEN sales BETWEEN 100 AND 500 THEN 'Medium'
		ELSE 'High'
		END AS order_size
FROM orders
GROUP BY order_size;

-- Show total sales and average profit for each order size.

WITH data_analysis AS (
	SELECT 
		sales,
		profit,
		CASE 
			WHEN sales < 100 THEN 'Low'
			WHEN sales BETWEEN 100 AND 500 THEN 'Medium'
			ELSE 'High'
			END AS order_size
		FROM orders
)
SELECT 
	order_size,
	sum(sales) AS total_sales,
	avg(profit) AS avg_profit
FROM data_analysis
GROUP BY order_size
ORDER BY order_size;

-- without cte: Show total sales and average profit for each order size.

SELECT 
	sum(sales) as total_sales,
	avg(profit) as avg_profit,
	CASE 
		WHEN sales < 100 THEN 'Low'
		WHEN sales BETWEEN 100 AND 500 THEN 'Medium'
		ELSE 'High'
		END AS order_size
FROM orders
GROUP BY order_size
ORDER BY order_size;

-- Create a new column called status.
--If profit > 0, show "Profit".
--Otherwise, show "Loss".

SELECT 
	CASE 
		WHEN profit > 0 THEN 'Profit'
		ELSE 'Loss'
	END AS status
FROM orders;

-- Which individual orders generated high sales but ended up making a loss?

SELECT 
	order_id FROM orders
WHERE sales > 500 AND profit <= 0;

-- Can you also show me the sales amount and the loss?

SELECT 
	order_id,
	sales,
	profit
FROM orders
WHERE sales > 500 AND profit <= 0
