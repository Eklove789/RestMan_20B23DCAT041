# RestMan1 – Hệ thống quản lí nhà hàng (đề 20, B23DCAT041)

Bài tập lớn học phần Phân tích thiết kế hệ thống thông tin – Vũ Xuân Đạo – B23DCAT041.
Mã nguồn cài đặt hai module theo đúng thiết kế trong báo cáo (biểu đồ lớp thiết kế, biểu đồ hoạt động,
kịch bản phiên bản 3.0 và biểu đồ tuần tự):

- Module 1 – Search Dish By Name 1: khách hàng tìm kiếm thông tin món ăn.
- Module 2 – Receive Payment 1: nhân viên bán hàng nhận thanh toán tại bàn.

Kiến trúc ba tầng J2EE: JSP → DAO (JDBC) → MySQL, chạy trên Tomcat 9.

## Cấu trúc thư mục

```
RestMan_20B23DCAT041/
├── pom.xml                      Maven web project (mở bằng NetBeans / IntelliJ / Eclipse)
├── database/restman1.sql        Tạo CSDL restman1 (28 bảng theo thiết kế) + dữ liệu mẫu theo kịch bản
└── src/main/
    ├── java/model/              Gói model – 26 lớp thực thể
    ├── java/dao/                Gói dao – DAO1 (giữ Connection) và 11 lớp DAO
    └── webapp/
        ├── index.jsp            Chọn vai trò (thay cho bước đăng nhập, không thuộc hai module)
        ├── khachhang/           Gói view.khachhang – 5 trang JSP của module 1
        ├── nhanvienbanhang/     Gói view.nhanvienbanhang – 6 trang JSP của module 2
        ├── css/, images/
        └── WEB-INF/web.xml
```

## Ánh xạ thiết kế → mã nguồn

| Trang JSP | Phương thức DAO | Bước kịch bản 3.0 |
|---|---|---|
| khachhang/UICustomerHome1.jsp | – | M1: 1 – 2 |
| khachhang/UISearchDish1.jsp | DishDAO1.searchDishByName(name) | M1: 3 – 12 |
| khachhang/UIDishList1.jsp | – | M1: 13 – 15, 47 |
| khachhang/UIDishDetail1.jsp | DishDAO1.getDishDetail(idDish), DishIngredientDAO1.getIngredientsByDish(idDish) | M1: 16 – 30 |
| khachhang/UIComboList1.jsp | ComboDAO1.getCombosByDish(idDish), ComboDetailDAO1.getComboDetails(idCombo) | M1: 31 – 46 |
| nhanvienbanhang/UISaleStaffHome1.jsp | – | M2: 1 – 2 |
| nhanvienbanhang/UIPayment1.jsp | OrderDAO1.searchServingOrders(name) | M2: 3 – 12, 77 |
| nhanvienbanhang/UIServingTableList1.jsp | OrderDetailDAO1.calculateTempTotal(idOrder) | M2: 13 – 18 |
| nhanvienbanhang/UITempBill1.jsp | OrderDetailDAO1.getOrderDetailsByOrder(idOrder), BookingDAO1.getDepositByOrder(idOrder), MemberCardDAO1.findValidCard(key) | M2: 19 – 41 |
| nhanvienbanhang/doSaveBill1.jsp | OrderDetailDAO1.countUnservedDetails(idOrder), cancelUnservedDetails(idOrder), BillDAO1.saveBill(bill) → BillDetailDAO1.saveBillDetails(), PaymentDAO1.savePayments(), MemberCardDAO1.addPoints(), OrderDAO1.closeOrder() | M2: 42 – 70 |
| nhanvienbanhang/UIBill1.jsp | – | M2: 71 – 76 |

Trong mã, mỗi đoạn xử lí có ghi chú `buoc n` trùng số thứ tự thông điệp trên biểu đồ tuần tự.

## Chạy thử

1. Cài JDK 11 trở lên, MySQL 8.0, Apache Tomcat 9.
2. Chạy `database/restman1.sql` để tạo CSDL `restman1` và dữ liệu mẫu.
3. Sửa `dbUrl`, `dbUser`, `dbPassword` trong `src/main/java/dao/DAO1.java` cho khớp MySQL trên máy
   (mặc định `localhost:3307`, tài khoản `root`).
4. Mở project bằng NetBeans rồi Run trên Tomcat, hoặc chạy `mvn package` và chép `target/RestMan1.war`
   vào thư mục `webapps` của Tomcat.
5. Mở `http://localhost:8080/RestMan1/`, chọn vai trò Khách hàng hoặc Nhân viên bán hàng.

Dữ liệu thử theo kịch bản: module 1 tìm “bò” (4 món, Bò lúc lắc có trong 2 combo);
module 2 tìm khách “Tuấn” (bàn B05 và V02), thẻ thành viên TV000128, hoá đơn HD0157.
Để demo lại từ đầu, chạy `tools/reset-db-restman.bat` (nạp lại `database/restman1.sql` vào MySQL cổng 3307).
