-- MySQL dump 10.19  Distrib 10.3.31-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: sleep_tracker
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
-- Current Database: `sleep_tracker`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `sleep_tracker` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `sleep_tracker`;

--
-- Table structure for table `buddies`
--

DROP TABLE IF EXISTS `buddies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `buddies` (
  `pname` varchar(100) DEFAULT NULL,
  `uname` varchar(100) DEFAULT NULL,
  KEY `pname` (`pname`),
  KEY `uname` (`uname`),
  CONSTRAINT `buddies_ibfk_1` FOREIGN KEY (`pname`) REFERENCES `prem` (`uname`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `buddies_ibfk_2` FOREIGN KEY (`uname`) REFERENCES `user` (`uname`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buddies`
--

LOCK TABLES `buddies` WRITE;
/*!40000 ALTER TABLE `buddies` DISABLE KEYS */;
INSERT INTO `buddies` VALUES ('bsleford2','nhillam6'),('hfranciskiewicz3','jpicot7'),('hfranciskiewicz3','vtidmas0'),('vtidmas0','bkleingrub1'),('vtidmas0','bsleford2'),('vtidmas0','hfranciskiewicz3'),('vtidmas0','jcapelle4'),('vtidmas0','ntatam5'),('vtidmas0','nhillam6'),('vtidmas0','jpicot7'),('vtidmas0','bmccorley9'),('abcdefg','abcd'),('12345jesse','1234'),('abcdefg','abcde'),('abcdefg','1234'),('12345jesse','abcde'),('12345jesse','vtidmas0'),('jesse12345','vtidmas0'),(NULL,'jesse12345');
/*!40000 ALTER TABLE `buddies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log` (
  `logid` int(11) NOT NULL AUTO_INCREMENT,
  `uname` varchar(100) DEFAULT 'default',
  `pid` int(11) DEFAULT 0,
  `stime` datetime NOT NULL,
  `isstart` tinyint(1) NOT NULL,
  `etime` datetime NOT NULL,
  `isend` tinyint(1) NOT NULL,
  PRIMARY KEY (`logid`),
  KEY `uname` (`uname`),
  CONSTRAINT `log_ibfk_1` FOREIGN KEY (`uname`) REFERENCES `user` (`uname`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=194 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log`
--

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
INSERT INTO `log` VALUES (1,'bkleingrub1',1,'2021-10-22 20:45:00',1,'2021-10-23 09:53:00',1),(2,'vtidmas0',2,'2021-10-23 03:05:00',1,'2021-10-23 05:28:00',0),(3,'vtidmas0',2,'2021-10-23 05:28:00',0,'2021-10-23 09:53:00',1),(4,'bsleford2',4,'2021-10-23 09:53:00',1,'2021-10-23 13:37:00',1),(5,'hfranciskiewicz3',5,'2022-03-29 06:15:00',1,'2022-03-29 08:22:00',1),(6,'ntatam5',6,'2022-03-29 11:54:00',1,'2022-03-29 13:54:00',0),(7,'ntatam5',6,'2022-03-29 16:50:00',0,'2022-03-29 19:42:00',1),(8,'nhillam6',8,'2022-03-29 22:42:00',1,'2022-03-30 10:34:00',1),(9,'bkleingrub1',9,'2022-03-29 19:42:00',1,'2022-03-30 06:09:00',1),(11,'jpicot7',11,'2022-03-30 23:36:00',1,'2022-03-31 02:30:00',0),(12,'jpicot7',11,'2022-03-31 02:30:00',0,'2022-03-31 05:09:00',0),(13,'jpicot7',11,'2022-03-31 05:09:00',0,'2022-03-31 05:48:00',0),(14,'jpicot7',11,'2022-03-31 05:48:00',0,'2022-03-31 05:53:00',0),(15,'jpicot7',11,'2022-03-31 05:53:00',0,'2022-03-31 07:00:00',1),(16,'vtidmas0',16,'2022-04-01 22:21:00',1,'2022-04-02 05:26:00',0),(17,'vtidmas0',16,'2022-04-02 05:38:00',0,'2022-04-02 08:19:00',1),(18,'jpicot7',18,'2022-04-01 22:55:00',1,'2022-04-02 05:38:00',1),(19,'bkeitch8',19,'2022-04-02 22:22:00',1,'2022-04-03 06:03:00',1),(20,'vtidmas0',20,'2022-04-02 22:09:00',1,'2022-04-03 06:25:00',1),(21,'bmccorley9',21,'2022-04-02 23:19:00',1,'2022-04-03 07:14:00',1),(22,'ntatam5',22,'2022-04-02 21:25:00',1,'2022-04-03 02:46:00',0),(23,'ntatam5',22,'2022-04-03 02:46:00',0,'2022-04-03 04:30:00',0),(24,'ntatam5',22,'2022-04-03 04:30:00',0,'2022-04-03 05:23:00',0),(25,'ntatam5',22,'2022-04-03 05:23:00',0,'2022-04-03 07:07:00',1),(26,'bkeitch8',26,'2022-04-03 23:33:00',1,'2022-04-04 06:07:00',1),(27,'bkeitch8',27,'2022-04-04 14:19:00',1,'2022-04-04 15:49:00',1),(28,'vtidmas0',28,'2022-04-03 22:50:00',1,'2022-04-04 07:15:00',1),(29,'ntatam5',29,'2022-04-04 22:21:00',1,'2022-04-05 06:59:00',1),(30,'vtidmas0',30,'2022-04-04 23:57:00',1,'2022-04-05 08:50:00',1),(31,'vtidmas0',31,'2022-04-05 21:14:00',1,'2022-04-05 23:56:00',0),(32,'vtidmas0',31,'2022-04-05 23:56:00',0,'2022-04-06 00:40:00',0),(33,'vtidmas0',31,'2022-04-06 00:40:00',0,'2022-04-06 01:35:00',0),(34,'vtidmas0',31,'2022-04-06 01:35:00',0,'2022-04-06 04:20:00',0),(35,'vtidmas0',31,'2022-04-06 04:20:00',0,'2022-04-06 06:58:00',1),(36,'vtidmas0',36,'2022-04-06 23:38:00',1,'2022-04-07 08:23:00',1),(37,'vtidmas0',37,'2022-04-07 21:03:00',1,'2022-04-07 22:12:00',0),(38,'vtidmas0',37,'2022-04-07 22:12:00',0,'2022-04-08 05:46:00',0),(39,'vtidmas0',37,'2022-04-08 05:46:00',0,'2022-04-08 05:56:00',1),(40,'vtidmas0',40,'2022-04-08 22:17:00',1,'2022-04-09 06:37:00',1),(41,'ntatam5',41,'2022-04-08 22:06:00',1,'2022-04-09 05:59:00',1),(42,'vtidmas0',42,'2022-04-09 22:48:00',1,'2022-04-10 06:49:00',1),(43,'vtidmas0',43,'2022-04-10 23:26:00',1,'2022-04-11 23:50:00',0),(44,'vtidmas0',43,'2022-04-11 23:50:00',0,'2022-04-11 08:23:00',1),(45,'vtidmas0',45,'2022-04-11 23:06:00',1,'2022-04-12 06:07:00',1),(46,'vtidmas0',46,'2022-04-12 23:21:00',1,'2022-04-13 08:20:00',1),(47,'vtidmas0',47,'2022-04-13 17:17:00',1,'2022-04-13 17:42:00',1),(48,'vtidmas0',48,'2022-04-13 23:10:00',1,'2022-04-14 05:22:00',1),(49,'vtidmas0',49,'2022-04-14 22:45:00',1,'2022-04-15 07:29:00',1),(50,'vtidmas0',50,'2022-04-15 23:57:00',1,'2022-04-16 07:47:00',1),(51,'abcd',51,'2022-05-01 00:00:00',1,'2022-05-01 00:01:00',0),(52,'abcd',51,'2022-05-01 00:01:30',0,'2022-05-02 00:01:01',0),(53,'abcd',51,'2022-05-03 00:00:00',0,'2022-05-04 00:00:00',1),(54,'abcd',54,'2022-05-10 00:00:00',1,'2022-05-13 00:00:00',1),(93,'12ab',93,'2022-05-06 10:29:00',1,'2022-05-06 10:29:00',0),(94,'12ab',93,'2022-05-06 22:30:00',0,'2022-05-06 23:15:00',0),(95,'12ab',93,'2022-05-06 23:30:00',0,'2022-05-06 23:59:00',1),(96,'12ab',96,'2022-05-07 10:32:00',1,'2022-05-07 10:33:00',0),(97,'12ab',96,'2022-05-07 10:50:00',0,'2022-05-07 13:15:00',0),(98,'12ab',96,'2022-05-07 13:20:00',0,'2022-05-07 20:59:00',1),(131,'12345jesse',131,'2022-05-08 07:25:00',1,'2022-05-08 07:25:00',1),(132,'12345jesse',132,'2022-05-08 07:35:00',1,'2022-05-08 08:35:00',0),(133,'12345jesse',132,'2022-05-08 09:00:00',0,'2022-05-08 09:30:00',1),(134,'12345jesse',134,'2022-05-08 09:31:00',1,'2022-05-08 09:45:00',1),(145,'abcdefg',145,'2022-05-10 10:29:00',1,'2022-05-10 10:35:00',1),(146,'abcdefg',146,'2022-05-10 10:37:00',1,'2022-05-10 10:40:00',1),(147,'1234',147,'2022-05-10 10:38:00',1,'2022-05-10 10:38:00',0),(150,'abcdefg',150,'2022-05-11 01:35:00',1,'2022-05-11 09:35:00',1),(151,'abcdefg',151,'2022-05-11 01:45:00',1,'2022-05-11 10:23:00',1),(156,'1234',156,'2022-05-11 06:49:00',1,'2022-05-11 06:49:00',1),(157,'1234',157,'2022-05-11 07:03:00',1,'2022-05-11 07:03:00',0),(158,'1234',157,'2022-05-19 01:02:00',0,'2022-05-12 13:02:00',1),(168,'1234',168,'2022-05-15 13:29:00',1,'2022-05-15 18:29:00',1),(169,'1234',169,'2022-05-18 15:07:00',1,'2022-05-18 15:07:00',1),(170,'1234',170,'2022-05-18 15:07:00',1,'2022-05-18 15:07:00',0),(171,'1234',170,'2022-05-19 05:05:00',0,'2022-05-19 05:05:00',1),(174,'1234',174,'2022-05-18 15:09:00',1,'2022-05-18 15:09:00',0),(175,'1234',174,'2022-05-19 00:00:00',0,'2022-05-19 00:00:00',1),(178,'nhillam6',178,'2022-05-18 19:36:00',1,'2022-05-18 19:36:00',1),(182,'nhillam6',182,'2022-05-18 19:38:00',1,'2022-05-22 19:02:00',1),(183,'nhillam6',183,'2022-05-18 19:39:00',1,'2022-05-18 19:41:00',1),(184,'nhillam6',184,'2022-05-18 19:41:00',1,'2022-05-18 19:41:00',0),(187,'jesse12345',187,'2022-05-19 16:57:00',1,'2022-05-19 16:57:00',1),(193,'1234',193,'2022-05-19 17:01:00',1,'2022-05-20 17:01:00',1);
/*!40000 ALTER TABLE `log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_backup`
--

DROP TABLE IF EXISTS `password_backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_backup` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `uname` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`uname`),
  UNIQUE KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_backup`
--

LOCK TABLES `password_backup` WRITE;
/*!40000 ALTER TABLE `password_backup` DISABLE KEYS */;
INSERT INTO `password_backup` VALUES (11,'abcd','$2y$10$VRTJLAbyD/Ij5zZwJlYrse4J/o6AvoC9j3l2JRIabtGPVhYPL7E4K'),(9,'bkeitch8','vxKIyKQhbxC'),(2,'bkleingrub1','w28jtOBlYcc'),(10,'bmccorley9','jwui4B6AW'),(3,'bsleford2','Sjpk2vMZ6N'),(4,'hfranciskiewicz3','pAgFODt42'),(5,'jcapelle4','p8AiSP5tm3'),(8,'jpicot7','MKZuyuT'),(7,'nhillam6','y6cBK5T8M'),(6,'ntatam5','nHrelUoCxxt'),(1,'vtidmas0','qe9uKx6JrZ');
/*!40000 ALTER TABLE `password_backup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prem`
--

DROP TABLE IF EXISTS `prem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prem` (
  `uname` varchar(100) DEFAULT 'default',
  KEY `uname` (`uname`),
  CONSTRAINT `prem_ibfk_1` FOREIGN KEY (`uname`) REFERENCES `user` (`uname`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prem`
--

LOCK TABLES `prem` WRITE;
/*!40000 ALTER TABLE `prem` DISABLE KEYS */;
INSERT INTO `prem` VALUES (NULL),(NULL),(NULL),(NULL),(NULL),('12345jesse'),('abcdefg'),('bkleingrub1'),('bsleford2'),('hfranciskiewicz3'),('jcapelle4'),('jesse12345'),('nhillam6'),('vtidmas0');
/*!40000 ALTER TABLE `prem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `uname` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`uname`),
  UNIQUE KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (14,'1234','$2y$10$jLgRI1drDPMGcdG2vZ5gneSLJge9l65NgSpg96iJHojCCRSusnyQG'),(21,'12345jesse','$2y$10$A0L6oGK/xx9gUsUr5KrATeoLiPGAgO62Qe34EAS7eQ65402dkBG8W'),(20,'12ab','$2y$10$m8IYLy8FWhKJOLmqCt3pKOmyYTfDvf1oke5v4JULHjvZJhY6q5jci'),(11,'abcd','$2y$10$AftlYSZlMr3feps04IRIj.jV6rYo/hzIZ2dB17VRQoAOmPRmIRgOa'),(12,'abcde','$2y$10$EeDIs8vi0C4RMYw2e7YwiOyyh7fiXy3OHO9zvHSEgTYzGNqWl1bum'),(16,'abcdef','$2y$10$55SsHd5IkhpuNpddUeCnaeN/Q61HJLooC5.PN6xi3nuNR5xS8aC5C'),(19,'abcdefg','$2y$10$1FT8agBgYdNL6m48CpfsEOyZIjIutWHBQr.dISWOklzR.G4MiUP9W'),(13,'apples123','$2y$10$duOZnuZ8lLTAXD3mGFMpQuENGss5V9g5Ui2.G2kQ/fXzzhMYwwsOS'),(9,'bkeitch8','$2y$10$RjACSzrDdy0M4jKUOeMJSuIE6DlK11CfFc7F3sM3res6ueS4rSiAq'),(2,'bkleingrub1','$2y$10$NMpc2QkqfUPfFPJdGBIi6uVsZcfE9yVLeSjdQUarHg10VP68Td04K'),(10,'bmccorley9','$2y$10$eXjPPyfky20iN7ZGrKyKTOURrPA3X2Tzt0Hk2d7CNLsCbIsB4BZYm'),(3,'bsleford2','$2y$10$LGOxAh/Mugwz.GJZ2Okq4eT3Jd1rRYieKcob8D7N01LLHFiA6Z3T2'),(4,'hfranciskiewicz3','$2y$10$vL1ZE58XmsGByS7kOC2/nupahr5fjCOVNEf4pb3dVAtkWDyMKEMmW'),(5,'jcapelle4','$2y$10$2cfreXGOHFfPdGzskKZkcuK1kT5AVi5p47fCcmkVDmCTRJ9pLWkze'),(23,'jesse12345','$2y$10$ZSVJYIWeo37/C7XCXv1.3uktWcgl1S2TLm1mytyRTTdExltRSvVT.'),(8,'jpicot7','$2y$10$BuOo8RGIlL1tg.YrxjKZvu/PWSfmPeOvL28M6WTBbhMXfVc8FZZJ6'),(7,'nhillam6','$2y$10$c3lIrvQ1DBELRO3EvSzsh.8zD1snjcNZ3e9Ofgy7WHd.gtIT2nDGq'),(6,'ntatam5','$2y$10$2kVjdaAn2U4u5D/UxG1llukCAHz9sIULJ4SfSfYs0iJhdRcyiuST2'),(22,'svargas12','$2y$10$NFGgXNQe.O2Kc2zmXIGK5Ob5uIUp7tzHOBiLqZIUQ2fbHRRJSowvG'),(15,'test1','$2y$10$iCg5yr.zQ4/F8mHCSb5Neen.GtC.oxj.dHRKxSoUkEjraMqDPkI.W'),(1,'vtidmas0','$2y$10$Tx5RrNIZlWjuPKyZG9HPNe4vIXXFc6NUKVSG1skluOeYYNT6l6XYq');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`jkuo`@`localhost`*/ /*!50003 TRIGGER UserDelete
BEFORE DELETE ON user
FOR EACH ROW
BEGIN
    INSERT INTO user_history (uid, uname, password)
    SELECT uid, uname, password
    FROM user
    WHERE uid = OLD.uid;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `user_history`
--

DROP TABLE IF EXISTS `user_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_history` (
  `uid` int(11) DEFAULT NULL,
  `uname` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_history`
--

LOCK TABLES `user_history` WRITE;
/*!40000 ALTER TABLE `user_history` DISABLE KEYS */;
INSERT INTO `user_history` VALUES (17,'testing','testing'),(18,'whatever','whatever');
/*!40000 ALTER TABLE `user_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `view_1`
--

DROP TABLE IF EXISTS `view_1`;
/*!50001 DROP VIEW IF EXISTS `view_1`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `view_1` (
  `eligibledates` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `view_2`
--

DROP TABLE IF EXISTS `view_2`;
/*!50001 DROP VIEW IF EXISTS `view_2`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `view_2` (
  `uid` tinyint NOT NULL,
  `uname` tinyint NOT NULL,
  `password` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `view_3`
--

DROP TABLE IF EXISTS `view_3`;
/*!50001 DROP VIEW IF EXISTS `view_3`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `view_3` (
  `uname` tinyint NOT NULL,
  `password` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Current Database: `sleep_tracker`
--

USE `sleep_tracker`;

--
-- Final view structure for view `view_1`
--

/*!50001 DROP TABLE IF EXISTS `view_1`*/;
/*!50001 DROP VIEW IF EXISTS `view_1`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jkuo`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_1` AS select cast(`log`.`stime` as date) AS `eligibledates` from `log` where `log`.`isstart` = 1 and cast(`log`.`stime` as time) <= '21:00:00' order by cast(`log`.`stime` as date) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_2`
--

/*!50001 DROP TABLE IF EXISTS `view_2`*/;
/*!50001 DROP VIEW IF EXISTS `view_2`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jkuo`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_2` AS select distinct `user`.`uid` AS `uid`,`user`.`uname` AS `uname`,`user`.`password` AS `password` from (`log` join `user` on(`log`.`uname` = `user`.`uname`)) where `log`.`stime` <= '2022-04-22' and `log`.`etime` >= '2022-03-22' */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_3`
--

/*!50001 DROP TABLE IF EXISTS `view_3`*/;
/*!50001 DROP VIEW IF EXISTS `view_3`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jkuo`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_3` AS select `buddies`.`uname` AS `uname`,`user`.`password` AS `password` from (`log` join (`buddies` join `user` on(`buddies`.`uname` = `user`.`uname`)) on(`log`.`uname` = `buddies`.`pname`)) where `log`.`logid` = 3 */;
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

-- Dump completed on 2022-05-19 18:29:13
