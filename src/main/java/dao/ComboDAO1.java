package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.Combo1;

public class ComboDAO1 extends DAO1 {

    public ComboDAO1() {
        super();
    }

    /**
     * Lay cac combo dang ap dung co chua mon an.
     * Bieu do tuan tu: buoc 32 - 36.
     * @param idDish: id cua mon an
     * @return danh sach combo (rong neu mon chua co trong combo nao)
     */
    public ArrayList<Combo1> getCombosByDish(int idDish) {
        ArrayList<Combo1> kq = new ArrayList<Combo1>();
        String sql = "SELECT DISTINCT a.id, a.ten, a.gia, a.mota, a.anh, a.trangthai, b.ngaybatdau, b.ngayketthuc"
                + " FROM tblMenuItem1 a, tblCombo1 b, tblComboDetail1 c"
                + " WHERE b.tblMenuItem1id = a.id AND c.tblCombo1id = b.tblMenuItem1id AND c.tblDish1id = ?"
                + " AND b.ngaybatdau <= CURDATE() AND (b.ngayketthuc IS NULL OR b.ngayketthuc >= CURDATE())"
                + " AND a.trangthai = 'Đang phục vụ' ORDER BY a.id";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, idDish);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                // buoc 33 - 35: goi lop Combo1 dong goi thong tin
                Combo1 cb = new Combo1();
                cb.setId(rs.getInt("id"));
                cb.setTen(rs.getString("ten"));
                cb.setGia(rs.getFloat("gia"));
                cb.setMota(rs.getString("mota"));
                cb.setAnh(rs.getString("anh"));
                cb.setTrangthai(rs.getString("trangthai"));
                cb.setNgaybatdau(rs.getDate("ngaybatdau"));
                cb.setNgayketthuc(rs.getDate("ngayketthuc"));
                kq.add(cb);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        // buoc 36: tra ket qua cho UIComboList1.jsp
        return kq;
    }
}
