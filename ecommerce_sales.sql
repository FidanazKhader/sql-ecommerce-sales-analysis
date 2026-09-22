CREATE DATABASE IF NOT EXISTS ecommerce_sales;

USE ecommerce_sales;

CREATE TABLE IF NOT EXISTS sales (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_name VARCHAR(100),
    region VARCHAR(50),
    category VARCHAR(50),
    product VARCHAR(100),
    quantity INT,
    unit_price DECIMAL(10,2),
    sales DECIMAL(12,2),
    cost DECIMAL(12,2),
    profit DECIMAL(12,2)
);

INSERT IGNORE INTO sales
(order_id, order_date, customer_name, region, category, product, quantity, unit_price, sales, cost, profit)
VALUES
(1001, '2025-01-05', 'Aarav', 'North', 'Electronics', 'Laptop', 2, 55000, 110000, 85000, 25000),
(1002, '2025-01-08', 'Priya', 'South', 'Electronics', 'Tablet', 3, 30000, 90000, 69000, 21000),
(1003, '2025-01-15', 'Rahul', 'East', 'Accessories', 'Keyboard', 5, 2500, 12500, 8500, 4000),
(1004, '2025-02-03', 'Ananya', 'West', 'Electronics', 'Monitor', 2, 18000, 36000, 27000, 9000),
(1005, '2025-02-12', 'Vikram', 'North', 'Electronics', 'Laptop', 1, 55000, 55000, 42500, 12500),
(1006, '2025-02-20', 'Sneha', 'South', 'Accessories', 'Mouse', 8, 1200, 9600, 6400, 3200),
(1007, '2025-03-02', 'Arjun', 'East', 'Electronics', 'Printer', 2, 15000, 30000, 22500, 7500),
(1008, '2025-03-10', 'Meera', 'West', 'Electronics', 'Laptop', 3, 55000, 165000, 127500, 37500),
(1009, '2025-03-18', 'Kiran', 'North', 'Accessories', 'Headphones', 6, 4000, 24000, 16800, 7200),
(1010, '2025-03-25', 'Neha', 'South', 'Electronics', 'Tablet', 2, 30000, 60000, 46000, 14000),
(1011, '2025-04-06', 'Rohan', 'East', 'Electronics', 'Monitor', 3, 18000, 54000, 40500, 13500),
(1012, '2025-04-14', 'Divya', 'West', 'Accessories', 'Webcam', 5, 3500, 17500, 12250, 5250),
(1013, '2025-05-01', 'Aditya', 'North', 'Electronics', 'Laptop', 2, 55000, 110000, 85000, 25000),
(1014, '2025-05-11', 'Isha', 'South', 'Accessories', 'Keyboard', 4, 2500, 10000, 6800, 3200),
(1015, '2025-05-22', 'Manish', 'East', 'Electronics', 'Printer', 3, 15000, 45000, 33750, 11250),
(1016, '2025-06-04', 'Pooja', 'West', 'Electronics', 'Tablet', 4, 30000, 120000, 92000, 28000),
(1017, '2025-06-16', 'Sanjay', 'North', 'Accessories', 'Mouse', 10, 1200, 12000, 8000, 4000),
(1018, '2025-07-07', 'Nisha', 'South', 'Electronics', 'Laptop', 1, 55000, 55000, 42500, 12500),
(1019, '2025-07-19', 'Varun', 'East', 'Accessories', 'Headphones', 7, 4000, 28000, 19600, 8400),
(1020, '2025-08-02', 'Kavya', 'West', 'Electronics', 'Monitor', 2, 18000, 36000, 27000, 9000);

CREATE TABLE IF NOT EXISTS customers (
    customer_name VARCHAR(100) PRIMARY KEY,
    city VARCHAR(50),
    customer_type VARCHAR(50)
);

INSERT IGNORE INTO customers (customer_name, city, customer_type)
VALUES
('Aarav', 'Bengaluru', 'Retail'),
('Priya', 'Mangalore', 'Retail'),
('Rahul', 'Mysuru', 'Business'),
('Ananya', 'Bengaluru', 'Retail'),
('Vikram', 'Mumbai', 'Business'),
('Sneha', 'Chennai', 'Retail'),
('Arjun', 'Hyderabad', 'Business'),
('Meera', 'Bengaluru', 'Business'),
('Kiran', 'Delhi', 'Retail'),
('Neha', 'Kochi', 'Retail'),
('Rohan', 'Hyderabad', 'Business'),
('Divya', 'Mumbai', 'Retail'),
('Aditya', 'Bengaluru', 'Business'),
('Isha', 'Mangalore', 'Retail'),
('Manish', 'Kolkata', 'Business'),
('Pooja', 'Mumbai', 'Retail'),
('Sanjay', 'Delhi', 'Business'),
('Nisha', 'Chennai', 'Retail'),
('Varun', 'Kolkata', 'Retail'),
('Kavya', 'Bengaluru', 'Retail');

-- 1. Total Sales and Profit
SELECT
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM sales;


-- 2. Sales by Product
SELECT
    product,
    SUM(sales) AS total_sales
FROM sales
GROUP BY product
ORDER BY total_sales DESC;


-- 3. Sales by Region
SELECT
    region,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM sales
GROUP BY region
ORDER BY total_sales DESC;


-- 4. Monthly Sales and Profit
SELECT
    MONTH(order_date) AS month_number,
    MONTHNAME(order_date) AS month,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM sales
GROUP BY
    MONTH(order_date),
    MONTHNAME(order_date)
ORDER BY month_number;


-- 5. Top Customers
SELECT
    customer_name,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM sales
GROUP BY customer_name
ORDER BY total_sales DESC;

-- 6. Sales by Customer Type
SELECT
    c.customer_type,
    SUM(s.sales) AS total_sales,
    SUM(s.profit) AS total_profit
FROM sales s
INNER JOIN customers c
    ON s.customer_name = c.customer_name
GROUP BY c.customer_type
ORDER BY total_sales DESC;


-- 7. Customer Details with Sales
SELECT
    s.order_id,
    s.customer_name,
    c.city,
    c.customer_type,
    s.product,
    s.sales,
    s.profit
FROM sales s
INNER JOIN customers c
    ON s.customer_name = c.customer_name;

-- 8. Rank Products by Sales
WITH product_sales AS (
    SELECT
        product,
        SUM(sales) AS total_sales
    FROM sales
    GROUP BY product
)
SELECT
    product,
    total_sales,
    RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
FROM product_sales;


-- 9. Top 5 Orders
WITH ranked_orders AS (
    SELECT
        order_id,
        customer_name,
        product,
        sales,
        profit,
        ROW_NUMBER() OVER (ORDER BY sales DESC) AS row_num
    FROM sales
)
SELECT
    order_id,
    customer_name,
    product,
    sales,
    profit
FROM ranked_orders
WHERE row_num <= 5
ORDER BY sales DESC;


-- 10. Highest-Sales Order in Each Region
WITH ranked_orders AS (
    SELECT
        order_id,
        customer_name,
        region,
        product,
        sales,
        profit,
        ROW_NUMBER() OVER (
            PARTITION BY region
            ORDER BY sales DESC
        ) AS region_rank
    FROM sales
)
SELECT
    order_id,
    customer_name,
    region,
    product,
    sales,
    profit
FROM ranked_orders
WHERE region_rank = 1
ORDER BY sales DESC;


-- 11. Running Total of Sales
SELECT
    order_id,
    order_date,
    customer_name,
    sales,
    SUM(sales) OVER (
        ORDER BY order_date
    ) AS running_total_sales
FROM sales
ORDER BY order_date;

-- 12. Check for Missing Values
SELECT
    COUNT(*) AS total_rows,
    COUNT(customer_name) AS customer_names,
    COUNT(product) AS products,
    COUNT(region) AS regions,
    COUNT(sales) AS sales_values,
    COUNT(profit) AS profit_values
FROM sales;


-- 13. Check for Duplicate Orders
SELECT
    order_id,
    COUNT(*) AS duplicate_count
FROM sales
GROUP BY order_id
HAVING COUNT(*) > 1;


-- 14. Check for Invalid Sales or Profit
SELECT
    order_id,
    customer_name,
    product,
    sales,
    profit
FROM sales
WHERE sales <= 0
   OR profit < 0;


-- 15. Check Order Date Range
SELECT
    MIN(order_date) AS earliest_order,
    MAX(order_date) AS latest_order,
    COUNT(DISTINCT order_date) AS unique_order_dates
FROM sales;

-- 16. Overall Business KPI Summary
SELECT
    COUNT(order_id) AS total_orders,
    SUM(quantity) AS total_units,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin
FROM sales;