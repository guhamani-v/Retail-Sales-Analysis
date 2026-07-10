-- create table to import it (people)

CREATE TABLE people (
	Regional_Manager TEXT,
	Region TEXT
);

-- importing dataset from excel for people table

COPY people
FROM 'C:\PostGresData\people.csv'
WITH (
	format csv,
	header true
);

-- check the imported dataset for people

SELECT * FROM people;

-- create another table to import it (return)

CREATE TABLE return(
	order_id TEXT,
	returned TEXT
);

-- importing dataset from excel for return table

COPY return
FROM 'C:\PostGresData\return.csv'
WITH (
	format csv,
	header true
);

-- check the imported dataset for return

SELECT * FROM return;

-- renaming the table name because of the command

ALTER TABLE return
RENAME TO returns;

-- checking again for returns

SELECT * FROM returns
LIMIT 5;

-- Which Regional Manager generated the highest sales?

SELECT 
	SUM(o.sales) AS total_sales,
	p.Regional_Manager AS Manager
FROM orders o 
JOIN people p
ON o.region = p.region
GROUP BY p.Regional_Manager
ORDER BY SUM(o.sales) DESC;

-- Which Regional Manager has the highest profit?

SELECT 
	SUM(o.profit) AS total_profit,
	p.Regional_Manager AS Manager
FROM orders o 
JOIN people p
ON o.region = p.Region
GROUP BY p.Regional_Manager
ORDER BY SUM(o.profit) DESC;

-- Which regions have the highest number of returned orders?

SELECT 
	COUNT(DISTINCT r.order_id) AS Returned_orders,
	o.region
FROM orders o
INNER JOIN returns r
ON o.order_id = r.order_id
GROUP BY o.region
ORDER BY Returned_orders DESC;

-- Which categories are associated with the highest number of returned orders?

SELECT 
	o.category,
	COUNT(DISTINCT r.order_id) AS count_of_return
FROM orders o
JOIN returns r
ON o.order_id = r.order_id
GROUP BY o.category
ORDER BY count_of_return DESC;
