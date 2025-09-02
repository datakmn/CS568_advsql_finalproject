# OLTP ERD & Data Integrity Notes
_Date: September 02, 2025_

This document explains the OLTP schema for **Mocha Madness** and the design choices that enforce integrity and support the OLAP pipeline.

## Entities (tables)

### 1) `customers`
- **PK:** `customer_id` (INT AUTO_INCREMENT)
- **Columns:** `email` (UNIQUE), `first_name`, `last_name`, `phone`, `created_at`
- **Purpose:** customer master for orders and analytics
- **Integrity:** `email` uniqueness prevents duplicates; timestamps support recency queries

### 2) `employees`
- **PK:** `employee_id`
- **Columns:** `first_name`, `last_name`, `role` (ENUM), `is_active` (TINYINT), `current_load`, `created_at`
- **Purpose:** optional assignment target for orders (barista/manager)

### 3) `orders`
- **PK:** `order_id`
- **FKs:** 
  - `customer_id → customers.customer_id` (**NULL OK** to allow guest/unknown orders)
  - `assigned_employee_id → employees.employee_id` (**NULL OK**, **ON DELETE SET NULL**)
- **Columns:** `status` (ENUM: `PENDING|PAID|IN_PROGRESS|READY|COMPLETED|CANCELLED`), `total_cents`, `notes`, `created_at`, `updated_at`
- **Purpose:** header row for a cart/checkout

### 4) `order_items`
- **PK:** `order_item_id`
- **FKs:** 
  - `order_id → orders.order_id` (**NOT NULL**, **ON DELETE CASCADE**)
  - `product_id → products.product_id` (**NOT NULL**)
- **Columns:** `qty` (CHECK qty > 0 if present), `price_cents` (line total)
- **Purpose:** line-level items that become **fact rows** in OLAP

### 5) `products`
- **PK:** `product_id`
- **Columns:** `name`, `category` (ENUM: `coffee|tea|food|other`), `price_cents`, `sku` (UNIQUE), `stock`, `is_active`, `created_at`
- **Purpose:** sellable items with current inventory

### 6) `payments`
- **PK:** `payment_id`
- **FK:** `order_id → orders.order_id` (**NOT NULL**, **ON DELETE CASCADE**)
- **Columns:** `provider` (ENUM: `STRIPE|PAYPAL|CASH|CARD`), `status` (ENUM), `amount_cents`, `txn_ref`, `method`, `created_at`

### 7) `inventory_movements`
- **PK:** `movement_id`
- **FK:** `product_id → products.product_id` (**NOT NULL**)
- **Columns:** `delta` (signed), `reason` (e.g., `SALE`, `ADJUSTMENT`, `STOCKTAKE`), `ref_order_id` (informational), `created_at`
- **Purpose:** audit trail for stock changes

### 8) `customer_audit`
- **PK:** `audit_id`
- **Columns:** `customer_id`, `action_type` (`INSERT|UPDATE|DELETE`), `changed_by`, `old_email`, `new_email`, `action_time`
- **Purpose:** data-change history for customers (trigger-populated)

## Relationships (crow’s-foot)

- **customers 1—0..*** orders (optional on orders; guest orders allowed)  
- **employees 1—0..*** orders (optional; **ON DELETE SET NULL**)  
- **orders 1—0..*** order_items (**ON DELETE CASCADE**)  
- **products 1—0..*** order_items  
- **orders 1—0..*** payments (**ON DELETE CASCADE**)  
- **products 1—0..*** inventory_movements  
- **inventory_movements — orders** via `ref_order_id` (no FK; informational)  
- **customers — customer_audit** (no FK; populated by triggers)

## Triggers (why they exist)

- **Customer audit (AFTER INSERT/UPDATE/DELETE)** → immutable history of changes for compliance & debugging.  
- **Order item (AFTER INSERT)** → decrements `products.stock` and inserts an `inventory_movements` row, ensuring inventory is always in sync with sales.  
- **Payment (AFTER UPDATE)** → when a payment becomes `SUCCEEDED`, flag `orders.status = PAID` automatically.

## Integrity & domain controls

- **ENUMs** provide lightweight domain constraints in MySQL.  
- **ON DELETE CASCADE** on `order_items` and `payments` prevents orphans when an order is removed.  
- **UNIQUE** on `customers.email` and `products.sku` prevents dupes.  
- **Timestamps** support rolling-window queries and ETL.

## Rationale highlights

- Optional FKs in `orders` let the system record walk-in/guest orders.  
- Inventory is **event-sourced** via `inventory_movements` so stock can be reconstructed.  
- Triggers enforce critical rules even if application code fails to apply them.
