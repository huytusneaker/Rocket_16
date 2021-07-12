DROP DATABASE IF EXISTS ThucTap;
-- tạo database
CREATE DATABASE ThucTap;

-- Sử dụng database vừa tạo:
USE ThucTap;
-- tạo các bảng:
DROP TABLE IF EXISTS Country;
CREATE TABLE Country(
		country_id			TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
		country_name		VARCHAR(50)
);
DROP TABLE IF EXISTS Location;

CREATE TABLE Location(
		location_id			TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
        street_address		VARCHAR(100),
        postal_code			VARCHAR(10),
        country_id			TINYINT UNSIGNED
);
DROP TABLE IF EXISTS Employee;

CREATE TABLE Employee(
		employee_id			TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
        full_name			VARCHAR(50),
        email				VARCHAR(50),
        location_id			TINYINT UNSIGNED
);

-- thêm dữ liệu vào các bảng:
-- thêm dữ liệu vào bảng Country
INSERT INTO `country` (`country_name`) 				VALUES ('Việt Nam'),
													('Trung Quốc'),
													('Campuchia'),
													('Myanma'),
													('Đài Loan'),
													('Hàn Quốc'),
													('Thái Lan'),
													('Nhật Bản'),
													('Ấn Độ'),
													('Iran');
-- thêm dữ liệu vào bảng Employee
	INSERT INTO `Employee`(full_name,email,location_id)			 
										 VALUES ('Đặng Huy Tú', 'dhtu12345@gmial.com', '1'),
												('Lê Hải Thành', 'haithanh@gmail.com', '2'),
												('Nguyễn Hà Trung', 'hatrung@gmail.com', '3'),
												('Nguyễn Thanh Tùng', 'thanhtung@gmail.com', '4'),
												('Nguyễn Chí Trung', 'chitrung@gmail.com', '5'),
												('Trần Văn Nhàn', 'vannhan@gmail.com', '6'),
												('Lê Văn Tuấn', 'vantuan@gmail.com', '7'),
												('Trần Hoàng Trung', 'hoangtrung@gmail.com', '8'),
												('Trương Quốc Trung', 'quoctrung@gmail.com', '9'),
												('Phạm Thế Duy Tuấn', 'duytuan@gmail.com', '10'),
												('Đặng Thị Thu Lan', 'thulan@gmail.com', '2'),
												('Đặng Thị Phương Anh', 'phuonganh@gmail.com', '3');
-- Thêm dữ liệu vào bảng Location
INSERT INTO `thuctap`.`location` (`street_address`, `postal_code`, `country_id`) VALUES ('121 Trần Phú', '21000', '1'),
																						('132 Phú Diễn', '23000', '2'),
																						('327 Lê Thái Tông', '22400', '3'),
																						('99 Cầu Diễn', '25000', '4'),
																						('33 Nguyễn Trãi', '30000', '5'),
																						('43 Nguyễn Xiển', '31000', '6'),
																						('55 Quang Trung', '32000', '7'),
																						('50 Thanh Hà', '33000', '8'),
																						('33 Hàng Dầu', '31000', '9'),
																						('50 Hàng Bạc', '50000', '10');






