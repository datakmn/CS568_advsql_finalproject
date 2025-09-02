-- 02_sample_oltp_data.sql
USE mocha_madness_v4;

INSERT INTO customers (email, first_name, last_name, phone, created_at)
SELECT CONCAT('extra', n, '@example.com'),
       CONCAT('Extra', n),
       'User',
       CONCAT('+1-555-09', LPAD(n,2,'0')),
       NOW() - INTERVAL (n*3) DAY
FROM (
  SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
  UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10
) AS seq
ON DUPLICATE KEY UPDATE email = email;
