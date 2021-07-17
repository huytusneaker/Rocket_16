-- xóa database trùng lặp
DROP DATABASE IF EXISTS CARS_SELLING;

-- tạo database		
CREATE DATABASE CARS_SELLING;

-- sử dụng database vừa tạo

USE CARS_SELLING;

-- tạo các bảng

-- tạo bảng Customer

CREATE TABLE Customer(
	customerID		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    name			VARCHAR(50),
    phone			VARCHAR(15),
    email			VARCHAR(50),
    address			VARCHAR(100),
    note			VARCHAR(100) DEFAULT 'no note'
);

-- tạo bảng Car

CREATE TABLE CAR(
	carID		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	maker		ENUM('HONDA','TOYOTA','NISSAN'),
    model		VARCHAR(50),
    `year`		INT,
    color		VARCHAR(50),
    note		VARCHAR(100)   DEFAULT 'no note'
);

-- tạo bảng CarOrder

CREATE TABLE CarOrder(
	orderID			TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    customerID		TINYINT UNSIGNED,
    carID			TINYINT UNSIGNED,
    amount			TINYINT UNSIGNED DEFAULT 1,
    salePrice		DOUBLE UNSIGNED,
    orderDate		DATE,
    deliveryDate 	DATE,
    deliveryAddress VARCHAR(100),
    `status`		ENUM( '0','1','2') DEFAULT '0',
    note			VARCHAR(100) DEFAULT 'no note'
);

-- thêm dữ liệu vào các bảng vừa tạo 

-- thêm dữ liệu vào bảng customer
INSERT INTO `customer` (`name`, `phone`, `email`, `address`) VALUES 				('Đặng Huy Tú', '0964745624', 'huytu@gmail.com', 'Hà Đông'),
																							('Phạm Thế Duy Tuấn', '0357868798', 'duytuan@gmail.com', 'Đỗ Đức Dục'),
																							('Bùi Thị Yến', '0822280100', 'buiyen@gmail.com', 'Nguyên Xá'),
																							('Nguyễn Văn Tuân', '0988777666', 'vantuan@gmail.com', 'Hà Nội'),
																							('Nguyễn Hà Trung', '0356765444', 'hatrung@gmail.com', 'Hồ Tùng Mậu');



-- thêm dữ liệu vào bảng car

INSERT INTO 				`car` (`maker`, `model`, `year`, `color`) VALUES('TOYOTA', '1', '2000', 'red'),
																			('NISSAN', '2', '2001', 'Green'),
																			('HONDA', '3', '2002', 'blue'),
																			('TOYOTA', '4', '2003', 'yellow'),
																			('NISSAN', '4', '2004', 'brown');


-- thêm dữ liệu vào bảng carorder




