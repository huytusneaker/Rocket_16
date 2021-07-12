-- Xóa database nếu đã tồn tại
DROP DATABASE IF EXISTS ThucTap2;

-- tạo database
CREATE DATABASE		ThucTap2;

-- sử dụng database vừa tạo: 
USE  ThucTap2;

-- tạo các bảng:

-- bảng GiangVien
CREATE TABLE GiangVien(
	maGV		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    hoTen		VARCHAR(50),
    luong		DOUBLE
);
-- tạo bảng SinhVien
CREATE TABLE SinhVien(
	maSV		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    hoTen		VARCHAR(50),
    namSinh		INT,
    quequan		VARCHAR(50)
);
-- tạo bảng DeTai
CREATE TABLE DeTai(
	maDT		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    tenDT		VARCHAR(50),
    kinhPhi		DOUBLE,
    noiThucTap	VARCHAR(50)
);
-- tạo bảng HuongDan
CREATE TABLE HuongDan(
	id			TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    maSV		TINYINT UNSIGNED,
    maDT		TINYINT UNSIGNED,
    maGV		TINYINT UNSIGNED,
    ketQua		VARCHAR(50)
);
-- Thêm dữ liệu vào các bảng

-- thêm dữ liệu vào bảng GiangVien
INSERT INTO `giangvien` (`hoTen`, `luong`) VALUES 			('Nguyễn Văn Thắng', '50000000'),
															('Nguyễn Thị Nhung', '30000000'),
															('Nguyễn Bá Nghiễn', '100000000');

-- thêm dữ liệu vào bảng SinhVien

INSERT INTO `sinhvien` (`hoTen`, `namSinh`, `quequan`) VALUES   ('Đặng Huy Tú', '2000', 'Bắc Giang'),
																('Phạm Thế Duy Tuấn', '2001', 'Thanh Hóa'),
																('Nguyễn Thanh Tùng', '2003', 'Yên Bái'),
																('Trương Quốc Trung', '1990', 'Phú Thọ');

-- thêm dữ liệu vào bảng DeTai

INSERT INTO `detai` (`tenDT`, `kinhPhi`, `noiThucTap`) VALUES 	('Thiết kế Web bán hàng', '10000000', 'SamSung'),
																			('Thiết kế trang thương mại điện tử', '2000000', 'BKAV'),
																			('Android APP', '500000', 'Xiaomi');


-- thêm dữ liệu vào bảng hướng dẫn

INSERT INTO `huongdan` (`maSV`, `maDT`, `maGV`, `ketQua`) VALUES 				('1', '2', '1', 'Kém'),
																				('2', '1', '3', 'Tốt'),
																				('3', '3', '2', 'Trung Bình');

SELECT * FROM SinhVien;
SELECT * FROM GiangVien;
SELECT * FROM HuongDan;
SELECT * FROM DeTai;

