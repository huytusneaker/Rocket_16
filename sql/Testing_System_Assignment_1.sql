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
    Email		varchar(50),
    Username 	varchar(50),
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

