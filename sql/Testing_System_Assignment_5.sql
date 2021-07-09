USE testing_system;
-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
DROP VIEW IF EXISTS v_q1;
CREATE VIEW v_q1 AS
			SELECT *
			FROM `Account` 
			WHERE DepartmentID = (		SELECT DepartmentID
										FROM	Department
										WHERE	DepartmentName= 'Phòng Sale');

SELECT 	*
FROM v_q1;

-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
DROP VIEW IF EXISTS v_q2;
			CREATE VIEW 	v_q2	AS
			SELECT 		*
			FROM 		`Account`
			WHERE		AccountID =	 (	SELECT AccountID
										FROM 		GroupAccount
										GROUP BY	AccountID
										HAVING Count(*)=				(SELECT		Count(*) as soluong
																		 FROM 		GroupAccount
																		 GROUP BY	AccountID
																		 ORDER BY 	soluong DESC
																		 LIMIT 		1));

SELECT		*
FROM		v_q2;



-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ 
-- được coi là quá dài) và xóa nó đi
DROP VIEW IF EXISTS v_q3;
CREATE VIEW v_q3	AS
		SELECT 		*
        FROM		Question
        WHERE		CHARACTER_LENGTH(Content) >3;
 
 
 SELECT * FROM v_q3;

-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất

DROP VIEW IF EXISTS		v_q4;

		CREATE VIEW 	v_q4	AS
		SELECT			*
		FROM			`Account`
		GROUP BY		DepartmentID
		HAVING			COUNT(*) =		(	SELECT	COUNT(*) as soluong
											FROM	`Account`
                                            GROUP BY DepartmentID
                                            ORDER BY soluong DESC
                                            LIMIT	 1);

SELECT * FROM v_q4;

-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo


DROP VIEW IF EXISTS	v_q5;

CREATE VIEW 	v_q5	AS
		SELECT 		QuestionID
        FROM 		`Question`
        WHERE		CreatorID IN (	SELECT `AccountID`
									FROM 	`Account`
                                    WHERE	FullName like	'Nguyễn%');


SELECT * FROM v_q5;