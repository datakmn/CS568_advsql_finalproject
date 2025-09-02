# Index Report — Rationale & Observations
_Date: September 02, 2025_

We add three targeted indexes to support common filters/joins/sorts.

## Indexes created
1. **`order_items(order_id, product_id)`**
   - **Why:** Common join path `orders → order_items` and per-order rollups.
   - **Impact:** Reduces join cost and enables index scan on `oi.order_id`.

2. **`payments(status, provider)`**
   - **Why:** Typical reporting filters by payment status and provider (success rates, splits).
   - **Impact:** Indexable predicates improve selectivity and reduce full scans.

3. **`orders(created_at, status)`**
   - **Why:** Many queries use a **recent time window** and filter by **revenue statuses**; also sort by `created_at DESC`.
   - **Impact:** Range scan on `created_at` plus filter on `status`; supports ordering with minimal filesort.

## Example query (used for EXPLAIN before/after)
```sql
EXPLAIN
SELECT o.order_id, o.created_at, SUM(oi.price_cents) AS line_total
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.created_at >= CURRENT_DATE - INTERVAL 60 DAY
  AND o.status IN ('PAID','READY','COMPLETED')
GROUP BY o.order_id, o.created_at
ORDER BY o.created_at DESC;
```

## What to look for in EXPLAIN (textual)
- **Before:** `type=ALL` / full table scan on `orders`; possible temp/filesort; join via full scan on `order_items`.
- **After:** `type=range` on `orders` using `idx_orders_created_status`; join via `ref` or `eq_ref` using `idx_items_order_product`; reduced “rows” estimates and improved key usage.

## Notes
- Indexes should match **WHERE/JOIN/ORDER BY**.  
- Avoid over-indexing write-heavy tables; measure real workloads.
