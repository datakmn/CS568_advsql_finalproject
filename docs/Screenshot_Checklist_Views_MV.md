# Views & Materialized View — Evidence Without Screenshots
_Date: September 02, 2025_

## Regular views
- **`vw_daily_sales`** — daily totals (revenue, units) filtered to revenue statuses.  
- **`vw_top_products_30d`** — best sellers in the last 30 days.

**Why views?** Reuse, security (expose only what’s needed), and consistent definitions across teams.

## “Materialized” view
- **Table:** `mv_monthly_product_sales` with `(year, month, product_key)` PK.  
- **Refresh:** `CALL sp_refresh_mv_monthly_product_sales();`  
- **Optional event:** nightly at 02:00 (requires `@@event_scheduler = ON`).

## Quick SQL proofs (text only)
```sql
-- Views exist
SHOW FULL TABLES IN mocha_dw WHERE Table_type='VIEW';

-- MV table exists
SHOW CREATE TABLE mocha_dw.mv_monthly_product_sales\G

-- Refresh proc exists
SHOW PROCEDURE STATUS WHERE Db='mocha_dw' AND Name='sp_refresh_mv_monthly_product_sales';
SHOW CREATE PROCEDURE mocha_dw.sp_refresh_mv_monthly_product_sales\G
```
