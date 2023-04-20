DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `assignTask`(IN `valUserId` INT, IN `valTaskId` INT, IN `valDateDue` DATETIME, IN `valStartTime` DATETIME, IN `valEndTime` DATETIME, IN `valRemarks` VARCHAR(100), IN `valStatusId` INT(12))
BEGIN

INSERT INTO `user_tasks`(`user_id`, `task_id`, `due_date`, `start_time`, `end_time`, `remarks`, `status_id`, `created_at`) VALUES (valUserId, valTaskId, valDateDue, valStartTime, valEndTime, valRemarks, valStatusId, NOW());


IF  (SELECT ROW_COUNT() > 0) THEN
        
            SELECT "Task saved succesfully" AS message, 200 AS "code";

        ELSE

            SELECT "An error occured when saving the task. Please try again" AS message, 400 AS "code";
            
            END IF;


END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllUsers`()
BEGIN

SELECT `email_address` FROM `users`;

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `login`(IN `valEmail` VARCHAR(100))
BEGIN

SELECT `email_address`, `password` FROM `users` WHERE `email_address` = valEmail LIMIT 1;

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateTask`(IN `valStatusId` INT(12), IN `valUserId` INT(11), IN `valTaskId` INT(11))
BEGIN

UPDATE `user_tasks` SET `status_id`=valStatusId, `updated_at`=NOW() WHERE `user_id`=valUserId AND `task_id`=valTaskId;

IF  (SELECT ROW_COUNT() > 0) THEN
        
            SELECT "User task updated succesfully" AS message, 200 AS "code";

        ELSE

            SELECT "An error occured when updating the user task. Please try again" AS message, 400 AS "code";

            END IF;

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `userRegistration`(IN `valEmail` VARCHAR(100), IN `valPassword` VARCHAR(100))
BEGIN

IF ((SELECT COUNT(`email_address`) FROM `users` WHERE `email_address` = valEmail) = 0) THEN

INSERT INTO `users`(`email_address`, `password`, `created_at`) VALUES (valEmail, valPassword, NOW());

IF  (SELECT ROW_COUNT() > 0) THEN
        
            SELECT "User registered succesfully" AS message, 200 AS "code";

        ELSE

            SELECT "An error occured when registering the user. Please try again" AS message, 400 AS "code";

        END IF;

ELSE

SELECT "User already exists" AS message, 400 AS "code";

END IF;

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addTask`(IN `valName` VARCHAR(100), IN `valDescription` VARCHAR(255), IN `valDueDate` DATETIME, IN `valStatusId` INT(12))
BEGIN

INSERT INTO `tasks`(`name`, `description`, `due_date`, `status_id`, `created_at`) VALUES (valName, valDescription, valDueDate, valStatusId, NOW());


IF  (SELECT ROW_COUNT() > 0) THEN
        
            SELECT "Task saved succesfully" AS message, 200 AS "code";

        ELSE

            SELECT "An error occured when saving the task. Please try again" AS message, 400 AS "code";
            
            END IF;


END$$
DELIMITER ;
