DROP TABLE IF EXISTS `buddies`;
DROP TABLE IF EXISTS `prem`;
DROP TABLE IF EXISTS `log`;
DROP TABLE IF EXISTS `user`;
DROP TABLE IF EXISTS `user_history`;

--  on delete set null on update cascade


CREATE TABLE `user` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `uname` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`uname`),
  UNIQUE (`uid`)
); 


CREATE TABLE `log` (
  `logid` int(11) NOT NULL AUTO_INCREMENT,
  `uname` varchar(100) Default "default",
  `pid` int(11) DEFAULT 0,
  `stime` datetime NOT NULL,
  `isstart` tinyint(1) NOT NULL,
  `etime` datetime NOT NULL,
  `isend` tinyint(1) NOT NULL,
  PRIMARY KEY (`logid`),
  KEY `uname` (`uname`),
  CONSTRAINT `log_ibfk_1` FOREIGN KEY (`uname`) REFERENCES `user` (`uname`)
  ON DELETE SET NULL ON UPDATE CASCADE
);


CREATE TABLE `prem` (
  `uname` varchar(100) default "default",
  KEY `uname` (`uname`),
  CONSTRAINT `prem_ibfk_1` FOREIGN KEY (`uname`) REFERENCES `user` (`uname`)
  ON DELETE SET NULL ON UPDATE CASCADE
);


CREATE TABLE `buddies` (
  `pname` varchar(100) default null,
  `uname` varchar(100) default null,
  KEY `pname` (`pname`),
  KEY `uname` (`uname`),
  CONSTRAINT `buddies_ibfk_1` FOREIGN KEY (`pname`) REFERENCES `prem` (`uname`)
  ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `buddies_ibfk_2` FOREIGN KEY (`uname`) REFERENCES `user` (`uname`)
  ON DELETE SET NULL ON UPDATE CASCADE
);




-- tables for record history --


CREATE TABLE `user_history` (
  `uid` int(11) default null,
  `uname` varchar(100) default NULL,
  `password` varchar(100) default NULL
); 





-- source triggers.sql;


-- source workingsqls/create_client.sql;
-- source workingsqls/create_log.sql;
-- source workingsqls/create_premiumclient.sql;
-- source workingsqls/create_buddies.sql;




-- -- test
-- -- insert into user values ("default", "asdfjk");
--  insert into log (startdatetime, isoverallstart, enddatetime, isoverallend) values ("1111-11-11 11:11:11", 1, "1111-11-11 11:11:11", 1);
-- delete from user where uname = "default";
