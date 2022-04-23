
-- for registering new users

DROP PROCEDURE IF EXISTS `RegisterUser`;

DELIMITER //

CREATE PROCEDURE `RegisterUser`(uname varchar(100), passhash text)
BEGIN
    START TRANSACTION;

    SELECT COUNT(*) INTO @usernameCount
    FROM client
    WHERE username = uname;

    IF @usernameCount > 0 THEN
        SELECT "false" as 'Result', "Username already exists" AS 'Error';
    ELSE
        INSERT INTO client (username, password) VALUES (uname, passhash);
        SELECT "true" AS 'Result', NULL as 'Error';
    END IF;
    
    COMMIT;
END;
//
DELIMITER ;




-- for deleting a log
-- ***CREATED DUPLICATE TABLE CALLED “log_backup” TO TEST THIS***

DROP PROCEDURE IF EXISTS `DeleteLog`;

DELIMITER //
CREATE PROCEDURE `DeleteLog` (inputLogID int)
BEGIN
    START TRANSACTION;
    SELECT COUNT(*) INTO @logCount
    FROM log
    WHERE logid = inputLogID;
    
    IF @logCount > 0 THEN
    DELETE FROM log_backup where logid = inputLogID;
        SELECT "true" as 'Result', "log successfully deleted" AS 'Error';
    
    ELSE
        SELECT "false" as 'Result', "log does not exist" AS 'Error';
    END IF;
    COMMIT;
 END;
//
DELIMITER ;






-- to calculate the duration of a sleep session
-- while loop reference: https://stackoverflow.com/questions/5125096/for-loop-example-in-mysql
-- reference for summing date time objects: https://stackoverflow.com/questions/40456972/mysql-sum-datetime
-- ours was already in hh:mm:ss format because of datediff().

DROP PROCEDURE IF EXISTS `TotalSleepPerSession`;

DELIMITER //
CREATE PROCEDURE `TotalSleepPerSession` (inputPID int)
BEGIN
    START TRANSACTION;
    SELECT COUNT(*) INTO @logCount
    FROM log
    WHERE parentid = inputPID;
    
    IF @logCount > 0 THEN

        select null as 'Error', 
        sec_to_time(sum(time_to_sec(TIMEDIFF(enddatetime, startdatetime))))
        as 'duration' 
        from log 
        where parentid = inputPID;

        -- SELECT "true" as 'Result', "duration successfully calculated" AS 'Error';
    
    ELSE
        select 'parent id does not exist' as 'Error', 
        -1 as 'duration';
        -- SELECT "false" as 'Result', "parent id does not exist" AS 'Error';
    END IF;
    COMMIT;
 END;
//
DELIMITER ;






-- -- notes:
-- -- select parentid, TIMEDIFF(enddatetime, startdatetime) from log where parentid = 22;

-- select TIMEDIFF(enddatetime, startdatetime) into @subDuration
-- from log 
-- where parentid = inputPID;



-- template for while loop:

--         -- DECLARE indexCounter int unsigned default 0;
--         -- START TRANSACTION;
--             -- WHILE indexCounter < @logCount
--             --     -- action
--             --     SET indexCounter = indexCounter + 1;
--             -- END WHILE;
--         -- COMMIT;


