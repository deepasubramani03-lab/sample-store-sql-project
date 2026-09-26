-- 30 SQL QUESTIONS + ANSWERS
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
