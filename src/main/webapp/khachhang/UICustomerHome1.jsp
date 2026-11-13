<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="model.*"%>
<%
    // nhan thong tin khach hang dang nhap (luu trong session sau khi dang nhap)
    // buoc 1: khach hang click link Tim thong tin mon an -> buoc 2: goi trang UISearchDish1.jsp
    Customer1 customer = (Customer1) session.getAttribute("customer");
    String tenKH = "Quý khách";
    if (customer != null && customer.getFullName() != null) {
        FullName1 fn = customer.getFullName();
        tenKH = fn.getHo() + " " + (fn.getTendem() == null ? "" : fn.getTendem() + " ") + fn.getTen();
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="../css/restman1.css">
<title>Trang chủ khách hàng - RestMan</title>
</head>
<body>
<%@ include file="header.jspf" %>
<main class="container">
    <section class="hero">
        <h1>Xin chào, <%=tenKH%>!</h1>
        <p>Chào mừng bạn đến với nhà hàng RestMan. Bạn muốn làm gì hôm nay?</p>
    </section>
    <div class="tiles">
        <a class="tile" id="subSearchDish" href="UISearchDish1.jsp">
            <span class="icon">🔍</span>
            <b>Tìm thông tin món ăn</b>
            <span>Tra cứu món theo tên, xem giá, nguyên liệu và các combo có món đó.</span>
        </a>
    </div>
</main>
</body>
</html>
