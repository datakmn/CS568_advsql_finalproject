-- 03_triggers.sql
USE mocha_madness_v4;
DELIMITER $$

-- Customer audit triggers
DROP TRIGGER IF EXISTS trg_customer_insert $$
CREATE TRIGGER trg_customer_insert
AFTER INSERT ON customers FOR EACH ROW
BEGIN
  INSERT INTO customer_audit(customer_id, action_type, changed_by, new_email)
  VALUES (NEW.customer_id, 'INSERT', CURRENT_USER(), NEW.email);
END $$

DROP TRIGGER IF EXISTS trg_customer_update $$
CREATE TRIGGER trg_customer_update
AFTER UPDATE ON customers FOR EACH ROW
BEGIN
  INSERT INTO customer_audit(customer_id, action_type, changed_by, old_email, new_email)
  VALUES (NEW.customer_id, 'UPDATE', CURRENT_USER(), OLD.email, NEW.email);
END $$

DROP TRIGGER IF EXISTS trg_customer_delete $$
CREATE TRIGGER trg_customer_delete
AFTER DELETE ON customers FOR EACH ROW
BEGIN
  INSERT INTO customer_audit(customer_id, action_type, changed_by, old_email)
  VALUES (OLD.customer_id, 'DELETE', CURRENT_USER(), OLD.email);
END $$

-- Order item trigger: decrement stock + inventory movement
DROP TRIGGER IF EXISTS trg_items_after_insert $$
CREATE TRIGGER trg_items_after_insert
AFTER INSERT ON order_items FOR EACH ROW
BEGIN
  UPDATE products SET stock = stock - NEW.qty WHERE product_id = NEW.product_id;
  INSERT INTO inventory_movements(product_id, delta, reason, ref_order_id)
  VALUES(NEW.product_id, -NEW.qty, 'SALE', NEW.order_id);
END $$

-- Payment trigger: mark order PAID when payment status becomes SUCCEEDED
DROP TRIGGER IF EXISTS trg_payment_after_update $$
CREATE TRIGGER trg_payment_after_update
AFTER UPDATE ON payments FOR EACH ROW
BEGIN
  IF NEW.status = 'SUCCEEDED' AND OLD.status <> 'SUCCEEDED' THEN
    UPDATE orders SET status = 'PAID' WHERE order_id = NEW.order_id;
  END IF;
END $$

DELIMITER ;
