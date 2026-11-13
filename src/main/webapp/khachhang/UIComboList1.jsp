<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList,java.util.Locale,dao.*,model.*"%>
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
    // mon an dang xem (UIDishDetail1.jsp luu trong session)
    Dish1 dish = (Dish1) session.getAttribute("dish");
    if (dish == null) {
        response.sendRedirect("UIDishList1.jsp");
        return;
    }
    String keyword = (String) session.getAttribute("keyword");
    String outMessage = "";
    // buoc 31 - 36: goi ComboDAO1.getCombosByDish()
    ArrayList<Combo1> listCombo = (new ComboDAO1()).getCombosByDish(dish.getId());
    float[] listRetailPrice = new float[listCombo.size()];
    if (listCombo.isEmpty()) {
        outMessage = "Món " + dish.getTen() + " hiện chưa có trong combo nào.";
    } else {
        // loop moi combo trong danh sach
        for (int i = 0; i < listCombo.size(); i++) {
            Combo1 cb = listCombo.get(i);
            // buoc 37 - 42: goi ComboDetailDAO1.getComboDetails()
            ArrayList<ComboDetail1> details = (new ComboDetailDAO1()).getComboDetails(cb.getId());
            cb.setDetails(details);
            // buoc 43: tinh gia le = tong gia ban x so luong
            float retail = 0;
            for (ComboDetail1 cd : details) {
                retail += cd.getDish().getGia() * cd.getSoluong();
            }
            listRetailPrice[i] = retail;
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
<title>Combo có món <%=esc(dish.getTen())%> - RestMan</title>
</head>
<body>
<%@ include file="header.jspf" %>
<main class="container">
    <div class="crumbs"><span>Trang chủ</span><span>Kết quả “<%=esc(keyword)%>”</span><span><%=esc(dish.getTen())%></span><span>Combo</span></div>
    <% if (listCombo.isEmpty()) { %>
    <div class="card msgbox">
        <div class="icon">ℹ️</div>
        <div class="title">Thông báo</div>
        <p id="outMessage"><%=esc(outMessage)%></p>
        <form action="UIDishDetail1.jsp" method="get">
            <input type="hidden" name="idDish" value="<%=dish.getId()%>" />
            <input type="submit" value="OK" />
        </form>
    </div>
    <% } else { %>
    <div class="page-title">
        <h1>Combo có món <%=esc(dish.getTen())%></h1>
        <span class="sub"><%=listCombo.size()%> combo đang áp dụng</span>
    </div>
    <%-- buoc 44: hien thi danh sach combo --%>
    <div class="card">
        <div class="table-wrap">
        <table class="grid" id="outComboList">
            <thead>
            <tr>
                <th class="center">TT</th><th>Mã</th><th>Tên combo</th><th>Các món trong combo</th>
                <th class="right">Giá lẻ</th><th class="right">Giá combo</th>
            </tr>
            </thead>
            <tbody>
            <% for (int i = 0; i < listCombo.size(); i++) {
                   Combo1 cb = listCombo.get(i);
                   float tietKiem = listRetailPrice[i] - cb.getGia(); %>
            <tr>
                <td class="center"><%=i + 1%></td>
                <td class="code"><%=String.format("CB%03d", cb.getId())%></td>
                <td><b><%=esc(cb.getTen())%></b></td>
                <td>
                    <% for (ComboDetail1 cd : cb.getDetails()) {
                           boolean current = cd.getDish().getId() == dish.getId(); %>
                    <span class="chip<%=current ? " current" : ""%>"><%=esc(cd.getDish().getTen())%><%=cd.getSoluong() > 1 ? " ×" + cd.getSoluong() : ""%></span>
                    <% } %>
                </td>
                <td class="right"><span class="old-price"><%=vnd(listRetailPrice[i])%> đ</span></td>
                <td class="right">
                    <div class="price"><%=vnd(cb.getGia())%> đ</div>
                    <% if (tietKiem > 0) { %><span class="badge save">Tiết kiệm <%=vnd(tietKiem)%> đ</span><% } %>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
        </div>
        <p class="note">Giá lẻ = tổng giá bán các món thành phần × số lượng.</p>
    </div>
    <%-- buoc 45 - 46: click Quay lai -> goi lai UIDishList1.jsp --%>
    <form class="actions" action="UIDishList1.jsp" method="get">
        <input type="submit" class="secondary" name="subBack" value="← Quay lại danh sách món" />
    </form>
    <% } %>
</main>
</body>
</html>
