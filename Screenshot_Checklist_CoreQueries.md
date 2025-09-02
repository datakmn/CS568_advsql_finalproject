# Core Queries — Coverage Guide (No Screenshots)
_Date: September 02, 2025_

This section lists representative queries that satisfy each rubric area and why each is useful.

## Joins
- **INNER JOIN:** MoM revenue by category → combines fact with date & product dims.  
- **LEFT JOIN:** Customers without orders → support churn/outreach lists.  
- **RIGHT JOIN:** Products with no sales → catalog clean-up and inventory strategy.

## Aggregations
- GROUP BY over time and category; **HAVING** to filter aggregated results (e.g., price bands with non-zero units).

## CTEs / Subqueries
- **CTE (`WITH`)** for first-order date and cohorting (new vs returning).  
- **Subquery** to compare each customer’s spend vs average.

## Functions
- **Date:** `DAYOFWEEK`, `WEEK`, `MONTH`, `QUARTER` for time slicing.  
- **String:** `CONCAT`, `UPPER` for presentation/grouping.  
- **Numeric:** `ROUND` for currency, boolean sums for ratios (e.g., attachment rate).

## Example SQL snippets
```sql
-- LEFT JOIN: customers without orders
SELECT c.customer_id, c.email
FROM mocha_madness_v4.customers c
LEFT JOIN mocha_madness_v4.orders o ON o.customer_id = c.customer_id
WHERE o.order_id IS NULL;

-- CTE: new vs returning
WITH first_order AS (
  SELECT customer_key, MIN(date_key) AS first_date
  FROM mocha_dw.fact_sales GROUP BY customer_key
)
SELECT CASE WHEN f.date_key = fo.first_date THEN 'NEW' ELSE 'RETURNING' END AS cohort,
       COUNT(DISTINCT f.order_id) AS orders,
       ROUND(SUM(f.line_amount_cents)/100.0,2) AS revenue_usd
FROM mocha_dw.fact_sales f
JOIN first_order fo ON fo.customer_key = f.customer_key
WHERE f.order_status IN ('PAID','READY','COMPLETED')
GROUP BY cohort;
```
