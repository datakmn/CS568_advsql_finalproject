# OLAP Design Notes — Star Schema
_Date: September 02, 2025_

## Objectives
- Enable fast analytics and BI (daily sales, top products, MoM trends, new vs returning customers).  
- Keep OLTP write path separate from reporting workloads.

## Grain (most important choice)
**One row in the fact = one order line (`order_item_id`).**  
This preserves atomicity, avoids duplicate keys when an order repeats a product, and supports audit-level drill-through.

## Tables

### Fact: `mocha_dw.fact_sales`
- **PK:** `order_item_id` (from OLTP)  
- **FKs:** `date_key` (DATE), `product_key` (INT), `customer_key` (INT, nullable), `order_id` (INT)  
- **Measures:** `qty`, `line_amount_cents`  
- **Status:** `order_status` (to filter to revenue statuses `PAID|READY|COMPLETED`)  
- **Indexes:** `(date_key)`, `(product_key)`, `(customer_key)`, `idx_fs_order(order_id)`

### Dimensions
- **`dim_date`** (`date_key` DATE PK): `day_of_week`, `week_of_year`, `month`, `month_name`, `quarter`, `year`  
- **`dim_product`** (`product_key` = `products.product_id`): `product_name`, `category`, `current_price_cents`  
  - **SCD policy:** SCD-1 (overwrite). SCD-2 is a good future enhancement for price history.  
- **`dim_customer`** (`customer_key` = `customers.customer_id`): `email`, `first_name`, `last_name` (nullable key in fact for guest orders)

## ETL Overview
1. **Build date spine** from `orders.created_at` → fill `dim_date`.  
2. **Upsert** products/customers into dims with `ON DUPLICATE KEY UPDATE`.  
3. **Load fact** from `order_items` JOIN `orders` with:  
   ```sql
   INSERT INTO mocha_dw.fact_sales
     (order_item_id, date_key, product_key, customer_key, order_id, qty, line_amount_cents, order_status)
   SELECT oi.order_item_id, DATE(o.created_at), oi.product_id, o.customer_id,
          oi.order_id, oi.qty, oi.price_cents, o.status
   FROM mocha_madness_v4.order_items oi
   JOIN mocha_madness_v4.orders o ON o.order_id = oi.order_id;
   ```

## Design choices
- **Natural keys** from OLTP (product_id, customer_id) simplify lineage and drill-through.  
- **Nullable customer_key** keeps guest/unknown orders without synthetic customers.  
- **Order status** in fact allows reusable revenue filters without JOINing the header every time.

## Query patterns
- Time series (daily, weekly, monthly), category mix, LTV, cohort (new vs returning), Pareto analysis.  
- Views provide canonical forms (`vw_daily_sales`, `vw_top_products_30d`).  
- Simulated MV (`mv_monthly_product_sales`) provides fast month-end reporting.

## Future improvements
- SCD-2 for product pricing history.  
- Additional dimensions: `dim_employee` for staffing analytics; `dim_store` if multi-location.
