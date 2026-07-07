-- create new table

CREATE TABLE orders (
    row_id INTEGER,
    order_id TEXT,
    order_date DATE,
    ship_date DATE,
    ship_mode TEXT,
    customer_id TEXT,
    customer_name TEXT,
    segment TEXT,
    country_region TEXT,
    city TEXT,
    state_province TEXT,
    postal_code TEXT,
    region TEXT,
    product_id TEXT,
    category TEXT,
    sub_category TEXT,
    product_name TEXT,
    sales NUMERIC(10,2),
    quantity INTEGER,
    discount NUMERIC(5,2),
    profit NUMERIC(10,2)
);

-- import data into the db

COPY orders
FROM 'C:\PostGresData\orders.csv'
with (
format csv,
header true
);

select * from orders;

select * from orders
limit 5;

-- Which state makes the highest profit?

select state_province, sum(profit) as high_profit from orders 
group by state_province
order by high_profit desc
limit 1;

-- Which category has the highest sales?

select category, sum(sales) as high_sales from orders
group by category
order by high_sales desc
limit 1;

-- Which city has the highest profit?

select city, sum(profit) as high_profit from orders
group by city
order by high_profit desc
limit 1;

select customer_name from orders
limit 2;

-- Which customer placed the highest number of orders?

select customer_name, count(*) as num_orders from orders
group by customer_name
order by num_orders desc
limit 1;

-- top 5 customers by total sales

select customer_name, sum(sales) as tot_sales from orders
group by customer_name
order by tot_sales desc
limit 5;
