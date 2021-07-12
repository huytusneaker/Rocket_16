USE ThucTap2;

-- 2. Viết lệnh để
--  a) Lấy tất cả các sinh viên chưa có đề tài hướng dẫn
-- b) Lấy ra số sinh viên làm đề tài ‘CONG NGHE SINH HOC’


--  a) Lấy tất cả các sinh viên chưa có đề tài hướng dẫn
SELECT 		* 
FROM 		SinhVien
WHERE		maSV 		NOT IN (SELECT 		maSV
								FROM		HuongDan);
                                
-- b) Lấy ra số sinh viên làm đề tài ‘CONG NGHE SINH HOC’

SELECT			 tenDT, COUNT(*) as soluong
FROM			HuongDan h INNER JOIN SinhVien s ON h.maSV = s.maSV
							INNER JOIN DeTai d ON h.maDT = d.maDT
WHERE			tenDT like 'Công Nghệ Sinh Học'
GROUP BY 		d.maDT;



-- 3. Tạo view có tên là "SinhVienInfo" lấy các thông tin về học sinh bao gồm: 
-- mã số, họ tên và tên đề tài
-- (Nếu sinh viên chưa có đề tài thì column tên đề tài sẽ in ra "Chưa có")
CREATE VIEW		SinhVienInfo
AS
	SELECT 			s.maSV, s.hoTen, CASE
									WHEN	tenDT IS NULL THEN 'chưa có đề tài'
                                    ELSE	tenDT
                                    END AS tenDeTai
                                    
    FROM			SinhVien s 
    LEFT JOIN (HuongDan h INNER JOIN DeTai d ON h.maDT = d.maDT) 
    ON  s.maSV = h.maSV;
    
SELECT * FROM SinhVienInfo;



-- 4. Tạo trigger cho table SinhVien khi insert sinh viên có năm sinh <= 1900 
-- thì hiện ra thông báo "năm sinh phải > 1900"
DROP TRIGGER IF EXISTS trigger_q4;
DELIMITER $$
		CREATE TRIGGER trigger_q4
		BEFORE INSERT ON `SinhVien`
        FOR EACH ROW
				BEGIN
						IF NEW.namSinh <= 1900
                        THEN
                        SIGNAL SQLSTATE '16090'
                        SET MESSAGE_TEXT = 'Can not add student born earlier than 1901';
                        END IF;
                END$$
DELIMITER ;	

INSERT INTO `sinhvien` (`hoTen`, `namSinh`, `quequan`) VALUES   ('Đặng Văn Tày', '1900', 'Bắc Thái');

-- 5. Hãy cấu hình table sao cho khi xóa 1 sinh viên nào đó thì sẽ tất cả thông 
-- tin trong table HuongDan liên quan tới sinh viên đó sẽ bị xóa đi

DROP TRIGGER IF EXISTS trigger_q5;
DELIMITER $$
		CREATE TRIGGER trigger_q5
        BEFORE DELETE ON `SinhVien`
        FOR EACH ROW
				BEGIN
					DELETE
                    FROM 		HuongDan
                    WHERE		maSV = OLD.maSV;      
                    
                END$$
DELIMITER ;

DELETE
FROM 		SinhVien
WHERE		maSV ='2';