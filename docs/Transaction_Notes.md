# Transaction & Concurrency Notes
_Date: September 02, 2025_

## Goal
Place an order atomically with **inventory checks** and **row-level locking** to prevent overselling.

## Procedure: `sp_place_order` (summary)
- **Inputs:** customer id, assigned employee id, cart as JSON (array of `{product_id, qty}`).  
- **Flow:**
  1. `START TRANSACTION`
  2. Stage JSON into a **temporary table** `_req_items` using `JSON_TABLE(...)`
  3. Snapshot prices into `_req_items.price_each_cents`
  4. Create order header (`status='PENDING'`)
  5. **Lock** only the needed product rows:  
     ```sql
     SELECT p.product_id
     FROM products p JOIN _req_items r ON r.product_id = p.product_id
     FOR UPDATE;
     ```
  6. **Stock check** while locked → if any insufficient, **ROLLBACK** and return `FAILED_INSUFFICIENT_STOCK`
  7. Insert `order_items` **without joining `products`** (avoids trigger conflicts)
  8. Compute total from staged prices; set `orders.status='PAID'`
  9. `COMMIT` and drop `_req_items`

## Why this design
- **ACID:** All-or-nothing order placement.  
- **Concurrency-safe:** `FOR UPDATE` prevents races when two sessions buy the same item.  
- **Trigger-friendly:** The AFTER INSERT trigger on `order_items` updates stock and logs the movement; we avoid reading `products` in that same statement to prevent MySQL error 1442.  
- **Deterministic totals:** Calculated from staged prices, so totals match inserted lines exactly.

## How to test (textual)
- **Success path:** pick a product with stock; call the proc with qty=1; verify order returns `SUCCESS`, stock decreased, and a `SALE` movement exists.  
- **Rollback path:** call with an absurd qty; expect `FAILED_INSUFFICIENT_STOCK`; stock unchanged; no new order.  
- **Concurrency:** Session A locks a product row with `SELECT ... FOR UPDATE`; Session B calls the proc and waits; after A commits, B succeeds — proving isolation.

## Isolation & deadlocks
- Default isolation (REPEATABLE READ) is acceptable; `FOR UPDATE` promotes write-intent locks.  
- Keep the critical section short (lock → check → insert → commit) to minimize contention.
