
-- for registering new users

DROP PROCEDURE IF EXISTS `RegisterUser`;

DELIMITER //

CREATE PROCEDURE `RegisterUser`(unameinput varchar(100), passhash text)
BEGIN
    START TRANSACTION;

    SELECT COUNT(*) INTO @usernameCount
    FROM user
    WHERE uname = unameinput;

    IF @usernameCount > 0 THEN
        SELECT "false" as 'Result', "Username already exists" AS 'Error';
    ELSE
        INSERT INTO user (uname, password) VALUES (unameinput, passhash);
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
    DELETE FROM log where logid = inputLogID;
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
    WHERE pid = inputPID;
    
    IF @logCount > 0 THEN

        SELECT null as 'Error', 
        sec_to_time(sum(time_to_sec(TIMEDIFF(etime, stime))))
        as 'duration' 
        from log 
        where pid = inputPID;

        -- SELECT "true" as 'Result', "duration successfully calculated" AS 'Error';
    
    ELSE
        SELECT 'parent id does not exist' as 'Error', 
        -1 as 'duration';
        -- SELECT "false" as 'Result', "parent id does not exist" AS 'Error';
    END IF;
    COMMIT;
 END;
//
DELIMITER ;



-- retrieves all users that have shared access to a log when a logID is entered

DROP PROCEDURE IF EXISTS `LogSharedWith`;
DELIMITER //
Create procedure `LogSharedWith` (inputLogID int)
BEGIN
        
    SELECT buddies.uname, user.password 
    from log inner join buddies natural join user
    on log.uname = buddies.pname 
    where logid = inputLogID;

END;
//
DELIMITER ;





-- create log

DROP PROCEDURE IF EXISTS `AddLog`;

DELIMITER //
Create procedure `AddLog` (unameInput varchar(100), pidInput int(11), stimeInput datetime, isstartInput tinyint(1), etimeInput datetime, isendInput tinyint(1))
BEGIN
        
    START TRANSACTION;

    SELECT COUNT(*) INTO @usernameCount
    FROM user
    WHERE uname = unameInput;

    IF @usernameCount > 0 THEN

        IF isstartInput = true THEN
            -- INSERT INTO log (uname, pid, stime, isstart, etime, isend)
            -- VALUES (unameInput, NULL, stimeInput, isstartInput, etimeInput, isendInput);

            INSERT INTO log (uname, stime, isstart, etime, isend)
            VALUES (unameInput, stimeInput, isstartInput, etimeInput, isendInput);

            SELECT last_insert_id() into @newParentID;

            UPDATE log SET pid = logid where logid = @newParentID;

            -- REFER TO THIS WHEN WRITING PHP
            SELECT "true" AS "New Parent ID", @newParentID AS "pid", "true" AS "Result", NULL AS "Error";

        ELSE

            INSERT INTO log (uname, pid, stime, isstart, etime, isend)
            VALUES (unameInput, pidInput, stimeInput, isstartInput, etimeInput, isendInput);

            SELECT "false" AS "New Parent ID", pidInput AS "pid", "true" AS "Result", NULL AS "Error";

        END IF;

    ELSE
        SELECT "false" as "New Parent ID", NULL as "pid", "false" AS 'Result', "user not found" as 'Error';
    END IF;
    
    COMMIT;

END;
//
DELIMITER ;








-- (unameInput varchar(100), pidInput int(11), stimeInput datetime, isstartInput tinyint(1), etimeInput datetime, isendInput tinyint(1))
-- select * from log where logid >= 50;

-- call `AddLog` ("abcd", NULL, "2022-05-01", "1", "2022-05-03", "0");
-- call `AddLog` ("abcd", 51, "2022-05-02", "0", "2022-05-03", "0");
-- call `AddLog` ("abcd", 51, "2022-05-03", "0", "2022-05-04", "1");

-- call `AddLog` ("abcd", NULL, "2022-05-10", "1", "2022-05-13", "1");





-- // DISCLAIMER: 
-- // This procedure is copied and pasted from Jennifer's 3680 individual project 3: pocket list
-- // because the two projects can use the same mechanism. She is the only owner of the project she copied this from.

DROP PROCEDURE IF EXISTS `LogIn`;

DELIMITER //

CREATE PROCEDURE `LogIn`(unameInput varchar(100))
BEGIN
    START TRANSACTION;

    SELECT COUNT(*) INTO @usernameCount
    FROM user
    WHERE uname = unameInput;

    IF @usernameCount > 0 THEN
        SELECT password INTO @matchingPassword
        FROM user
        WHERE uname = unameInput;
        
        SELECT uid INTO @matchingUID
        FROM user 
        WHERE uname = unameInput;
        
        SELECT @matchingUID AS 'user_id', @matchingPassword AS 'user_password', Null AS 'Error', 'true' as 'Result';
    ELSE
        SELECT NULL AS 'user_id', NULL AS 'user_password', 'user not found in our database' AS 'Error', 'false' as 'Result';
    END IF;
    
    COMMIT;
END;
//
DELIMITER ;








-- -- notes:
-- -- SELECT pid, TIMEDIFF(etime, stime) from log where pid = 22;

-- SELECT TIMEDIFF(etime, stime) into @subDuration
-- from log 
-- where pid = inputPID;








-- By Jesse:


DROP PROCEDURE IF EXISTS `EditLog`;

DELIMITER //
Create procedure `EditLog` (logidInput int(11), unameInput varchar(100), pidInput int(11), stimeInput datetime, isstartInput tinyint(1), etimeInput datetime, isendInput tinyint(1))
BEGIN
       
-- START TRANSACTION;

IF (isstartInput = 1 AND isendInput = 1) THEN

    select pid INTO @parentID
    FROM log
    where logID = logidInput;

    IF @parentID != pidInput || stimeInput > etimeInput THEN
        SELECT "false" as 'Result', "Error" AS 'Error';

    ELSE
        UPDATE log
        SET stime = stimeInput, etime = etimeInput
        WHERE logid = logidInput;

    END IF;

ELSEIF (isstartInput = 0 AND isendInput = 0) THEN

    SELECT etime INTO @prevendtime
    FROM log
    where logID = logidInput-1;

    SELECT stime INTO @nextstarttime
    FROM log
    where logID = logidInput+1;
    
    IF etimeInput > @nextstarttime || stimeInput < @prevendtime || stimeInput > etimeInput THEN
        SELECT "false" as 'Result', "Error" AS 'Error';

    ELSE
        UPDATE log
        SET stime = stimeInput, etime = etimeInput
        WHERE logid = logidInput;

    END IF;

ELSEIF (isstartInput = 1 AND isendInput = 0) THEN

    select stime INTO @nextlogstart
    from log
    where logid = logidInput+1;

    IF etimeInput > @nextlogstart || stimeInput > etimeInput THEN
        SELECT "false" as 'Result', "Error" AS 'Error';

    ELSE
        UPDATE log
        SET stime = stimeInput, etime = etimeInput
        WHERE logid = logidInput;

    END IF;

ELSEIF (isstartInput = 0 AND isendInput = 1) THEN

    select etime INTO @prevlogend
    from log
    where logid = logidInput-1;

    IF stimeInput < @prevlogend || stimeInput > etimeInput THEN
        SELECT "false" as 'Result', "Error" AS 'Error';

    ELSE
        UPDATE log
        SET stime = stimeInput, etime = etimeInput
        WHERE logid = logidInput;

    END IF;

END IF;   
-- COMMIT;
END;
//
DELIMITER ;

-- can't upload a sleep session before another sleep session with the same parentID
-- call `EditLog` ("52", "abcd", "51", "2022-05-01 00:00:30", "0", "2022-05-02 00:01:01", "0");

-- can't have your sleep session end before it starts
-- call `EditLog` ("52", "abcd", "51", "2022-05-02 00:01:01", "0", "2022-05-01 00:01:01", "0");

-- on isstart = 1, see if you can make a new log start after your next log start time
-- call `EditLog` ("51", "abcd", "51", "2022-05-01 00:01:00", "1", "2022-05-01 00:01:03", "0");

-- on isend = 1, see if you can make a new log start before your prev log end time
-- call `EditLog` ("53", "abcd", "51", "2022-05-02 00:01:00", "0", "2022-05-04 00:01:00", "1");

-- replace just in case you mess up table
-- call `EditLog` ("52", "abcd", "51", "2022-05-01 00:01:01", "0", "2022-05-03", "0");

-- parent (should be able to input before pid = 50, but currently it cannot)
-- call `EditLog` ("51", "abcd", "51", "2022-04-01 00:01:01", "1", "2022-05-03", "0");






-- By Jeff:
-- shared logs with buddy (fetch all the logs that a user can view)

-- use this to retrieve all shared logs

DROP PROCEDURE IF EXISTS `LogSharedWithBuddy`;
DELIMITER //
Create procedure `LogSharedWithBuddy` (unameInput varchar(100))
BEGIN
        
    SELECT log.uname, log.stime, log.etime 
    from log inner join buddies
    on log.uname = buddies.pname 
    where buddies.uname = unameInput; 
END;
//
DELIMITER ;


-- All of jpicot7's buddies logs returned
-- call `LogSharedWithBuddy` ("jpicot7");

-- No logs returned since test1 has no buddies
-- call `LogSharedWithBuddy` ("test1");





-- By Jesse:
DROP PROCEDURE IF EXISTS `OneUserAllTheirLogs`;

DELIMITER //
CREATE PROCEDURE `OneUserAllTheirLogs`(unameInput varchar(100))
BEGIN
    START TRANSACTION;

    select count(*) into @usercount
    from user
    where uname = unameInput;

    IF @usercount > 0 THEN
        select log.* 
        from log natural join user
        where uname = unameInput 
        order by logid;

    ELSE
        SELECT "user does not exist" AS 'Error';

    END IF;
    
    COMMIT;
END;
//
DELIMITER ;



-- By Jesse... similar to Jeff's?


-- use this to retrieve shared logs from a specific premUser

DROP PROCEDURE IF EXISTS `ViewAllBuddyLogs`;

DELIMITER //
CREATE PROCEDURE `ViewAllBuddyLogs`(unameInput varchar(100), pnameInput varchar(100))
BEGIN
    START TRANSACTION;

    select count(*) into @usercount
    from user
    where uname = unameInput;

    select count(*) into @pusercount
    from user
    where uname = pnameInput;

    SELECT count(*) into @friendship
    from buddies
    where uname = unameInput and pname = pnameInput;

    IF @usercount > 0 AND @pusercount > 0 THEN

        IF @friendship > 0 THEN
            select log.* 
            from log
            where uname = pnameInput
            order by logid;

        ELSE
            SELECT "you are not buddies with that user" AS 'Error';

        END IF;

    ELSE 
        SELECT "username does not exist" AS 'Error';

    END IF;
    
    COMMIT;
END;
//
DELIMITER ;




-- By Sal:
DROP PROCEDURE IF EXISTS `AddBuddy`;

DELIMITER //

CREATE PROCEDURE `AddBuddy`(pnameInput varchar(100), unameInput varchar(100))
BEGIN
    START TRANSACTION;

    SELECT COUNT(*) INTO @userCount 
    FROM user
    WHERE uname = unameInput;

    SELECT COUNT(*) INTO @pUserCount 
    FROM prem
    WHERE uname = pnameInput;

    SELECT COUNT(*) INTO @combo 
    FROM buddies
    WHERE pname = pnameInput AND uname = unameInput;

    IF @userCount > 0 AND @pUserCount > 0 THEN

        IF @combo > 0 THEN

            SELECT "false" AS 'Result', "buddy relationship already exists" AS 'Error';

        ELSE
            INSERT INTO buddies (pname, uname) VALUES (pnameInput, unameInput);
            SELECT "true" AS 'Result', NULL AS 'Error';
        END IF;

        
    ELSE
        
        SELECT "false" AS 'Result', "user does not exist" AS 'Error';
        
    END IF;
    
    COMMIT;
END;
// 

DELIMITER ;






-- By Jesse:

DROP PROCEDURE IF EXISTS `MostRecentUserLog`;

DELIMITER //
CREATE PROCEDURE `MostRecentUserLog`(unameInput varchar(100))
BEGIN
    START TRANSACTION;

    select count(*) into @usercount
    from user
    where uname = unameInput;

    IF @usercount > 0 THEN
        select max(etime) 
        from log natural join user
        where uname = unameInput;

    ELSE
        SELECT "user does not exist" AS 'Error';

    END IF;
    
    COMMIT;
END;
//
DELIMITER ;



-- By Jesse:
-- DROP PROCEDURE IF EXISTS `BecomePremium`;

-- DELIMITER //

-- CREATE PROCEDURE `BecomePremium`(unameinput varchar(100))
-- BEGIN
--     START TRANSACTION;

--     SELECT COUNT(*) INTO @usernameCount
--     FROM user
--     WHERE uname = unameinput;

--     IF @usernameCount > 0 THEN
--         INSERT INTO prem (uname) VALUES (unameinput);
--         SELECT "true" AS 'Result', NULL as 'Error';
--     ELSE
--          SELECT "false" as 'Result', "Username doesn't exist" AS 'Error';
--     END IF;
    
--     COMMIT;
-- END;
-- //
-- DELIMITER;


-- By Jesse:
DROP PROCEDURE IF EXISTS `BecomePremium`;

DELIMITER //

CREATE PROCEDURE `BecomePremium`(unameinput varchar(100))
BEGIN
    START TRANSACTION;

    SELECT COUNT(*) INTO @premuserCount
    from prem
    where uname = unameinput;

    IF @premuserCount = 0 THEN
        INSERT INTO prem (uname) VALUES (unameinput);
        SELECT "true" AS 'Result', NULL as 'Error';
    ELSE
         SELECT "false" as 'Result', "Premium user already exists" AS 'Error';
    END IF;
    
    COMMIT;
END;
//
DELIMITER ;




-- By Sal:
DROP PROCEDURE IF EXISTS `DeleteBuddy`;

DELIMITER //

CREATE PROCEDURE DeleteBuddy (pnameInput varchar(100), unameInput varchar(100))
BEGIN

    START TRANSACTION;

    -- ENSURING uname IN USER
    SELECT COUNT(*) INTO @userCount
    FROM user
    WHERE uname = unameInput;

    -- ENSURING uname IS PREMIUM
    SELECT COUNT(*) INTO @pUserCount
    FROM prem
    WHERE uname = pnameInput;

        IF @pUserCount < 1 AND @userCount > 0 THEN
            SELECT "false" as 'Result', "you are not a premium user" AS 'Error';
        END IF;

        IF @pUserCount > 0 AND @userCount < 1 THEN
            SELECT "false" as 'Result', "username not found" AS 'Error';
        END IF;

        IF @pUserCount < 1 AND @userCount < 1 THEN
            SELECT "false" as 'Result', "you are not a premium user and the buddy you are trying to add is not found in our database" AS 'Error';
        END IF;

        SELECT COUNT(*) INTO @relationship
        FROM buddies
        WHERE pname = pnameInput AND uname = unameInput;

        IF (@userCount > 0 AND @pUserCount > 0) THEN

            IF @relationship < 1 THEN
                SELECT "false" as 'Result', "pname - uname relationship does not exist" AS 'Error';

            ELSE
                DELETE FROM buddies WHERE uname = unameInput AND pname = pnameInput;
                SELECT "true" AS 'Result', NULL AS 'Error';
            END IF;

        END IF;

    COMMIT;

END;

-- FAILS TO DELETE BECAUSE FIRST ENTERED USERNAME IS EITHER NOT REGISTERED OR NOT PREMIUM
-- Call DeleteBuddy("jpicot7", "ntatam5");

-- FAILS TO DELETE BECAUSE SECOND ENTERED USERNAME IS NOT REGISTERED
-- Call DeleteBuddy("vtidmas0", "svargas11");

-- FAILS TO DELETE BECAUSE FIRST ENTERED USERNAME IS EITHER NOT REGISTERED OR NOT PREMIUM
-- AND SECOND ENTERED USERNAME IS NOT REGISTERED
-- Call DeleteBuddy("ntatam5", "svargas11");

-- FAILS TO DELETE BECAUSE pname - uname RELATIONSHIP DOES NOT EXIST
-- Call DeleteBuddy("12345jesse", "abcd");

-- SUCCESSFULLY DELETED BUDDY
-- Call DeleteBuddy("vtidmas0", "bmccorley9");

//

DELIMITER ;






DROP PROCEDURE IF EXISTS `BuddiesWith`;

DELIMITER //
Create procedure `BuddiesWith` (pnameInput varchar(100))
BEGIN
        
    SELECT uname
    from buddies
    where pname = pnameInput;

END;
//
DELIMITER ;



DROP PROCEDURE IF EXISTS `optOutPremium`;

DELIMITER //

CREATE PROCEDURE `optOutPremium`(unameinput varchar(100))
BEGIN
    START TRANSACTION;

    SELECT COUNT(*) INTO @premuserCount
    from prem
    where uname = unameinput;

    IF @premuserCount > 0 THEN
        DELETE from prem where uname = unameinput;
        SELECT "true" AS 'Result', NULL as 'Error';
    ELSE
         SELECT "false" as 'Result', "user already not premium." AS 'Error';
    END IF;
    
    COMMIT;
END;
//
DELIMITER ;






DROP PROCEDURE IF EXISTS `fetchAllPremBuddies`;

DELIMITER //
CREATE PROCEDURE `fetchAllPremBuddies`(unameInput varchar(100))
BEGIN
    START TRANSACTION;

    select count(*) into @usercount
    from user
    where uname = unameInput;

    SELECT count(*) into @friendship
    from buddies
    where uname = unameInput;

    IF @usercount > 0 THEN

        IF @friendship > 0 THEN
            SELECT NULL AS 'Error', pname AS 'Result'
            from buddies
            where uname = unameInput
            order by pname;
        ELSE
            SELECT "you have not been shared any logs by another user" AS 'Error', NULL AS 'Result';
        END IF;

    ELSE 
        SELECT "username does not exist" AS 'Error', NULL AS 'Result';
    END IF;
    
    COMMIT;
END;
//
DELIMITER ;






-- By Sal:

DROP PROCEDURE IF EXISTS IsPremium;

DELIMITER //

CREATE PROCEDURE `IsPremium` (pnameInput varchar(100))
BEGIN
    START TRANSACTION;

    SELECT COUNT(*) INTO @userCount
    FROM user
    WHERE uname = pnameInput;

    SELECT COUNT(*) INTO @pUserCount
    FROM prem
    WHERE uname = pnameInput;

        IF @userCount > 0 AND @pUserCount > 0 THEN
            SELECT "true" AS 'Result', NULL AS 'Error';
        END IF;

        IF @userCount > 0 AND @pUserCount < 1 THEN
            SELECT "false" AS 'Result', "User is not premium" AS 'Error';
        END IF;

        IF @userCount < 1 THEN
            SELECT "false" AS 'Result', "User is not registered" AS 'Error';
        END IF;

    COMMIT;
END;


//

DELIMITER ;


-- -- By Jesse:

-- DELIMITER //
-- CREATE PROCEDURE `DeleteLog` (unameInput varchar(100),inputLogID int)
-- BEGIN
--     START TRANSACTION;
--     SELECT COUNT(*) INTO @logCount
--     FROM log
--     WHERE logid = inputLogID;

--     select pid INTO @parentID
--     from log where logid = inputLogID;
    
--     IF @logCount > 0 THEN
--     DELETE FROM log where pid = @parentID and uname = unameInput;
--         SELECT "true" as 'Result', "log successfully deleted" AS 'Res';
    
--     ELSE
--         SELECT "false" as 'Result', "parent id does not exist" AS 'Error';
--     END IF;
--     COMMIT;
--  END;
-- //
-- DELIMITER ;


-- By Jesse (modified):

DROP PROCEDURE IF EXISTS DeleteLog;

DELIMITER //
CREATE PROCEDURE `DeleteLog` (unameInput varchar(100), inputPID int)
BEGIN
    START TRANSACTION;
    SELECT COUNT(*) INTO @logCount
    FROM log
    WHERE pid = inputPID and uname = unameInput;  

    IF @logCount > 0 THEN
        DELETE FROM log where pid = inputPID and uname = unameInput;
        SELECT "true" as 'Result', "Log successfully deleted." AS 'Res';
    
    ELSE
        SELECT "false" as 'Result', "Parent ID does not exist for this user." AS 'Error';
    END IF;

    COMMIT;
 END;
//
DELIMITER ;






-- RESULTS IN USER NOT REGISTERED MESSAGE
-- Call IsPremium("svargas12");

-- RESULTS IN USER NOT PREMIUM MESSAGE
-- Call IsPremium("bkeitch8");

-- RESULTS IN USER IS PREMIUM MESSAGE
-- Call IsPremium("vtidmas0");




DROP PROCEDURE IF EXISTS EditIsDone;

DELIMITER //
CREATE PROCEDURE `EditIsDone` (unameInput varchar(100), inputLogID int, isEndInput varchar(3))
BEGIN
    START TRANSACTION;
    SELECT COUNT(*) INTO @logCount
    FROM log
    WHERE logid = inputLogID and uname = unameInput;
    
    IF @logCount > 0 THEN
        UPDATE log set isend = isEndInput where logid = inputLogID and uname = unameInput;
        SELECT "true" as 'Result', NULL AS 'Error';
    
    ELSE
        SELECT "false" as 'Result', "no log of such log id is found under this user" AS 'Error';
    END IF;
    COMMIT;
 END;
//
DELIMITER ;








-- template for while loop:

--         -- DECLARE indexCounter int unsigned default 0;
--         -- START TRANSACTION;
--             -- WHILE indexCounter < @logCount
--             --     -- action
--             --     SET indexCounter = indexCounter + 1;
--             -- END WHILE;
--         -- COMMIT;



-- Inserting Logs


-- Add Buddies


-- Retrieving list of buddies (from the REGULAR perspective)

-- Retrieving logs from buddies (from the REGULAR perspective)

-- Retrieving list of buddies (from the PREM perspective)

-- EditLog

-- Viewing all logs for 1 user

-- Maybe log in
