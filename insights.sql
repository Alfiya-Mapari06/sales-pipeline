create database if not exists sales_db;
USE sales_db;
select * from sales;
SELECT COUNT(*) FROM sales;

SELECT * FROM sales
WHERE order_date IS NULL
OR customer_name IS NULL
OR quantity IS NULL;

SELECT region,
       SUM(revenue)  AS total_revenue,
       COUNT(*)       AS total_orders
FROM sales
GROUP BY region
ORDER BY total_revenue DESC;

-- Top customers by revenue (window function)
SELECT customer_name,
       SUM(revenue) AS total_spent,
       RANK() OVER (ORDER BY SUM(revenue) DESC) AS customer_rank
FROM sales
GROUP BY customer_name
ORDER BY customer_rank;


WITH ranked AS (
    SELECT region,
           product,
           SUM(revenue) AS product_revenue,
           ROW_NUMBER() OVER (
               PARTITION BY region
               ORDER BY SUM(revenue) DESC
           ) AS rn
    FROM sales
    GROUP BY region, product
)
SELECT region, product, product_revenue
FROM ranked
WHERE rn = 1
ORDER BY region;


-- Monthly revenue trend with growth %
WITH monthly AS (
    SELECT order_month,
           SUM(revenue) AS revenue
    FROM sales
    GROUP BY order_month
)
SELECT order_month,
       revenue,
       LAG(revenue) OVER (ORDER BY order_month) AS prev_month_revenue,
       ROUND(
           (revenue - LAG(revenue) OVER (ORDER BY order_month))
           / LAG(revenue) OVER (ORDER BY order_month) * 100, 2
       ) AS growth_pct
FROM monthly
ORDER BY order_month;


WITH ranked AS (
    SELECT region,
           product,
           SUM(revenue) AS product_revenue,
           ROW_NUMBER() OVER (
               PARTITION BY region
               ORDER BY SUM(revenue) DESC
           ) AS rn
    FROM sales
    GROUP BY region, product
)
SELECT region, product, product_revenue
FROM ranked
WHERE rn = 1
ORDER BY region;

SELECT salesperson,
       SUM(revenue)  AS total_revenue,
       COUNT(*)       AS total_orders,
       RANK() OVER (ORDER BY SUM(revenue) DESC) AS sales_rank
FROM sales
GROUP BY salesperson
ORDER BY sales_rank;