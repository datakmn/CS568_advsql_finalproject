-- Set default schema to OLTP
USE mocha_madness_v4;

-- See if the proc exists anywhere (just in case it was created in another DB)
SELECT ROUTINE_SCHEMA, ROUTINE_NAME
FROM information_schema.ROUTINES
WHERE ROUTINE_TYPE='PROCEDURE'
  AND ROUTINE_NAME='sp_place_order';

-- Step 2 — Create the procedure
USE mocha_madness_v4;
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_place_order $$
CREATE PROCEDURE sp_place_order(
  IN p_customer_id INT,
  IN p_assigned_employee_id INT,
  IN p_items_json JSON  -- e.g. '[{"product_id":1,"qty":2},{"product_id":4,"qty":1}]'
)
BEGIN
  DECLARE v_order_id INT;
  DECLARE v_insufficient INT DEFAULT 0;

  START TRANSACTION;

  -- Stage request
  CREATE TEMPORARY TABLE IF NOT EXISTS _req_items (
    product_id INT NOT NULL,
    qty INT NOT NULL,
    price_each_cents INT NOT NULL DEFAULT 0,
    PRIMARY KEY(product_id)
  ) ENGINE=MEMORY;

  TRUNCATE TABLE _req_items;

  INSERT INTO _req_items(product_id, qty)
  SELECT jt.product_id, jt.qty
  FROM JSON_TABLE(p_items_json, '$[*]' COLUMNS(
         product_id INT PATH '$.product_id',
         qty        INT PATH '$.qty'
       )) AS jt;

  -- Hydrate prices (read-only)
  UPDATE _req_items r
  JOIN products p ON p.product_id = r.product_id
  SET r.price_each_cents = p.price_cents;

  -- Create order header
  INSERT INTO orders(customer_id, status, total_cents, assigned_employee_id, notes)
  VALUES(p_customer_id, 'PENDING', 0, p_assigned_employee_id, 'Placed via sp_place_order');
  SET v_order_id = LAST_INSERT_ID();

  -- Lock only needed product rows (prevents race conditions)
  SELECT p.product_id
  FROM products p
  JOIN _req_items r ON r.product_id = p.product_id
  FOR UPDATE;

  -- Stock check while locked
  SELECT COUNT(*) INTO v_insufficient
  FROM products p
  JOIN _req_items r ON r.product_id = p.product_id
  WHERE p.stock < r.qty;

  IF v_insufficient > 0 THEN
    ROLLBACK;
    DROP TEMPORARY TABLE IF EXISTS _req_items;
    SELECT 'FAILED_INSUFFICIENT_STOCK' AS result, NULL AS order_id;
  ELSE
    -- Insert order lines WITHOUT joining products here (so trigger can update products)
    INSERT INTO order_items(order_id, product_id, qty, price_cents)
    SELECT v_order_id, r.product_id, r.qty, (r.price_each_cents * r.qty)
    FROM _req_items r;

    -- Update order header total from staged data
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

-- Step 3 - Verification
SHOW CREATE PROCEDURE mocha_madness_v4.sp_place_order;


-- Step 4 - Quick Test
-- Pick a real product with stock > 0
SELECT product_id, name, stock FROM products ORDER BY stock DESC LIMIT 5;

-- Set the one you’ll use
SET @pid := 1;  -- change to a product_id from the query above

-- Success path (should return SUCCESS + an order_id)
CALL sp_place_order(1, 1, JSON_ARRAY(JSON_OBJECT('product_id', @pid, 'qty', 1)));

-- Force rollback (should return FAILED_INSUFFICIENT_STOCK)
CALL sp_place_order(1, 1, JSON_ARRAY(JSON_OBJECT('product_id', @pid, 'qty', 999999)));

-- ****************************************

USE mocha_madness_v4;

-- 0) Clean up any leftover temp table in your session
DROP TEMPORARY TABLE IF EXISTS _req_items;

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

  -- Always start with a fresh temp table (prevents column mismatch)
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

  -- Fill unit prices (read-only)
  UPDATE _req_items r
  JOIN products p ON p.product_id = r.product_id
  SET r.price_each_cents = p.price_cents;

  -- Create order header
  INSERT INTO orders(customer_id, status, total_cents, assigned_employee_id, notes)
  VALUES (p_customer_id, 'PENDING', 0, p_assigned_employee_id, 'Placed via sp_place_order');
  SET v_order_id = LAST_INSERT_ID();

  -- Lock the needed product rows
  SELECT p.product_id
  FROM products p
  JOIN _req_items r ON r.product_id = p.product_id
  FOR UPDATE;

  -- Stock check while locked
  SELECT COUNT(*) INTO v_insufficient
  FROM products p
  JOIN _req_items r ON r.product_id = p.product_id
  WHERE p.stock < r.qty;

  IF v_insufficient > 0 THEN
    ROLLBACK;
    DROP TEMPORARY TABLE IF EXISTS _req_items;
    SELECT 'FAILED_INSUFFICIENT_STOCK' AS result, NULL AS order_id;
  ELSE
    -- Insert lines WITHOUT joining products (keeps trigger legal)
    INSERT INTO order_items(order_id, product_id, qty, price_cents)
    SELECT v_order_id, r.product_id, r.qty, (r.price_each_cents * r.qty)
    FROM _req_items r;

    -- Update order total from staged data
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

-- Pick a product with stock > 0
SELECT product_id, name, stock FROM products ORDER BY stock DESC LIMIT 5;
SET @pid := 1;  -- change to a real product_id

CALL sp_place_order(1, 1, JSON_ARRAY(JSON_OBJECT('product_id', @pid, 'qty', 1)));
