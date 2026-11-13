<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.Locale,java.text.SimpleDateFormat,model.*"%>
<%!
    private String esc(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
    }
    private String vnd(float v) {
        return String.format(Locale.forLanguageTag("vi-VN"), "%,.0f", v);
    }
    private String hoTen(FullName1 fn) {
        if (fn == null) return "";
        return fn.getHo() + " " + (fn.getTendem() == null ? "" : fn.getTendem() + " ") + fn.getTen();
    }
%>
<%
    request.setCharacterEncoding("UTF-8");
    if (session.getAttribute("staff") == null) {
        response.sendRedirect("../index.jsp");
        return;
    }
    // nhan hoa don vua luu tu trang doSaveBill1.jsp (luu trong session)
    Bill1 bill = (Bill1) session.getAttribute("bill");
    if (bill == null) {
        response.sendRedirect("UIPayment1.jsp");
        return;
    }
    // buoc 75 - 76: nhan vien click OK -> goi trang UIPayment1.jsp de phuc vu ban tiep theo
    if (request.getParameter("subOK") != null) {
        session.removeAttribute("bill");
        session.removeAttribute("orderKeyword");
        response.sendRedirect("UIPayment1.jsp");
        return;
    }
    String maHD = String.format("HD%04d", bill.getId());
    String outMessage = "";
    if (request.getParameter("subPrint") != null) {
        // buoc 72 - 74: submit goi chinh trang nay gui hoa don ra may in tai quay (lenh in o cuoi trang)
        outMessage = "Đã gửi hoá đơn " + maHD + " ra máy in";
    }
    Order1 order = bill.getOrder();
    MemberCard1 card = bill.getCard();
    SimpleDateFormat ngaygio = new SimpleDateFormat("dd/MM/yyyy HH:mm");
    float tongKhachDua = 0, tongTienThua = 0;
    for (Payment1 pm : bill.getPayments()) {
        if ("Tiền mặt".equals(pm.getHinhthuc())) {
            tongKhachDua += pm.getTienkhachdua();
            tongTienThua += pm.getTienthua();
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
<title>Hoá đơn <%=maHD%> - RestMan</title>
</head>
<body>
<%@ include file="header.jspf" %>
<main class="container">
    <div class="crumbs no-print"><span>Trang chủ</span><span>Thanh toán</span><span>Hoá đơn <%=maHD%></span></div>
    <% if (outMessage.length() > 0) { %>
    <%-- buoc 74: thong bao in hoa don thanh cong; may in loi thi click In lai (ngoai le 15.1) --%>
    <div class="card msgbox no-print" style="margin:0 auto 20px">
        <div class="icon">🖨️</div>
        <div class="title">Thông báo</div>
        <p id="outMessage"><%=esc(outMessage)%>. Nếu máy in lỗi, kiểm tra giấy và kết nối rồi click In lại; hoá đơn đã được lưu.</p>
        <form action="UIBill1.jsp" method="post" class="actions" style="justify-content:center">
            <input type="submit" class="secondary" name="subPrint" value="In lại" />
            <input type="submit" name="subOK" value="OK" />
        </form>
    </div>
    <% } %>
    <%-- buoc 71: hien thi hoa don chinh thuc --%>
    <div class="card receipt" id="outBill">
        <div class="receipt-head">
            <div class="shop">Nhà hàng RestMan</div>
            <div class="hint">96A Trần Phú, Hà Đông, Hà Nội — ĐT 024 3355 6677</div>
            <h1>HOÁ ĐƠN THANH TOÁN</h1>
            <div class="code">Mã hoá đơn: <b><%=maHD%></b></div>
        </div>
        <div class="facts four">
            <div class="fact"><small>Bàn</small><b><%=esc(order.getTable().getTen())%> — <%=esc(order.getStaff().getArea().getTen())%></b></div>
            <div class="fact"><small>Khách hàng</small><b><%=esc(order.getTenkhach())%> (<%=order.getSoluongkhach()%> khách)</b></div>
            <div class="fact"><small>Nhân viên lập</small><b><%=esc(hoTen(bill.getStaff().getFullName()))%></b></div>
            <div class="fact"><small>Ngày lập</small><b><%=ngaygio.format(bill.getNgaylap())%></b></div>
        </div>
        <div class="table-wrap" style="margin-top:16px">
        <table class="grid">
            <thead>
            <tr><th class="center">TT</th><th>Tên món / combo</th><th class="right">Đơn giá</th>
                <th class="center">SL</th><th class="right">Thành tiền</th></tr>
            </thead>
            <tbody>
            <% for (int i = 0; i < bill.getDetails().size(); i++) {
                   BillDetail1 bd = bill.getDetails().get(i); %>
            <tr>
                <td class="center"><%=i + 1%></td>
                <td><b><%=esc(bd.getMenuItem().getTen())%></b></td>
                <td class="right"><%=vnd(bd.getDongia())%></td>
                <td class="center"><%=bd.getSoluong()%></td>
                <td class="right price"><%=vnd(bd.getThanhtien())%></td>
            </tr>
            <% } %>
            </tbody>
        </table>
        </div>
        <table class="sum">
            <tr><td>Tổng tiền</td><td><%=vnd(bill.getTongtien())%> đ</td></tr>
            <tr><td>Giảm giá<%=card != null ? " (thẻ " + esc(card.getSothe()) + ", hạng " + esc(card.getRank().getTen()) + ")" : ""%></td>
                <td>− <%=vnd(bill.getGiamgia())%> đ</td></tr>
            <tr><td>Tiền cọc đã trả</td><td>− <%=vnd(bill.getTiencoc())%> đ</td></tr>
            <tr class="due"><td>Số tiền phải trả</td><td><%=vnd(bill.getSotienphaitra())%> đ</td></tr>
            <% for (Payment1 pm : bill.getPayments()) { %>
            <tr><td><%=esc(pm.getHinhthuc())%><%=pm.getMagiaodich() != null ? " (mã GD " + esc(pm.getMagiaodich()) + ")" : ""%></td>
                <td><%=vnd(pm.getSotien())%> đ</td></tr>
            <% } %>
            <% if (tongKhachDua > 0) { %>
            <tr><td>Tiền khách đưa</td><td><%=vnd(tongKhachDua)%> đ</td></tr>
            <tr><td>Tiền thừa</td><td><%=vnd(tongTienThua)%> đ</td></tr>
            <% } %>
            <% if (card != null) { %>
            <tr><td>Điểm được cộng</td><td>+ <%=bill.getDiemcong()%> điểm (điểm mới <%=String.format(Locale.forLanguageTag("vi-VN"), "%,d", card.getDiemtichluy() + bill.getDiemcong())%>)</td></tr>
            <% } %>
        </table>
        <p class="note center">Cảm ơn quý khách và hẹn gặp lại!</p>
    </div>
    <form class="actions no-print" action="UIBill1.jsp" method="post" style="justify-content:center">
        <input type="submit" name="subPrint" value="🖨 In hoá đơn" />
        <input type="submit" class="secondary" name="subOK" value="OK" />
    </form>
</main>
<% if (outMessage.length() > 0) { %>
<script>
// gui hoa don ra may in (hop thoai in cua trinh duyet tai quay)
window.addEventListener('load', function () { window.print(); });
</script>
<% } %>
</body>
</html>
