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
    // id mon an: tu cot Chon cua UIDishList1.jsp, hoac lay lai mon dang xem trong session
    int idDish = -1;
    try {
        idDish = Integer.parseInt(request.getParameter("idDish"));
    } catch (Exception e) {
        Dish1 old = (Dish1) session.getAttribute("dish");
        if (old != null) idDish = old.getId();
    }
    // buoc 16 - 21: goi DishDAO1.getDishDetail()
    Dish1 dish = (idDish > 0) ? (new DishDAO1()).getDishDetail(idDish) : null;
    if (dish == null) {
        response.sendRedirect("UIDishList1.jsp");
        return;
    }
    // buoc 22 - 27: goi DishIngredientDAO1.getIngredientsByDish()
    ArrayList<DishIngredient1> listIngredient = (new DishIngredientDAO1()).getIngredientsByDish(idDish);
    dish.setIngredients(listIngredient);
    session.setAttribute("dish", dish);
    String keyword = (String) session.getAttribute("keyword");

    String outStatus = dish.getTrangthai();
    boolean tamHet = "Tạm hết".equalsIgnoreCase(outStatus);
    if (tamHet) outStatus = "Tạm hết — vui lòng chọn món khác";
%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="../css/restman1.css">
<title><%=esc(dish.getTen())%> - RestMan</title>
</head>
<body>
<%@ include file="header.jspf" %>
<%-- buoc 28: hien thi thong tin chi tiet mon an --%>
<main class="container">
    <div class="crumbs"><span>Trang chủ</span><span>Kết quả “<%=esc(keyword)%>”</span><span><%=esc(dish.getTen())%></span></div>
    <div class="card">
        <div class="detail">
            <div class="image" id="outImage">
                <% if (dish.getAnh() != null && dish.getAnh().length() > 0) { %>
                <img src="../images/<%=esc(dish.getAnh())%>" alt="Ảnh món <%=esc(dish.getTen())%>">
                <% } else { %>(ảnh món ăn)<% } %>
            </div>
            <div>
                <span class="badge" id="outCategory"><%=esc(dish.getCategory().getTen())%></span>
                <span class="badge <%=tamHet ? "warn" : "ok"%>" id="outStatus"><%=esc(outStatus)%></span>
                <h1 id="outName"><%=esc(dish.getTen())%></h1>
                <div class="big-price" id="outPrice"><%=vnd(dish.getGia())%> đ</div>
                <div class="facts">
                    <div class="fact"><small>Mã món ăn</small><b id="outId"><%=String.format("MA%03d", dish.getId())%></b></div>
                    <div class="fact"><small>Đơn vị tính</small><b id="outUnit"><%=esc(dish.getUnit().getTen())%></b></div>
                    <div class="fact"><small>Thời gian chế biến</small><b id="outCookingTime"><%=dish.getThoigianchebien()%> phút</b></div>
                </div>
                <div class="section-label">Mô tả</div>
                <textarea class="desc" id="outDescription" rows="3" readonly><%=esc(dish.getMota())%></textarea>
            </div>
        </div>

        <div class="section-label">Nguyên liệu chính</div>
        <div class="table-wrap ingredients">
        <table class="grid" id="outIngredientList">
            <thead><tr><th class="center" style="width:60px">TT</th><th>Nguyên liệu</th></tr></thead>
            <tbody>
            <% for (int i = 0; i < listIngredient.size(); i++) { %>
            <tr>
                <td class="center"><%=i + 1%></td>
                <td><%=esc(listIngredient.get(i).getIngredient().getTen())%></td>
            </tr>
            <% } %>
            </tbody>
        </table>
        </div>

        <div class="actions">
            <form action="UIDishList1.jsp" method="get">
                <input type="submit" class="secondary" name="subBack" value="← Quay lại" />
            </form>
            <%-- buoc 29 - 30: click Xem combo co mon nay -> goi UIComboList1.jsp --%>
            <form action="UIComboList1.jsp" method="get">
                <input type="submit" name="subViewCombo" value="Xem combo có món này" />
            </form>
        </div>
    </div>
</main>
</body>
</html>
