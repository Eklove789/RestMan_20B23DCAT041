<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList,java.util.Locale,java.text.SimpleDateFormat,dao.*,model.*"%>
<%!
    private String esc(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
    }
    private String vnd(float v) {
        return String.format(Locale.forLanguageTag("vi-VN"), "%,.0f", v);
    }
%>
<%
    if (session.getAttribute("staff") == null) {
        response.sendRedirect("../index.jsp");
        return;
    }
    // nhan tu khoa va danh sach phieu goi mon dang mo tu trang UIPayment1.jsp (luu trong session)
    String keyword = (String) session.getAttribute("orderKeyword");
    ArrayList<Order1> listOrder = (ArrayList<Order1>) session.getAttribute("listOrder");
    if (keyword == null || listOrder == null) {
        response.sendRedirect("UIPayment1.jsp");
        return;
    }
    // buoc 13 - 15: goi OrderDetailDAO1.calculateTempTotal() cho tung ban trong danh sach
    ArrayList<Float> listTempTotal = new ArrayList<Float>();
    OrderDetailDAO1 orderDetailDAO = new OrderDetailDAO1();
    for (Order1 od : listOrder) {
        listTempTotal.add(orderDetailDAO.calculateTempTotal(od.getId()));
    }
    SimpleDateFormat gio = new SimpleDateFormat("HH:mm");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="../css/restman1.css">
<title>Bàn đang phục vụ - RestMan</title>
</head>
<body>
<%@ include file="header.jspf" %>
<%-- buoc 16: hien thi danh sach ban dang phuc vu --%>
<main class="container">
    <div class="crumbs"><span>Trang chủ</span><span>Thanh toán</span><span>Bàn đang phục vụ</span></div>
    <div class="page-title">
        <h1>Bàn đang phục vụ có tên khách chứa “<%=esc(keyword)%>”</h1>
        <span class="sub"><%=listOrder.size()%> bàn</span>
    </div>
    <div class="card">
        <div class="table-wrap">
        <table class="grid" id="outsubTableList">
            <thead>
            <tr>
                <th class="center">TT</th><th>Bàn</th><th>Khu vực</th><th>Tên khách</th>
                <th class="center">Số khách</th><th class="center">Bắt đầu</th>
                <th class="right">Tạm tính</th><th class="center">Chọn</th>
            </tr>
            </thead>
            <tbody>
            <% for (int i = 0; i < listOrder.size(); i++) {
                   Order1 od = listOrder.get(i); %>
            <tr>
                <td class="center"><%=i + 1%></td>
                <td class="code"><%=esc(od.getTable().getTen())%></td>
                <td><span class="badge"><%=esc(od.getStaff().getArea().getTen())%></span></td>
                <td><b><%=esc(od.getTenkhach())%></b></td>
                <td class="center"><%=od.getSoluongkhach()%></td>
                <td class="center"><%=gio.format(od.getThoigianmo())%></td>
                <td class="right price"><%=vnd(listTempTotal.get(i))%> đ</td>
                <%-- buoc 17 - 18: click chon ban -> goi UITempBill1.jsp --%>
                <td class="center"><a class="btn small subChoose" href="UITempBill1.jsp?idOrder=<%=od.getId()%>">Thanh toán</a></td>
            </tr>
            <% } %>
            </tbody>
        </table>
        </div>
    </div>
    <form class="actions" action="UIPayment1.jsp" method="get">
        <input type="submit" class="secondary" name="subBackList" value="← Quay lại" />
    </form>
</main>
</body>
</html>
