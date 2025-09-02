-- 04_olap_schema.sql  (Corrected grain & PK)
CREATE SCHEMA IF NOT EXISTS mocha_dw;
USE mocha_dw;

CREATE TABLE IF NOT EXISTS dim_date (
  date_key DATE PRIMARY KEY,
  day_of_week TINYINT NOT NULL,
  week_of_year TINYINT NOT NULL,
  month TINYINT NOT NULL,
  month_name VARCHAR(10) NOT NULL,
  quarter TINYINT NOT NULL,
  year SMALLINT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS dim_product (
  product_key INT PRIMARY KEY,
  product_name VARCHAR(150) NOT NULL,
  category ENUM('coffee','tea','food','other') NOT NULL,
  current_price_cents INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS dim_customer (
  customer_key INT PRIMARY KEY,
  email VARCHAR(255) NOT NULL,
  first_name VARCHAR(100),
  last_name  VARCHAR(100)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS fact_sales;
CREATE TABLE fact_sales (
  order_item_id INT NOT NULL,
  date_key DATE NOT NULL,
  product_key INT NOT NULL,
  customer_key INT,
  order_id INT NOT NULL,
  qty INT NOT NULL,
  line_amount_cents INT NOT NULL,
  order_status ENUM('PENDING','PAID','IN_PROGRESS','READY','COMPLETED','CANCELLED') NOT NULL,
  PRIMARY KEY (order_item_id),
  KEY (product_key),
  KEY (customer_key),
  KEY (date_key),
  KEY idx_fs_order (order_id)
) ENGINE=InnoDB;

-- ===== ETL =====
USE mocha_madness_v4;

DROP TEMPORARY TABLE IF EXISTS _dates;
CREATE TEMPORARY TABLE _dates AS
SELECT DATE(created_at) AS d FROM orders GROUP BY DATE(created_at);

INSERT IGNORE INTO mocha_dw.dim_date
SELECT d AS date_key,
       DAYOFWEEK(d),
       WEEK(d, 3),
       MONTH(d),
       DATE_FORMAT(d, '%b'),
       QUARTER(d),
       YEAR(d)
FROM _dates;

INSERT INTO mocha_dw.dim_product (product_key, product_name, category, current_price_cents)
SELECT p.product_id, p.name, p.category, p.price_cents
FROM products p
ON DUPLICATE KEY UPDATE
  product_name = VALUES(product_name),
  category = VALUES(category),
  current_price_cents = VALUES(current_price_cents);

INSERT INTO mocha_dw.dim_customer (customer_key, email, first_name, last_name)
SELECT c.customer_id, c.email, c.first_name, c.last_name
FROM customers c
ON DUPLICATE KEY UPDATE
  email = VALUES(email),
  first_name = VALUES(first_name),
  last_name = VALUES(last_name);

TRUNCATE TABLE mocha_dw.fact_sales;
INSERT INTO mocha_dw.fact_sales
  (order_item_id, date_key, product_key, customer_key, order_id, qty, line_amount_cents, order_status)
SELECT
  oi.order_item_id,
  DATE(o.created_at),
  oi.product_id,
  o.customer_id,
  oi.order_id,
  oi.qty,
  oi.price_cents,
  o.status
FROM order_items oi
JOIN orders o ON o.order_id = oi.order_id;
