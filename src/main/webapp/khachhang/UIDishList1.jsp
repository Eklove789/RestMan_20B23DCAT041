<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList,java.util.Locale,model.*"%>
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
    // nhan danh sach mon an va tu khoa tu trang UISearchDish1.jsp (luu trong session)
    // buoc 13 / 47: hien thi danh sach mon an (ca khi quay lai tu UIComboList1.jsp)
    String keyword = (String) session.getAttribute("keyword");
    ArrayList<Dish1> listDish = (ArrayList<Dish1>) session.getAttribute("listDish");
    if (keyword == null || listDish == null) {
        response.sendRedirect("UISearchDish1.jsp");
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
<link rel="stylesheet" href="../css/restman1.css">
<title>Danh sách món ăn - RestMan</title>
</head>
<body>
<%@ include file="header.jspf" %>
<main class="container">
    <div class="crumbs"><span>Trang chủ</span><span>Tìm thông tin món ăn</span><span>Kết quả</span></div>
    <div class="page-title">
        <h1>Kết quả tìm kiếm cho “<%=esc(keyword)%>”</h1>
        <span class="sub"><%=listDish.size()%> món ăn</span>
    </div>
    <div class="card">
        <div class="table-wrap">
        <table class="grid" id="outsubDishList">
            <thead>
            <tr>
                <th class="center">TT</th><th>Mã</th><th>Món ăn</th><th>Loại món</th>
                <th>ĐVT</th><th class="right">Giá bán</th><th class="center">Chọn</th>
            </tr>
            </thead>
            <tbody>
            <% for (int i = 0; i < listDish.size(); i++) {
                   Dish1 d = listDish.get(i); %>
            <tr>
                <td class="center"><%=i + 1%></td>
                <td class="code"><%=String.format("MA%03d", d.getId())%></td>
                <td>
                    <div class="dish-cell">
                        <% if (d.getAnh() != null && d.getAnh().length() > 0) { %>
                        <img class="thumb" src="../images/<%=esc(d.getAnh())%>" alt="">
                        <% } else { %><span class="thumb-empty">(ảnh)</span><% } %>
                        <b><%=esc(d.getTen())%></b>
                    </div>
                </td>
                <td><span class="badge"><%=esc(d.getCategory().getTen())%></span></td>
                <td><%=esc(d.getUnit().getTen())%></td>
                <td class="right price"><%=vnd(d.getGia())%> đ</td>
                <%-- buoc 14 - 15: click chon mon -> goi UIDishDetail1.jsp --%>
                <td class="center"><a class="btn small subChoose" href="UIDishDetail1.jsp?idDish=<%=d.getId()%>">Xem chi tiết</a></td>
            </tr>
            <% } %>
            </tbody>
        </table>
        </div>
    </div>
    <form class="actions" action="UISearchDish1.jsp" method="get">
        <input type="submit" class="secondary" name="subBackList" value="← Quay lại tìm kiếm" />
    </form>
</main>
</body>
</html>
