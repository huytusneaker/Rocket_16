-- 2. Viết lệnh để
--  a) Lấy tất cả các nhân viên thuộc Việt nam
-- b) Lấy ra tên quốc gia của employee có email là "nn03@gmail.com"
-- c) Thống kê mỗi country, mỗi location có bao nhiêu employee đang 
-- làm việc.


--  a) Lấy tất cả các nhân viên thuộc Việt nam
SELECT 		* 
FROM 		Employee e INNER JOIN Location l ON e.location_id = l.location_id
					   INNER JOIN Country c ON c.country_id = l.country_id
WHERE 		country_name LIKE 'Việt Nam';               

-- b) Lấy ra tên quốc gia của employee có email là "nn03@gmail.com"

SELECT 		email, c.country_name
FROM 		Employee e INNER JOIN Location l ON e.location_id = l.location_id
					   INNER JOIN Country c ON c.country_id = l.country_id
WHERE 		email like 'nn03@gmail.com';


-- c) Thống kê mỗi country, mỗi location có bao nhiêu employee đang 
-- làm việc.

SELECT		l.street_address, c.country_name, count(*) as num_of_employee
FROM 		Employee e INNER JOIN Location l ON e.location_id = l.location_id
					   INNER JOIN Country c ON c.country_id = l.country_id
GROUP BY	l.location_id, c.country_id;

-- 3. Tạo trigger cho table Employee chỉ cho phép insert mỗi quốc gia có tối đa 
-- 10 employee
DROP TRIGGER IF EXISTS trigger_insert_q3;
DELIMITER $$
		CREATE TRIGGER trigger_insert_q3
        BEFORE INSERT ON `Employee`
        FOR EACH ROW
				BEGIN
						DECLARE		num_of_employee TINYINT UNSIGNED;
                        SELECT 			COUNT(*) INTO num_of_employee
                        FROM 			Employee e INNER JOIN Location l ON e.location_id = l.location_id
												   INNER JOIN Country c ON c.country_id = l.country_id
						WHERE			l.location_id = NEW.location_id
						GROUP BY		c.country_id;
                        
                        IF num_of_employee >= 10
                        THEN
							SIGNAL SQLSTATE '16080'
                            SET MESSAGE_TEXT = 'Can hot have more than 10 people from a country';
						END IF;
				END$$
DELIMITER ;



INSERT INTO `Employee`(full_name,email,location_id)			 
										 VALUES ('Dữ liệu test', 'test@gmial.com', '2');






-- 4. Hãy cấu hình table sao cho khi xóa 1 location nào đó thì tất cả employee ở 
-- location đó sẽ có location_id = null

DROP TRIGGER IF EXISTS		trigger_q4;
DELIMITER $$
		CREATE TRIGGER  		trigger_q4
        BEFORE DELETE ON Location
        FOR EACH ROW
				BEGIN
						UPDATE		Employee
                        SET			location_id = null
                        WHERE		location_id = OLD.location_id;
                END$$

DELIMITER ;

DELETE
FROM		Location
WHERE 		Location_id = 9 ;


