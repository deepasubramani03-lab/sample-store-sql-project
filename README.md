# Sample Store SQL Data Analysis Project

## Project Overview

This is a beginner-to-intermediate SQL portfolio project based on a fictional retail **Sample Store**.

The project demonstrates how SQL can be used to analyze customers, products, orders, and order-item sales.

## Database Structure

The project contains 4 related tables:

1. **customers** — customer information
2. **products** — product, category, price, and stock information
3. **orders** — order date, customer, payment method, and status
4. **order_items** — products and quantities included in each order

### Relationship

```text
customers
    |
    | customer_id
    v
orders
    |
    | order_id
    v
order_items
    |
    | product_id
    v
products
```

## SQL Concepts Demonstrated

- SELECT
- WHERE
- ORDER BY
- DISTINCT
- Aggregate functions
- COUNT
- SUM
- AVG
- MAX / MIN
- GROUP BY
- HAVING
- INNER JOIN
- LEFT JOIN
- Subqueries
- CTEs
- RANK()
- DENSE_RANK()
- ROW_NUMBER()
- PARTITION BY
- Running totals
- Percentage calculations
- Date functions

## 30 Business Questions

1. Display all customers.
2. Display products priced above 5000.
3. Find the maximum product price.
4. Find the average product price.
5. Count customers from Bangalore.
6. Display Electronics products.
7. Find total quantity sold for each product.
8. Find total sales for each product.
9. Find total sales by category.
10. Display customers and their orders.
11. Display order details with customer and product names.
12. Find total spending by each customer.
13. Find customers with more than one order.
14. Find order count by payment method.
15. Find sales from delivered orders.
16. Find products that were never ordered.
17. Find customers who never placed an order.
18. Find products priced above average.
19. Find customers whose spending is above average.
20. Find the highest-priced product in each category.
21. Rank products by total sales.
22. Find the top 3 products by sales.
23. Find the second-highest priced product.
24. Find total sales by city.
25. Find the customer with the highest spending.
26. Find monthly sales.
27. Rank customers by order count.
28. Find each product's percentage contribution to sales.
29. Calculate a running total of monthly sales.
30. Find the best-selling product in each category.

## How to Run

### Step 1
Install MySQL and open MySQL Workbench.

### Step 2
Open `sample_store.sql`.

### Step 3
Run the complete script using the Execute button.

### Step 4
The database `sample_store` will be created automatically.

### Step 5
Run the queries in `queries.sql`.

## Files

```text
Sample-Store-SQL-Project/
│
├── sample_store.sql
├── queries.sql
├── README.md
└── screenshots/
```

## Project Objective

The objective is to practice SQL in a realistic retail-sales scenario and demonstrate:

- Data retrieval
- Data filtering
- Relational joins
- Sales analysis
- Customer analysis
- Product analysis
- Subquery-based analysis
- CTE-based analysis
- Window-function analysis

## Tools

- MySQL
- MySQL Workbench
- GitHub

## Portfolio Use

This project can be included in a Data Analyst fresher portfolio to demonstrate practical SQL skills.

## Author

**Deepa S**

Data Analyst Aspirant
