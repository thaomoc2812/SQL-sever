-- Tạo database

CREATE DATABASE DBHousing;


-- Tạo các bảng

USE DBHousing
GO
CREATE TABLE KhachHang
(
	MaKH nvarchar(5) primary key
	,HoTen nvarchar(25)
	,SoDienThoai nvarchar(50)
	,CoQuan nvarchar(20)
);
GO
CREATE TABLE NhaChoThue
(
	MaN nvarchar(5) primary key
	,DiaChi nvarchar(50)
	,GiaThue int
	,TenChuNha nvarchar(20)
);
GO
CREATE TABLE HopDong
(
	MaN nvarchar(5)
	,MaKH nvarchar(5)
	,NgayBatDau datetime
	,NgayKetThuc datetime
	,foreign key (MaKH) references KhachHang
	,foreign key (MaN) references NhaChoThue
);


-- Nạp DATABASE

USE DBHousing
GO
INSERT INTO KhachHang(MaKH,HoTen,SoDienThoai,CoQuan) VALUES
('KH01',N'Vũ Tuyết Trinh',N'0968123456',N'Hoàng Mai, Hà Nội'),
('KH02',N'Nguyễn Nhật Quang',N'0123456789',N'Hai Bà Trưng, Hà Nội'),
('KH03',N'Trần Đức Khánh',N'0406197777',N'Đống Đa, Hà Nội'),
('KH04',N'Nguyễn Hồng Phương',N'01012198383',N'Tây Hồ, Hà Nội'),
('KH05',N'Lê Thanh Hương',N'0110197676',N'Hai Bà Trưng, Hà Nội'),
('KH06',N'Trần Hồng Ngọc',N'0147258963',N'Hoàng Mai, Hà Nội'),
('KH07',N'Hà Nhật Quang',N'0321654987',N'Tây Hồ, Hà Nội'),
('KH08',N'Trần Văn Đức',N'0452178963',N'Đống Đa, Hà Nội'),
('KH09',N'Nguyễn Thị Phương',N'0563214789',N'Tây Hồ, Hà Nội'),
('KH10',N'Lê Đình Sơn',N'0969068742',N'Hai Bà Trưng, Hà Nội'),
('KH11',N'Tòng Thị Héo',N'0321987456',N'Hoàng Mai, Hà Nội'),
('KH12',N'Đinh Văn Hùng',N'0321614528',N'Tây Hồ, Hà Nội'),
('KH13',N'Trần Thị Hằng',N'0452174712',N'Đống Đa, Hà Nội'),
('KH14',N'Nguyễn Thị Nguyệt',N'0563147258',N'Tây Hồ, Hà Nội'),
('KH15',N'Kiều Phương Thảo',N'0969068777',N'Hai Bà Trưng, Hà Nội');



GO
INSERT INTO NhaChoThue(MaN,DiaChi,GiaThue,TenChuNha) VALUES
('N01',N'Hoàng Mai, Hà Nội',5000000,N'Nông Văn Dền'),
('N02',N'Hai Bà Trưng, Hà Nội',3000000,N'Mạc Văn Khoa'),
('N03',N'Tây Hồ, Hà Nội',9000000,N'Chu Thị Linh'),
('N04',N'Hai Bà Trưng, Hà Nội',4000000,N'Nguyễn Hoàng Hiệp'),
('N05',N'Đống Đa, Hà Nội',6000000,N'Chu Thị Linh'),
('N06',N'Hoàng Mai, Hà Nội',8000000,N'Trần Văn Nông'),
('N07',N'Hai Bà Trưng, Hà Nội',10000000,N'Nguyễn Hữu Phước'),
('N08',N'Tây Hồ, Hà Nội',15000000,N'Nguyễn Hữu Phước'),
('N09',N'Đống Đa, Hà Nội',7000000,N'Nguyễn Hữu Phước'),
('N10',N'Hai Bà Trưng, Hà Nội',5000000,N'Hoàng Thị Mai');

GO

INSERT INTO HopDong(MaN,MaKH,NgayBatDau,NgayKetThuc) VALUES
('N01','KH01','3/10/2020','5/10/2020'),
('N01','KH02','5/11/2020','9/11/2020'),
('N01','KH03','9/12/2020','11/12/2020'),
('N02','KH01','9/11/2020','11/10/2020'),
('N02','KH04','2/11/2021','4/11/2021'),
('N03','KH05','9/1/2020','11/1/2020'),
('N04','KH06','6/12/2020','8/12/2020'),
('N05','KH07','3/10/2020','5/10/2020'),
('N06','KH09','5/11/2020','9/11/2020'),
('N07','KH10','8/11/2020','12/11/2020');



-- b) Biểu diễn các yêu cầu sau bằng SQL

-- Đưa ra danh sách (Địachỉ, Tênchủnhà) của những ngôi nhà có giá thuê ít hơn 10 triệu.

SELECT DiaChi,TenChuNha
FROM NhaChoThue
WHERE GiaThue< 10000000;

-- Đưa ra danh sách (MãKH, Họtên, Cơquan) của những người đã từng thuê nhà của chủ nhà có tên là "Nông Văn Dền"

SELECT MaKH,HoTen,CoQuan
FROM KhachHang
WHERE MaKH IN
(
	SELECT MaKH
	FROM HopDong
	WHERE MaN IN
	(
		SELECT MaN
		FROM NhaChoTHue
		WHERE TenChuNha = N'Nông Văn Dền'
	)
);


-- Đưa ra danh sách các ngôi nhà chưa từng được ai thuê

SELECT *
FROM NhaChoThue
WHERE MaN NOT IN
(
	SELECT MaN
	FROM HopDong
);

-- Đưa ra giá thuê cao nhất trong số các giá thuê của các ngôi nhà đã từng ít nhất một lần

SELECT *
FROM NhaChoThue
WHERE GiaThue >= All
(
	SELECT GiaThue
	FROM NhaChoThue
	WHERE MaN in 
	(
		SELECT MaN
		from HopDong
	)
)
AND MaN IN
(
	SELECT MaN
	FROM HopDong
);


-- c) Tạo các index có thể sử dụng cho các câu truy vấn sau và giải thích kế hoạch thực thi:
-- Viết câu lệnh đưa ra danh sách các khách hàng ở một cơ quan nào đó.

CREATE INDEX IX_CoQuan ON KhachHang (CoQuan)

SELECT * FROM KhachHang
WHERE CoQuan = N'Hai Bà Trưng, Hà Nội';


-- Đưa ra danh sách các Chủ nhà cho thuê và tổng số lượng Nhà cho thuê.

 CREATE INDEX IX_Nhachothue_Tenchunha
 ON Nhachothue(Tenchunha)

 SELECT Tenchunha, COUNT(MaN) AS "Tong so nha cho thue"
 FROM Nhachothue
 GROUP BY Tenchunha;

--d) Tạo procedure để thực hiện các yêu cầu sau:
-- Đưa ra danh sách các Hợp đồng có giá thuê lớn hơn một ngưỡng cho trước

 CREATE PROCEDURE HopDongGiaLonHonMotNguongChoTruoc
 AS 
 BEGIN
     SELECT Hopdong.MaN,MaKH,Ngaybatdau,Ngayketthuc,Nhachothue.Giathue
     FROM Hopdong,Nhachothue
     WHERE Hopdong.MaN = Nhachothue.MaN AND Nhachothue.Giathue > 1000000
 END;

 EXEC HopDongGiaLonHonMotNguongChoTruoc;


-- Đưa ra danh sách khách hàng có tổng giá trị hợp đồng lớn hơn một ngưỡng cho trước
SELECT Hopdong.MaKH,HopDong.MaN,(month(ngayketthuc)-month(ngaybatdau)) AS TimeHopDong,GiaThue
	into CostHopDong
	FROM Hopdong, nhaChoThue

 CREATE PROCEDURE KhachHangCoTongHopDongLonHonMotNguongChoTruoc
 AS 
 BEGIN
	SELECT HoTen,costHopDong.MaN,TimeHopDong * giathue as 'TONG GIA TRI HOP DONG'
	FROM KhachHang,CostHopDong
	where KhachHang.MaKH = COstHopDong.MaKH
	and TimeHopDong * GiaThue > 10000000
	
 END;
 
 EXEC KhachHangCoTongHopDongLonHonMotNguongChoTruoc
 
 


