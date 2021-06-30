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
    constraint pk_examquestion	primary key(ExamID),
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
VALUES						(15,1);
INSERT INTO `ExamQuestion`(ExamID,QuestionID)
VALUES						(2,3);
INSERT INTO `ExamQuestion`(ExamID,QuestionID)
VALUES						(2,4);
INSERT INTO `ExamQuestion`(ExamID,QuestionID)
VALUES						(3,5);

