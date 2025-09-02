-- 09_demo_queries.sql
USE mocha_dw;

-- 1) Daily revenue & units
SELECT * FROM vw_daily_sales ORDER BY date_key DESC LIMIT 14;

-- 2) Top 10 products (last 30 days)
SELECT * FROM vw_top_products_30d LIMIT 10;

-- 3) Month-over-month revenue by category
SELECT d.year, d.month, p.category,
       ROUND(SUM(f.line_amount_cents)/100.0,2) AS revenue_usd
FROM fact_sales f
JOIN dim_date d ON d.date_key = f.date_key
JOIN dim_product p ON p.product_key = f.product_key
WHERE f.order_status IN ('PAID','READY','COMPLETED')
GROUP BY d.year, d.month, p.category
ORDER BY d.year, d.month, revenue_usd DESC;

-- 4) Customer LTV
SELECT c.customer_key, c.email,
       ROUND(SUM(f.line_amount_cents)/100.0,2) AS lifetime_value_usd
FROM fact_sales f
JOIN dim_customer c ON c.customer_key = f.customer_key
WHERE f.order_status IN ('PAID','READY','COMPLETED')
GROUP BY c.customer_key, c.email
ORDER BY lifetime_value_usd DESC
LIMIT 20;

-- 5) New vs returning customers (CTE)
WITH first_order AS (
  SELECT customer_key, MIN(date_key) AS first_date
  FROM fact_sales
  GROUP BY customer_key
)
SELECT
  CASE WHEN f.date_key = fo.first_date THEN 'NEW' ELSE 'RETURNING' END AS cohort,
  COUNT(DISTINCT f.order_id) AS orders,
  ROUND(SUM(f.line_amount_cents)/100.0,2) AS revenue_usd
FROM fact_sales f
JOIN first_order fo ON fo.customer_key = f.customer_key
WHERE f.date_key >= CURRENT_DATE - INTERVAL 60 DAY
  AND f.order_status IN ('PAID','READY','COMPLETED')
GROUP BY cohort;

-- 6) Attachment rate
WITH per_order AS (
  SELECT order_id, COUNT(DISTINCT product_key) AS distinct_items
  FROM fact_sales
  GROUP BY order_id
)
SELECT ROUND(100.0 * SUM(distinct_items >= 2)/COUNT(*), 2) AS pct_with_2plus
FROM per_order;

-- 7) Price band performance
SELECT
  CASE
    WHEN p.current_price_cents < 400 THEN 'Under $4'
    WHEN p.current_price_cents < 600 THEN '$4–5.99'
    ELSE '$6+'
  END AS price_band,
  SUM(f.qty) AS units,
  ROUND(SUM(f.line_amount_cents)/100.0,2) AS revenue_usd
FROM fact_sales f
JOIN dim_product p ON p.product_key = f.product_key
WHERE f.order_status IN ('PAID','READY','COMPLETED')
GROUP BY price_band
HAVING units > 0
ORDER BY revenue_usd DESC;

-- 8) Weekday vs weekend revenue
SELECT
  CASE WHEN d.day_of_week IN (1,7) THEN 'Weekend' ELSE 'Weekday' END AS day_type,
  ROUND(SUM(f.line_amount_cents)/100.0,2) AS revenue_usd
FROM fact_sales f
JOIN dim_date d ON d.date_key = f.date_key
WHERE f.order_status IN ('PAID','READY','COMPLETED')
GROUP BY day_type;

-- 9) Pareto: top products by revenue share
WITH per_product AS (
  SELECT p.product_key, p.product_name,
         SUM(f.line_amount_cents) AS rev
  FROM fact_sales f JOIN dim_product p ON p.product_key=f.product_key
  WHERE f.order_status IN ('PAID','READY','COMPLETED')
  GROUP BY p.product_key, p.product_name
),
tot AS (SELECT SUM(rev) AS total_rev FROM per_product)
SELECT pp.product_key, pp.product_name,
       ROUND(pp.rev/t.total_rev*100.0,2) AS pct_of_total
FROM per_product pp CROSS JOIN tot t
ORDER BY pct_of_total DESC
LIMIT 10;

-- 10) Materialized view usage
CALL sp_refresh_mv_monthly_product_sales();
SELECT * FROM mv_monthly_product_sales
ORDER BY year DESC, month DESC, revenue_usd DESC
LIMIT 20;
