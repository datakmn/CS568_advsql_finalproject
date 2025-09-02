# Materialized View (Simulated) — What / When / How
_Date: September 02, 2025_

MySQL doesn’t have native materialized views. We simulate one with a **table** plus a **refresh stored procedure** (and optional **EVENT**).

## What
**Table:** `mocha_dw.mv_monthly_product_sales`  
Grain: one row per **year × month × product** with `revenue_usd` and `units`.

**Refresh procedure:** `sp_refresh_mv_monthly_product_sales()`  
Logic:
```sql
CREATE TEMPORARY TABLE _mv AS
SELECT d.year, d.month, f.product_key,
       ROUND(SUM(f.line_amount_cents)/100.0, 2) AS revenue_usd,
       SUM(f.qty) AS units
FROM fact_sales f
JOIN dim_date d ON d.date_key = f.date_key
WHERE f.order_status IN ('PAID','READY','COMPLETED')
GROUP BY d.year, d.month, f.product_key;

INSERT INTO mv_monthly_product_sales (year, month, product_key, revenue_usd, units)
SELECT year, month, product_key, revenue_usd, units FROM _mv
ON DUPLICATE KEY UPDATE revenue_usd = VALUES(revenue_usd),
                        units = VALUES(units);
```

## When
- Before month-end reporting or dashboards
- After backfills or schema changes
- Nightly automation at **02:00** (optional EVENT) if permissions allow

## How (options)
- **Manual:**  
  ```sql
  CALL mocha_dw.sp_refresh_mv_monthly_product_sales();
  ```
- **Scheduled:**  
  ```sql
  SET GLOBAL event_scheduler = ON; -- if permitted
  -- Event defined in 06_materialized_view.sql
  ```

## Validation (no screenshots required)
- Compare a product-month between `mv_monthly_product_sales` and an ad-hoc aggregation from `fact_sales`.  
- Sanity counts: # of product-month rows should equal the number of months × distinct products with sales.

## Why this approach
- Keeps **OLAP queries fast** for month-level reports.  
- isolates heavy aggregations from the OLTP system.  
- Refresh is deterministic and auditable.
