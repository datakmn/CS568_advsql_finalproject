# End-to-End Rationale
_Date: September 02, 2025_

## Separation of concerns: OLTP vs OLAP
- OLTP handles **writes and integrity** (orders, items, stock, payments).  
- OLAP handles **reads and analytics** (facts/dims, pre-aggregations).  
- This separation avoids contention and allows purpose-built schemas.

## Scripts overview
1. **01_create_oltp.sql** — schema + base data for day-to-day operations.  
2. **02_sample_oltp_data.sql** — optional extras to reach meaningful row counts.  
3. **03_triggers.sql** — enforces business rules at the database tier.  
4. **04_olap_schema.sql** — star schema with fact at **order-line** grain (PK=`order_item_id`).  
5. **05_views.sql** — canonical analytical views for reuse and simplicity.  
6. **06_materialized_view.sql** — pre-aggregated monthly product metrics + refresh proc (optional event).  
7. **07_indexes.sql** — targeted indexes aligned with common workloads.  
8. **08_procedures_transactions.sql** — transactional order placement with locks and error handling.  
9. **09_demo_queries.sql** — 10+ analytic queries with business value.

## Why the fact grain is order-line
- Prevents PK collisions when the same product appears on multiple lines within an order.  
- Preserves detail for auditing, anomaly detection, and drill-through.

## Why triggers
- Ensure **inventory correctness** and **audit trails** even if app code misbehaves.  
- Reduce race conditions by centralizing side-effects.

## Why a simulated MV
- Month-end reporting is heavy; pre-aggregate once and read many times.  
- Clean refresh semantics (manual or scheduled) with simple validation.

## Query rationale (high level)
- Daily sales & MoM trends → staffing and purchasing decisions.  
- Top products & price bands → merchandising and pricing strategy.  
- New vs returning & LTV → acquisition vs retention focus.  
- Pareto analysis → identify the vital few products driving most revenue.
