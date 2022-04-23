DROP TABLE IF EXISTS `premiumbuddieswithothers`;
DROP TABLE IF EXISTS `premiumclient`;
DROP TABLE IF EXISTS `log`;
DROP TABLE IF EXISTS `client`;




CREATE TABLE `client` (
  `username` varchar(100) NOT NULL on delete set null on update cascade,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `premiumclient` (
  `username` varchar(100) NOT NULL,
  KEY `username` (`username`),
  CONSTRAINT `premiumclient_ibfk_1` FOREIGN KEY (`username`) REFERENCES `client` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `premiumbuddieswithothers` (
  `premusername` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  KEY `premusername` (`premusername`),
  KEY `username` (`username`),
  CONSTRAINT `premiumbuddieswithothers_ibfk_1` FOREIGN KEY (`premusername`) REFERENCES `premiumclient` (`username`),
  CONSTRAINT `premiumbuddieswithothers_ibfk_2` FOREIGN KEY (`username`) REFERENCES `client` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;