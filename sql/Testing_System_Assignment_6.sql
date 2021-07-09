use Testing_system;

-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các 
 -- account thuộc phòng ban đó
 DROP PROCEDURE IF EXISTS proc_get_account;
 DELIMITER $$
	CREATE PROCEDURE	proc_get_account(IN department_name VARCHAR(50))
		BEGIN
			DECLARE dpmtID	TINYINT UNSIGNED;
            SELECT	  DepartmentID INTO dpmtID
								FROM Department
                                WHERE	DepartmentName = department_name;
                                
			SELECT *
            FROM	`Account`
            WHERE	DepartmentID = dpmtID;
                                
        END$$
 DELIMITER ;
 
 CALL proc_get_account('Phòng marketing');
 
 -- Question 2: Tạo store để in ra số lượng account trong mỗi group
  DROP PROCEDURE IF EXISTS pro2;
DELIMITER $$
	CREATE PROCEDURE	pro2()
		BEGIN
			SELECT 		GroupID,  Count(*)
            FROM		GroupAccount
			GROUP BY	GroupID;
        END$$
DELIMITER ;

 CALL pro2();
 -- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo 
--  trong tháng hiện tại
SELECT			TypeID,	MONTH(CreateDate), COUNT(*)
FROM			Question
WHERE			MONTH(CreateDate) = MONTH(now())
GROUP BY		TypeID;

DROP PROCEDURE IF EXISTS proc3;
DELIMITER $$
		CREATE PROCEDURE	proc3()
			BEGIN
				SELECT			TypeID,	MONTH(CreateDate), COUNT(*)
				FROM			Question
				WHERE			MONTH(CreateDate) = MONTH(now())
				GROUP BY		TypeID;
            END$$
	DELIMITER ;
    
    CALL proc3();
    
-- Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất
SELECT TypeID, Count(*) AS soluong
FROM		QUESTION
GROUP BY	TypeID
HAVING		soluong = (		SELECT 		Count(*) 
							FROM		QUESTION
							GROUP BY	TypeID
                            ORDER BY	Count(*) DESC
                            LIMIT 		1);


DROP PROCEDURE IF EXISTS proc4;
DELIMITER $$
		CREATE PROCEDURE	proc4(OUT tpid TINYINT UNSIGNED)
				BEGIN
					SELECT 		TypeID INTO tpid
					FROM		QUESTION
					GROUP BY	TypeID
					HAVING		count(*) = (		SELECT 		Count(*) 
												FROM		QUESTION
												GROUP BY	TypeID
												ORDER BY	Count(*) DESC
												LIMIT 		1);
                END$$
DELIMITER ;
SET @kq = '';  -- tạo biến kqua

CALL proc4(@kq); -- gán giá trị cho biến
SELECT @kq;  -- hiển thị biến kết quả


-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question
SELECT 		TypeName
FROM		TypeQuestion
WHERE		TypeID = @kq;

DROP PROCEDURE IF EXISTS proc5;
DELIMITER $$
		CREATE PROCEDURE	proc5()
				BEGIN
					SELECT 		TypeName
					FROM		TypeQuestion
					WHERE		TypeID = @kq;
				END$$
DELIMITER ;

CALL proc5();

-- Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên 
 -- chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa 
 -- chuỗi của người dùng nhập vào
 
 (SELECT 		GroupName
 FROM			`Group`
 WHERE			GroupName like '%chuoi%')
 UNION
 (SELECT 		FullName
 FROM			`Account`
 WHERE			FullName like '%chuoi%');
 
 DROP PROCEDURE IF EXISTS proc6;
 DELIMITER $$
		CREATE PROCEDURE	proc6(IN chuoi VARCHAR(50))
				BEGIN
						
						 (SELECT 		GroupName
						 FROM			`Group`
						 WHERE			GroupName LIKE CONCAT ('%', chuoi, '%'));
						 
						 (SELECT 		FullName
						 FROM			`Account`
						 WHERE			FullName  LIKE CONCAT ('%', chuoi, '%'));
                END$$
DELIMITER ;

CALL proc6('DEV');
 
 
-- Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và 
 -- trong store sẽ tự động gán:
-- username sẽ giống email nhưng bỏ phần @..mail đi
-- positionID: sẽ có default là developer
-- departmentID: sẽ được cho vào 1 phòng chờ
--  Sau đó in ra kết quả tạo thành công

select  substring_index(Email, '@', 1)
FROM  `Account`;

DROP PROCEDURE IF EXISTS proc7;
DELIMITER $$
		CREATE PROCEDURE	proc7 (IN fname VARCHAR(50), IN emai VARCHAR(50)) 
					BEGIN
						DECLARE uname VARCHAR(50);
                      
                        SET uname= substring_index(emai, '@', 1);
                        INSERT INTO `Account`(Email,Username,FullName,PositionId,DepartmentID)
                        VALUES                (emai,uname,fname,1,0);
						
                        SELECT 		*
                        FROM 		`Account`
                        WHERE 		Email = emai;
                    
                    END$$
DELIMITER ;

CALL proc7('danghuytu','dhtu12345@gmail.com');




-- Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice
--  để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất

DROP PROCEDURE IF EXISTS proc8;
DELIMITER $$
		CREATE PROCEDURE	proc8(IN typeques VARCHAR(50))
				BEGIN
					SELECT		QuestionId, character_length(Content) as dodaict
                    FROM		Question q INNER JOIN TypeQuestion t
                    ON			q.TypeID = t.TypeID
                    WHERE		TypeName like typeques                     
                    GROUP BY	t.TypeName
                    HAVING		max(dodaict);
                    
                
                
                END$$
DELIMITER ;

CALL	proc8('essay');








-- Question 9: Viết 1 store cho phép người dùng xóa exam dựa vào ID

DROP PROCEDURE IF EXISTS proc9;
DELIMITER $$
		 CREATE PROCEDURE proc9 (IN idexammuonxoa TINYINT UNSIGNED)
				BEGIN
						DELETE
                        FROM		Exam 
                        WHERE		ExamID = idexammuonxoa;
                
                END$$               
DELIMITER ;
			

CALL proc9(11);

-- Question 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi
--  Sau đó in số lượng record đã remove từ các table liên quan trong khi 
--  removing
DROP PROCEDURE IF EXISTS proc10;
DELIMITER $$
		CREATE PROCEDURE proc10(OUT soluong TINYINT UNSIGNED)
				BEGIN
                DECLARE soluong TINYINT UNSIGNED;
					SELECT 		COUNT(*) INTO soluong
                        FROM 		Exam
                        WHERE		YEAR(CreateDate) =YEAR(NOW())-3
                        GROUP BY	YEAR(CreateDate);
                      DELETE
                      FROM	Exam
                      WHERE		YEAR(CreateDate) =YEAR(NOW())-3;
                        
                END$$
DELIMITER ;
SET @sl='';
CALL proc10(@sl);
SELECT @sl;







-- Question 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng 
--  nhập vào tên phòng ban và các account thuộc phòng ban đó sẽ được 
--  chuyển về phòng ban default là phòng ban chờ việc
DROP PROCEDURE IF EXISTS proc11;
DELIMITER $$
			CREATE PROCEDURE	proc11(IN DpName VARCHAR(50))
				BEGIN
					DECLARE dpid TINYINT UNSIGNED;
                    
                    SET dpid =( SELECT 		DepartmentID
								FROM 		Department
                                WHERE		DepartmentName = Dpname);
                                
					UPDATE		`Account`
                    SET			DepartmentID = 12
                    WHERE		DepartmentID = dpid;
                END$$
DELIMITER ;

CALL proc11('Phòng Thư ký');






-- Question 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm 
-- nay
DROP PROCEDURE IF EXISTS proc12;
 DELIMITER $$
		CREATE PROCEDURE	proc12()
				BEGIN
					SELECT 		MONTH(CREATEDATE),COUNT(*)
                    FROM		`Question`
                    WHERE		YEAR(CreateDate) = 2020 -- YEAR(NOW())
                    GROUP BY	MONTH(CreateDate),YEAR(CreateDate);
                    
                
                END$$

 DELIMITER ;
 
 Call proc12();
 
 -- Question 13: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong 6 
 -- tháng gần đây nhất
 -- (Nếu tháng nào không có thì sẽ in ra là "không có câu hỏi nào trong 
-- tháng")

DROP PROCEDURE IF EXISTS proc13;
 DELIMITER $$
		CREATE PROCEDURE	proc13()
				BEGIN
					SELECT 		MONTH(CREATEDATE),COUNT(*)
                    FROM		`Question`
                    WHERE		MONTH(CreateDate) >= MONTH(NOW())-5 AND YEAR(CreateDate) = YEAR(NOW())
                    GROUP BY	MONTH(CreateDate),YEAR(CreateDate);                   	
                    
                
                END$$

 DELIMITER ;
 
 Call proc13();