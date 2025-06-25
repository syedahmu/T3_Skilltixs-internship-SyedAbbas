-- First  We will create a database
create database coffe_shop;
use coffe_shop;

-- Create products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

-- Create customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city_id INT
);

-- Create city table
CREATE TABLE city (
    city_id INT PRIMARY KEY,
    city_name VARCHAR(100),
    population int,
    estimated_rent int,
    city_rank int
);

-- Create sales table
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    sale_date DATE,
	product_id INT,
    customer_id INT,    
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Basic queries on test

-- Q:1. SELECT column_name FROM table
SELECT product_name FROM products;

-- Q:2 Retrieve all the product names records where product price is 300.
select product_name from products
where price = 300;

-- Q:3 List the top 10 sales ordered by the most recent sale date.
SELECT * FROM sales
ORDER BY sale_date DESC
LIMIT 10;

-- Q:4 Show total quantity sold per product.
SELECT product_id, SUM(total) AS total_quantity_sold
FROM sales
GROUP BY product_id;

-- Q:5 Find the number of sales transactions per customer.
SELECT customer_id, COUNT(*) AS transaction_count
FROM sales
GROUP BY customer_id;

-- Q:6 List the customer names  and their  each city .
SELECT c.customer_name, d.city_name
FROM customers as c
INNER JOIN city as d ON c.city_id = d.city_id;

-- Q:7 Get full name of each customer, product name, and  total sale .
select c.customer_name,s.total,p.product_name
FROM customers as c
inner join sales as s
on c.customer_id=s.customer_id
inner join products as p
on p.product_id=s.product_id;

-- Q:8 Show the 5 most expensive products. 
select product_name,price 
FROM products
order by price DESC 
limit 5 ;

-- Q:9 Find total quantity sold for each month.
SELECT MONTH(sale_date) AS sale_month, SUM(total) AS monthly_sales
FROM sales
GROUP BY MONTH(sale_date)
ORDER BY sale_month;

-- Q:10 How many days ago was each sale made?
SELECT sale_id, DATEDIFF(CURDATE(), sale_date) AS days_since_sale
FROM sales;

-- Q:11 Show the total number of sales and quantity sold per city.
SELECT ci.city_name, COUNT(s.sale_id) AS total_sales, SUM(s.total) AS total_quantity
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
INNER JOIN city ci ON c.city_id = ci.city_id
GROUP BY ci.city_name
ORDER BY total_quantity DESC;