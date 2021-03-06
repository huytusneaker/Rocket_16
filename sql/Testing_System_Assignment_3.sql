-- xóa thông tin database nếu tồn tại
DROP DATABASE IF EXISTS Testing_System_Assignment_1;
-- tạo database
CREATE DATABASE Testing_System_Assignment_1;
-- sử dụng database vừa tạo
USE Testing_System_Assignment_1;
-- tạo thông tin các bảng
CREATE TABLE Department(
	 DepartmentID TINYINT auto_increment PRIMARY KEY,
     DepartmentName nvarchar(50)
);

CREATE TABLE `Position`(
	PositionID TINYINT auto_increment primary key,
    PositionName NVARCHAR(50)
);

CREATE TABLE `Account`(
	AccountID	tinyint auto_increment primary key,
    Email		varchar(50) unique key,
    Username 	varchar(50) unique key,
    Fullname	varchar(50),
    DepartmentID	Tinyint,
    PositionID 		tinyint,
    CreateDate		date,
    constraint fk_account1 foreign key (DepartmentID) references Department(DepartmentID),
    constraint fk_account2 foreign key (PositionID) references 	`Position`(PositionID)
    
);

CREATE TABLE `Group`(
	GroupID 		tinyint auto_increment primary key,
    Groupname		varchar(50),
    CreatorID		tinyint,
    CreateDate		date,
    constraint fk_group1 foreign key (CreatorID) references `Account`(AccountID)  
    
);

CREATE TABLE GroupAccount(
	GroupID		tinyint,
    AccountID	tinyint,
    JoinDate	date,
    constraint pk_groupaccount primary key (GroupID,AccountID),
    constraint fk_groupaccount foreign key (GroupID) references `Group`(GroupID),
    constraint fk_groupaccount2 foreign key (AccountID) references `Account`(AccountID)
       
);

CREATE TABLE TypeQuestion(
	TypeID		tinyint auto_increment primary key,
    Typename	varchar(50)
);

CREATE TABLE CategoryQuestion(
	CategoryID		tinyint auto_increment primary key,
    CategoryName	varchar(50)
);


CREATE TABLE Question(
	QuestionID tinyint auto_increment primary key,
    Content		varchar(100),
    CategoryID	tinyint,
    TypeID		tinyint,
    CreatorID	tinyint,
    CreateDate	date,
    constraint fk_question foreign key (CreatorID) references `Account`(AccountID),
    constraint fk_question1 foreign key (TypeID) references `TypeQuestion`(TypeID),
    constraint fk_question2 foreign key (CategoryID) references `CategoryQuestion`(CategoryID)  
);

CREATE TABLE Answer(
	AnswerID	tinyint	auto_increment primary key,
    Content		varchar(50),
    QuestionID	tinyint,
    isCorrect	boolean,
    constraint pk_answer foreign key (QuestionID) references `Question`(QuestionID)
);

CREATE TABLE Exam(
	ExamID		tinyint auto_increment	primary key,
    `Code`		tinyint,
    Title		varchar(50),
    CategoryID	tinyint,
    Duration	tinyint,
    CreatorID	tinyint,
    CreateDate	date,
    constraint fk_exam	foreign key (CategoryID) references CategoryQuestion(CategoryID),
    constraint fk_exam2 foreign key (CreatorID) references `Account`(AccountID)
);

CREATE TABLE ExamQuestion(
	ExamID		tinyint,
    QuestionID	tinyint,
    constraint pk_examquestion	primary key(ExamID,QuestionID),
    constraint fk_examquestion	foreign key(ExamID) references Exam(ExamID),
    constraint fk_examquestion1 foreign key (QuestionID) references `Question`(QuestionID)
);


-- thêm dữ liệu vào các bảng, mỗi bảng 5 dữ liệu

-- thêm vào bảng department
INSERT INTO `Department`(DepartmentID,DepartmentName)
VALUES	(1,'Dev');
INSERT INTO `Department`(DepartmentID,DepartmentName)
VALUES	(2,'PM');
INSERT INTO `Department`(DepartmentID,DepartmentName)
VALUES	(3,'Director');
INSERT INTO `Department`(DepartmentID,DepartmentName)
VALUES	(4,'Accoutant');
INSERT INTO `Department`(DepartmentID,DepartmentName)
VALUES	(5,'Marketing');

-- thêm dữ liệu vào bảng position
INSERT INTO `Position`(PositionID,PositionName)
VALUES	(1,'Java Dev');
INSERT INTO `Position`(PositionID,PositionName)
VALUES	(2,'Java PM');
INSERT INTO `Position`(PositionID,PositionName)
VALUES	(3,'Main Director');
INSERT INTO `Position`(PositionID,PositionName)
VALUES	(4,'Accountant 1');
INSERT INTO `Position`(PositionID,PositionName)
VALUES	(5,'CEO');
-- thêm dữ liệu vào bảng account
INSERT INTO `Account`(AccountID,Email,Username,Fullname,DepartmentID,PositionID,CreateDate)
VALUES	(1,'dhtu12345@gmail.com','dhtu12345','Dang Huy Tu',1,1,'2021/06/16');
INSERT INTO `Account`(AccountID,Email,Username,Fullname,DepartmentID,PositionID,CreateDate)
VALUES	(2,'tuan12345@gmail.com','tuan12345','Nguyen Van Tuan',2,2,'2021/01/02');
INSERT INTO `Account`(AccountID,Email,Username,Fullname,DepartmentID,PositionID,CreateDate)
VALUES	(3,'tung12345@gmail.com','tung12345','Nguyen Thanh Tung',3,3,'2021/03/06');
INSERT INTO `Account`(AccountID,Email,Username,Fullname,DepartmentID,PositionID,CreateDate)
VALUES	(4,'trung12345@gmail.com','trung12345','Nguyen Ha Trung',4,4,'2021/04/19');
INSERT INTO `Account`(AccountID,Email,Username,Fullname,DepartmentID,PositionID,CreateDate)
VALUES	(5,'yen12345@gmail.com','yen12345','Bui Thi Yen',5,5,'2021/05/16');

-- thêm dữ liệu vào bảng Group
INSERT INTO 	`Group`(GroupID,Groupname,CreatorID,CreateDate)
VALUES					(1,'Nhom 1',1,'2021/06/20');
INSERT INTO 	`Group`(GroupID,Groupname,CreatorID,CreateDate)
VALUES					(2,'Nhom 2',1,'2021/06/21');
INSERT INTO 	`Group`(GroupID,Groupname,CreatorID,CreateDate)
VALUES					(3,'Nhom 3',5,'2021/06/22');
INSERT INTO 	`Group`(GroupID,Groupname,CreatorID,CreateDate)
VALUES					(4,'Nhom 4',3,'2021/06/23');
INSERT INTO 	`Group`(GroupID,Groupname,CreatorID,CreateDate)
VALUES					(5,'Nhom 5',2,'2021/06/24');

-- thêm dữ liệu vào bảng GroupAccount
INSERT INTO GroupAccount(GroupID,AccountID,JoinDate)
VALUES 					(1,2,'2021/06/29');
INSERT INTO GroupAccount(GroupID,AccountID,JoinDate)
VALUES 					(2,1,'2021/06/29');
INSERT INTO GroupAccount(GroupID,AccountID,JoinDate)
VALUES 					(3,3,'2021/06/29');
INSERT INTO GroupAccount(GroupID,AccountID,JoinDate)
VALUES 					(4,5,'2021/06/29');
INSERT INTO GroupAccount(GroupID,AccountID,JoinDate)
VALUES 					(5,4,'2021/06/29');

-- thêm dữ liệu vào bảng typequestion
INSERT INTO TypeQuestion(TypeID,Typename)
VALUES					(1,'Trac Nghiem');
INSERT INTO TypeQuestion(TypeID,Typename)
VALUES					(2,'Tu luan');
INSERT INTO TypeQuestion(TypeID,Typename)
VALUES					(3,'Trac Nghiem+ Tu luan');
INSERT INTO TypeQuestion(TypeID,Typename)
VALUES					(4,'Van dap');
INSERT INTO TypeQuestion(TypeID,Typename)
VALUES					(5,'Bai tap lon');
-- thêm dữ liệu vào bảng categoryquestion
INSERT INTO `CategoryQuestion`(CategoryID,CategoryName)
VALUES						(1,'Loai 1');

INSERT INTO `CategoryQuestion`(CategoryID,CategoryName)
VALUES						(2,'Loai 2');

INSERT INTO `CategoryQuestion`(CategoryID,CategoryName)
VALUES						(3,'Loai 3');

INSERT INTO `CategoryQuestion`(CategoryID,CategoryName)
VALUES						(4,'Loai 4');

INSERT INTO `CategoryQuestion`(CategoryID,CategoryName)
VALUES						(5,'Loai 5');

-- thêm dữ liệu vào bảng question

INSERT INTO `Question`(QuestionID,Content,CategoryID,TypeID,CreatorID,CreateDate)
VALUES					(1,'Content 1',1,1,1,'2021/06/27');
INSERT INTO `Question`(QuestionID,Content,CategoryID,TypeID,CreatorID,CreateDate)
VALUES					(2,'Content 2',1,3,1,'2021/06/27');
INSERT INTO `Question`(QuestionID,Content,CategoryID,TypeID,CreatorID,CreateDate)
VALUES					(3,'Content 3',3,4,4,'2021/06/27');
INSERT INTO `Question`(QuestionID,Content,CategoryID,TypeID,CreatorID,CreateDate)
VALUES					(4,'Content 4',5,5,2,'2021/06/27');
INSERT INTO `Question`(QuestionID,Content,CategoryID,TypeID,CreatorID,CreateDate)
VALUES					(5,'Content 5',4,1,5,'2021/06/27');		



-- thêm dữ liệu vào bảng answer
INSERT INTO answer(AnswerID,Content,QuestionID,isCorrect)
VALUES				(1,'Content 1',1,1);
INSERT INTO answer(AnswerID,Content,QuestionID,isCorrect)
VALUES				(2,'Content 2',2,1);
INSERT INTO answer(AnswerID,Content,QuestionID,isCorrect)
VALUES				(3,'Content 3',1,0);
INSERT INTO answer(AnswerID,Content,QuestionID,isCorrect)
VALUES				(4,'Content 4',3,0);
INSERT INTO answer(AnswerID,Content,QuestionID,isCorrect)
VALUES				(5,'Content 5',5,1);

-- thêm dữ liệu cho bảng exam:
INSERT INTO `Exam`(ExamID,`Code`,Title,CategoryID,Duration,CreatorID,CreateDate)
VALUES				(1,1,'de thi so 1',1,60,1,'2021/06/20');
INSERT INTO `Exam`(ExamID,`Code`,Title,CategoryID,Duration,CreatorID,CreateDate)
VALUES				(2,2,'de thi so 2',2,120,1,'2021/06/20');
INSERT INTO `Exam`(ExamID,`Code`,Title,CategoryID,Duration,CreatorID,CreateDate)
VALUES				(3,3,'de thi so 1',3,60,2,'2021/06/20');
INSERT INTO `Exam`(ExamID,`Code`,Title,CategoryID,Duration,CreatorID,CreateDate)
VALUES				(4,4,'de thi so 1',4,60,5,'2021/06/20');
INSERT INTO `Exam`(ExamID,`Code`,Title,CategoryID,Duration,CreatorID,CreateDate)
VALUES				(5,5,'de thi so 1',5,60,4,'2021/06/20');

-- thêm dữ liệu vào bảng examquestion
INSERT INTO `ExamQuestion`(ExamID,QuestionID)
VALUES						(1,2);
INSERT INTO `ExamQuestion`(ExamID,QuestionID)
VALUES						(1,1);
INSERT INTO `ExamQuestion`(ExamID,QuestionID)
VALUES						(2,3);
INSERT INTO `ExamQuestion`(ExamID,QuestionID)
VALUES						(2,4);
INSERT INTO `ExamQuestion`(ExamID,QuestionID)
VALUES						(3,5);

SELECT * FROM `Account`;
SELECT * FROM `Answer`;
SELECT * FROM `CategoryQuestion`;
SELECT * FROM `Department`;
SELECT * FROM `Exam`;
SELECT * FROM `ExamQuestion`;
SELECT * FROM `Group`;
SELECT * FROM `GroupAccount`;
SELECT * FROM `Position`;
SELECT * FROM `Question`;
SELECT * FROM `TypeQuestion`;

-- Question 1: Thêm ít nhất 10 record vào mỗi table

-- Question 2: lấy ra tất cả các phòng ban
SELECT * FROM 	`Department`;

-- Question 3: lấy ra id của phòng ban "Dev"
SELECT DepartmentID
FROM Department 
WHERE DepartmentName ='Dev';

-- Question 4: lấy ra thông tin account có full name dài nhất

SET FOREIGN_KEY_CHECKS=0;

select * , character_length(Fullname) AS'chieudaiten'
FROM `Account`
WHERE 	character_length(Fullname)=
(SELECT character_length(Fullname) as 'dodai' 
FROM `Account` 
ORDER BY 	dodai DESC
LIMIT 1);


SELECT max(length(fullname)) as 'dodai'
FROM `Account`;

-- Question 5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id =3 

select * , character_length(Fullname) AS'chieudaiten'
FROM `Account`
WHERE  DepartmentID= 3 AND	character_length(Fullname)=
(SELECT character_length(Fullname) as 'dodai' 
FROM `Account` 
ORDER BY 	dodai DESC
LIMIT 1);


-- Question 6: Lấy ra tên group đã tham gia trước ngày 20/12/2019
SELECT * 
FROM `Group`
WHERE 	CreateDate <'2019/12/20';

-- Question 7: Lấy ra ID của question có >= 4 câu trả lời
SELECT QuestionID, Count(1)  as 'socautl'
FROM Answer
GROUP BY QuestionID
HAVING count(1)>=4;



SELECT * FROM Answer;
-- Question 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019

SELECT ExamID
FROM Exam
WHERE Duration >=60;

-- Question 9: Lấy ra 5 group được tạo gần đây nhất
SELECT *
FROM `Group`
ORDER BY CreateDate ASC
LIMIT 5;

-- Question 10: Đếm số nhân viên thuộc department có id = 2
SELECT Count(1) AS dp2_numberOfAccount
FROM `Account`
WHERE DepartmentID = 2
Group by DepartmentID;

-- Question 11: Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"

SELECT * 
FROM `account`
WHERE fullname like 'D%o';

-- Question 12: Xóa tất cả các exam được tạo trước ngày 20/12/2019
DELETE 
FROM	Exam
WHERE CreateDate < '2019/12/20';

-- Question 13: Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"
Delete 
FROM Question
WHERE Content like 'câu hỏi %';

-- Question 14: Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và 
--  email thành loc.nguyenba@vti.com.vn

UPDATE `Account`
SET		Fullname = 'dao ba loc'
WHERE	AccountID= 5;

UPDATE `Account`
SET		email = 'loc.nguyenba@vti.com.vn'
WHERE	AccountID= 5;

-- Question 15: update account có id = 5 sẽ thuộc group có id = 4
UPDATE `GroupAccount`
SET		`GroupID` =4
WHERE	`AccountID`= 5;











