-- MySQL dump 10.13  Distrib 8.0.42, for macos15 (arm64)
--
-- Host: localhost    Database: mocha_madness_v4
-- ------------------------------------------------------
-- Server version	8.0.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customer_audit`
--

DROP TABLE IF EXISTS `customer_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_audit` (
  `audit_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `action_type` varchar(10) DEFAULT NULL,
  `changed_by` varchar(100) DEFAULT NULL,
  `old_email` varchar(255) DEFAULT NULL,
  `new_email` varchar(255) DEFAULT NULL,
  `action_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`audit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_audit`
--

LOCK TABLES `customer_audit` WRITE;
/*!40000 ALTER TABLE `customer_audit` DISABLE KEYS */;
INSERT INTO `customer_audit` VALUES (1,34,'INSERT','root@localhost',NULL,'audit_demo@example.com','2025-08-27 01:13:36'),(2,34,'UPDATE','root@localhost','audit_demo@example.com','audit_demo2@example.com','2025-08-27 01:13:36'),(3,34,'DELETE','root@localhost','audit_demo2@example.com',NULL,'2025-08-27 01:13:36');
/*!40000 ALTER TABLE `customer_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'demo@customer.com','Demo','Customer','+1-555-0100','2025-08-15 02:57:08'),(2,'user1@example.com','First1','Last1','+1-555-0101','2024-11-29 02:29:25'),(3,'user2@example.com','First2','Last2','+1-555-0102','2024-11-12 02:29:25'),(4,'user3@example.com','First3','Last3','+1-555-0103','2024-12-13 02:29:25'),(5,'user4@example.com','First4','Last4','+1-555-0104','2025-07-11 01:29:25'),(6,'user5@example.com','First5','Last5','+1-555-0105','2025-02-19 02:29:25'),(7,'user6@example.com','First6','Last6','+1-555-0106','2025-06-22 01:29:25'),(8,'user7@example.com','First7','Last7','+1-555-0107','2025-04-28 01:29:25'),(9,'user8@example.com','First8','Last8','+1-555-0108','2025-07-23 01:29:25'),(10,'user9@example.com','First9','Last9','+1-555-0109','2025-03-07 02:29:25'),(11,'user10@example.com','First10','Last10','+1-555-0110','2025-08-04 01:29:25'),(12,'user11@example.com','First11','Last11','+1-555-0111','2024-10-12 01:29:25'),(13,'user12@example.com','First12','Last12','+1-555-0112','2025-06-29 01:29:25'),(14,'user13@example.com','First13','Last13','+1-555-0113','2025-06-27 01:29:25'),(15,'user14@example.com','First14','Last14','+1-555-0114','2025-04-26 01:29:25'),(16,'user15@example.com','First15','Last15','+1-555-0115','2025-06-28 01:29:25'),(17,'user16@example.com','First16','Last16','+1-555-0116','2024-11-11 02:29:25'),(18,'user17@example.com','First17','Last17','+1-555-0117','2025-03-15 01:29:25'),(19,'user18@example.com','First18','Last18','+1-555-0118','2024-10-15 01:29:25'),(20,'user19@example.com','First19','Last19','+1-555-0119','2024-09-12 01:29:25'),(21,'user20@example.com','First20','Last20','+1-555-0120','2025-06-27 01:29:25');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_customer_insert` AFTER INSERT ON `customers` FOR EACH ROW BEGIN
  INSERT INTO customer_audit(customer_id, action_type, changed_by, new_email)
  VALUES (NEW.customer_id, 'INSERT', CURRENT_USER(), NEW.email);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_customer_update` AFTER UPDATE ON `customers` FOR EACH ROW BEGIN
  INSERT INTO customer_audit(customer_id, action_type, changed_by, old_email, new_email)
  VALUES (NEW.customer_id, 'UPDATE', CURRENT_USER(), OLD.email, NEW.email);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_customer_delete` AFTER DELETE ON `customers` FOR EACH ROW BEGIN
  INSERT INTO customer_audit(customer_id, action_type, changed_by, old_email)
  VALUES (OLD.customer_id, 'DELETE', CURRENT_USER(), OLD.email);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `employee_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `role` enum('barista','cashier','manager') NOT NULL DEFAULT 'barista',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `current_load` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'Ava','Nguyen','barista',1,0,'2025-08-15 02:57:08'),(2,'Leo','Kim','barista',1,0,'2025-08-15 02:57:08'),(3,'Maya','Patel','barista',1,0,'2025-08-15 02:57:08');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_movements`
--

DROP TABLE IF EXISTS `inventory_movements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_movements` (
  `movement_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `delta` int NOT NULL,
  `reason` varchar(64) NOT NULL,
  `ref_order_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`movement_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `inventory_movements_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_movements`
--

LOCK TABLES `inventory_movements` WRITE;
/*!40000 ALTER TABLE `inventory_movements` DISABLE KEYS */;
INSERT INTO `inventory_movements` VALUES (8,1,-2,'SALE',1,'2025-08-20 01:37:29'),(9,2,-1,'SALE',1,'2025-08-20 01:37:29'),(10,3,-1,'SALE',1,'2025-08-20 01:37:29'),(11,4,-2,'SALE',1,'2025-08-20 01:37:29'),(12,1,-1,'SALE',2,'2025-08-20 01:37:29'),(13,2,-2,'SALE',2,'2025-08-20 01:37:29'),(14,4,-3,'SALE',2,'2025-08-20 01:37:29'),(15,3,-2,'SALE',3,'2025-08-20 01:37:29'),(16,1,-1,'SALE',3,'2025-08-20 01:37:29'),(17,4,-1,'SALE',3,'2025-08-20 01:37:29'),(18,2,-1,'SALE',4,'2025-08-20 01:37:29'),(19,3,-1,'SALE',4,'2025-08-20 01:37:29'),(20,4,-2,'SALE',4,'2025-08-20 01:37:29'),(21,1,-3,'SALE',5,'2025-08-20 01:37:29'),(22,2,-1,'SALE',5,'2025-08-20 01:37:29'),(23,3,-2,'SALE',5,'2025-08-20 01:37:29'),(24,4,-2,'SALE',6,'2025-08-20 01:37:29'),(25,1,-1,'SALE',6,'2025-08-20 01:37:29'),(26,2,-2,'SALE',6,'2025-08-20 01:37:29'),(27,3,-1,'SALE',7,'2025-08-20 01:37:29'),(28,4,-3,'SALE',7,'2025-08-20 01:37:29'),(29,1,-2,'SALE',7,'2025-08-20 01:37:29'),(30,2,-2,'SALE',8,'2025-08-20 01:37:29'),(31,3,-2,'SALE',8,'2025-08-20 01:37:29'),(32,4,-1,'SALE',8,'2025-08-20 01:37:29'),(33,1,-1,'SALE',9,'2025-08-20 01:37:29'),(34,2,-3,'SALE',9,'2025-08-20 01:37:29'),(35,3,-1,'SALE',9,'2025-08-20 01:37:29'),(36,4,-2,'SALE',10,'2025-08-20 01:37:29'),(37,1,-2,'SALE',10,'2025-08-20 01:37:29'),(38,2,-1,'SALE',10,'2025-08-20 01:37:29'),(39,3,-3,'SALE',1,'2025-08-20 01:37:29'),(40,4,-1,'SALE',2,'2025-08-20 01:37:29'),(41,2,-2,'SALE',3,'2025-08-20 01:37:29'),(42,1,-2,'SALE',4,'2025-08-20 01:37:29'),(43,2,-3,'SALE',5,'2025-08-20 01:37:29'),(44,3,-1,'SALE',6,'2025-08-20 01:37:29'),(45,4,-2,'SALE',7,'2025-08-20 01:37:29'),(46,1,-1,'SALE',8,'2025-08-20 01:37:29'),(47,2,-1,'SALE',9,'2025-08-20 01:37:29'),(48,3,-2,'SALE',10,'2025-08-20 01:37:29'),(49,4,-3,'SALE',1,'2025-08-20 01:37:29'),(50,1,-1,'SALE',2,'2025-08-20 01:37:29'),(51,2,-2,'SALE',3,'2025-08-20 01:37:29'),(52,3,-1,'SALE',4,'2025-08-20 01:37:29'),(53,4,-2,'SALE',5,'2025-08-20 01:37:29'),(54,1,-3,'SALE',6,'2025-08-20 01:37:29');
/*!40000 ALTER TABLE `inventory_movements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `order_item_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `qty` int NOT NULL,
  `price_cents` int NOT NULL,
  `unit_price_cents` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`order_item_id`),
  KEY `product_id` (`product_id`),
  KEY `idx_items_order` (`order_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (11,1,1,2,990,495),(12,1,2,1,450,450),(13,1,3,1,525,525),(14,1,4,2,750,375),(15,2,1,1,495,495),(16,2,2,2,900,450),(17,2,4,3,1125,375),(18,3,3,2,1050,525),(19,3,1,1,495,495),(20,3,4,1,375,375),(21,4,2,1,450,450),(22,4,3,1,525,525),(23,4,4,2,750,375),(24,5,1,3,1485,495),(25,5,2,1,450,450),(26,5,3,2,1050,525),(27,6,4,2,750,375),(28,6,1,1,495,495),(29,6,2,2,900,450),(30,7,3,1,525,525),(31,7,4,3,1125,375),(32,7,1,2,990,495),(33,8,2,2,900,450),(34,8,3,2,1050,525),(35,8,4,1,375,375),(36,9,1,1,495,495),(37,9,2,3,1350,450),(38,9,3,1,525,525),(39,10,4,2,750,375),(40,10,1,2,990,495),(41,10,2,1,450,450),(42,1,3,3,1575,525),(43,2,4,1,375,375),(44,3,2,2,900,450),(45,4,1,2,990,495),(46,5,2,3,1350,450),(47,6,3,1,525,525),(48,7,4,2,750,375),(49,8,1,1,495,495),(50,9,2,1,450,450),(51,10,3,2,1050,525),(52,1,4,3,1125,375),(53,2,1,1,495,495),(54,3,2,2,900,450),(55,4,3,1,525,525),(56,5,4,2,750,375),(57,6,1,3,1485,495);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_items_after_insert` AFTER INSERT ON `order_items` FOR EACH ROW BEGIN
  UPDATE products SET stock = stock - NEW.qty WHERE product_id = NEW.product_id;
  INSERT INTO inventory_movements(product_id, delta, reason, ref_order_id)
  VALUES(NEW.product_id, -NEW.qty, 'SALE', NEW.order_id);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `status` enum('PENDING','PAID','IN_PROGRESS','READY','COMPLETED','CANCELLED') NOT NULL DEFAULT 'PENDING',
  `total_cents` int NOT NULL DEFAULT '0',
  `notes` varchar(255) DEFAULT NULL,
  `assigned_employee_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`),
  KEY `idx_orders_status` (`status`),
  KEY `idx_orders_customer` (`customer_id`),
  KEY `fk_orders_employee` (`assigned_employee_id`),
  CONSTRAINT `fk_orders_employee` FOREIGN KEY (`assigned_employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`assigned_employee_id`) REFERENCES `employees` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,'PENDING',1495,'Order note 1',2,'2025-07-30 01:26:22','2025-08-20 01:26:22'),(2,1,'PAID',1391,'Order note 2',3,'2025-07-14 01:26:22','2025-08-20 01:26:22'),(3,1,'PAID',1871,'Order note 3',3,'2025-07-30 01:26:22','2025-08-20 01:26:22'),(4,1,'IN_PROGRESS',900,'Order note 4',2,'2025-07-20 01:26:22','2025-08-20 01:26:22'),(5,1,'COMPLETED',970,'Order note 5',3,'2025-07-22 01:26:22','2025-08-20 01:26:22'),(6,1,'CANCELLED',1509,'Order note 6',1,'2025-08-09 01:26:22','2025-08-20 01:26:22'),(7,1,'COMPLETED',753,'Order note 7',2,'2025-08-16 01:26:22','2025-08-20 01:26:22'),(8,1,'CANCELLED',947,'Order note 8',2,'2025-07-30 01:26:22','2025-08-20 01:26:22'),(9,1,'READY',2501,'Order note 9',3,'2025-07-05 01:26:22','2025-08-20 01:26:22'),(10,1,'CANCELLED',1131,'Order note 10',2,'2025-08-08 01:26:22','2025-08-20 01:26:22'),(11,1,'PAID',2085,'Order note 11',1,'2025-07-29 01:26:22','2025-08-20 01:26:22'),(12,1,'PENDING',2358,'Order note 12',3,'2025-07-10 01:26:22','2025-08-20 01:26:22'),(13,1,'READY',654,'Order note 13',2,'2025-06-24 01:26:22','2025-08-20 01:26:22'),(14,1,'COMPLETED',3286,'Order note 14',3,'2025-07-30 01:26:22','2025-08-20 01:26:22'),(15,1,'COMPLETED',2917,'Order note 15',3,'2025-07-31 01:26:22','2025-08-20 01:26:22'),(16,1,'COMPLETED',2369,'Order note 16',1,'2025-08-20 01:26:22','2025-08-20 01:26:22'),(17,1,'IN_PROGRESS',3052,'Order note 17',2,'2025-07-29 01:26:22','2025-08-20 01:26:22'),(18,1,'READY',2697,'Order note 18',1,'2025-07-01 01:26:22','2025-08-20 01:26:22'),(19,1,'IN_PROGRESS',2763,'Order note 19',3,'2025-08-19 01:26:22','2025-08-20 01:26:22'),(20,1,'CANCELLED',3105,'Order note 20',3,'2025-07-15 01:26:22','2025-08-20 01:26:22'),(32,19,'PAID',785,'Order note 1',1,'2025-06-15 01:30:14','2025-08-20 01:30:14'),(33,19,'READY',2444,'Order note 2',1,'2025-08-12 01:30:14','2025-08-20 01:30:14'),(34,7,'IN_PROGRESS',925,'Order note 3',3,'2025-06-08 01:30:14','2025-08-20 01:30:14'),(35,1,'READY',2885,'Order note 4',2,'2025-07-20 01:30:14','2025-08-20 01:30:14'),(36,20,'CANCELLED',1209,'Order note 5',3,'2025-05-27 01:30:14','2025-08-20 01:30:14'),(37,18,'IN_PROGRESS',1934,'Order note 6',2,'2025-06-25 01:30:14','2025-08-20 01:30:14'),(38,16,'PENDING',2605,'Order note 7',3,'2025-06-30 01:30:14','2025-08-20 01:30:14'),(39,11,'PENDING',1470,'Order note 8',3,'2025-07-06 01:30:14','2025-08-20 01:30:14'),(40,15,'PENDING',3130,'Order note 9',3,'2025-06-28 01:30:14','2025-08-20 01:30:14'),(41,19,'CANCELLED',2093,'Order note 10',2,'2025-05-28 01:30:14','2025-08-20 01:30:14'),(42,14,'IN_PROGRESS',1294,'Order note 11',1,'2025-07-15 01:30:14','2025-08-20 01:30:14'),(43,4,'READY',2643,'Order note 12',3,'2025-07-26 01:30:14','2025-08-20 01:30:14'),(44,13,'PAID',2008,'Order note 13',3,'2025-08-03 01:30:14','2025-08-20 01:30:14'),(45,1,'IN_PROGRESS',1441,'Order note 14',2,'2025-08-08 01:30:14','2025-08-20 01:30:14'),(46,7,'PENDING',2579,'Order note 15',2,'2025-06-22 01:30:14','2025-08-20 01:30:14'),(47,4,'COMPLETED',1641,'Order note 16',3,'2025-08-12 01:30:14','2025-08-20 01:30:14'),(48,17,'CANCELLED',2482,'Order note 17',1,'2025-07-18 01:30:14','2025-08-20 01:30:14'),(49,11,'READY',937,'Order note 18',2,'2025-08-03 01:30:14','2025-08-20 01:30:14'),(50,18,'CANCELLED',1876,'Order note 19',1,'2025-08-19 01:30:14','2025-08-20 01:30:14'),(51,15,'READY',2021,'Order note 20',1,'2025-07-12 01:30:14','2025-08-20 01:30:14'),(52,11,'PAID',2066,'Order note 21',1,'2025-06-27 01:30:14','2025-08-20 01:30:14'),(53,4,'PENDING',649,'Order note 22',1,'2025-07-05 01:30:14','2025-08-20 01:30:14'),(54,2,'COMPLETED',2671,'Order note 23',2,'2025-07-17 01:30:14','2025-08-20 01:30:14'),(55,5,'PENDING',2373,'Order note 24',1,'2025-05-29 01:30:14','2025-08-20 01:30:14'),(56,2,'IN_PROGRESS',1230,'Order note 25',1,'2025-07-19 01:30:14','2025-08-20 01:30:14'),(57,13,'PENDING',2160,'Order note 26',3,'2025-08-18 01:30:14','2025-08-20 01:30:14'),(58,16,'CANCELLED',852,'Order note 27',1,'2025-07-24 01:30:14','2025-08-20 01:30:14'),(59,1,'PENDING',2578,'Order note 28',1,'2025-07-26 01:30:14','2025-08-20 01:30:14'),(60,10,'READY',1521,'Order note 29',1,'2025-07-18 01:30:14','2025-08-20 01:30:14'),(61,18,'PAID',3163,'Order note 30',3,'2025-08-05 01:30:14','2025-08-20 01:30:14'),(62,9,'COMPLETED',603,'Order note 31',2,'2025-05-26 01:30:14','2025-08-20 01:30:14'),(63,9,'PAID',793,'Order note 32',3,'2025-08-01 01:30:14','2025-08-20 01:30:14'),(64,6,'COMPLETED',2793,'Order note 33',3,'2025-07-27 01:30:14','2025-08-20 01:30:14'),(65,11,'COMPLETED',991,'Order note 34',3,'2025-06-16 01:30:14','2025-08-20 01:30:14'),(66,1,'CANCELLED',957,'Order note 35',2,'2025-08-14 01:30:14','2025-08-20 01:30:14'),(67,15,'READY',1135,'Order note 36',3,'2025-07-01 01:30:14','2025-08-20 01:30:14'),(68,4,'PAID',2086,'Order note 37',1,'2025-06-23 01:30:14','2025-08-20 01:30:14'),(69,8,'CANCELLED',2655,'Order note 38',3,'2025-07-13 01:30:14','2025-08-20 01:30:14'),(70,6,'PENDING',1803,'Order note 39',1,'2025-08-11 01:30:14','2025-08-20 01:30:14'),(71,11,'IN_PROGRESS',1547,'Order note 40',3,'2025-08-19 01:30:14','2025-08-20 01:30:14'),(72,11,'READY',2015,'Order note 41',3,'2025-08-20 01:30:14','2025-08-20 01:30:14'),(73,5,'PENDING',1875,'Order note 42',2,'2025-08-15 01:30:14','2025-08-20 01:30:14'),(74,15,'READY',1605,'Order note 43',2,'2025-07-03 01:30:14','2025-08-20 01:30:14'),(75,1,'IN_PROGRESS',591,'Order note 44',1,'2025-06-15 01:30:14','2025-08-20 01:30:14'),(76,2,'PENDING',1723,'Order note 45',3,'2025-07-16 01:30:14','2025-08-20 01:30:14'),(77,2,'PENDING',1873,'Order note 46',1,'2025-07-15 01:30:14','2025-08-20 01:30:14'),(78,9,'CANCELLED',1213,'Order note 47',3,'2025-05-26 01:30:14','2025-08-20 01:30:14'),(79,11,'READY',2136,'Order note 48',1,'2025-08-13 01:30:14','2025-08-20 01:30:14'),(80,18,'PENDING',2934,'Order note 49',1,'2025-06-05 01:30:14','2025-08-20 01:30:14'),(81,20,'PAID',2000,'Order note 50',3,'2025-08-18 01:30:14','2025-08-20 01:30:14'),(95,1,'PENDING',500,NULL,NULL,'2025-08-21 00:56:00','2025-08-21 00:56:00'),(96,1,'PENDING',895,NULL,1,'2025-08-21 00:56:16','2025-08-21 00:56:16'),(97,1,'PAID',2097,'Order note 1',1,'2025-07-10 00:56:20','2025-08-21 00:56:20'),(98,1,'COMPLETED',954,'Order note 2',1,'2025-07-11 00:56:20','2025-08-21 00:56:20'),(99,1,'PAID',1202,'Order note 3',2,'2025-07-27 00:56:20','2025-08-21 00:56:20'),(100,1,'PENDING',1746,'Order note 4',3,'2025-08-05 00:56:20','2025-08-21 00:56:20'),(101,1,'READY',3258,'Order note 5',1,'2025-08-09 00:56:20','2025-08-21 00:56:20'),(102,1,'IN_PROGRESS',1009,'Order note 6',1,'2025-07-20 00:56:20','2025-08-21 00:56:20'),(103,1,'READY',895,'Order note 7',1,'2025-06-30 00:56:20','2025-08-21 00:56:20'),(104,1,'READY',3261,'Order note 8',2,'2025-07-04 00:56:20','2025-08-21 00:56:20'),(105,1,'CANCELLED',1801,'Order note 9',2,'2025-08-08 00:56:20','2025-08-21 00:56:20'),(106,1,'IN_PROGRESS',2446,'Order note 10',1,'2025-07-17 00:56:20','2025-08-21 00:56:20'),(107,1,'READY',3026,'Order note 11',3,'2025-06-29 00:56:20','2025-08-21 00:56:20'),(108,1,'COMPLETED',2522,'Order note 12',2,'2025-08-18 00:56:20','2025-08-21 00:56:20'),(109,1,'PAID',1729,'Order note 13',2,'2025-07-22 00:56:20','2025-08-21 00:56:20'),(110,1,'IN_PROGRESS',1749,'Order note 14',1,'2025-07-19 00:56:20','2025-08-21 00:56:20'),(111,1,'PENDING',681,'Order note 15',1,'2025-07-25 00:56:20','2025-08-21 00:56:20'),(112,1,'COMPLETED',1598,'Order note 16',3,'2025-08-12 00:56:20','2025-08-21 00:56:20'),(113,1,'PENDING',723,'Order note 17',2,'2025-08-07 00:56:20','2025-08-21 00:56:20'),(114,1,'PAID',1496,'Order note 18',1,'2025-07-31 00:56:20','2025-08-21 00:56:20'),(115,1,'CANCELLED',1256,'Order note 19',3,'2025-07-05 00:56:20','2025-08-21 00:56:20'),(116,1,'PENDING',457,'Order note 20',1,'2025-06-27 00:56:20','2025-08-21 00:56:20');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `provider` enum('MOCK','STRIPE','SQUARE') NOT NULL DEFAULT 'MOCK',
  `status` enum('INITIATED','SUCCEEDED','FAILED','REFUNDED') NOT NULL DEFAULT 'INITIATED',
  `amount_cents` int NOT NULL,
  `txn_ref` varchar(128) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `method` varchar(32) NOT NULL DEFAULT 'CARD',
  PRIMARY KEY (`payment_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (2,20,'SQUARE','SUCCEEDED',3074,'TXN-cad1814a-7d64-11f0-88ff-5c41333c9431','2025-06-15 01:27:10','MOBILE'),(3,11,'MOCK','REFUNDED',1770,'TXN-cad18348-7d64-11f0-88ff-5c41333c9431','2025-08-07 01:27:10','CARD'),(4,20,'STRIPE','FAILED',148,'TXN-cad18406-7d64-11f0-88ff-5c41333c9431','2025-05-27 01:27:10','MOBILE'),(5,13,'MOCK','SUCCEEDED',1336,'TXN-cad184a6-7d64-11f0-88ff-5c41333c9431','2025-08-07 01:27:10','CASH'),(6,4,'MOCK','FAILED',2611,'TXN-cad1853c-7d64-11f0-88ff-5c41333c9431','2025-08-16 01:27:10','MOBILE'),(7,12,'SQUARE','FAILED',443,'TXN-cad185dc-7d64-11f0-88ff-5c41333c9431','2025-06-20 01:27:10','CARD'),(8,8,'SQUARE','SUCCEEDED',921,'TXN-cad1867c-7d64-11f0-88ff-5c41333c9431','2025-07-01 01:27:10','CARD'),(9,7,'STRIPE','REFUNDED',2342,'TXN-cad18758-7d64-11f0-88ff-5c41333c9431','2025-08-14 01:27:10','CARD'),(10,7,'MOCK','SUCCEEDED',1535,'TXN-cad187ee-7d64-11f0-88ff-5c41333c9431','2025-05-23 01:27:10','CASH'),(11,13,'STRIPE','REFUNDED',222,'TXN-cad18884-7d64-11f0-88ff-5c41333c9431','2025-07-19 01:27:10','MOBILE'),(12,8,'SQUARE','INITIATED',1089,'TXN-cad18906-7d64-11f0-88ff-5c41333c9431','2025-08-13 01:27:10','CASH'),(13,16,'SQUARE','INITIATED',1706,'TXN-cad18988-7d64-11f0-88ff-5c41333c9431','2025-07-24 01:27:10','MOBILE'),(14,16,'MOCK','FAILED',2232,'TXN-cad18a0a-7d64-11f0-88ff-5c41333c9431','2025-07-23 01:27:10','CASH'),(15,5,'SQUARE','SUCCEEDED',2386,'TXN-cad18aa0-7d64-11f0-88ff-5c41333c9431','2025-07-09 01:27:10','CARD'),(16,19,'STRIPE','INITIATED',1415,'TXN-cad18b18-7d64-11f0-88ff-5c41333c9431','2025-06-04 01:27:10','CARD'),(17,9,'MOCK','FAILED',289,'TXN-cad18bb8-7d64-11f0-88ff-5c41333c9431','2025-08-13 01:27:10','CARD'),(18,19,'SQUARE','REFUNDED',2392,'TXN-cad18c3a-7d64-11f0-88ff-5c41333c9431','2025-08-15 01:27:10','CARD'),(19,20,'SQUARE','INITIATED',1699,'TXN-cad18cbc-7d64-11f0-88ff-5c41333c9431','2025-08-17 01:27:10','CASH'),(20,19,'SQUARE','FAILED',1269,'TXN-cad18d3e-7d64-11f0-88ff-5c41333c9431','2025-08-10 01:27:10','CASH'),(21,13,'SQUARE','SUCCEEDED',1971,'TXN-cad18db6-7d64-11f0-88ff-5c41333c9431','2025-06-08 01:27:10','CARD'),(22,14,'STRIPE','INITIATED',913,'TXN-cad18e42-7d64-11f0-88ff-5c41333c9431','2025-06-25 01:27:10','CARD'),(23,16,'SQUARE','REFUNDED',593,'TXN-cad18eba-7d64-11f0-88ff-5c41333c9431','2025-05-23 01:27:10','CASH'),(24,8,'STRIPE','FAILED',1777,'TXN-cad18f3c-7d64-11f0-88ff-5c41333c9431','2025-06-07 01:27:10','CASH'),(25,19,'MOCK','SUCCEEDED',999,'TXN-cad18fdc-7d64-11f0-88ff-5c41333c9431','2025-07-27 01:27:10','CASH'),(26,11,'MOCK','REFUNDED',2604,'TXN-cad19072-7d64-11f0-88ff-5c41333c9431','2025-07-25 01:27:10','MOBILE'),(27,20,'SQUARE','SUCCEEDED',2420,'TXN-cad190ea-7d64-11f0-88ff-5c41333c9431','2025-07-12 01:27:10','MOBILE'),(28,3,'SQUARE','FAILED',1820,'TXN-cad1916c-7d64-11f0-88ff-5c41333c9431','2025-07-19 01:27:10','CARD'),(29,8,'STRIPE','SUCCEEDED',2692,'TXN-cad191e4-7d64-11f0-88ff-5c41333c9431','2025-06-02 01:27:10','MOBILE'),(30,12,'STRIPE','REFUNDED',2529,'TXN-cad19266-7d64-11f0-88ff-5c41333c9431','2025-08-07 01:27:10','CASH'),(31,5,'MOCK','FAILED',374,'TXN-cad192e8-7d64-11f0-88ff-5c41333c9431','2025-07-07 01:27:10','CARD'),(32,12,'MOCK','FAILED',1237,'TXN-cad1937e-7d64-11f0-88ff-5c41333c9431','2025-05-26 01:27:10','MOBILE'),(33,11,'STRIPE','SUCCEEDED',720,'TXN-cad19400-7d64-11f0-88ff-5c41333c9431','2025-06-07 01:27:10','CASH'),(34,5,'STRIPE','REFUNDED',1626,'TXN-cad1946e-7d64-11f0-88ff-5c41333c9431','2025-08-07 01:27:10','CARD'),(35,13,'STRIPE','INITIATED',970,'TXN-cad194f0-7d64-11f0-88ff-5c41333c9431','2025-08-03 01:27:10','CARD'),(36,20,'STRIPE','INITIATED',2673,'TXN-cad19568-7d64-11f0-88ff-5c41333c9431','2025-06-05 01:27:10','CASH'),(37,15,'SQUARE','SUCCEEDED',1687,'TXN-cad195e0-7d64-11f0-88ff-5c41333c9431','2025-06-22 01:27:10','MOBILE'),(38,11,'STRIPE','REFUNDED',1429,'TXN-cad19658-7d64-11f0-88ff-5c41333c9431','2025-07-31 01:27:10','MOBILE'),(39,8,'STRIPE','REFUNDED',2456,'TXN-cad196d0-7d64-11f0-88ff-5c41333c9431','2025-06-29 01:27:10','CASH'),(40,3,'SQUARE','SUCCEEDED',2978,'TXN-cad19770-7d64-11f0-88ff-5c41333c9431','2025-06-19 01:27:10','CASH'),(41,1,'MOCK','REFUNDED',1275,'TXN-cad197e8-7d64-11f0-88ff-5c41333c9431','2025-06-24 01:27:10','CARD'),(42,6,'MOCK','INITIATED',2373,'TXN-cad19860-7d64-11f0-88ff-5c41333c9431','2025-06-24 01:27:10','MOBILE'),(43,16,'MOCK','REFUNDED',1285,'TXN-cad198d8-7d64-11f0-88ff-5c41333c9431','2025-07-28 01:27:10','CARD'),(44,15,'STRIPE','FAILED',1720,'TXN-cad19950-7d64-11f0-88ff-5c41333c9431','2025-08-05 01:27:10','CARD'),(45,12,'MOCK','SUCCEEDED',2026,'TXN-cad199d2-7d64-11f0-88ff-5c41333c9431','2025-06-10 01:27:10','CARD'),(46,16,'SQUARE','REFUNDED',1201,'TXN-cad19a4a-7d64-11f0-88ff-5c41333c9431','2025-07-04 01:27:10','CASH'),(47,4,'MOCK','REFUNDED',2399,'TXN-cad19ac2-7d64-11f0-88ff-5c41333c9431','2025-08-18 01:27:10','MOBILE'),(48,1,'SQUARE','SUCCEEDED',2650,'TXN-cad19b44-7d64-11f0-88ff-5c41333c9431','2025-08-13 01:27:10','MOBILE'),(49,3,'MOCK','REFUNDED',1706,'TXN-cad19bbc-7d64-11f0-88ff-5c41333c9431','2025-06-08 01:27:10','CASH'),(50,20,'STRIPE','INITIATED',1413,'TXN-cad19c52-7d64-11f0-88ff-5c41333c9431','2025-06-11 01:27:10','CASH'),(64,13,'MOCK','SUCCEEDED',2402,'TXN-a6ea756e-7e29-11f0-88ff-5c41333c9431','2025-05-25 00:56:20','CASH'),(65,3,'SQUARE','REFUNDED',2859,'TXN-a6ea7a1e-7e29-11f0-88ff-5c41333c9431','2025-06-03 00:56:20','CASH'),(66,14,'MOCK','SUCCEEDED',1772,'TXN-a6ea7b68-7e29-11f0-88ff-5c41333c9431','2025-07-23 00:56:20','MOBILE'),(67,19,'SQUARE','FAILED',802,'TXN-a6ea7c76-7e29-11f0-88ff-5c41333c9431','2025-08-04 00:56:20','CARD'),(68,14,'STRIPE','REFUNDED',767,'TXN-a6ea7d70-7e29-11f0-88ff-5c41333c9431','2025-06-11 00:56:20','CARD'),(69,2,'STRIPE','INITIATED',2994,'TXN-a6ea7e60-7e29-11f0-88ff-5c41333c9431','2025-06-25 00:56:20','CARD'),(70,11,'SQUARE','INITIATED',1296,'TXN-a6ea7f82-7e29-11f0-88ff-5c41333c9431','2025-06-26 00:56:20','MOBILE'),(71,19,'SQUARE','FAILED',1822,'TXN-a6ea807c-7e29-11f0-88ff-5c41333c9431','2025-06-22 00:56:20','CASH'),(72,4,'MOCK','SUCCEEDED',1475,'TXN-a6ea816c-7e29-11f0-88ff-5c41333c9431','2025-06-11 00:56:20','CASH'),(73,13,'STRIPE','REFUNDED',1158,'TXN-a6ea8252-7e29-11f0-88ff-5c41333c9431','2025-08-12 00:56:20','CASH'),(74,3,'MOCK','INITIATED',2143,'TXN-a6ea8338-7e29-11f0-88ff-5c41333c9431','2025-06-10 00:56:20','MOBILE'),(75,8,'MOCK','INITIATED',2244,'TXN-a6ea8414-7e29-11f0-88ff-5c41333c9431','2025-08-20 00:56:20','MOBILE'),(76,14,'STRIPE','FAILED',2126,'TXN-a6ea8504-7e29-11f0-88ff-5c41333c9431','2025-07-16 00:56:20','CARD'),(77,17,'MOCK','INITIATED',1507,'TXN-a6ea85e0-7e29-11f0-88ff-5c41333c9431','2025-06-09 00:56:20','MOBILE'),(78,1,'MOCK','INITIATED',197,'TXN-a6ea86c6-7e29-11f0-88ff-5c41333c9431','2025-08-11 00:56:20','CASH'),(79,1,'SQUARE','FAILED',1780,'TXN-a6ea87a2-7e29-11f0-88ff-5c41333c9431','2025-08-08 00:56:20','CARD'),(80,20,'SQUARE','FAILED',1548,'TXN-a6ea891e-7e29-11f0-88ff-5c41333c9431','2025-06-05 00:56:20','MOBILE'),(81,16,'MOCK','SUCCEEDED',197,'TXN-a6ea8a18-7e29-11f0-88ff-5c41333c9431','2025-06-22 00:56:20','CARD'),(82,7,'SQUARE','INITIATED',2291,'TXN-a6ea8b08-7e29-11f0-88ff-5c41333c9431','2025-06-30 00:56:20','MOBILE'),(83,16,'SQUARE','FAILED',797,'TXN-a6ea8bee-7e29-11f0-88ff-5c41333c9431','2025-05-28 00:56:20','CARD'),(84,8,'STRIPE','INITIATED',2598,'TXN-a6ea8cde-7e29-11f0-88ff-5c41333c9431','2025-06-19 00:56:20','CARD'),(85,3,'STRIPE','INITIATED',1074,'TXN-a6ea8dba-7e29-11f0-88ff-5c41333c9431','2025-08-12 00:56:20','CASH'),(86,7,'MOCK','FAILED',1952,'TXN-a6ea8ea0-7e29-11f0-88ff-5c41333c9431','2025-07-26 00:56:20','CASH'),(87,4,'SQUARE','SUCCEEDED',2351,'TXN-a6ea8f7c-7e29-11f0-88ff-5c41333c9431','2025-06-13 00:56:20','CASH'),(88,17,'MOCK','REFUNDED',2254,'TXN-a6ea904e-7e29-11f0-88ff-5c41333c9431','2025-06-06 00:56:20','CARD'),(89,17,'SQUARE','SUCCEEDED',2023,'TXN-a6ea9134-7e29-11f0-88ff-5c41333c9431','2025-07-27 00:56:20','CASH'),(90,14,'SQUARE','REFUNDED',1829,'TXN-a6ea9210-7e29-11f0-88ff-5c41333c9431','2025-06-01 00:56:20','MOBILE'),(91,6,'SQUARE','REFUNDED',1118,'TXN-a6ea92f6-7e29-11f0-88ff-5c41333c9431','2025-07-31 00:56:20','CARD'),(92,2,'SQUARE','FAILED',1356,'TXN-a6ea93dc-7e29-11f0-88ff-5c41333c9431','2025-08-17 00:56:20','CARD'),(93,19,'STRIPE','SUCCEEDED',1786,'TXN-a6ea94b8-7e29-11f0-88ff-5c41333c9431','2025-05-27 00:56:20','CARD'),(94,15,'MOCK','REFUNDED',805,'TXN-a6ea959e-7e29-11f0-88ff-5c41333c9431','2025-08-01 00:56:20','CASH'),(95,9,'SQUARE','SUCCEEDED',2480,'TXN-a6ea9684-7e29-11f0-88ff-5c41333c9431','2025-08-19 00:56:20','MOBILE'),(96,13,'SQUARE','SUCCEEDED',188,'TXN-a6ea976a-7e29-11f0-88ff-5c41333c9431','2025-07-30 00:56:20','CARD'),(97,1,'STRIPE','REFUNDED',1354,'TXN-a6ea98d2-7e29-11f0-88ff-5c41333c9431','2025-06-27 00:56:20','MOBILE'),(98,8,'STRIPE','FAILED',185,'TXN-a6ea99c2-7e29-11f0-88ff-5c41333c9431','2025-07-26 00:56:20','CASH'),(99,1,'MOCK','INITIATED',2097,'TXN-a6ea9a9e-7e29-11f0-88ff-5c41333c9431','2025-06-09 00:56:20','CARD'),(100,3,'MOCK','FAILED',560,'TXN-a6ea9b7a-7e29-11f0-88ff-5c41333c9431','2025-08-06 00:56:20','CASH'),(101,11,'STRIPE','SUCCEEDED',2285,'TXN-a6ea9c56-7e29-11f0-88ff-5c41333c9431','2025-07-07 00:56:20','CARD'),(102,3,'SQUARE','INITIATED',1222,'TXN-a6ea9d32-7e29-11f0-88ff-5c41333c9431','2025-06-30 00:56:20','MOBILE'),(103,5,'SQUARE','REFUNDED',2818,'TXN-a6ea9e0e-7e29-11f0-88ff-5c41333c9431','2025-08-08 00:56:20','CARD'),(104,15,'STRIPE','FAILED',2917,'TXN-a6ea9eea-7e29-11f0-88ff-5c41333c9431','2025-07-11 00:56:20','CASH'),(105,2,'SQUARE','SUCCEEDED',2432,'TXN-a6ea9fc6-7e29-11f0-88ff-5c41333c9431','2025-05-24 00:56:20','CASH'),(106,3,'SQUARE','FAILED',2555,'TXN-a6eaa0a2-7e29-11f0-88ff-5c41333c9431','2025-08-09 00:56:20','CARD'),(107,17,'STRIPE','SUCCEEDED',2234,'TXN-a6eaa188-7e29-11f0-88ff-5c41333c9431','2025-07-10 00:56:20','CARD'),(108,14,'SQUARE','INITIATED',1951,'TXN-a6eaa264-7e29-11f0-88ff-5c41333c9431','2025-08-18 00:56:20','CARD'),(109,11,'SQUARE','REFUNDED',2638,'TXN-a6eaa340-7e29-11f0-88ff-5c41333c9431','2025-05-31 00:56:20','CARD'),(110,8,'SQUARE','FAILED',2821,'TXN-a6eaa41c-7e29-11f0-88ff-5c41333c9431','2025-06-23 00:56:20','CASH'),(111,18,'STRIPE','SUCCEEDED',1856,'TXN-a6eaa4f8-7e29-11f0-88ff-5c41333c9431','2025-07-10 00:56:20','CASH'),(112,11,'SQUARE','FAILED',262,'TXN-a6eaa674-7e29-11f0-88ff-5c41333c9431','2025-08-13 00:56:20','CARD'),(113,4,'MOCK','REFUNDED',1397,'TXN-a6eaa75a-7e29-11f0-88ff-5c41333c9431','2025-07-25 00:56:20','CARD'),(127,64,'MOCK','SUCCEEDED',895,NULL,'2025-08-21 00:57:42','CARD');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_payment_after_update` AFTER UPDATE ON `payments` FOR EACH ROW BEGIN
  IF NEW.status = 'SUCCEEDED' AND OLD.status <> 'SUCCEEDED' THEN
    UPDATE orders SET status = 'PAID' WHERE order_id = NEW.order_id;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `category` enum('coffee','tea','food','other') NOT NULL,
  `price_cents` int NOT NULL,
  `sku` varchar(64) DEFAULT NULL,
  `stock` int NOT NULL DEFAULT '100',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`),
  UNIQUE KEY `sku` (`sku`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Caffè Latte','coffee',520,'LATTE-12OZ',180,1,'2025-08-15 02:57:08'),(2,'Cold Brew','coffee',450,'CBREW-16OZ',179,1,'2025-08-15 02:57:08'),(3,'Matcha Latte','tea',525,'MATCHA-12OZ',133,1,'2025-08-15 02:57:08'),(4,'Blueberry Muffin','food',375,'MUFF-BLUE',76,1,'2025-08-15 02:57:08');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_customer_ltv`
--

DROP TABLE IF EXISTS `vw_customer_ltv`;
/*!50001 DROP VIEW IF EXISTS `vw_customer_ltv`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_customer_ltv` AS SELECT 
 1 AS `customer_id`,
 1 AS `customer_name`,
 1 AS `email`,
 1 AS `orders_count`,
 1 AS `header_total_cents`,
 1 AS `net_paid_cents`,
 1 AS `balance_due_cents`,
 1 AS `first_order_at`,
 1 AS `last_order_at`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_customer_orders`
--

DROP TABLE IF EXISTS `vw_customer_orders`;
/*!50001 DROP VIEW IF EXISTS `vw_customer_orders`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_customer_orders` AS SELECT 
 1 AS `customer_id`,
 1 AS `first_name`,
 1 AS `last_name`,
 1 AS `email`,
 1 AS `order_id`,
 1 AS `order_datetime`,
 1 AS `status`,
 1 AS `total_cents`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_order_payment_summary`
--

DROP TABLE IF EXISTS `vw_order_payment_summary`;
/*!50001 DROP VIEW IF EXISTS `vw_order_payment_summary`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_order_payment_summary` AS SELECT 
 1 AS `order_id`,
 1 AS `customer_id`,
 1 AS `status`,
 1 AS `order_total_cents`,
 1 AS `net_paid_cents`,
 1 AS `amount_due_cents`,
 1 AS `created_at`,
 1 AS `updated_at`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'mocha_madness_v4'
--

--
-- Dumping routines for database 'mocha_madness_v4'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_assign_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_assign_order`(IN p_order_id INT)
BEGIN
  DECLARE v_emp INT;
  -- pick active employee with smallest current_load
  SELECT employee_id INTO v_emp
  FROM employees WHERE is_active = 1 AND role = 'barista'
  ORDER BY current_load ASC, employee_id ASC
  LIMIT 1;

  IF v_emp IS NOT NULL THEN
    UPDATE orders SET assigned_employee_id = v_emp, status = 'IN_PROGRESS' WHERE order_id = p_order_id;
    UPDATE employees SET current_load = current_load + 1 WHERE employee_id = v_emp;
  END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vw_customer_ltv`
--

/*!50001 DROP VIEW IF EXISTS `vw_customer_ltv`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_customer_ltv` AS select `c`.`customer_id` AS `customer_id`,concat_ws(' ',`c`.`first_name`,`c`.`last_name`) AS `customer_name`,`c`.`email` AS `email`,count(distinct `o`.`order_id`) AS `orders_count`,coalesce(sum(`o`.`total_cents`),0) AS `header_total_cents`,coalesce(sum((case when (`p`.`status` = 'SUCCEEDED') then `p`.`amount_cents` when (`p`.`status` = 'REFUNDED') then -(`p`.`amount_cents`) else 0 end)),0) AS `net_paid_cents`,(coalesce(sum(`o`.`total_cents`),0) - coalesce(sum((case when (`p`.`status` = 'SUCCEEDED') then `p`.`amount_cents` when (`p`.`status` = 'REFUNDED') then -(`p`.`amount_cents`) else 0 end)),0)) AS `balance_due_cents`,min(`o`.`created_at`) AS `first_order_at`,max(`o`.`created_at`) AS `last_order_at` from ((`customers` `c` left join `orders` `o` on((`o`.`customer_id` = `c`.`customer_id`))) left join `payments` `p` on((`p`.`order_id` = `o`.`order_id`))) group by `c`.`customer_id`,`customer_name`,`c`.`email` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_customer_orders`
--

/*!50001 DROP VIEW IF EXISTS `vw_customer_orders`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_customer_orders` AS select `c`.`customer_id` AS `customer_id`,`c`.`first_name` AS `first_name`,`c`.`last_name` AS `last_name`,`c`.`email` AS `email`,`o`.`order_id` AS `order_id`,`o`.`created_at` AS `order_datetime`,`o`.`status` AS `status`,`o`.`total_cents` AS `total_cents` from (`customers` `c` join `orders` `o` on((`c`.`customer_id` = `o`.`customer_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_order_payment_summary`
--

/*!50001 DROP VIEW IF EXISTS `vw_order_payment_summary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_order_payment_summary` AS select `o`.`order_id` AS `order_id`,`o`.`customer_id` AS `customer_id`,`o`.`status` AS `status`,`o`.`total_cents` AS `order_total_cents`,coalesce(sum((case when (`p`.`status` = 'SUCCEEDED') then `p`.`amount_cents` when (`p`.`status` = 'REFUNDED') then -(`p`.`amount_cents`) else 0 end)),0) AS `net_paid_cents`,(`o`.`total_cents` - coalesce(sum((case when (`p`.`status` = 'SUCCEEDED') then `p`.`amount_cents` when (`p`.`status` = 'REFUNDED') then -(`p`.`amount_cents`) else 0 end)),0)) AS `amount_due_cents`,`o`.`created_at` AS `created_at`,`o`.`updated_at` AS `updated_at` from (`orders` `o` left join `payments` `p` on((`p`.`order_id` = `o`.`order_id`))) group by `o`.`order_id`,`o`.`customer_id`,`o`.`status`,`o`.`total_cents`,`o`.`created_at`,`o`.`updated_at` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-02  8:41:07
