 DROP VIEW IF EXISTS `view_1`;
 DROP VIEW IF EXISTS `view_2`;
 DROP VIEW IF EXISTS `view_3`;
--  DROP VIEW IF EXISTS `view_logrename`;
--  DROP VIEW IF EXISTS `premiumLogs`;

-- retrieves all sleep sessions that started before 9pm
--  VIEW 1
create view view_1 as
select date(stime) as eligibledates 
from log  
where isstart = 1 
and time(stime) <= "21:00:00" 
order by date(stime);


-- retrieves all logs that happened between 2022-03-22 and 2022-04-22
 -- View 2
create view view_2 as
select distinct user.* from log natural join user 
where stime <= "2022-04-22" and etime >= "2022-03-22";


-- retrieves regular users that have shared access to log 3.
-- View 3
create view view_3 as
select buddies.uname, user.password 
from log inner join buddies natural join user
on log.uname = buddies.pname 
where logid = 3;



-- create view view_logrename as
-- select logid, uname as l.uname, pid, stime, isstart, etime, isend
-- from log;

-- -- create view premiumLogs as
-- -- select *
-- -- from log inner join prembuddies natural join user
-- -- on log.uname = prembuddies.pname;




-- select *
-- from logrename inner join buddies natural join user
-- on log.uname = buddies.pname
-- where log.uname = buddies.pname;

-- create view view_premLogs as
-- select *
-- from log inner join buddies natural join user
-- on log.uname = buddies.pname;