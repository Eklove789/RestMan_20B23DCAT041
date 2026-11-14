<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="model.*"%>
<%
    // Chuc nang dang nhap khong thuoc hai module duoc giao (tien dieu kien cua ca hai use case la "da dang nhap").
    // Trang nay thay cho buoc dang nhap: chon vai tro roi dua thong tin nguoi dung vao session
    // dung nhu trang dang nhap se lam (customer / staff), sau do goi trang chu cua vai tro do.
    String role = request.getParameter("role");
    if ("customer".equals(role)) {
        // khach hang Nguyen Thu Trang (tblMember1.id = 6, username trangnt)
        FullName1 fnKH = new FullName1();
        fnKH.setHo("Nguyễn");
        fnKH.setTendem("Thu");
        fnKH.setTen("Trang");
        Account1 accKH = new Account1();
        accKH.setUsername("trangnt");
        accKH.setVaitro("Khách hàng");
        Customer1 customer = new Customer1();
        customer.setId(6);
        customer.setFullName(fnKH);
        customer.setAccount(accKH);
        session.setAttribute("customer", customer);
        response.sendRedirect("khachhang/UICustomerHome1.jsp");
        return;
    }
    if ("salestaff".equals(role)) {
        // nhan vien ban hang Pham Thu Ha (tblMember1.id = 1, username hapt, phu trach khu vuc Tang 1)
        FullName1 fn = new FullName1();
        fn.setHo("Phạm");
        fn.setTendem("Thu");
        fn.setTen("Hà");
        Account1 acc = new Account1();
        acc.setUsername("hapt");
        acc.setVaitro("Nhân viên bán hàng");
        Area1 area = new Area1();
        area.setId(1);
        area.setTen("Tầng 1");
        SaleStaff1 staff = new SaleStaff1();
        staff.setId(1);
        staff.setFullName(fn);
        staff.setAccount(acc);
        staff.setVitri("Bán hàng");
        staff.setArea(area);
        session.setAttribute("staff", staff);
        response.sendRedirect("nhanvienbanhang/UISaleStaffHome1.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/restman1.css">
<title>RestMan - Hệ thống quản lí nhà hàng</title>
</head>
<body>
<header class="topbar">
    <div class="inner">
        <a class="brand" href="index.jsp">
            <span class="logo">🍽</span>
            <span>RestMan<small>Nhà hàng RestMan</small></span>
        </a>
    </div>
</header>
<main class="container">
    <section class="hero">
        <h1>Hệ thống quản lí nhà hàng RestMan</h1>
        <p>Chọn vai trò để vào trang chủ tương ứng.</p>
    </section>
    <div class="tiles">
        <a class="tile" href="index.jsp?role=customer">
            <span class="icon">🧑</span>
            <b>Khách hàng</b>
            <span>Tìm kiếm thông tin món ăn, xem nguyên liệu và các combo có món đó.</span>
        </a>
        <a class="tile" href="index.jsp?role=salestaff">
            <span class="icon">🧾</span>
            <b>Nhân viên bán hàng</b>
            <span>Nhận thanh toán tại bàn, lập và in hoá đơn cho khách.</span>
        </a>
    </div>
</main>
</body>
</html>
