-- LEFT JOIN (customers with no orders):
SELECT c.customer_id, c.email
FROM mocha_madness_v4.customers c
LEFT JOIN mocha_madness_v4.orders o
       ON o.customer_id = c.customer_id
WHERE o.order_id IS NULL
LIMIT 20;

-- Aggregations (GROUP BY, HAVING)
-- GROUP BY + HAVING (already in #7 “Price band performance”):
USE mocha_dw;
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

-- Subqueries / CTEs (WITH)
-- CTE (already in #5 “New vs returning customers”):
USE mocha_dw;
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


-- Functions (date, string, numeric) & Date Funcitons
USE mocha_dw;
SELECT
  CASE WHEN d.day_of_week IN (1,7) THEN 'Weekend' ELSE 'Weekday' END AS day_type,
  ROUND(SUM(f.line_amount_cents)/100.0,2) AS revenue_usd
FROM fact_sales f
JOIN dim_date d ON d.date_key = f.date_key
WHERE f.order_status IN ('PAID','READY','COMPLETED')
GROUP BY day_type;
