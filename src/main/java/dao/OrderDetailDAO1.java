package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.Combo1;
import model.Dish1;
import model.MenuItem1;
import model.OrderDetail1;

public class OrderDetailDAO1 extends DAO1 {

    public OrderDetailDAO1() {
        super();
    }

    /**
     * Tinh tien tam tinh cua mot phieu goi mon (khong tinh cac dong da huy).
     * Bieu do tuan tu: buoc 14 - 15 (lap cho tung ban).
     * @param idOrder: id cua phieu goi mon
     * @return tong so luong x don gia
     */
    public float calculateTempTotal(int idOrder) {
        float kq = 0;
        String sql = "SELECT SUM(soluong * dongia) AS tamtinh FROM tblOrderDetail1"
                + " WHERE tblOrder1id = ? AND trangthai <> 'Đã huỷ'";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, idOrder);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                kq = rs.getFloat("tamtinh");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return kq;
    }

    /**
     * Lay cac mon da goi cua mot phieu goi mon (khong lay cac dong da huy).
     * Bieu do tuan tu: buoc 20 - 24.
     * @param idOrder: id cua phieu goi mon
     * @return danh sach chi tiet phieu goi mon kem mon an / combo
     */
    public ArrayList<OrderDetail1> getOrderDetailsByOrder(int idOrder) {
        ArrayList<OrderDetail1> kq = new ArrayList<OrderDetail1>();
        String sql = "SELECT a.id, a.soluong, a.dongia, a.thoigiangoi, a.trangthai,"
                + " b.id AS idmenu, b.ten, b.gia, b.mota, b.anh, b.trangthai AS ttmenu, c.tblMenuItem1id AS iddish"
                + " FROM tblOrderDetail1 a INNER JOIN tblMenuItem1 b ON a.tblMenuItem1id = b.id"
                + " LEFT JOIN tblDish1 c ON c.tblMenuItem1id = b.id"
                + " WHERE a.tblOrder1id = ? AND a.trangthai <> 'Đã huỷ' ORDER BY a.id";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, idOrder);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                // buoc 21 - 23: goi lop OrderDetail1 dong goi thong tin
                OrderDetail1 dt = new OrderDetail1();
                dt.setId(rs.getInt("id"));
                dt.setSoluong(rs.getInt("soluong"));
                dt.setDongia(rs.getFloat("dongia"));
                dt.setThanhtien(dt.getSoluong() * dt.getDongia());
                dt.setThoigiangoi(rs.getTimestamp("thoigiangoi"));
                dt.setTrangthai(rs.getString("trangthai"));
                // MenuItem1 la lop truu tuong: dong la mon an neu co trong tblDish1, nguoc lai la combo
                MenuItem1 mi = (rs.getObject("iddish") != null) ? new Dish1() : new Combo1();
                mi.setId(rs.getInt("idmenu"));
                mi.setTen(rs.getString("ten"));
                mi.setGia(rs.getFloat("gia"));
                mi.setMota(rs.getString("mota"));
                mi.setAnh(rs.getString("anh"));
                mi.setTrangthai(rs.getString("ttmenu"));
                dt.setMenuItem(mi);
                kq.add(dt);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        // buoc 24: tra ket qua cho UITempBill1.jsp
        return kq;
    }

    /**
     * Dem so mon da gui bep nhung chua phuc vu cua phieu goi mon (ngoai le 12.1).
     * Bieu do tuan tu: buoc 47 - 48.
     * @param idOrder: id cua phieu goi mon
     * @return so dong chi tiet o trang thai da gui bep
     */
    public int countUnservedDetails(int idOrder) {
        int kq = 0;
        String sql = "SELECT COUNT(*) AS somon FROM tblOrderDetail1"
                + " WHERE tblOrder1id = ? AND trangthai = 'Đã gửi bếp'";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, idOrder);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                kq = rs.getInt("somon");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return kq;
    }

    /**
     * Huy cac mon chua phuc vu cua phieu goi mon (ngoai le 12.1, nhan vien click Huy mon).
     * @param idOrder: id cua phieu goi mon
     * @return true neu cap nhat thanh cong
     */
    public boolean cancelUnservedDetails(int idOrder) {
        boolean kq = false;
        String sql = "UPDATE tblOrderDetail1 SET trangthai = 'Đã huỷ'"
                + " WHERE tblOrder1id = ? AND trangthai = 'Đã gửi bếp'";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, idOrder);
            ps.executeUpdate();
            kq = true;
        } catch (Exception e) {
            e.printStackTrace();
            kq = false;
        }
        return kq;
    }
}
