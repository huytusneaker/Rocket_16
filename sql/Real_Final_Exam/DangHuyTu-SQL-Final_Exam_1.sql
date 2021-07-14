----------------- xóa database đã tồn tại
DROP DATABASE IF EXISTS StudentManagement;
----------------- tạo database
CREATE DATABASE StudentManagement;
----------------- sử dụng database vừa tạo
USE StudentManagement;
----------------- tạo bảng Student:
CREATE TABLE `Student`(
	ID			TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `Name`		VARCHAR(50),
    `Age`		TINYINT,
    Gender		TINYINT
);

----------------- tạo bảng Subject
CREATE TABLE `Subject`(
	ID			TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	`Name`		VARCHAR(50)
);

-------------- tạo bảng StudnetSubject
CREATE TABLE `StudentSubject`(
	StudentID		TINYINT UNSIGNED,
	SubjectID		TINYINT UNSIGNED,
	Mark			DOUBLE,
    `Date`			Date,
    CONSTRAINT pk_studentsubject PRIMARY KEY (StudentID,SubjectID)
);

-------------- Thêm dữ liệu vào bảng Student
INSERT INTO `student` (`Name`, `Age`, `Gender`) VALUES 						('Đặng Huy Tú', '21', 1),
																			('Bùi Thị Yến', '22', 0),
																			('Nguyễn Văn Tuân', '20', 1);

-------------- Thêm dữ liệu vào bảng Subject
INSERT INTO `subject` (`Name`) VALUES 						('Cấu trúc dữ liệu giải thuật'),
															('Lập trình C#'),
															('Lập trình Windows'),
															('Kiến trúc máy tính'),
															('Kỹ thuật lập trình');


-------------- Thêm dữ liệu vào bảng StudentSubject
INSERT INTO `studentsubject` (`StudentID`, `SubjectID`, `Mark`, `Date`) VALUES 						('1', '1', '9', '2021/07/04'),
																									('1', '2', '8', '2021/06/04'),
																									('2', '3', '7', '2021/05/04'),
																									('2', '1', '7.5', '2021/04/04'),
																									('2', '2', '3', '2021/05/04'),
																									('3', '1', '1', '2021/04/04'),
																									('3', '2', '10', '2021/05/09'),
																									('3', '3', '4', '2021/01/04');

----------------------------------- Hiển thị dữ liệu từ các bảng vừa tạo
SELECT * FROM Student;
SELECT * FROM `Subject`;
SELECT * FROM StudentSubject;


-- 2. Viết lệnh để
-- a) Lấy tất cả các môn học không có bất kì điểm nào 

SELECT		*
FROM		`Subject` 
WHERE		ID NOT IN (		SELECT		s.ID
							FROM		`Subject` s INNER JOIN	StudentSubject j ON s.ID = j.SubjectID);
                            



-- b) Lấy danh sách các môn học có ít nhất 2 điểm

SELECT		Name, COUNT(*)	AS mum_of_mark
FROM		`Subject` s INNER JOIN	StudentSubject j ON s.ID = j.SubjectID
GROUP BY	s.ID
HAVING		mum_of_mark >= 2;









-- 3. Tạo view có tên là "StudentInfo" lấy các thông tin về học sinh bao gồm: 
-- Student ID,Subject ID, Student Name, Student Age, Student Gender, 
-- Subject Name, Mark, Date
-- (Với cột Gender show 'Male' để thay thế cho 0, 'Female' thay thế cho 1 và 
-- 'Unknow' thay thế cho null)

DROP VIEW IF EXISTS StudentInfo;
CREATE VIEW		StudentInfo	AS

	SELECT 		t.ID AS StudentID , s.ID AS SubjectID, t.`Name` AS StudentName, Age,CASE
										  WHEN 		Gender = 1 THEN 'Male'
                                          WHEN		Gender = 0 THEN 'Female'
                                          ELSE 'Unknown'
                                          END	AS Gender,
													s.`Name` AS SubjectName, Mark, `Date`
																  
    FROM		Student		t	LEFT JOIN (`Subject` s INNER JOIN	StudentSubject j ON s.ID = j.SubjectID)
								ON t.ID = j.StudentID;
							
SELECT * FROM StudentInfo;







-- 4. Không sử dụng On Update Cascade & On Delete Cascade
-- a) Tạo trigger cho table Subject có tên là SubjectUpdateID: 
-- Khi thay đổi data của cột ID của table Subject, thì giá trị tương 
-- ứng với cột SubjectID của table StudentSubject cũng thay đổi 
-- theo



-------------------- xóa trigger nếu tồn tại
DROP TRIGGER IF EXISTS SubjectUpdateID;

----------------------- Tạo trigger
DELIMITER $$
		CREATE TRIGGER 	SubjectUpdateID
        BEFORE UPDATE ON `Subject`
        FOR EACH ROW
				BEGIN
						UPDATE	StudentSubject
                        SET		SubjectID = NEW.ID                        
                        WHERE	SubjectID = OLD.ID;
                END$$
DELIMITER ;
;
-------------------------- Test thử câu lệnh update
UPDATE		`Subject`
SET			ID = 10
WHERE		ID = 2;





-- b) Tạo trigger cho table Student có tên là StudentDeleteID:
-- Khi xóa data của cột ID của table Student, thì giá trị tương ứng với
-- cột SubjectID của table StudentSubject cũng bị xóa theo

DROP TRIGGER IF EXISTS StudentDeleteID;
DELIMITER $$
		CREATE TRIGGER StudentDeleteID
        BEFORE DELETE ON `Student`
        FOR EACH ROW	
				BEGIN	
						DELETE 
                        FROM		StudentSubject
                        WHERE		StudentID	= OLD.ID;
                END$$

DELIMITER ;

DELETE
FROM		Student 
WHERE		ID = 4;


-- 5. Viết 1 store procedure (có parameters: student name) sẽ xóa tất cả các 
-- thông tin liên quan tới học sinh có cùng tên như parameter
-- Trong trường hợp nhập vào student name = "*" thì procedure sẽ xóa tất cả 
-- các học sinh

DROP PROCEDURE IF EXISTS cau5;
DELIMITER $$
		CREATE PROCEDURE	cau5(IN 	stdname VARCHAR(50))
        BEGIN
			DECLARE newid TINYINT UNSIGNED;
            SET newid = (SELECT ID
						  FROM	Student
                          WHERE	`Name`= stdname);
                          
			IF stdname = '*'
            THEN	
					DELETE 
					FROM 	`Student`;
                    
                    DELETE 
                    FROM	StudentSubject;
			ELSE
				DELETE
                FROM		`Student`
                WHERE		`Name` like stdname;
                
                DELETE
                FROM		`StudentSubject`
                WHERE		`StudentID` = newid;
			END IF;
			
            
        END$$

DELIMITER ;


CALL	cau5 ('trần văn nhàn');

CALL cau5 ('*');
















