-- Sample Store SQL Project
-- MySQL 8.0+

DROP DATABASE IF EXISTS sample_store;
CREATE DATABASE sample_store;
USE sample_store;

-- =========================
-- 1. TABLES
-- =========================

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    state VARCHAR(50),
    signup_date DATE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock INT
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    payment_method VARCHAR(30),
    order_status VARCHAR(30),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- =========================
-- 2. SAMPLE DATA
-- =========================

INSERT INTO customers VALUES
(1,'Aarav Sharma','Bangalore','Karnataka','2025-01-10'),
(2,'Priya Nair','Mumbai','Maharashtra','2025-01-15'),
(3,'Rahul Verma','Delhi','Delhi','2025-02-05'),
(4,'Sneha Reddy','Hyderabad','Telangana','2025-02-20'),
(5,'Vikram Singh','Pune','Maharashtra','2025-03-01'),
(6,'Ananya Iyer','Chennai','Tamil Nadu','2025-03-18'),
(7,'Karan Mehta','Bangalore','Karnataka','2025-04-02'),
(8,'Neha Gupta','Jaipur','Rajasthan','2025-04-15'),
(9,'Rohan Das','Kolkata','West Bengal','2025-05-01'),
(10,'Meera Joshi','Mumbai','Maharashtra','2025-05-12'),
(11,'Arjun Rao','Bangalore','Karnataka','2025-06-01'),
(12,'Kavya Shah','Ahmedabad','Gujarat','2025-06-15');

INSERT INTO products VALUES
(101,'Laptop','Electronics',55000.00,20),
(102,'Smartphone','Electronics',25000.00,35),
(103,'Headphones','Electronics',2500.00,60),
(104,'Keyboard','Accessories',1500.00,80),
(105,'Mouse','Accessories',800.00,100),
(106,'Office Chair','Furniture',7500.00,25),
(107,'Desk','Furniture',12000.00,15),
(108,'Backpack','Bags',2200.00,50),
(109,'Water Bottle','Lifestyle',700.00,100),
(110,'Smart Watch','Electronics',6000.00,30);

INSERT INTO orders VALUES
(1001,1,'2025-06-01','UPI','Delivered'),
(1002,2,'2025-06-03','Card','Delivered'),
(1003,3,'2025-06-05','Cash','Delivered'),
(1004,1,'2025-06-10','Card','Delivered'),
(1005,4,'2025-06-12','UPI','Shipped'),
(1006,5,'2025-06-15','Card','Delivered'),
(1007,6,'2025-06-18','UPI','Cancelled'),
(1008,7,'2025-06-20','Card','Delivered'),
(1009,8,'2025-06-22','UPI','Delivered'),
(1010,2,'2025-06-25','Card','Delivered'),
(1011,9,'2025-06-27','Cash','Shipped'),
(1012,10,'2025-06-28','UPI','Delivered'),
(1013,11,'2025-07-01','Card','Delivered'),
(1014,12,'2025-07-03','UPI','Delivered'),
(1015,5,'2025-07-05','Card','Delivered'),
(1016,1,'2025-07-08','UPI','Delivered'),
(1017,4,'2025-07-10','Card','Delivered'),
(1018,10,'2025-07-12','UPI','Delivered');

INSERT INTO order_items VALUES
(1,1001,101,1,55000),
(2,1001,103,2,2500),
(3,1002,102,1,25000),
(4,1002,105,2,800),
(5,1003,106,1,7500),
(6,1003,108,1,2200),
(7,1004,107,1,12000),
(8,1004,104,2,1500),
(9,1005,110,1,6000),
(10,1005,103,1,2500),
(11,1006,101,1,55000),
(12,1006,105,3,800),
(13,1007,102,1,25000),
(14,1008,106,1,7500),
(15,1008,109,2,700),
(16,1009,108,2,2200),
(17,1009,104,1,1500),
(18,1010,110,1,6000),
(19,1010,103,2,2500),
(20,1011,107,1,12000),
(21,1012,102,2,25000),
(22,1012,105,1,800),
(23,1013,101,1,55000),
(24,1013,104,1,1500),
(25,1014,106,1,7500),
(26,1014,109,3,700),
(27,1015,110,2,6000),
(28,1015,108,1,2200),
(29,1016,103,3,2500),
(30,1016,105,2,800),
(31,1017,102,1,25000),
(32,1017,110,1,6000),
(33,1018,107,1,12000),
(34,1018,104,2,1500);

-- =========================
-- 3. 30 SQL QUESTIONS + ANSWERS
-- =========================

-- Q1. Display all customers.
SELECT * FROM customers;

-- Q2. Display all products with price greater than 5000.
SELECT * FROM products
WHERE price > 5000;

-- Q3. Find the maximum product price.
SELECT MAX(price) AS max_price
FROM products;

-- Q4. Find the average product price.
SELECT ROUND(AVG(price),2) AS average_price
FROM products;

-- Q5. Count customers from Bangalore.
SELECT COUNT(*) AS bangalore_customers
FROM customers
WHERE city = 'Bangalore';

-- Q6. Display products from the Electronics category.
SELECT * FROM products
WHERE category = 'Electronics';

-- Q7. Find total quantity sold for each product.
SELECT product_id, SUM(quantity) AS total_quantity
FROM order_items
GROUP BY product_id;

-- Q8. Find total sales for each product.
SELECT product_id,
       ROUND(SUM(quantity * unit_price),2) AS total_sales
FROM order_items
GROUP BY product_id
ORDER BY total_sales DESC;

-- Q9. Find total sales by category.
SELECT p.category,
       ROUND(SUM(oi.quantity * oi.unit_price),2) AS total_sales
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY total_sales DESC;

-- Q10. Display customer names and their orders.
SELECT c.customer_name, o.order_id, o.order_date, o.order_status
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id;

-- Q11. Display order details with customer and product names.
SELECT o.order_id,
       c.customer_name,
       p.product_name,
       oi.quantity,
       oi.unit_price
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;

-- Q12. Find total spending by each customer.
SELECT c.customer_id,
       c.customer_name,
       ROUND(SUM(oi.quantity * oi.unit_price),2) AS total_spending
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spending DESC;

-- Q13. Find customers who placed more than one order.
SELECT c.customer_id, c.customer_name, COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 1;

-- Q14. Find the number of orders for each payment method.
SELECT payment_method, COUNT(*) AS order_count
FROM orders
GROUP BY payment_method;

-- Q15. Find total sales for delivered orders.
SELECT ROUND(SUM(oi.quantity * oi.unit_price),2) AS delivered_sales
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'Delivered';

-- Q16. Find products that were never ordered.
SELECT p.product_id, p.product_name
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;

-- Q17. Find customers who have never placed an order.
SELECT c.customer_id, c.customer_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;

-- Q18. Find products priced above the average product price.
SELECT product_id, product_name, price
FROM products
WHERE price > (SELECT AVG(price) FROM products);

-- Q19. Find customers whose total spending is above average customer spending.
WITH customer_sales AS (
    SELECT c.customer_id,
           c.customer_name,
           SUM(oi.quantity * oi.unit_price) AS total_spending
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status <> 'Cancelled'
    GROUP BY c.customer_id, c.customer_name
)
SELECT *
FROM customer_sales
WHERE total_spending > (SELECT AVG(total_spending) FROM customer_sales);

-- Q20. Find the highest-priced product in each category.
WITH ranked_products AS (
    SELECT product_id, product_name, category, price,
           RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rnk
    FROM products
)
SELECT product_id, product_name, category, price
FROM ranked_products
WHERE rnk = 1;

-- Q21. Rank products by total sales.
WITH product_sales AS (
    SELECT p.product_id,
           p.product_name,
           SUM(oi.quantity * oi.unit_price) AS total_sales
    FROM products p
    JOIN order_items oi ON p.product_id = oi.product_id
    GROUP BY p.product_id, p.product_name
)
SELECT product_id, product_name,
       ROUND(total_sales,2) AS total_sales,
       RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
FROM product_sales;

-- Q22. Find the top 3 products by sales.
WITH product_sales AS (
    SELECT p.product_id,
           p.product_name,
           SUM(oi.quantity * oi.unit_price) AS total_sales
    FROM products p
    JOIN order_items oi ON p.product_id = oi.product_id
    GROUP BY p.product_id, p.product_name
)
SELECT *
FROM (
    SELECT product_id,
           product_name,
           ROUND(total_sales,2) AS total_sales,
           DENSE_RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
    FROM product_sales
) x
WHERE sales_rank <= 3;

-- Q23. Find the second-highest priced product.
SELECT product_id, product_name, price
FROM (
    SELECT product_id, product_name, price,
           DENSE_RANK() OVER (ORDER BY price DESC) AS rnk
    FROM products
) x
WHERE rnk = 2;

-- Q24. Find total sales by city.
SELECT c.city,
       ROUND(SUM(oi.quantity * oi.unit_price),2) AS total_sales
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY c.city
ORDER BY total_sales DESC;

-- Q25. Find the customer with the highest total spending.
WITH customer_sales AS (
    SELECT c.customer_id,
           c.customer_name,
           SUM(oi.quantity * oi.unit_price) AS total_spending
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status <> 'Cancelled'
    GROUP BY c.customer_id, c.customer_name
)
SELECT *
FROM customer_sales
ORDER BY total_spending DESC
LIMIT 1;

-- Q26. Find monthly sales.
SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
       ROUND(SUM(oi.quantity * oi.unit_price),2) AS total_sales
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY sales_month;

-- Q27. Find each customer's order count and rank them by order count.
WITH customer_orders AS (
    SELECT c.customer_id,
           c.customer_name,
           COUNT(o.order_id) AS order_count
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT *,
       RANK() OVER (ORDER BY order_count DESC) AS order_rank
FROM customer_orders;

-- Q28. Find each product's percentage contribution to total sales.
WITH product_sales AS (
    SELECT p.product_id,
           p.product_name,
           SUM(oi.quantity * oi.unit_price) AS total_sales
    FROM products p
    JOIN order_items oi ON p.product_id = oi.product_id
    GROUP BY p.product_id, p.product_name
)
SELECT product_name,
       ROUND(total_sales,2) AS total_sales,
       ROUND(100 * total_sales / SUM(total_sales) OVER (), 2) AS sales_percentage
FROM product_sales
ORDER BY total_sales DESC;

-- Q29. Find the running total of monthly sales.
WITH monthly_sales AS (
    SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
           SUM(oi.quantity * oi.unit_price) AS total_sales
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status <> 'Cancelled'
    GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
)
SELECT sales_month,
       ROUND(total_sales,2) AS monthly_sales,
       ROUND(SUM(total_sales) OVER (ORDER BY sales_month),2) AS running_total
FROM monthly_sales
ORDER BY sales_month;

-- Q30. Find the best-selling product in each category.
WITH product_sales AS (
    SELECT p.category,
           p.product_id,
           p.product_name,
           SUM(oi.quantity * oi.unit_price) AS total_sales
    FROM products p
    JOIN order_items oi ON p.product_id = oi.product_id
    GROUP BY p.category, p.product_id, p.product_name
),
ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY category
               ORDER BY total_sales DESC
           ) AS rn
    FROM product_sales
)
SELECT category,
       product_id,
       product_name,
       ROUND(total_sales,2) AS total_sales
FROM ranked
WHERE rn = 1
ORDER BY category;
