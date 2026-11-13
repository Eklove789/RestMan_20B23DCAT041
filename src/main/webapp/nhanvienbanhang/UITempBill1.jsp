<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList,java.util.Date,java.util.Locale,java.text.SimpleDateFormat,dao.*,model.*"%>
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
    // doc so tien nguoi dung nhap (bo dau cham, dau phay, khoang trang); tra -1 neu khong hop le
    private float soTien(String s) {
        if (s == null) return -1;
        s = s.replaceAll("[.,\\s]", "");
        if (s.length() == 0 || !s.matches("\\d{1,9}")) return -1;
        return Float.parseFloat(s);
    }
%>
<%
    request.setCharacterEncoding("UTF-8");
    SaleStaff1 staff = (SaleStaff1) session.getAttribute("staff");
    if (staff == null) {
        response.sendRedirect("../index.jsp");
        return;
    }
    // nut Huy (ngoai le 7.1): chua ghi CSDL, quay ve trang thanh toan
    if (request.getParameter("subCancel") != null) {
        session.removeAttribute("order");
        session.removeAttribute("listOrderDetail");
        session.removeAttribute("deposit");
        session.removeAttribute("card");
        session.removeAttribute("listPayment");
        response.sendRedirect("UIPayment1.jsp");
        return;
    }
    String keyword = (String) session.getAttribute("orderKeyword");
    ArrayList<Order1> listOrder = (ArrayList<Order1>) session.getAttribute("listOrder");
    Order1 order = (Order1) session.getAttribute("order");
    ArrayList<OrderDetail1> listOrderDetail = (ArrayList<OrderDetail1>) session.getAttribute("listOrderDetail");
    Float depositObj = (Float) session.getAttribute("deposit");
    MemberCard1 card = (MemberCard1) session.getAttribute("card");
    ArrayList<Payment1> listPayment = (ArrayList<Payment1>) session.getAttribute("listPayment");
    String outMessage = "";
    String outCardMessage = "";

    String idOrderParam = request.getParameter("idOrder");
    if (idOrderParam != null && listOrder != null) {
        // buoc 18: nhan ban duoc chon tu trang UIServingTableList1.jsp (hoac tinh lai sau khi huy mon chua phuc vu)
        Order1 chosen = null;
        for (Order1 od : listOrder) {
            if (String.valueOf(od.getId()).equals(idOrderParam)) {
                chosen = od;
            }
        }
        if (chosen == null) {
            response.sendRedirect("UIPayment1.jsp");
            return;
        }
        // doi sang ban khac thi bo the da ap dung cua ban truoc
        if (order == null || order.getId() != chosen.getId()) {
            card = null;
        }
        order = chosen;
        // buoc 19 - 24: goi OrderDetailDAO1.getOrderDetailsByOrder()
        listOrderDetail = (new OrderDetailDAO1()).getOrderDetailsByOrder(order.getId());
        order.setDetails(listOrderDetail);
        // buoc 25 - 27: goi BookingDAO1.getDepositByOrder()
        depositObj = (new BookingDAO1()).getDepositByOrder(order.getId());
        listPayment = new ArrayList<Payment1>();
        session.setAttribute("order", order);
        session.setAttribute("listOrderDetail", listOrderDetail);
        session.setAttribute("deposit", depositObj);
        session.setAttribute("card", card);
        session.setAttribute("listPayment", listPayment);
    }
    if (order == null || listOrderDetail == null || depositObj == null || listPayment == null) {
        response.sendRedirect("UIPayment1.jsp");
        return;
    }
    float deposit = depositObj.floatValue();

    String inCardNumber = request.getParameter("inCardNumber");
    if (request.getParameter("subApplyDiscount") != null) {
        // buoc 30 - 31: nhan vien nhap so the (hoac so dien thoai - ngoai le 10.2), click Ap dung uu dai; submit goi chinh trang nay
        String key = (inCardNumber == null) ? "" : inCardNumber.trim();
        if (key.length() == 0) {
            outCardMessage = "Vui lòng nhập số thẻ thành viên hoặc số điện thoại";
        } else {
            // buoc 32 - 37: goi MemberCardDAO1.findValidCard()
            MemberCard1 found = (new MemberCardDAO1()).findValidCard(key);
            if (found == null) {
                // ngoai le 10.1: giu nguyen so tien phai tra
                outCardMessage = "Số thẻ không hợp lệ hoặc thẻ đã bị khoá";
            } else {
                card = found;
                session.setAttribute("card", card);
                // giam gia thay doi nen cac khoan da them khong con dung
                listPayment.clear();
            }
        }
    }

    // buoc 28 / 38: tinh tong tien, giam gia theo hang the, so tien phai tra
    float tongtien = 0;
    for (OrderDetail1 dt : listOrderDetail) {
        tongtien += dt.getThanhtien();
    }
    float giamgia = 0;
    if (card != null) {
        giamgia = Math.round(tongtien * card.getRank().getTilegiamgia() / 100);
    }
    float sotienphaitra = Math.max(0, tongtien - giamgia - deposit);
    float daThem = 0;
    for (Payment1 pm : listPayment) {
        daThem += pm.getSotien();
    }
    float conLai = sotienphaitra - daThem;

    if (request.getParameter("subAddPayment") != null) {
        // ngoai le 11.2: them mot khoan thanh toan vao danh sach (chua ghi CSDL)
        String hinhthuc = request.getParameter("inPaymentMethod");
        float sotien = soTien(request.getParameter("inAmount"));
        float tienkhachdua = soTien(request.getParameter("inCashReceived"));
        boolean tienmat = "Tiền mặt".equals(hinhthuc);
        if (hinhthuc == null || sotien <= 0) {
            outMessage = "Vui lòng chọn hình thức và nhập số tiền của khoản thanh toán";
        } else if (sotien > conLai) {
            outMessage = "Số tiền của khoản thanh toán vượt số tiền còn lại (" + vnd(conLai) + " đ)";
        } else if (tienmat && tienkhachdua < sotien) {
            outMessage = "Tiền khách đưa phải từ " + vnd(sotien) + " đ trở lên";
        } else {
            Payment1 pm = new Payment1();
            pm.setHinhthuc(hinhthuc);
            pm.setSotien(sotien);
            if (tienmat) {
                pm.setTienkhachdua(tienkhachdua);
                pm.setTienthua(tienkhachdua - sotien);
            } else {
                // ma giao dich do cong thanh toan tra ve (o day sinh theo thoi gian)
                pm.setMagiaodich("GD" + new SimpleDateFormat("yyMMddHHmmss").format(new Date()) + (listPayment.size() + 1));
            }
            listPayment.add(pm);
            daThem += sotien;
            conLai = sotienphaitra - daThem;
        }
    }
    // thong bao tu trang doSaveBill1.jsp (ngoai le 11.1: so tien thanh toan chua du)
    if (session.getAttribute("billMessage") != null) {
        outMessage = (String) session.getAttribute("billMessage");
        session.removeAttribute("billMessage");
    }
    if (inCardNumber == null) {
        inCardNumber = (card != null) ? card.getSothe() : "";
    }
    SimpleDateFormat ngaygio = new SimpleDateFormat("dd/MM/yyyy HH:mm");
    String[] dsHinhthuc = {"Tiền mặt", "Thẻ ngân hàng", "Chuyển khoản QR", "Ví điện tử"};
%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="../css/restman1.css">
<title>Hoá đơn tạm - RestMan</title>
</head>
<body>
<%@ include file="header.jspf" %>
<%-- buoc 29 / 39: hien thi hoa don tam --%>
<main class="container">
    <div class="crumbs"><span>Trang chủ</span><span>Thanh toán</span><span>Kết quả “<%=esc(keyword)%>”</span><span>Hoá đơn tạm</span></div>
    <div class="page-title">
        <h1>Hoá đơn tạm — bàn <%=esc(order.getTable().getTen())%></h1>
        <span class="sub">Chưa lưu</span>
    </div>
    <% if (outMessage.length() > 0) { %>
    <div class="alert error" id="outMessage" style="margin:0 0 16px">⚠ <%=esc(outMessage)%></div>
    <% } %>
    <div class="bill-layout">
        <div class="card">
            <div class="facts four">
                <div class="fact"><small>Bàn</small><b id="outTable"><%=esc(order.getTable().getTen())%> — <%=esc(order.getStaff().getArea().getTen())%></b></div>
                <div class="fact"><small>Khách hàng</small><b id="outCustomer"><%=esc(order.getTenkhach())%> (<%=order.getSoluongkhach()%> khách)</b></div>
                <div class="fact"><small>Nhân viên phục vụ</small><b id="outStaff"><%=esc(hoTen(order.getStaff().getFullName()))%></b></div>
                <div class="fact"><small>Ngày giờ</small><b id="outDateTime"><%=ngaygio.format(new Date())%></b></div>
            </div>
            <div class="section-label">Các món đã gọi</div>
            <div class="table-wrap">
            <table class="grid" id="outOrderLines">
                <thead>
                <tr><th class="center">TT</th><th>Tên món / combo</th><th class="right">Đơn giá</th>
                    <th class="center">SL</th><th class="right">Thành tiền</th></tr>
                </thead>
                <tbody>
                <% for (int i = 0; i < listOrderDetail.size(); i++) {
                       OrderDetail1 dt = listOrderDetail.get(i); %>
                <tr>
                    <td class="center"><%=i + 1%></td>
                    <td><b><%=esc(dt.getMenuItem().getTen())%></b>
                        <% if (dt.getMenuItem() instanceof Combo1) { %><span class="badge save">Combo</span><% } %>
                        <% if ("Đã gửi bếp".equals(dt.getTrangthai())) { %><span class="badge warn">Chưa phục vụ</span><% } %></td>
                    <td class="right"><%=vnd(dt.getDongia())%></td>
                    <td class="center"><%=dt.getSoluong()%></td>
                    <td class="right price"><%=vnd(dt.getThanhtien())%></td>
                </tr>
                <% } %>
                </tbody>
            </table>
            </div>
            <table class="sum">
                <tr><td>Tổng tiền</td><td id="outTotal"><%=vnd(tongtien)%> đ</td></tr>
                <tr><td>Giảm giá<%=card != null ? " (hạng " + esc(card.getRank().getTen()) + " " + vnd(card.getRank().getTilegiamgia()) + "%)" : ""%></td>
                    <td id="outDiscount">− <%=vnd(giamgia)%> đ</td></tr>
                <tr><td>Tiền cọc đã trả</td><td id="outDeposit">− <%=vnd(deposit)%> đ</td></tr>
                <tr class="due"><td>Số tiền phải trả</td><td id="outAmountDue"><%=vnd(sotienphaitra)%> đ</td></tr>
            </table>
        </div>

        <div>
            <div class="card">
                <h2>Thẻ thành viên</h2>
                <form action="UITempBill1.jsp" method="post" class="inline-form">
                    <input type="text" class="field" id="inCardNumber" name="inCardNumber" maxlength="20"
                           placeholder="Số thẻ hoặc số điện thoại" value="<%=esc(inCardNumber)%>" />
                    <input type="submit" name="subApplyDiscount" value="Áp dụng ưu đãi" />
                </form>
                <% if (outCardMessage.length() > 0) { %>
                <div class="alert error" id="outCardMessage">⚠ <%=esc(outCardMessage)%></div>
                <% } else if (card != null) { %>
                <div class="alert ok" id="outCardInfo">✓ Thẻ <%=esc(card.getSothe())%> — <%=esc(hoTen(card.getCustomer().getFullName()))%>,
                    hạng <%=esc(card.getRank().getTen())%> (giảm <%=vnd(card.getRank().getTilegiamgia())%>%),
                    điểm tích luỹ <%=String.format(Locale.forLanguageTag("vi-VN"), "%,d", card.getDiemtichluy())%></div>
                <% } %>
            </div>

            <div class="card" style="margin-top:16px">
                <h2>Thanh toán</h2>
                <% if (!listPayment.isEmpty()) { %>
                <table class="grid compact" id="outPaymentList">
                    <thead><tr><th>Hình thức</th><th class="right">Số tiền</th><th class="right">Khách đưa</th></tr></thead>
                    <tbody>
                    <% for (Payment1 pm : listPayment) { %>
                    <tr><td><%=esc(pm.getHinhthuc())%></td><td class="right"><%=vnd(pm.getSotien())%></td>
                        <td class="right"><%="Tiền mặt".equals(pm.getHinhthuc()) ? vnd(pm.getTienkhachdua()) : "—"%></td></tr>
                    <% } %>
                    </tbody>
                </table>
                <div class="hint" style="margin-bottom:12px">Còn lại: <b><%=vnd(conLai)%> đ</b></div>
                <% } %>
                <form action="UITempBill1.jsp" method="post" id="payForm">
                    <div class="form-grid">
                        <label for="inPaymentMethod">Hình thức</label>
                        <select class="field" id="inPaymentMethod" name="inPaymentMethod">
                            <% for (String ht : dsHinhthuc) { %><option value="<%=ht%>"><%=ht%></option><% } %>
                        </select>
                        <label for="inAmount">Số tiền</label>
                        <input type="text" class="field right" id="inAmount" name="inAmount" inputmode="numeric" value="<%=vnd(conLai)%>" />
                        <label for="inCashReceived" class="cash-only">Tiền khách đưa</label>
                        <input type="text" class="field right cash-only" id="inCashReceived" name="inCashReceived" inputmode="numeric" value="" />
                        <label class="cash-only">Tiền thừa</label>
                        <b id="outChange" class="cash-only right">0 đ</b>
                    </div>
                    <div class="actions">
                        <input type="submit" class="secondary" name="subAddPayment" value="+ Thêm hình thức" />
                        <%-- buoc 40 - 41: click Xac nhan -> goi trang doSaveBill1.jsp --%>
                        <input type="submit" name="subConfirm" value="Xác nhận" formaction="doSaveBill1.jsp" />
                        <input type="submit" class="secondary" name="subCancel" value="Huỷ" />
                    </div>
                </form>
            </div>
        </div>
    </div>
</main>
<script>
// hien tien thua = tien khach dua - so tien; an o tien khach dua khi khong tra bang tien mat
(function () {
    var method = document.getElementById('inPaymentMethod');
    var amount = document.getElementById('inAmount');
    var cash = document.getElementById('inCashReceived');
    var change = document.getElementById('outChange');
    function num(s) { var v = parseInt(String(s).replace(/[^0-9]/g, ''), 10); return isNaN(v) ? 0 : v; }
    function update() {
        var isCash = method.value === 'Tiền mặt';
        var nodes = document.querySelectorAll('.cash-only');
        for (var i = 0; i < nodes.length; i++) { nodes[i].style.display = isCash ? '' : 'none'; }
        var c = num(cash.value) - num(amount.value);
        change.textContent = (c > 0 ? c : 0).toLocaleString('vi-VN') + ' đ';
    }
    method.addEventListener('change', update);
    amount.addEventListener('input', update);
    cash.addEventListener('input', update);
    update();
})();
</script>
</body>
</html>
