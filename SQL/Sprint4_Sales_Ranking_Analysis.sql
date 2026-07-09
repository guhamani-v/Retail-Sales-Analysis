-- Find the highest sales order in every category.

WITH sales_order AS (
	SELECT 
		order_id,
		category,
		sum(sales) AS total_sales,
		ROW_NUMBER() OVER(PARTITION BY category ORDER BY sum(sales) DESC) AS rnk
	FROM orders
	GROUP BY order_id, category	
)
SELECT 
	*
	FROM sales_order
	WHERE rnk = 1;

-- Show the Top 5 customers based on total sales

WITH customers_grp AS (
	SELECT 
		customer_name,
		sum(sales) AS total_sales
		FROM orders
		GROUP BY customer_name
),
ranked AS (
	SELECT 
		*,
		ROW_NUMBER() OVER(ORDER BY total_sales DESC) AS rnk
	FROM customers_grp
)
SELECT * FROM ranked
WHERE rnk <=5;

-- Find the second most profitable state

WITH sec_profit AS (
	SELECT 
		state_province,
		sum(profit) AS total_profit,
		ROW_NUMBER() OVER(ORDER BY sum(profit) DESC) AS rnk
	FROM orders
	GROUP BY state_province		
)
SELECT * FROM sec_profit 
WHERE rnk = 2;

-- Which customer has placed the largest single order?

WITH large_order AS (
	SELECT 
		customer_name,
		order_id,
		sales,
		ROW_NUMBER() OVER(ORDER BY sales DESC) AS rnk
	FROM orders
)
SELECT * FROM large_order
WHERE rnk = 1;
