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
    // nut Quay lai: ve trang chu khach hang
    if (request.getParameter("subBack") != null) {
        response.sendRedirect("UICustomerHome1.jsp");
        return;
    }
    String outMessage = "";
    String inDishName = request.getParameter("inDishName");
    if (request.getParameter("subSearch") != null) {
        // buoc 4 - 5: khach hang nhap ten mon, click Tim; submit goi chinh trang nay, kiem tra tu khoa
        String keyword = (inDishName == null) ? "" : inDishName.trim();
        if (keyword.length() == 0) {
            outMessage = "Vui lòng nhập tên món ăn cần tìm";
        } else {
            // buoc 6 - 11: goi DishDAO1.searchDishByName()
            ArrayList<Dish1> listDish = (new DishDAO1()).searchDishByName(keyword);
            if (listDish.isEmpty()) {
                outMessage = "Không tìm thấy món ăn phù hợp";
            } else {
                // buoc 12: goi trang UIDishList1.jsp
                session.setAttribute("keyword", keyword);
                session.setAttribute("listDish", listDish);
                response.sendRedirect("UIDishList1.jsp");
                return;
            }
        }
    } else if (inDishName == null) {
        // quay lai tu trang danh sach: hien lai tu khoa da tim
        inDishName = (String) session.getAttribute("keyword");
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
<title>Tìm thông tin món ăn - RestMan</title>
</head>
<body>
<%@ include file="header.jspf" %>
<%-- buoc 3: hien thi giao dien tim kiem --%>
<main class="container">
    <div class="card search-card">
        <div class="crumbs"><span>Trang chủ</span><span>Tìm thông tin món ăn</span></div>
        <h2 style="font-size:22px">Tìm thông tin món ăn</h2>
        <form name="searchDish" action="UISearchDish1.jsp" method="post">
            <label for="inDishName" class="hint" style="display:block;margin:0 0 8px">Tên món ăn</label>
            <div class="search-box">
                <input type="text" name="inDishName" id="inDishName" placeholder="Ví dụ: bò, lẩu, gỏi..."
                       value="<%=esc(inDishName)%>" autofocus />
                <input type="submit" name="subSearch" value="Tìm" />
            </div>
            <% if (outMessage.length() > 0) { %>
            <div class="alert error" id="outMessage">⚠ <%=outMessage%></div>
            <% } %>
            <p class="hint">Có thể gõ không dấu, không phân biệt chữ hoa – chữ thường.</p>
            <div class="actions">
                <input type="submit" class="secondary" name="subBack" value="← Quay lại" />
            </div>
        </form>
    </div>
</main>
</body>
</html>
