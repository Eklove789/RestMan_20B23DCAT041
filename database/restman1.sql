-- =====================================================================
-- CSDL restman1 - he thong quan li nha hang RestMan (de 20, B23DCAT041)
-- 28 bang, cot / kieu / khoa dung theo bieu do thiet ke CSDL cua bao cao.
-- Du lieu mau theo kich ban cua hai module:
--   Module 1: khach hang tim "bò" -> 4 mon (MA012, MA015, MA031, MA044); Bo luc lac co trong CB003, CB007.
--   Module 2: nhan vien Pham Thu Ha tim khach "Tuấn" -> ban B05 (1.000.000 d) va V02 (3.260.000 d, coc 500.000 d);
--             the TV000128 hang Bac giam 5%, 1.240 diem; hoa don tiep theo co ma HD0157.
-- Collation utf8mb4_0900_ai_ci: tim kiem khong phan biet hoa thuong va dau.
-- =====================================================================
CREATE DATABASE IF NOT EXISTS restman1 CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE restman1;
SET NAMES utf8mb4;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS tblPayment1;
DROP TABLE IF EXISTS tblBillDetail1;
DROP TABLE IF EXISTS tblBill1;
DROP TABLE IF EXISTS tblOrderDetail1;
DROP TABLE IF EXISTS tblOrder1;
DROP TABLE IF EXISTS tblBookingDetail1;
DROP TABLE IF EXISTS tblBooking1;
DROP TABLE IF EXISTS tblDishIngredient1;
DROP TABLE IF EXISTS tblComboDetail1;
DROP TABLE IF EXISTS tblDish1;
DROP TABLE IF EXISTS tblSaleStaff1;
DROP TABLE IF EXISTS tblImportDetail1;
DROP TABLE IF EXISTS tblImportBill1;
DROP TABLE IF EXISTS tblIngredient1;
DROP TABLE IF EXISTS tblUnit1;
DROP TABLE IF EXISTS tblDishCategory1;
DROP TABLE IF EXISTS tblCombo1;
DROP TABLE IF EXISTS tblMenuItem1;
DROP TABLE IF EXISTS tblTable1;
DROP TABLE IF EXISTS tblArea1;
DROP TABLE IF EXISTS tblRestaurant1;
DROP TABLE IF EXISTS tblSupplier1;
DROP TABLE IF EXISTS tblMemberCard1;
DROP TABLE IF EXISTS tblCardRank1;
DROP TABLE IF EXISTS tblStaff1;
DROP TABLE IF EXISTS tblCustomer1;
DROP TABLE IF EXISTS tblMember1;
DROP TABLE IF EXISTS tblAddress1;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE tblAddress1 (
    id INT(10) NOT NULL AUTO_INCREMENT,
    sonha VARCHAR(255) NOT NULL,
    duong VARCHAR(255) NOT NULL,
    phuong VARCHAR(255) NOT NULL,
    quan VARCHAR(255) NOT NULL,
    tinhthanh VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE tblMember1 (
    id INT(10) NOT NULL AUTO_INCREMENT,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    vaitro VARCHAR(50) NOT NULL,
    trangthaitk VARCHAR(50) NOT NULL,
    ho VARCHAR(255) NOT NULL,
    tendem VARCHAR(255) NULL,
    ten VARCHAR(255) NOT NULL,
    ngaysinh DATE NULL,
    gioitinh VARCHAR(10) NULL,
    email VARCHAR(255) NULL UNIQUE,
    dt VARCHAR(15) NOT NULL UNIQUE,
    ghichu VARCHAR(255) NULL,
    tblAddress1id INT(10) NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (tblAddress1id) REFERENCES tblAddress1(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE tblCustomer1 (
    tblMember1id INT(10) NOT NULL,
    ngaydangki DATE NOT NULL,
    PRIMARY KEY (tblMember1id),
    FOREIGN KEY (tblMember1id) REFERENCES tblMember1(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE tblStaff1 (
    tblMember1id INT(10) NOT NULL,
    vitri VARCHAR(50) NOT NULL,
    ngayvaolam DATE NOT NULL,
    PRIMARY KEY (tblMember1id),
    FOREIGN KEY (tblMember1id) REFERENCES tblMember1(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE tblCardRank1 (
    id INT(10) NOT NULL AUTO_INCREMENT,
    ten VARCHAR(50) NOT NULL UNIQUE,
    diemtoithieu INT(10) NOT NULL,
    tilegiamgia FLOAT NOT NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE tblMemberCard1 (
    id INT(10) NOT NULL AUTO_INCREMENT,
    sothe VARCHAR(20) NOT NULL UNIQUE,
    ngaycap DATE NOT NULL,
    diemtichluy INT(10) NOT NULL,
    trangthai VARCHAR(50) NOT NULL,
    tblCustomer1id INT(10) NOT NULL UNIQUE,
    tblCardRank1id INT(10) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (tblCustomer1id) REFERENCES tblCustomer1(tblMember1id),
    FOREIGN KEY (tblCardRank1id) REFERENCES tblCardRank1(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE tblSupplier1 (
    id INT(10) NOT NULL AUTO_INCREMENT,
    ten VARCHAR(255) NOT NULL UNIQUE,
    dt VARCHAR(15) NOT NULL,
    email VARCHAR(255) NULL,
    nguoilienhe VARCHAR(255) NULL,
    trangthai VARCHAR(50) NOT NULL,
    mota VARCHAR(255) NULL,
    tblAddress1id INT(10) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (tblAddress1id) REFERENCES tblAddress1(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE tblRestaurant1 (
    id INT(10) NOT NULL AUTO_INCREMENT,
    ten VARCHAR(255) NOT NULL,
    dt VARCHAR(15) NOT NULL,
    giomocua VARCHAR(50) NOT NULL,
    mota VARCHAR(255) NULL,
    tblAddress1id INT(10) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (tblAddress1id) REFERENCES tblAddress1(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE tblArea1 (
    id INT(10) NOT NULL AUTO_INCREMENT,
    ten VARCHAR(255) NOT NULL,
    succhua INT(10) NOT NULL,
    mota VARCHAR(255) NULL,
    tblRestaurant1id INT(10) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (tblRestaurant1id) REFERENCES tblRestaurant1(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE tblTable1 (
    id INT(10) NOT NULL AUTO_INCREMENT,
    ten VARCHAR(50) NOT NULL,
    sochongoi INT(10) NOT NULL,
    trangthai VARCHAR(50) NOT NULL,
    tblArea1id INT(10) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (tblArea1id) REFERENCES tblArea1(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE tblMenuItem1 (
    id INT(10) NOT NULL AUTO_INCREMENT,
    ten VARCHAR(255) NOT NULL UNIQUE,
    gia FLOAT NOT NULL,
    mota VARCHAR(1000) NULL,
    anh VARCHAR(255) NULL,
    trangthai VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE tblCombo1 (
    tblMenuItem1id INT(10) NOT NULL,
    ngaybatdau DATE NOT NULL,
    ngayketthuc DATE NULL,
    PRIMARY KEY (tblMenuItem1id),
    FOREIGN KEY (tblMenuItem1id) REFERENCES tblMenuItem1(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE tblDishCategory1 (
    id INT(10) NOT NULL AUTO_INCREMENT,
    ten VARCHAR(255) NOT NULL UNIQUE,
    mota VARCHAR(255) NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE tblUnit1 (
    id INT(10) NOT NULL AUTO_INCREMENT,
    ten VARCHAR(50) NOT NULL UNIQUE,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE tblIngredient1 (
    id INT(10) NOT NULL AUTO_INCREMENT,
    ten VARCHAR(255) NOT NULL UNIQUE,
    giavon FLOAT NOT NULL,
    soluongton FLOAT NOT NULL,
    tontoithieu FLOAT NOT NULL,
    dieukienbaoquan VARCHAR(255) NULL,
    tblUnit1id INT(10) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (tblUnit1id) REFERENCES tblUnit1(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE tblImportBill1 (
    id INT(10) NOT NULL AUTO_INCREMENT,
    ngaynhap DATE NOT NULL,
    ghichu VARCHAR(255) NULL,
    tblSupplier1id INT(10) NOT NULL,
    tblStaff1id INT(10) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (tblSupplier1id) REFERENCES tblSupplier1(id),
    FOREIGN KEY (tblStaff1id) REFERENCES tblStaff1(tblMember1id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE tblImportDetail1 (
    id INT(10) NOT NULL AUTO_INCREMENT,
    soluong FLOAT NOT NULL,
    dongia FLOAT NOT NULL,
    hansudung DATE NULL,
    tblImportBill1id INT(10) NOT NULL,
    tblIngredient1id INT(10) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (tblImportBill1id) REFERENCES tblImportBill1(id),
    FOREIGN KEY (tblIngredient1id) REFERENCES tblIngredient1(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE tblSaleStaff1 (
    tblStaff1id INT(10) NOT NULL,
    tblArea1id INT(10) NOT NULL,
    PRIMARY KEY (tblStaff1id),
    FOREIGN KEY (tblStaff1id) REFERENCES tblStaff1(tblMember1id),
    FOREIGN KEY (tblArea1id) REFERENCES tblArea1(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE tblDish1 (
    tblMenuItem1id INT(10) NOT NULL,
    thoigianchebien INT(10) NOT NULL,
    tblDishCategory1id INT(10) NOT NULL,
    tblUnit1id INT(10) NOT NULL,
    PRIMARY KEY (tblMenuItem1id),
    FOREIGN KEY (tblMenuItem1id) REFERENCES tblMenuItem1(id),
    FOREIGN KEY (tblDishCategory1id) REFERENCES tblDishCategory1(id),
    FOREIGN KEY (tblUnit1id) REFERENCES tblUnit1(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE tblComboDetail1 (
    id INT(10) NOT NULL AUTO_INCREMENT,
    soluong INT(10) NOT NULL,
    tblCombo1id INT(10) NOT NULL,
    tblDish1id INT(10) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (tblCombo1id) REFERENCES tblCombo1(tblMenuItem1id),
    FOREIGN KEY (tblDish1id) REFERENCES tblDish1(tblMenuItem1id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE tblDishIngredient1 (
    id INT(10) NOT NULL AUTO_INCREMENT,
    dinhluong FLOAT NOT NULL,
    tblDish1id INT(10) NOT NULL,
    tblIngredient1id INT(10) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (tblDish1id) REFERENCES tblDish1(tblMenuItem1id),
    FOREIGN KEY (tblIngredient1id) REFERENCES tblIngredient1(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE tblBooking1 (
    id INT(10) NOT NULL AUTO_INCREMENT,
    ngaydat DATE NOT NULL,
    thoigianden DATETIME NOT NULL,
    soluongkhach INT(10) NOT NULL,
    tiencoc FLOAT NOT NULL,
    ghichu VARCHAR(255) NULL,
    trangthai VARCHAR(50) NOT NULL,
    ngayxacnhan DATE NULL,
    lidotuchoi VARCHAR(255) NULL,
    tblCustomer1id INT(10) NOT NULL,
    tblTable1id INT(10) NOT NULL,
    tblSaleStaff1id INT(10) NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (tblCustomer1id) REFERENCES tblCustomer1(tblMember1id),
    FOREIGN KEY (tblTable1id) REFERENCES tblTable1(id),
    FOREIGN KEY (tblSaleStaff1id) REFERENCES tblSaleStaff1(tblStaff1id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE tblBookingDetail1 (
    id INT(10) NOT NULL AUTO_INCREMENT,
    soluong INT(10) NOT NULL,
    dongia FLOAT NOT NULL,
    tblBooking1id INT(10) NOT NULL,
    tblMenuItem1id INT(10) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (tblBooking1id) REFERENCES tblBooking1(id),
    FOREIGN KEY (tblMenuItem1id) REFERENCES tblMenuItem1(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE tblOrder1 (
    id INT(10) NOT NULL AUTO_INCREMENT,
    tenkhach VARCHAR(255) NOT NULL,
    soluongkhach INT(10) NOT NULL,
    thoigianmo DATETIME NOT NULL,
    thoigiandong DATETIME NULL,
    trangthai VARCHAR(50) NOT NULL,
    tblTable1id INT(10) NOT NULL,
    tblSaleStaff1id INT(10) NOT NULL,
    tblBooking1id INT(10) NULL UNIQUE,
    PRIMARY KEY (id),
    FOREIGN KEY (tblTable1id) REFERENCES tblTable1(id),
    FOREIGN KEY (tblSaleStaff1id) REFERENCES tblSaleStaff1(tblStaff1id),
    FOREIGN KEY (tblBooking1id) REFERENCES tblBooking1(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE tblOrderDetail1 (
    id INT(10) NOT NULL AUTO_INCREMENT,
    soluong INT(10) NOT NULL,
    dongia FLOAT NOT NULL,
    thoigiangoi DATETIME NOT NULL,
    trangthai VARCHAR(50) NOT NULL,
    tblOrder1id INT(10) NOT NULL,
    tblMenuItem1id INT(10) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (tblOrder1id) REFERENCES tblOrder1(id),
    FOREIGN KEY (tblMenuItem1id) REFERENCES tblMenuItem1(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE tblBill1 (
    id INT(10) NOT NULL AUTO_INCREMENT,
    ngaylap DATETIME NOT NULL,
    giamgia FLOAT NOT NULL,
    tblOrder1id INT(10) NOT NULL UNIQUE,
    tblSaleStaff1id INT(10) NOT NULL,
    tblMemberCard1id INT(10) NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (tblOrder1id) REFERENCES tblOrder1(id),
    FOREIGN KEY (tblSaleStaff1id) REFERENCES tblSaleStaff1(tblStaff1id),
    FOREIGN KEY (tblMemberCard1id) REFERENCES tblMemberCard1(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE tblBillDetail1 (
    id INT(10) NOT NULL AUTO_INCREMENT,
    soluong INT(10) NOT NULL,
    dongia FLOAT NOT NULL,
    tblBill1id INT(10) NOT NULL,
    tblMenuItem1id INT(10) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (tblBill1id) REFERENCES tblBill1(id),
    FOREIGN KEY (tblMenuItem1id) REFERENCES tblMenuItem1(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE tblPayment1 (
    id INT(10) NOT NULL AUTO_INCREMENT,
    hinhthuc VARCHAR(50) NOT NULL,
    sotien FLOAT NOT NULL,
    tienkhachdua FLOAT NULL,
    magiaodich VARCHAR(100) NULL,
    tblBill1id INT(10) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (tblBill1id) REFERENCES tblBill1(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ======================= DU LIEU MAU - THUC DON (module 1) =======================
INSERT INTO tblUnit1 (id, ten) VALUES
(1, 'Đĩa'), (2, 'Nồi'), (3, 'Bát'), (4, 'Phần'), (5, 'kg');

INSERT INTO tblDishCategory1 (id, ten, mota) VALUES
(1, 'Khai vị', 'Món ăn nhẹ trước bữa chính'),
(2, 'Món chính', 'Món ăn chính của bữa'),
(3, 'Lẩu', 'Lẩu dùng cho nhóm khách'),
(4, 'Canh', NULL),
(5, 'Tráng miệng', NULL),
(6, 'Cơm', NULL);

-- Mon an (mã hiển thị = MA + id 3 chữ số) va combo (CB + id)
INSERT INTO tblMenuItem1 (id, ten, gia, mota, anh, trangthai) VALUES
(12, 'Bò lúc lắc', 185000, 'Thăn bò Úc cắt hạt lựu, xóc lửa lớn với tỏi, ớt chuông, hành tây; ăn kèm khoai tây chiên và salad.', 'MA012.jpg', 'Đang phục vụ'),
(15, 'Bò nướng lá lốt', 129000, 'Thịt bò bắp băm cuốn lá lốt nướng than hoa, chấm mắm nêm.', 'MA015.jpg', 'Đang phục vụ'),
(31, 'Lẩu bò nhúng dấm', 459000, 'Thịt bò bắp thái mỏng nhúng nồi nước dấm dừa, ăn kèm rau sống và bánh tráng.', 'MA031.jpg', 'Đang phục vụ'),
(44, 'Gỏi bò bóp thấu', 99000, 'Thịt bò tái chanh bóp cùng hành tây, rau thơm, đậu phộng.', 'MA044.jpg', 'Đang phục vụ'),
(18, 'Gà nướng muối ớt', 189000, 'Gà ta nướng muối ớt, da giòn.', 'MA018.jpg', 'Đang phục vụ'),
(25, 'Canh chua cá lóc', 119000, 'Canh chua miền Nam với cá lóc, dứa, cà chua, bạc hà.', 'MA025.jpg', 'Đang phục vụ'),
(50, 'Cơm trắng', 10000, NULL, 'MA050.jpg', 'Đang phục vụ'),
(46, 'Salad cá hồi', 109000, 'Cá hồi áp chảo cùng rau xà lách, sốt mè rang.', 'MA046.jpg', 'Đang phục vụ'),
(60, 'Tiramisu', 55000, 'Bánh tiramisu kiểu Ý.', 'MA060.jpg', 'Đang phục vụ'),
(20, 'Phở bò tái', 69000, 'Món đã ngừng bán - không hiện khi tìm kiếm.', 'MA020.jpg', 'Ngừng bán'),
(33, 'Cá kho tộ', 139000, 'Cá lóc kho tộ - dùng để thử ngoại lệ 6.1 (tìm "cá").', 'MA033.jpg', 'Tạm hết'),
(3, 'Combo Gia đình 4 người', 575000, 'Combo cho nhóm 4 người.', NULL, 'Đang phục vụ'),
(7, 'Combo Hẹn hò 2 người', 359000, 'Combo cho 2 người.', NULL, 'Đang phục vụ'),
(9, 'Combo Trưa văn phòng', 179000, 'Combo đã hết hạn - không hiện khi xem combo.', NULL, 'Đang phục vụ');

INSERT INTO tblDish1 (tblMenuItem1id, thoigianchebien, tblDishCategory1id, tblUnit1id) VALUES
(12, 15, 2, 1), (15, 20, 2, 1), (31, 25, 3, 2), (44, 10, 1, 1),
(18, 30, 2, 1), (25, 20, 4, 2), (50, 2, 6, 3), (46, 10, 1, 1),
(60, 5, 5, 4), (20, 10, 2, 3), (33, 25, 2, 1);

INSERT INTO tblCombo1 (tblMenuItem1id, ngaybatdau, ngayketthuc) VALUES
(3, '2026-01-01', NULL),
(7, '2026-09-01', '2030-12-31'),
(9, '2025-01-01', '2025-12-31');

-- CB003: giá lẻ = 99.000 + 185.000 + 189.000 + 119.000 + 4 x 10.000 = 632.000
-- CB007: giá lẻ = 109.000 + 185.000 + 2 x 55.000 = 404.000
INSERT INTO tblComboDetail1 (id, soluong, tblCombo1id, tblDish1id) VALUES
(1, 1, 3, 44), (2, 1, 3, 12), (3, 1, 3, 18), (4, 1, 3, 25), (5, 4, 3, 50),
(6, 1, 7, 46), (7, 1, 7, 12), (8, 2, 7, 60),
(9, 1, 9, 12), (10, 1, 9, 50);

INSERT INTO tblIngredient1 (id, ten, giavon, soluongton, tontoithieu, dieukienbaoquan, tblUnit1id) VALUES
(1, 'Thăn bò Úc', 520000, 12.5, 5, 'Ngăn mát 0 - 4 độ C', 5),
(2, 'Ớt chuông', 60000, 4, 1, 'Ngăn mát', 5),
(3, 'Hành tây', 25000, 8, 2, 'Nơi khô ráo', 5),
(4, 'Khoai tây', 30000, 15, 3, 'Nơi khô ráo', 5),
(5, 'Lá lốt', 40000, 1.5, 0.5, 'Ngăn mát', 5),
(6, 'Thịt bò bắp', 320000, 10, 4, 'Ngăn mát 0 - 4 độ C', 5),
(7, 'Gà ta', 150000, 9, 3, 'Ngăn mát 0 - 4 độ C', 5),
(8, 'Cá lóc', 120000, 6, 2, 'Ngăn mát 0 - 4 độ C', 5),
(9, 'Cá hồi', 450000, 3, 1, 'Ngăn đông', 5),
(10, 'Gạo tám', 28000, 40, 10, 'Nơi khô ráo', 5),
(11, 'Phô mai mascarpone', 380000, 2, 0.5, 'Ngăn mát', 5);

INSERT INTO tblDishIngredient1 (dinhluong, tblDish1id, tblIngredient1id) VALUES
(0.2, 12, 1), (0.05, 12, 2), (0.05, 12, 3), (0.1, 12, 4),
(0.15, 15, 6), (0.02, 15, 5),
(0.5, 31, 6), (0.1, 31, 3),
(0.12, 44, 6), (0.05, 44, 3),
(0.6, 18, 7),
(0.4, 25, 8),
(0.1, 50, 10),
(0.12, 46, 9),
(0.05, 60, 11),
(0.15, 20, 6),
(0.3, 33, 8);


-- ======================= DU LIEU MAU - THANH TOAN (module 2) =======================
-- Mon an, do uong co tren phieu goi mon cua ban B05
INSERT INTO tblUnit1 (id, ten) VALUES (6, 'Lon'), (7, 'Ly');
INSERT INTO tblDishCategory1 (id, ten, mota) VALUES (7, 'Rau', NULL), (8, 'Đồ uống', NULL);
INSERT INTO tblMenuItem1 (id, ten, gia, mota, anh, trangthai) VALUES
(52, 'Rau muống xào tỏi', 56000, 'Rau muống xào tỏi, giòn và xanh.', 'MA052.jpg', 'Đang phục vụ'),
(70, 'Bia Hà Nội (lon)', 25000, 'Bia Hà Nội lon 330 ml.', 'MA070.jpg', 'Đang phục vụ'),
(72, 'Nước cam ép', 45000, 'Cam sành ép nguyên chất.', 'MA072.jpg', 'Đang phục vụ');
INSERT INTO tblDish1 (tblMenuItem1id, thoigianchebien, tblDishCategory1id, tblUnit1id) VALUES
(52, 8, 7, 1), (70, 1, 8, 6), (72, 5, 8, 7);

INSERT INTO tblAddress1 (id, sonha, duong, phuong, quan, tinhthanh) VALUES
(1, '96A', 'Trần Phú', 'Mộ Lao', 'Hà Đông', 'Hà Nội'),
(2, '15', 'Nguyễn Trãi', 'Văn Quán', 'Hà Đông', 'Hà Nội'),
(3, '27', 'Quang Trung', 'Yên Nghĩa', 'Hà Đông', 'Hà Nội');

INSERT INTO tblRestaurant1 (id, ten, dt, giomocua, mota, tblAddress1id) VALUES
(1, 'Nhà hàng RestMan', '02433556677', '10:00 - 22:00', NULL, 1);

INSERT INTO tblArea1 (id, ten, succhua, mota, tblRestaurant1id) VALUES
(1, 'Tầng 1', 32, 'Khu bàn thường tầng 1', 1),
(2, 'Tầng 2', 32, 'Khu bàn thường tầng 2', 1),
(3, 'Phòng VIP', 30, 'Phòng riêng cho nhóm khách', 1);

INSERT INTO tblTable1 (id, ten, sochongoi, trangthai, tblArea1id) VALUES
(1, 'B01', 4, 'Trống', 1), (2, 'B02', 4, 'Trống', 1), (3, 'B03', 4, 'Trống', 1), (4, 'B04', 4, 'Trống', 1),
(5, 'B05', 4, 'Đang phục vụ', 1), (6, 'B06', 4, 'Trống', 1), (7, 'B07', 4, 'Trống', 1), (8, 'B08', 4, 'Đang phục vụ', 1),
(9, 'V01', 10, 'Trống', 3), (10, 'V02', 10, 'Đang phục vụ', 3), (11, 'V03', 10, 'Trống', 3);

-- Thanh vien: 2 nhan vien ban hang, 3 khach hang (mat khau mau 123456)
INSERT INTO tblMember1 (id, username, password, vaitro, trangthaitk, ho, tendem, ten, ngaysinh, gioitinh, email, dt, ghichu, tblAddress1id) VALUES
(1, 'hapt', '123456', 'Nhân viên bán hàng', 'Hoạt động', 'Phạm', 'Thu', 'Hà', '2001-05-12', 'Nữ', 'hapt@restman.vn', '0987000001', NULL, 2),
(2, 'lanvt', '123456', 'Nhân viên bán hàng', 'Hoạt động', 'Vũ', 'Thị', 'Lan', '2000-11-03', 'Nữ', 'lanvt@restman.vn', '0987000002', NULL, NULL),
(3, 'tuanlm', '123456', 'Khách hàng', 'Hoạt động', 'Lê', 'Minh', 'Tuấn', '1992-08-20', 'Nam', 'tuanlm@gmail.com', '0912345678', NULL, 3),
(4, 'tuanna', '123456', 'Khách hàng', 'Hoạt động', 'Nguyễn', 'Anh', 'Tuấn', '1988-02-14', 'Nam', NULL, '0903456789', NULL, NULL),
(5, 'namhv', '123456', 'Khách hàng', 'Hoạt động', 'Hoàng', 'Văn', 'Nam', '1995-12-01', 'Nam', NULL, '0934567890', NULL, NULL),
(6, 'trangnt', '123456', 'Khách hàng', 'Hoạt động', 'Nguyễn', 'Thu', 'Trang', '1998-04-18', 'Nữ', 'trangnt@gmail.com', '0978123456', NULL, NULL);

INSERT INTO tblStaff1 (tblMember1id, vitri, ngayvaolam) VALUES
(1, 'Bán hàng', '2024-03-01'), (2, 'Bán hàng', '2023-08-15');
INSERT INTO tblSaleStaff1 (tblStaff1id, tblArea1id) VALUES (1, 1), (2, 3);
INSERT INTO tblCustomer1 (tblMember1id, ngaydangki) VALUES
(3, '2025-02-10'), (4, '2025-06-01'), (5, '2025-11-20'), (6, '2026-03-05');

INSERT INTO tblCardRank1 (id, ten, diemtoithieu, tilegiamgia) VALUES
(1, 'Thường', 0, 0), (2, 'Bạc', 1000, 5), (3, 'Vàng', 5000, 10);
-- TV000128: the cua Le Minh Tuan (hang Bac, 1.240 diem); TV000200: the bi khoa de thu ngoai le 10.1
INSERT INTO tblMemberCard1 (id, sothe, ngaycap, diemtichluy, trangthai, tblCustomer1id, tblCardRank1id) VALUES
(1, 'TV000128', '2025-02-10', 1240, 'Hoạt động', 3, 2),
(2, 'TV000200', '2025-11-20', 150, 'Khoá', 5, 1);

-- Ban V02 co dat truoc va da coc 500.000 d (ngoai le 10.3)
INSERT INTO tblBooking1 (id, ngaydat, thoigianden, soluongkhach, tiencoc, ghichu, trangthai, ngayxacnhan, lidotuchoi, tblCustomer1id, tblTable1id, tblSaleStaff1id) VALUES
(1, '2026-09-20', '2026-09-24 19:00:00', 8, 500000, 'Liên hoan công ty', 'Đã đến', '2026-09-20', NULL, 4, 10, 2);
INSERT INTO tblBookingDetail1 (id, soluong, dongia, tblBooking1id, tblMenuItem1id) VALUES
(1, 2, 459000, 1, 31);

-- 3 phieu goi mon dang mo: B05 (Le Minh Tuan), V02 (Nguyen Anh Tuan), B08 (Hoang Van Nam - con mon chua phuc vu)
INSERT INTO tblOrder1 (id, tenkhach, soluongkhach, thoigianmo, thoigiandong, trangthai, tblTable1id, tblSaleStaff1id, tblBooking1id) VALUES
(1, 'Lê Minh Tuấn', 4, '2026-09-24 18:32:00', NULL, 'Đang mở', 5, 1, NULL),
(2, 'Nguyễn Anh Tuấn', 8, '2026-09-24 19:05:00', NULL, 'Đang mở', 10, 2, 1),
(3, 'Hoàng Văn Nam', 2, '2026-09-24 19:20:00', NULL, 'Đang mở', 8, 1, NULL);

-- B05: 575.000 + 129.000 + 56.000 + 6 x 25.000 + 2 x 45.000 = 1.000.000
-- V02: 2 x 459.000 + 3 x 189.000 + 3 x 185.000 + 575.000 + 16 x 25.000 + 3 x 45.000 + 2 x 55.000 = 3.260.000
-- B08: 185.000 + 2 x 10.000 + 2 x 55.000 (Tiramisu da gui bep, chua phuc vu - ngoai le 12.1) = 315.000
INSERT INTO tblOrderDetail1 (id, soluong, dongia, thoigiangoi, trangthai, tblOrder1id, tblMenuItem1id) VALUES
(1, 1, 575000, '2026-09-24 18:35:00', 'Đã phục vụ', 1, 3),
(2, 1, 129000, '2026-09-24 18:35:00', 'Đã phục vụ', 1, 15),
(3, 1, 56000, '2026-09-24 18:35:00', 'Đã phục vụ', 1, 52),
(4, 6, 25000, '2026-09-24 18:36:00', 'Đã phục vụ', 1, 70),
(5, 2, 45000, '2026-09-24 18:36:00', 'Đã phục vụ', 1, 72),
(6, 2, 459000, '2026-09-24 19:08:00', 'Đã phục vụ', 2, 31),
(7, 3, 189000, '2026-09-24 19:08:00', 'Đã phục vụ', 2, 18),
(8, 3, 185000, '2026-09-24 19:08:00', 'Đã phục vụ', 2, 12),
(9, 1, 575000, '2026-09-24 19:10:00', 'Đã phục vụ', 2, 3),
(10, 16, 25000, '2026-09-24 19:10:00', 'Đã phục vụ', 2, 70),
(11, 3, 45000, '2026-09-24 19:10:00', 'Đã phục vụ', 2, 72),
(12, 2, 55000, '2026-09-24 20:00:00', 'Đã phục vụ', 2, 60),
(13, 1, 185000, '2026-09-24 19:22:00', 'Đã phục vụ', 3, 12),
(14, 2, 10000, '2026-09-24 19:22:00', 'Đã phục vụ', 3, 50),
(15, 2, 55000, '2026-09-24 20:05:00', 'Đã gửi bếp', 3, 60);

-- Hoa don tiep theo co id 157 (ma hien thi HD0157)
ALTER TABLE tblBill1 AUTO_INCREMENT = 157;
