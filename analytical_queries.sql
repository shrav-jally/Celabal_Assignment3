USE superstore_db;
DESCRIBE superstore_raw;

-- Creating relational entities by extracting unique records to ensure data integrity
CREATE TABLE customers AS 
SELECT DISTINCT `Customer ID`, `Customer Name` 
FROM superstore_raw;

CREATE TABLE orders AS 
SELECT DISTINCT `Order ID`, `Customer ID`, `Order Date`, `Sales` 
FROM superstore_raw;

CREATE TABLE products AS 
SELECT DISTINCT `Product ID`, `Product Name`, `Category` 
FROM superstore_raw;

-- Mini project --

-- Joining tables to aggregate total revenue by customer and identifying top spenders
SELECT `Customer Name`, SUM(`Sales`) AS total_sales
FROM customers c
JOIN orders o ON c.`Customer ID` = o.`Customer ID`
GROUP BY `Customer Name`
ORDER BY total_sales DESC LIMIT 5;

-- Using ASC order to isolate the customers with the lowest contribution to total sales
SELECT `Customer Name`, SUM(`Sales`) AS total_sales
FROM customers c
JOIN orders o ON c.`Customer ID` = o.`Customer ID`
GROUP BY `Customer Name`
ORDER BY total_sales ASC LIMIT 5;

-- Applying a HAVING clause to filter out repeat purchasers and isolate single-order activity
SELECT `Customer ID`, COUNT(`Order ID`) AS order_count
FROM orders
GROUP BY `Customer ID`
HAVING order_count = 1;

-- Using a CTE to pre-calculate totals so I can compare each customer against the global average
WITH CustomerTotals AS (
    SELECT `Customer ID`, SUM(`Sales`) AS total_sales FROM orders GROUP BY `Customer ID`
)
SELECT * FROM CustomerTotals
WHERE total_sales > (SELECT AVG(total_sales) FROM CustomerTotals);

-- Aggregating individual order data to find the peak transaction value for every customer
SELECT `Customer ID`, MAX(`Sales`) AS highest_order
FROM orders
GROUP BY `Customer ID`;


-- steps 2 and 3 --

-- Using a subquery to calculate the benchmark average sales before filtering individual orders
SELECT * FROM orders 
WHERE `Sales` > (SELECT AVG(`Sales`) FROM orders);

SELECT `Customer ID`, MAX(`Sales`) AS highest_order 
FROM orders 
GROUP BY `Customer ID`;

-- Creating a temporary named result set to simplify aggregation before selecting final metrics
WITH CustTotal AS (
    SELECT `Customer ID`, SUM(`Sales`) AS total_s 
    FROM orders GROUP BY `Customer ID`
)
SELECT * FROM CustTotal;

-- Combining a CTE with a subquery to filter customers based on an aggregated benchmark
WITH CustTotal AS (
    SELECT `Customer ID`, SUM(`Sales`) AS ts FROM orders GROUP BY `Customer ID`
)
SELECT * FROM CustTotal 
WHERE ts > (SELECT AVG(ts) FROM CustTotal);

-- Applying RANK() to generate a competitive performance list based on total revenue
SELECT `Customer ID`, SUM(`Sales`) AS total_sales,
RANK() OVER (ORDER BY SUM(`Sales`) DESC) AS sales_rank
FROM orders
GROUP BY `Customer ID`;

-- Using PARTITION BY to reset the row count for every customer's order history sequence
SELECT `Customer ID`, `Order ID`, `Order Date`,
ROW_NUMBER() OVER (PARTITION BY `Customer ID` ORDER BY `Order Date`) AS row_num
FROM orders;

SELECT `Customer ID`, SUM(`Sales`) AS total_s
FROM orders
GROUP BY `Customer ID`
ORDER BY total_s DESC LIMIT 3;

-- Integrating a CTE for aggregation and a Window Function to create a clean rank-performance report
WITH CustomerTotals AS (
    SELECT `Customer ID`, SUM(`Sales`) AS total_sales 
    FROM orders 
    GROUP BY `Customer ID`
)
SELECT 
    c.`Customer Name`, 
    ct.total_sales, 
    RANK() OVER (ORDER BY ct.total_sales DESC) AS sales_rank
FROM customers c
JOIN CustomerTotals ct ON c.`Customer ID` = ct.`Customer ID`;