-- 07_indexes.sql
USE mocha_madness_v4;

CREATE INDEX idx_items_order_product ON order_items(order_id, product_id);
CREATE INDEX idx_payments_status_provider ON payments(status, provider);
CREATE INDEX idx_orders_created_status ON orders(created_at, status);

-- EXPLAIN example (run before and after creating indexes)
EXPLAIN
SELECT o.order_id, o.created_at, SUM(oi.price_cents) AS line_total
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.created_at >= CURRENT_DATE - INTERVAL 60 DAY
  AND o.status IN ('PAID','READY','COMPLETED')
GROUP BY o.order_id, o.created_at
ORDER BY o.created_at DESC;
