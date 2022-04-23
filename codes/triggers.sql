DROP TRIGGER IF EXISTS UserDelete;



DELIMITER //

CREATE TRIGGER UserDelete
BEFORE DELETE ON client
FOR EACH ROW
BEGIN
    INSERT INTO client_history (userid, username, password)
    SELECT userid, username, password
    FROM client
    WHERE userid = OLD.userid;
END
//

DELIMITER ;
