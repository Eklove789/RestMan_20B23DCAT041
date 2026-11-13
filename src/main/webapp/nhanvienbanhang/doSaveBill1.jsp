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
    // doc so tien nguoi dung nhap (bo dau cham, dau phay, khoang trang); tra -1 neu khong hop le
    private float soTien(String s) {
        if (s == null) return -1;
        s = s.replaceAll("[.,\\s]", "");
        if (s.length() == 0 || !s.matches("\\d{1,9}")) return -1;
        return Float.parseFloat(s);
    }
%>
<%
    // Trang xu li khi nhan vien click Xac nhan tren trang UITempBill1.jsp
    request.setCharacterEncoding("UTF-8");
    SaleStaff1 staff = (SaleStaff1) session.getAttribute("staff");
    Order1 order = (Order1) session.getAttribute("order");
    ArrayList<OrderDetail1> listOrderDetail = (ArrayList<OrderDetail1>) session.getAttribute("listOrderDetail");
    Float depositObj = (Float) session.getAttribute("deposit");
    MemberCard1 card = (MemberCard1) session.getAttribute("card");
    ArrayList<Payment1> listPayment = (ArrayList<Payment1>) session.getAttribute("listPayment");
    if (staff == null) {
        response.sendRedirect("../index.jsp");
        return;
    }
    if (order == null || listOrderDetail == null || depositObj == null || listPayment == null) {
        response.sendRedirect("UIPayment1.jsp");
        return;
    }
    // hop canh bao (ngoai le 12.1) - nut Quay lai: ve hoa don tam, chua luu gi
    if (request.getParameter("subBack") != null) {
        response.sendRedirect("UITempBill1.jsp");
        return;
    }
    // hop canh bao (ngoai le 12.1) - nut Huy mon: huy cac mon chua phuc vu roi tinh lai hoa don tam
    if (request.getParameter("subCancelDish") != null) {
        (new OrderDetailDAO1()).cancelUnservedDetails(order.getId());
        response.sendRedirect("UITempBill1.jsp?idOrder=" + order.getId());
        return;
    }
    if (request.getParameter("subConfirm") == null) {
        response.sendRedirect("UITempBill1.jsp");
        return;
    }

    float deposit = depositObj.floatValue();
    float tongtien = 0;
    for (OrderDetail1 dt : listOrderDetail) {
        tongtien += dt.getThanhtien();
    }
    float giamgia = 0;
    if (card != null) {
        giamgia = Math.round(tongtien * card.getRank().getTilegiamgia() / 100);
    }
    float sotienphaitra = Math.max(0, tongtien - giamgia - deposit);

    // buoc 42 - 44: goi lop Payment1 dong goi khoan thanh toan nhan vien vua nhap
    ArrayList<Payment1> payments = new ArrayList<Payment1>(listPayment);
    String hinhthuc = request.getParameter("inPaymentMethod");
    float sotien = soTien(request.getParameter("inAmount"));
    float tienkhachdua = soTien(request.getParameter("inCashReceived"));
    if (hinhthuc != null && sotien > 0) {
        Payment1 pm = new Payment1();
        pm.setHinhthuc(hinhthuc);
        pm.setSotien(sotien);
        if ("Tiền mặt".equals(hinhthuc)) {
            pm.setTienkhachdua(Math.max(0, tienkhachdua));
            pm.setTienthua(Math.max(0, tienkhachdua - sotien));
        } else {
            // ma giao dich do cong thanh toan tra ve (o day sinh theo thoi gian)
            pm.setMagiaodich("GD" + new SimpleDateFormat("yyMMddHHmmss").format(new Date()) + (payments.size() + 1));
        }
        payments.add(pm);
    }

    // buoc 45: kiem tra tong cac khoan thanh toan bang so tien phai tra (ngoai le 11.1)
    float tongKhoan = 0;
    float daNhan = 0;
    for (Payment1 pm : payments) {
        tongKhoan += pm.getSotien();
        if ("Tiền mặt".equals(pm.getHinhthuc())) {
            daNhan += Math.min(pm.getSotien(), pm.getTienkhachdua());
        } else {
            daNhan += pm.getSotien();
        }
    }
    if (tongKhoan > sotienphaitra) {
        session.setAttribute("billMessage", "Tổng các khoản thanh toán vượt số tiền phải trả (" + vnd(sotienphaitra) + " đ)");
        response.sendRedirect("UITempBill1.jsp");
        return;
    }
    if (daNhan < sotienphaitra) {
        session.setAttribute("billMessage", "Số tiền thanh toán chưa đủ, còn thiếu " + vnd(sotienphaitra - daNhan) + " đ");
        response.sendRedirect("UITempBill1.jsp");
        return;
    }

    // buoc 46 - 48: goi OrderDetailDAO1.countUnservedDetails()
    int unservedCount = (new OrderDetailDAO1()).countUnservedDetails(order.getId());
    String outMessage = "";
    Bill1 bill = null;
    if (unservedCount > 0) {
        // ngoai le 12.1: hien hop canh bao, chua luu hoa don
        outMessage = "Bàn " + order.getTable().getTen() + " còn " + unservedCount
                + " món đã gửi bếp nhưng chưa phục vụ. Huỷ các món này để thanh toán, hoặc quay lại chờ phục vụ xong.";
    } else {
        // buoc 49 - 51: goi lop BillDetail1 dong goi cac dong chi tiet hoa don
        ArrayList<BillDetail1> details = new ArrayList<BillDetail1>();
        for (OrderDetail1 dt : listOrderDetail) {
            BillDetail1 bd = new BillDetail1();
            bd.setSoluong(dt.getSoluong());
            bd.setDongia(dt.getDongia());
            bd.setThanhtien(dt.getThanhtien());
            bd.setMenuItem(dt.getMenuItem());
            details.add(bd);
        }
        // buoc 52 - 54: goi lop Bill1 dong goi thong tin hoa don
        bill = new Bill1();
        bill.setNgaylap(new Date());
        bill.setTongtien(tongtien);
        bill.setGiamgia(giamgia);
        bill.setTiencoc(deposit);
        bill.setSotienphaitra(sotienphaitra);
        // 1 diem cho moi 10.000 d phai tra (chi khi co the thanh vien)
        bill.setDiemcong(card != null ? (int) (sotienphaitra / 10000) : 0);
        bill.setOrder(order);
        bill.setStaff(staff);
        bill.setCard(card);
        bill.setDetails(details);
        bill.setPayments(payments);
        // buoc 55 - 69: goi BillDAO1.saveBill()
        if ((new BillDAO1()).saveBill(bill)) {
            // buoc 70: goi trang UIBill1.jsp
            session.setAttribute("bill", bill);
            session.removeAttribute("order");
            session.removeAttribute("listOrderDetail");
            session.removeAttribute("deposit");
            session.removeAttribute("card");
            session.removeAttribute("listPayment");
            session.removeAttribute("listOrder");
            response.sendRedirect("UIBill1.jsp");
            return;
        }
        session.setAttribute("billMessage", "Không lưu được hoá đơn, vui lòng thử lại");
        response.sendRedirect("UITempBill1.jsp");
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
<title>Cảnh báo - RestMan</title>
</head>
<body>
<%@ include file="header.jspf" %>
<main class="container">
    <div class="crumbs"><span>Trang chủ</span><span>Thanh toán</span><span>Hoá đơn tạm</span><span>Cảnh báo</span></div>
    <div class="card msgbox">
        <div class="icon">⚠️</div>
        <div class="title">Cảnh báo</div>
        <p id="outMessage"><%=esc(outMessage)%></p>
        <form action="doSaveBill1.jsp" method="post" class="actions" style="justify-content:center">
            <input type="submit" class="secondary" name="subBack" value="← Quay lại" />
            <input type="submit" name="subCancelDish" value="Huỷ món" />
        </form>
    </div>
</main>
</body>
</html>
