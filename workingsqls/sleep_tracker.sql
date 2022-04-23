-- MySQL dump 10.19  Distrib 10.3.31-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: jkuo
-- ------------------------------------------------------
-- Server version	10.3.31-MariaDB-0+deb10u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client` (
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES ('bkeitch8','vxKIyKQhbxC'),('bkleingrub1','w28jtOBlYcc'),('bmccorley9','jwui4B6AW'),('bsleford2','Sjpk2vMZ6N'),('hfranciskiewicz3','pAgFODt42'),('jcapelle4','p8AiSP5tm3'),('jpicot7','MKZuyuT'),('nhillam6','y6cBK5T8M'),('ntatam5','nHrelUoCxxt'),('vtidmas0','qe9uKx6JrZ');
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log` (
  `logid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `parentid` int(11) DEFAULT 0,
  `startdatetime` datetime NOT NULL,
  `isoverallstart` tinyint(1) NOT NULL,
  `enddatetime` datetime NOT NULL,
  `isoverallend` tinyint(1) NOT NULL,
  PRIMARY KEY (`logid`),
  KEY `username` (`username`),
  CONSTRAINT `log_ibfk_1` FOREIGN KEY (`username`) REFERENCES `client` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log`
--

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
INSERT INTO `log` VALUES (1,'bkleingrub1',1,'2021-10-22 20:45:00',1,'2021-10-23 09:53:00',1),(2,'vtidmas0',2,'2021-10-23 03:05:00',1,'2021-10-23 05:28:00',0),(3,'vtidmas0',2,'2021-10-23 05:28:00',0,'2021-10-23 09:53:00',1),(4,'bsleford2',4,'2021-10-23 09:53:00',1,'2021-10-23 13:37:00',1),(5,'hfranciskiewicz3',5,'2022-03-29 06:15:00',1,'2022-03-29 08:22:00',1),(6,'ntatam5',6,'2022-03-29 11:54:00',1,'2022-03-29 13:54:00',0),(7,'ntatam5',6,'2022-03-29 16:50:00',0,'2022-03-29 19:42:00',1),(8,'nhillam6',8,'2022-03-29 22:42:00',1,'2022-03-30 10:34:00',1),(9,'bkleingrub1',9,'2022-03-29 19:42:00',1,'2022-03-30 06:09:00',1),(10,'vtidmas0',10,'2022-03-30 06:09:00',1,'2022-03-29 13:54:00',1),(11,'jpicot7',11,'2022-03-30 23:36:00',1,'2022-03-31 02:30:00',0),(12,'jpicot7',11,'2022-03-31 02:30:00',0,'2022-03-31 05:09:00',0),(13,'jpicot7',11,'2022-03-31 05:09:00',0,'2022-03-31 05:48:00',0),(14,'jpicot7',11,'2022-03-31 05:48:00',0,'2022-03-31 05:53:00',0),(15,'jpicot7',11,'2022-03-31 05:53:00',0,'2022-03-31 07:00:00',1),(16,'vtidmas0',16,'2022-04-01 22:21:00',1,'2022-04-02 05:26:00',0),(17,'vtidmas0',16,'2022-04-02 05:38:00',0,'2022-04-02 08:19:00',1),(18,'jpicot7',18,'2022-04-01 22:55:00',1,'2022-04-02 05:38:00',1),(19,'bkeitch8',19,'2022-04-02 22:22:00',1,'2022-04-03 06:03:00',1),(20,'vtidmas0',20,'2022-04-02 22:09:00',1,'2022-04-03 06:25:00',1),(21,'bmccorley9',21,'2022-04-02 23:19:00',1,'2022-04-03 07:14:00',1),(22,'ntatam5',22,'2022-04-02 21:25:00',1,'2022-04-03 02:46:00',0),(23,'ntatam5',22,'2022-04-03 02:46:00',0,'2022-04-03 04:30:00',0),(24,'ntatam5',22,'2022-04-03 04:30:00',0,'2022-04-03 05:23:00',0),(25,'ntatam5',22,'2022-04-03 05:23:00',0,'2022-04-03 07:07:00',1),(26,'bkeitch8',26,'2022-04-03 23:33:00',1,'2022-04-04 06:07:00',1),(27,'bkeitch8',27,'2022-04-04 14:19:00',1,'2022-04-04 15:49:00',1),(28,'vtidmas0',28,'2022-04-03 22:50:00',1,'2022-04-04 07:15:00',1),(29,'ntatam5',29,'2022-04-04 22:21:00',1,'2022-04-05 06:59:00',1),(30,'vtidmas0',30,'2022-04-04 23:57:00',1,'2022-04-05 08:50:00',1),(31,'vtidmas0',31,'2022-04-05 21:14:00',1,'2022-04-05 23:56:00',0),(32,'vtidmas0',31,'2022-04-05 23:56:00',0,'2022-04-06 00:40:00',0),(33,'vtidmas0',31,'2022-04-06 00:40:00',0,'2022-04-06 01:35:00',0),(34,'vtidmas0',31,'2022-04-06 01:35:00',0,'2022-04-06 04:20:00',0),(35,'vtidmas0',31,'2022-04-06 04:20:00',0,'2022-04-06 06:58:00',1),(36,'vtidmas0',36,'2022-04-06 23:38:00',1,'2022-04-07 08:23:00',1),(37,'vtidmas0',37,'2022-04-07 21:03:00',1,'2022-04-07 22:12:00',0),(38,'vtidmas0',37,'2022-04-07 22:12:00',0,'2022-04-08 05:46:00',0),(39,'vtidmas0',37,'2022-04-08 05:46:00',0,'2022-04-08 05:56:00',1),(40,'vtidmas0',40,'2022-04-08 22:17:00',1,'2022-04-09 06:37:00',1),(41,'ntatam5',41,'2022-04-08 22:06:00',1,'2022-04-09 05:59:00',1),(42,'vtidmas0',42,'2022-04-09 22:48:00',1,'2022-04-10 06:49:00',1),(43,'vtidmas0',43,'2022-04-10 23:26:00',1,'2022-04-11 23:50:00',0),(44,'vtidmas0',43,'2022-04-11 23:50:00',0,'2022-04-11 08:23:00',1),(45,'vtidmas0',45,'2022-04-11 23:06:00',1,'2022-04-12 06:07:00',1),(46,'vtidmas0',46,'2022-04-12 23:21:00',1,'2022-04-13 08:20:00',1),(47,'vtidmas0',47,'2022-04-13 17:17:00',1,'2022-04-13 17:42:00',1),(48,'vtidmas0',48,'2022-04-13 23:10:00',1,'2022-04-14 05:22:00',1),(49,'vtidmas0',49,'2022-04-14 22:45:00',1,'2022-04-15 07:29:00',1),(50,'vtidmas0',50,'2022-04-15 23:57:00',1,'2022-04-16 07:47:00',1);
/*!40000 ALTER TABLE `log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `premiumbuddieswithothers`
--

DROP TABLE IF EXISTS `premiumbuddieswithothers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `premiumbuddieswithothers` (
  `premusername` varchar(100) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  KEY `premusername` (`premusername`),
  KEY `username` (`username`),
  CONSTRAINT `premiumbuddieswithothers_ibfk_1` FOREIGN KEY (`premusername`) REFERENCES `premiumclient` (`username`),
  CONSTRAINT `premiumbuddieswithothers_ibfk_2` FOREIGN KEY (`username`) REFERENCES `client` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `premiumbuddieswithothers`
--

LOCK TABLES `premiumbuddieswithothers` WRITE;
/*!40000 ALTER TABLE `premiumbuddieswithothers` DISABLE KEYS */;
INSERT INTO `premiumbuddieswithothers` VALUES ('bsleford2','bkeitch8'),('bsleford2','bmccorley9'),('bsleford2','nhillam6'),('hfranciskiewicz3','bkeitch8'),('hfranciskiewicz3','jpicot7'),('hfranciskiewicz3','vtidmas0'),('jcapelle4','vtidmas0'),('vtidmas0','bkleingrub1'),('vtidmas0','bsleford2'),('vtidmas0','hfranciskiewicz3'),('vtidmas0','jcapelle4'),('vtidmas0','ntatam5'),('vtidmas0','nhillam6'),('vtidmas0','jpicot7'),('vtidmas0','bkeitch8'),('vtidmas0','bmccorley9');
/*!40000 ALTER TABLE `premiumbuddieswithothers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `premiumclient`
--

DROP TABLE IF EXISTS `premiumclient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `premiumclient` (
  `username` varchar(100) DEFAULT NULL,
  KEY `username` (`username`),
  CONSTRAINT `premiumclient_ibfk_1` FOREIGN KEY (`username`) REFERENCES `client` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `premiumclient`
--

LOCK TABLES `premiumclient` WRITE;
/*!40000 ALTER TABLE `premiumclient` DISABLE KEYS */;
INSERT INTO `premiumclient` VALUES ('bkleingrub1'),('bsleford2'),('hfranciskiewicz3'),('jcapelle4'),('vtidmas0');
/*!40000 ALTER TABLE `premiumclient` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-30 11:44:03
