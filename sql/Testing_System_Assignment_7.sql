-- Question 1: Tạo trigger không cho phép người dùng nhập vào Group có ngày tạo 
-- trước 1 năm trước
DROP TRIGGER IF EXISTS trigger_q1;
DELIMITER $$
		CREATE TRIGGER trigger_q1
		BEFORE INSERT ON `Account`
        FOR EACH ROW
        BEGIN
			IF YEAR(NOW()) <YEAR(NEW.CreateDate) THEN
            SIGNAL  SQLSTATE '16062'
            SET MESSAGE_TEXT= 'Năm nhập vào phải nhỏ hơn năm hiện tại';
            END IF;
        END$$


DELIMITER ;

INSERT INTO `Account`(Email,UserName,FullName,DepartmentId,PositionID,CreateDate)
VALUES				 ('dongtay12345','dongtay','danghuydong',3,7,'2022/09/01');



-- Question 2: Tạo trigger Không cho phép người dùng thêm bất kỳ user nào vào 
--  department "Sale" nữa, khi thêm thì hiện ra thông báo "Department
--  "Sale" cannot add more user"

DROP TRIGGER IF EXISTS trigger_q2;
DELIMITER $$
		CREATE TRIGGER trigger_q2
        BEFORE INSERT ON 	`Account`
        FOR EACH ROW
			BEGIN
				DECLARE dpID TINYINT UNSIGNED;
                SET dpID =(SELECT DepartmentID  FROM Department WHERE DepartmentName ='Phòng Sale');
                IF NEW.DepartmentID = dpID
                THEN 
					SIGNAL SQLSTATE '16064'
                    SET MESSAGE_TEXT = 'Can not add more user in Sale Department';
				END IF;
				
                   
            END$$
DELIMITER ;

INSERT INTO `Account`(Email,UserName,FullName,DepartmentId,PositionID,CreateDate)
VALUES				 ('dongtay123456','dongtay','danghuydong',2,7,'2021/05/01');

-- Question 3: Cấu hình 1 group có nhiều nhất là 5 user
DROP TRIGGER IF EXISTS trigger_q3;
DELIMITER $$
		CREATE TRIGGER trigger_q3
        BEFORE INSERT ON `GroupAccount`
        FOR EACH ROW
			BEGIN
					DECLARE soluong TINYINT;
                    SELECT 		COUNT(*) INTO soluong
                    FROM		`GroupAccount`
                    GROUP BY	NEW.GroupID;
                    
                    IF soluong >=5
                    THEN
                    SIGNAL SQLSTATE '16065'
                    SET MESSAGE_TEXT ='Can not have more than 5 members in a group';
                    END IF;
            END$$
        
DELIMITER ;

INSERT INTO `GroupAccount` (GroupID,AccountID,JoinDate)
VALUES						(1,13,'2021/05/02');




-- Question 4: Cấu hình 1 bài thi có nhiều nhất là 10 Question
DROP TRIGGER IF EXISTS trigger_q4;
DELIMITER $$
		CREATE TRIGGER trigger_q4
		BEFORE INSERT ON ExamQuestion
        FOR EACH ROW
			BEGIN
				DECLARE numofques TINYINT;
                
                SET numofques = (SELECT 	COUNT(*)
								 FROM 		ExamQuestion
                                 GROUP BY	NEW.ExamID);
				
                IF numofques >= 2
                THEN
					SIGNAL SQLSTATE '16066'
                    SET MESSAGE_TEXT = 'Can not have more than 2 questions in a exam';
				END IF;
				            
            END$$

DELIMITER ;

INSERT INTO ExamQuestion (ExamID, QuestionID)
VALUES						(6,1);






-- Question 5: Tạo trigger không cho phép người dùng xóa tài khoản có email là 
--  admin@gmail.com (đây là tài khoản admin, không cho phép user xóa), 
 -- còn lại các tài khoản khác thì sẽ cho phép xóa và sẽ xóa tất cả các thông 
--  tin liên quan tới user đó
DROP TRIGGER IF EXISTS trigger_q5;
DELIMITER $$
		CREATE TRIGGER trigger_q5
        BEFORE DELETE ON `Account`
        FOR EACH ROW
			BEGIN
				IF OLD.Email ='admin@gmail.com' 
                THEN
                SIGNAL SQLSTATE '16067'
                SET MESSAGE_TEXT = 'Can not delete admin account';
                ELSE
					
                     DELETE
                    FROM 		`Exam`
                    WHERE 		CreatorID = OLD.AccountID;
                    
                    DELETE
                    FROM 		`Question`
                    WHERE 		CreatorID = OLD.AccountID;
                    
                    DELETE
                    FROM 		`GroupAccount`
                    WHERE 		AccountID = OLD.AccountID;
                    
				END IF;
            END$$
DELIMITER ;

DELETE
FROM 		`Account`
WHERE		Email='admin@gmail.com';

DELETE
FROM 		`Account`
WHERE		Email='email10@gmail.com';



-- Question 6: Không sử dụng cấu hình default cho field DepartmentID của table 
--  Account, hãy tạo trigger cho phép người dùng khi tạo account không điền 
--  vào departmentID thì sẽ được phân vào phòng ban "waiting Department"
DROP TRIGGER IF EXISTS trigger_q6;
DELIMITER $$
		CREATE TRIGGER trigger_q6
		BEFORE INSERT ON `Account`
        FOR EACH ROW
			BEGIN
			
				IF NEW.DepartmentID is Null 
                THEN
					SET NEW.DepartmentID = 13;--  (SELECT DepartmentID
-- 											FROM	Department
--                                             WHERE DepartmentName = 'Waiting Department');
				END IF;
            END$$

DELIMITER ;
INSERT INTO `Account`(Email,UserName,FullName,DepartmentID,PositionID,CreateDate)
VALUES				 ('cutay@gmail.com','cutay','nguyenhatrung',Null,2,'2021/05/01');


-- Question 7: Cấu hình 1 bài thi chỉ cho phép user tạo tối đa 4 answers cho mỗi 
--  question, trong đó có tối đa 2 đáp án đúng.
DROP TRIGGER IF EXISTS trigger_q7;
DELIMITER $$
		CREATE TRIGGER trigger_q7
        BEFORE INSERT ON `answer`
        FOR EACH ROW
				BEGIN
					DECLARE num_ans TINYINT;
                    DECLARE num_true TINYINT;
                    
                    SELECT COUNT(*) INTO num_ans
                    FROM `Answer`
                    GROUP BY QuestionID
                    HAVING QUestionID = NEW.QuestionID;
                    
                    SELECT COUNT(*) INTO num_true
                    FROM `Answer`
                    WHERE isCorrect = 1
                    GROUP BY QuestionID
                    HAVING QUestionID = NEW.QuestionID;
                    
                    IF num_ans >=4
                    THEN
						SIGNAL SQLSTATE '16069'
                        SET MESSAGE_TEXT = 'Can not have more than 4 answers for a question';
                        
					ELSEIF num_true >=2
                    THEN
						SIGNAL SQLSTATE '16071'
                        SET MESSAGE_TEXT = 'Can not have more than 2 right answers for a question';
                    END IF;
                    
                END$$
DELIMITER ;

INSERT INTO `Answer` (AnswerID,Content,QuestionID,isCorrect)
VALUES				(10,'Câu hỏi 1',1,1);

INSERT INTO `Answer` (AnswerID,Content,QuestionID,isCorrect)
VALUES				(10,'Câu hỏi 1',3,0);
-- Question 8: Viết trigger sửa lại dữ liệu cho đúng: 
--  Nếu người dùng nhập vào gender của account là nam, nữ, chưa xác định 
--  Thì sẽ đổi lại thành M, F, U cho giống với cấu hình ở database






-- Question 9: Viết trigger không cho phép người dùng xóa bài thi mới tạo được 2 ngày
DROP TRIGGER IF EXISTS trigger_q9;
DELIMITER $$
		CREATE TRIGGER trigger_q9
		BEFORE DELETE ON `Exam`
        FOR EACH ROW
				BEGIN
						IF OLD.CreateDate <= DATE(DATE_SUB(NOW(),INTERVAL 2 DAY))
                        THEN
							SIGNAL SQLSTATE '16072'
                            SET MESSAGE_TEXT = 'Can not delete this new exam';
						END IF;
                END$$

DELIMITER ;

DELETE
FROM		`Exam`
WHERE 		CreateDate = '2021/07/10';



-- Question 10: Viết trigger chỉ cho phép người dùng chỉ được update, delete các 
--  question khi question đó chưa nằm trong exam nào
DROP TRIGGER IF EXISTS trigger_q10;
DELIMITER $$
		CREATE TRIGGER trigger_q10
        BEFORE DELETE  ON `question`
        FOR EACH ROW
				BEGIN
						IF EXISTS (SELECT 		* 
									FROM 		ExamQuestion
                                    WHERE		QuestionID = OLD.QuestionID)
                                    THEN
						SIGNAL SQLSTATE '16073'
                        SET MESSAGE_TEXT = 'Can not delete this question because it is being used on examQuestion';
                        END IF;
                END$$
DELIMITER ;	

DROP TRIGGER IF EXISTS trigger_q11;
DELIMITER $$
		CREATE TRIGGER trigger_q11
        BEFORE UPDATE  ON `question`
        FOR EACH ROW
				BEGIN
						IF EXISTS (SELECT 		* 
									FROM 		ExamQuestion
                                    WHERE		QuestionID = OLD.QuestionID)
                                    THEN
						SIGNAL SQLSTATE '16073'
                        SET MESSAGE_TEXT = 'Can not update this question because it is being used on examQuestion';
                        END IF;
                END$$
DELIMITER ;	
-- SET FOREIGN_KEY_CHECKS=1;
DELETE
FROM 	`Question`
WHERE	QuestionID = 2;

UPDATE `Question`
SET		QuestionID= 10
WHERE 	QuestionID =2;

-- Question 12: Lấy ra thông tin exam trong đó:
-- Duration <= 30 thì sẽ đổi thành giá trị "Short time"
-- 30 < Duration <= 60 thì sẽ đổi thành giá trị "Medium time"
-- Duration > 60 thì sẽ đổi thành giá trị "Long time"


SELECT  	ExamID, Title, CASE 
							WHEN  Duration <= 30 THEN 'Short Time'
                            WHEN  Duration <= 60 THEN 'Medium Time'
                            WHEN  Duration >60  THEN  'Long Time'
                            END AS Duration
                            
FROM 		`Exam` ;



-- Question 13: Thống kê số account trong mỗi group và in ra thêm 1 column nữa có tên 
--  là the_number_user_amount và mang giá trị được quy định như sau
-- Nếu số lượng user trong group =< 5 thì sẽ có giá trị là few
-- Nếu số lượng user trong group <= 20 và > 5 thì sẽ có giá trị là normal
-- Nếu số lượng user trong group > 20 thì sẽ có giá trị là higher


SELECT		GroupID, COUNT(*) as soluong, CASE
								WHEN	COUNT(*) <=5 THEN 'few'
                                WHEN 	COUNT(*) >5 && COUNT(*) <20 THEN 'Normal'
                                WHEN	COUNT(*) >20 THEN 'Higher'
                                END AS the_number_user_amount
FROM GroupAccount
GROUP BY 	GroupID;



-- Question 14: Thống kê số mỗi phòng ban có bao nhiêu user, nếu phòng ban nào 
--  không có user thì sẽ thay đổi giá trị 0 thành "Không có User"
SELECT 		d.DepartmentID, CASE
						  WHEN COUNT(AccountID) =0 THEN 'no user'
                          ELSE COUNT(AccountID)
                          END AS soluong
FROM 		Department d LEFT JOIN `Account` a ON  d.DepartmentID = a.DepartmentID
GROUP BY 	d.DepartmentID;


-- bài tập trên lớp
-- trigger xóa department thì sẽ chuyển hết thành viên về department 0;
DROP TRIGGER IF EXISTS trigger_del_department;
DELIMITER $$
		CREATE TRIGGER trigger_del_department
        BEFORE DELETE ON Department
        FOR EACH ROW
			BEGIN
				
					UPDATE	`Account`
                    SET		DepartmentID =0
                    WHERE	DepartmentID = OLD.DepartmentID;
            END$$
DELIMITER ;

DELETE
FROM Department
WHERE DepartmentID = 12;