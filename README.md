# Mini Data Warehouse – Mocha Madness (MySQL 8.0)

## How to run in MySQL Workbench
1. Run `sql/01_create_oltp.sql` (loads OLTP schema/data).
2. (Optional) Run `sql/02_sample_oltp_data.sql` (adds sample customers).
3. Run `sql/03_triggers.sql` (audit + inventory + payment triggers).
4. Run `sql/04_olap_schema.sql` (creates `mocha_dw` and loads dimensions + fact with `order_item_id` PK).
5. Run `sql/05_views.sql` (reporting views).
6. Run `sql/06_materialized_view.sql` (MV table + refresh proc; optional nightly event, may require `SET GLOBAL event_scheduler = ON;`).
7. Run `sql/07_indexes.sql` (create 3 helpful indexes; capture EXPLAIN before/after).
8. Run `sql/08_procedures_transactions.sql` (installs `sp_place_order` transaction proc).
9. Run `sql/09_demo_queries.sql` (10+ queries with business rationale in docs).

**Schemas:** OLTP = `mocha_madness_v4`, OLAP = `mocha_dw`.
**Assumptions:** MySQL 8.0+, JSON_TABLE available.
