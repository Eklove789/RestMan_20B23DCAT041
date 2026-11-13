<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="model.*"%>
<%
    // nhan thong tin nhan vien ban hang dang nhap (luu trong session sau khi dang nhap)
    // buoc 1: nhan vien click Thanh toan -> buoc 2: goi trang UIPayment1.jsp
    SaleStaff1 staff = (SaleStaff1) session.getAttribute("staff");
    if (staff == null) {
        response.sendRedirect("../index.jsp");
        return;
    }
    FullName1 fn = staff.getFullName();
    String tenNV = fn.getHo() + " " + (fn.getTendem() == null ? "" : fn.getTendem() + " ") + fn.getTen();
%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="../css/restman1.css">
<title>Trang chủ nhân viên bán hàng - RestMan</title>
</head>
<body>
<%@ include file="header.jspf" %>
<main class="container">
    <section class="hero">
        <h1>Xin chào, <%=tenNV%>!</h1>
        <p>Nhân viên bán hàng — khu vực <%=staff.getArea() == null ? "" : staff.getArea().getTen()%>. Chọn chức năng cần thực hiện.</p>
    </section>
    <div class="tiles">
        <a class="tile" id="subPayment" href="UIPayment1.jsp">
            <span class="icon">🧾</span>
            <b>Thanh toán</b>
            <span>Tìm bàn đang phục vụ theo tên khách, lập hoá đơn, nhận thanh toán và in hoá đơn.</span>
        </a>
    </div>
</main>
</body>
</html>
