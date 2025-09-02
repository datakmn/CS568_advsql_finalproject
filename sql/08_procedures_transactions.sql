-- 08_procedures_transactions.sql
USE mocha_madness_v4;
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_place_order $$
CREATE PROCEDURE sp_place_order(
  IN p_customer_id INT,
  IN p_assigned_employee_id INT,
  IN p_items_json JSON
)
BEGIN
  DECLARE v_order_id INT;
  DECLARE v_insufficient INT DEFAULT 0;

  START TRANSACTION;

  DROP TEMPORARY TABLE IF EXISTS _req_items;
  CREATE TEMPORARY TABLE _req_items (
    product_id INT NOT NULL,
    qty INT NOT NULL,
    price_each_cents INT NOT NULL DEFAULT 0,
    PRIMARY KEY (product_id)
  ) ENGINE=MEMORY;

  INSERT INTO _req_items(product_id, qty)
  SELECT jt.product_id, jt.qty
  FROM JSON_TABLE(p_items_json, '$[*]' COLUMNS(
         product_id INT PATH '$.product_id',
         qty        INT PATH '$.qty'
       )) jt;

  UPDATE _req_items r
  JOIN products p ON p.product_id = r.product_id
  SET r.price_each_cents = p.price_cents;

  INSERT INTO orders(customer_id, status, total_cents, assigned_employee_id, notes)
  VALUES (p_customer_id, 'PENDING', 0, p_assigned_employee_id, 'Placed via sp_place_order');
  SET v_order_id = LAST_INSERT_ID();

  SELECT p.product_id
  FROM products p
  JOIN _req_items r ON r.product_id = p.product_id
  FOR UPDATE;

  SELECT COUNT(*) INTO v_insufficient
  FROM products p
  JOIN _req_items r ON r.product_id = p.product_id
  WHERE p.stock < r.qty;

  IF v_insufficient > 0 THEN
    ROLLBACK;
    DROP TEMPORARY TABLE IF EXISTS _req_items;
    SELECT 'FAILED_INSUFFICIENT_STOCK' AS result, NULL AS order_id;
  ELSE
    INSERT INTO order_items(order_id, product_id, qty, price_cents)
    SELECT v_order_id, r.product_id, r.qty, (r.price_each_cents * r.qty)
    FROM _req_items r;

    UPDATE orders o
    JOIN (
      SELECT v_order_id AS order_id, SUM(price_each_cents * qty) AS total_cents
      FROM _req_items
    ) x ON x.order_id = o.order_id
    SET o.total_cents = x.total_cents,
        o.status = 'PAID';

    COMMIT;
    DROP TEMPORARY TABLE IF EXISTS _req_items;
    SELECT 'SUCCESS' AS result, v_order_id AS order_id;
  END IF;
END $$
DELIMITER ;
