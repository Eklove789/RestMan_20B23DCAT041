package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.Area1;
import model.FullName1;
import model.Order1;
import model.SaleStaff1;
import model.Table1;

public class OrderDAO1 extends DAO1 {

    public OrderDAO1() {
        super();
    }

    /**
     * Tim cac phieu goi mon dang mo co ten khach chua tu khoa.
     * Bieu do tuan tu: buoc 7 - 11.
     * @param name: ten khach (tu khoa) nhan vien nhap
     * @return danh sach phieu goi mon kem ban, nhan vien phuc vu (rong neu khong co - ngoai le 5.1)
     */
    public ArrayList<Order1> searchServingOrders(String name) {
        ArrayList<Order1> kq = new ArrayList<Order1>();
        String sql = "SELECT a.id, a.tenkhach, a.soluongkhach, a.thoigianmo, a.trangthai,"
                + " b.id AS idtable, b.ten AS tentable, b.sochongoi, b.trangthai AS tttable,"
                + " c.tblStaff1id AS idstaff, d.ho, d.tendem, d.ten AS tennv, e.id AS idarea, e.ten AS tenarea"
                + " FROM tblOrder1 a, tblTable1 b, tblSaleStaff1 c, tblMember1 d, tblArea1 e"
                + " WHERE a.tblTable1id = b.id AND a.tblSaleStaff1id = c.tblStaff1id AND d.id = c.tblStaff1id"
                + " AND e.id = c.tblArea1id AND a.trangthai = 'Đang mở' AND a.tenkhach LIKE ?"
                + " ORDER BY a.thoigianmo";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                // buoc 8 - 10: goi lop Order1 dong goi thong tin
                Order1 od = new Order1();
                od.setId(rs.getInt("id"));
                od.setTenkhach(rs.getString("tenkhach"));
                od.setSoluongkhach(rs.getInt("soluongkhach"));
                od.setThoigianmo(rs.getTimestamp("thoigianmo"));
                od.setTrangthai(rs.getString("trangthai"));
                Table1 tb = new Table1();
                tb.setId(rs.getInt("idtable"));
                tb.setTen(rs.getString("tentable"));
                tb.setSochongoi(rs.getInt("sochongoi"));
                tb.setTrangthai(rs.getString("tttable"));
                od.setTable(tb);
                Area1 ar = new Area1();
                ar.setId(rs.getInt("idarea"));
                ar.setTen(rs.getString("tenarea"));
                FullName1 fn = new FullName1();
                fn.setHo(rs.getString("ho"));
                fn.setTendem(rs.getString("tendem"));
                fn.setTen(rs.getString("tennv"));
                SaleStaff1 st = new SaleStaff1();
                st.setId(rs.getInt("idstaff"));
                st.setFullName(fn);
                st.setArea(ar);
                od.setStaff(st);
                kq.add(od);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        // buoc 11: tra ket qua cho UIPayment1.jsp
        return kq;
    }

    /**
     * Dong phieu goi mon va chuyen ban ve trang thai trong.
     * Bieu do tuan tu: buoc 67 - 68 (duoc goi trong giao dich cua BillDAO1.saveBill()).
     * @param idOrder: id cua phieu goi mon
     * @return true neu dong duoc phieu dang mo
     */
    public boolean closeOrder(int idOrder) {
        boolean kq = false;
        String sqlOrder = "UPDATE tblOrder1 SET trangthai = 'Đã đóng', thoigiandong = NOW()"
                + " WHERE id = ? AND trangthai = 'Đang mở'";
        String sqlTable = "UPDATE tblTable1 SET trangthai = 'Trống'"
                + " WHERE id = (SELECT tblTable1id FROM tblOrder1 WHERE id = ?)";
        try {
            PreparedStatement ps = con.prepareStatement(sqlOrder);
            ps.setInt(1, idOrder);
            if (ps.executeUpdate() == 1) {
                ps = con.prepareStatement(sqlTable);
                ps.setInt(1, idOrder);
                ps.executeUpdate();
                kq = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            kq = false;
        }
        return kq;
    }
}
