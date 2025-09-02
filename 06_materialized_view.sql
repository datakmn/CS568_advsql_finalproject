-- 06_materialized_view.sql
USE mocha_dw;

CREATE TABLE IF NOT EXISTS mv_monthly_product_sales (
  year SMALLINT NOT NULL,
  month TINYINT NOT NULL,
  product_key INT NOT NULL,
  revenue_usd DECIMAL(12,2) NOT NULL,
  units INT NOT NULL,
  PRIMARY KEY (year, month, product_key)
) ENGINE=InnoDB;

DELIMITER $$
CREATE PROCEDURE sp_refresh_mv_monthly_product_sales()
BEGIN
  CREATE TEMPORARY TABLE _mv AS
  SELECT d.year, d.month,
         f.product_key,
         ROUND(SUM(f.line_amount_cents)/100.0, 2) AS revenue_usd,
         SUM(f.qty) AS units
  FROM fact_sales f
  JOIN dim_date d ON d.date_key = f.date_key
  WHERE f.order_status IN ('PAID','READY','COMPLETED')
  GROUP BY d.year, d.month, f.product_key;

  INSERT INTO mv_monthly_product_sales (year, month, product_key, revenue_usd, units)
  SELECT year, month, product_key, revenue_usd, units FROM _mv
  ON DUPLICATE KEY UPDATE
    revenue_usd = VALUES(revenue_usd),
    units = VALUES(units);
END$$
DELIMITER ;

-- Optional nightly event at 02:00
DROP EVENT IF EXISTS ev_refresh_mv_monthly_product_sales;
CREATE EVENT ev_refresh_mv_monthly_product_sales
ON SCHEDULE EVERY 1 DAY STARTS (CURRENT_DATE + INTERVAL 2 HOUR)
DO CALL sp_refresh_mv_monthly_product_sales();
