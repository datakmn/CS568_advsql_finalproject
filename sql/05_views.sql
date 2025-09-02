-- 05_views.sql
USE mocha_dw;

CREATE OR REPLACE VIEW vw_daily_sales AS
SELECT d.date_key,
       SUM(f.line_amount_cents)/100.0 AS sales_usd,
       SUM(f.qty) AS units
FROM fact_sales f
JOIN dim_date d ON d.date_key = f.date_key
WHERE f.order_status IN ('PAID','READY','COMPLETED')
GROUP BY d.date_key;

CREATE OR REPLACE VIEW vw_top_products_30d AS
SELECT p.product_key,
       p.product_name,
       p.category,
       SUM(f.line_amount_cents)/100.0 AS revenue_usd,
       SUM(f.qty) AS units
FROM fact_sales f
JOIN dim_product p ON p.product_key = f.product_key
WHERE f.order_status IN ('PAID','READY','COMPLETED')
  AND f.date_key >= (CURRENT_DATE - INTERVAL 30 DAY)
GROUP BY p.product_key, p.product_name, p.category
ORDER BY revenue_usd DESC;
