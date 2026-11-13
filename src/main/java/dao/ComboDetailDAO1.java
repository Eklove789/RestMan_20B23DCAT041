package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.ComboDetail1;
import model.Dish1;

public class ComboDetailDAO1 extends DAO1 {

    public ComboDetailDAO1() {
        super();
    }

    /**
     * Lay cac mon thanh phan cua mot combo.
     * Bieu do tuan tu: buoc 38 - 42 (lap lai cho tung combo).
     * @param idCombo: id cua combo
     * @return danh sach ComboDetail1, moi dong kem mon an (ten, gia ban) va so luong
     */
    public ArrayList<ComboDetail1> getComboDetails(int idCombo) {
        ArrayList<ComboDetail1> kq = new ArrayList<ComboDetail1>();
        String sql = "SELECT a.id, a.soluong, c.id AS iddish, c.ten, c.gia, c.trangthai"
                + " FROM tblComboDetail1 a, tblDish1 b, tblMenuItem1 c"
                + " WHERE a.tblCombo1id = ? AND b.tblMenuItem1id = a.tblDish1id AND c.id = b.tblMenuItem1id"
                + " ORDER BY a.id";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, idCombo);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                // buoc 39 - 41: goi lop ComboDetail1 dong goi thong tin
                ComboDetail1 cd = new ComboDetail1();
                cd.setId(rs.getInt("id"));
                cd.setSoluong(rs.getInt("soluong"));
                // mon an thanh phan
                Dish1 d = new Dish1();
                d.setId(rs.getInt("iddish"));
                d.setTen(rs.getString("ten"));
                d.setGia(rs.getFloat("gia"));
                d.setTrangthai(rs.getString("trangthai"));
                cd.setDish(d);
                kq.add(cd);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        // buoc 42: tra ket qua cho UIComboList1.jsp
        return kq;
    }
}
