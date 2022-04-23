DROP TABLE IF EXISTS `premiumbuddieswithothers`;
DROP TABLE IF EXISTS `premiumclient`;
DROP TABLE IF EXISTS `log`;
DROP TABLE IF EXISTS `client`;
DROP TABLE IF EXISTS `client_history`;

--  on delete set null on update cascade


CREATE TABLE `client` (
  `userid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`username`),
  UNIQUE (`userid`)
); 


CREATE TABLE `log` (
  `logid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) Default "default",
  `parentid` int(11) DEFAULT 0,
  `startdatetime` datetime NOT NULL,
  `isoverallstart` tinyint(1) NOT NULL,
  `enddatetime` datetime NOT NULL,
  `isoverallend` tinyint(1) NOT NULL,
  PRIMARY KEY (`logid`),
  KEY `username` (`username`),
  CONSTRAINT `log_ibfk_1` FOREIGN KEY (`username`) REFERENCES `client` (`username`)
  ON DELETE SET NULL ON UPDATE CASCADE
);


CREATE TABLE `premiumclient` (
  `username` varchar(100) default "default",
  KEY `username` (`username`),
  CONSTRAINT `premiumclient_ibfk_1` FOREIGN KEY (`username`) REFERENCES `client` (`username`)
  ON DELETE SET NULL ON UPDATE CASCADE
);


CREATE TABLE `premiumbuddieswithothers` (
  `premusername` varchar(100) default null,
  `username` varchar(100) default null,
  KEY `premusername` (`premusername`),
  KEY `username` (`username`),
  CONSTRAINT `premiumbuddieswithothers_ibfk_1` FOREIGN KEY (`premusername`) REFERENCES `premiumclient` (`username`)
  ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `premiumbuddieswithothers_ibfk_2` FOREIGN KEY (`username`) REFERENCES `client` (`username`)
  ON DELETE SET NULL ON UPDATE CASCADE
);




-- tables for record history --


CREATE TABLE `client_history` (
  `userid` int(11) default null,
  `username` varchar(100) default NULL,
  `password` varchar(100) default NULL
); 





-- source triggers.sql;


-- source workingsqls/create_client.sql;
-- source workingsqls/create_log.sql;
-- source workingsqls/create_premiumclient.sql;
-- source workingsqls/create_premiumbuddieswithothers.sql;




-- -- test
-- -- insert into client values ("default", "asdfjk");
--  insert into log (startdatetime, isoverallstart, enddatetime, isoverallend) values ("1111-11-11 11:11:11", 1, "1111-11-11 11:11:11", 1);
-- delete from client where username = "default";
