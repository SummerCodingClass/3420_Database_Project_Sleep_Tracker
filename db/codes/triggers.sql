DROP TRIGGER IF EXISTS UserDelete;



DELIMITER //

CREATE TRIGGER UserDelete
BEFORE DELETE ON user
FOR EACH ROW
BEGIN
    INSERT INTO user_history (uid, uname, password)
    SELECT uid, uname, password
    FROM user
    WHERE uid = OLD.uid;
END
//

DELIMITER ;
