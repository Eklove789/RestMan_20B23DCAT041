<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList,dao.*,model.*"%>
<%!
    private String esc(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
    }
%>
<%
    request.setCharacterEncoding("UTF-8");
    if (session.getAttribute("staff") == null) {
        response.sendRedirect("../index.jsp");
        return;
    }
    // nut Quay lai: ve trang chu nhan vien ban hang
    if (request.getParameter("subBack") != null) {
        response.sendRedirect("UISaleStaffHome1.jsp");
        return;
    }
    String outMessage = "";
    String inCustomerName = request.getParameter("inCustomerName");
    if (request.getParameter("subSearch") != null) {
        // buoc 4 - 5: nhan vien nhap ten khach, click Tim; submit goi chinh trang nay xu li
        String keyword = (inCustomerName == null) ? "" : inCustomerName.trim();
        if (keyword.length() == 0) {
            outMessage = "Vui lòng nhập tên khách cần tìm";
        } else {
            // buoc 6 - 11: goi OrderDAO1.searchServingOrders()
            ArrayList<Order1> listOrder = (new OrderDAO1()).searchServingOrders(keyword);
            if (listOrder.isEmpty()) {
                // ngoai le 5.1
                outMessage = "Không tìm thấy bàn phù hợp";
            } else {
                // buoc 12: goi trang UIServingTableList1.jsp
                session.setAttribute("orderKeyword", keyword);
                session.setAttribute("listOrder", listOrder);
                response.sendRedirect("UIServingTableList1.jsp");
                return;
            }
        }
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
<title>Thanh toán - RestMan</title>
</head>
<body>
<%@ include file="header.jspf" %>
<%-- buoc 3 / 77: hien thi giao dien thanh toan --%>
<main class="container">
    <div class="card search-card">
        <div class="crumbs"><span>Trang chủ</span><span>Thanh toán</span></div>
        <h2 style="font-size:22px">Thanh toán</h2>
        <form name="payment" action="UIPayment1.jsp" method="post">
            <label for="inCustomerName" class="hint" style="display:block;margin:0 0 8px">Tên khách</label>
            <div class="search-box">
                <input type="text" id="inCustomerName" name="inCustomerName" maxlength="255"
                       placeholder="Nhập tên khách đang dùng bữa, ví dụ: Tuấn" value="<%=esc(inCustomerName)%>" autofocus />
                <input type="submit" name="subSearch" value="Tìm" />
            </div>
            <% if (outMessage.length() > 0) { %>
            <div class="alert error" id="outMessage">⚠ <%=esc(outMessage)%></div>
            <% } %>
            <div class="hint">Hệ thống tìm các bàn đang phục vụ có tên khách chứa từ khoá.</div>
            <div class="actions">
                <input type="submit" class="secondary" name="subBack" value="← Quay lại" />
            </div>
        </form>
    </div>
</main>
</body>
</html>
