package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.Dish1;
import model.DishCategory1;
import model.Unit1;

public class DishDAO1 extends DAO1 {
    private static final String SELECT_DISH = "SELECT a.id, a.ten, a.gia, a.mota, a.anh, a.trangthai,"
            + " b.thoigianchebien, c.id AS idcategory, c.ten AS tencategory, c.mota AS motacategory,"
            + " d.id AS idunit, d.ten AS tenunit"
            + " FROM tblMenuItem1 a, tblDish1 b, tblDishCategory1 c, tblUnit1 d"
            + " WHERE b.tblMenuItem1id = a.id AND c.id = b.tblDishCategory1id AND d.id = b.tblUnit1id";

    public DishDAO1() {
        super();
    }

    /**
     * Tim cac mon an chua ngung ban co ten chua tu khoa
     * (cot ten dung collation khong phan biet hoa thuong va dau).
     * Bieu do tuan tu: buoc 7 - 11.
     * @param name: tu khoa ten mon an
     * @return danh sach mon an tim thay (rong neu khong co)
     */
    public ArrayList<Dish1> searchDishByName(String name) {
        ArrayList<Dish1> kq = new ArrayList<Dish1>();
        String sql = SELECT_DISH + " AND a.ten LIKE ? AND a.trangthai <> 'Ngừng bán' ORDER BY a.id";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                // buoc 8 - 10: goi lop Dish1 dong goi thong tin
                Dish1 d = new Dish1();
                d.setId(rs.getInt("id"));
                d.setTen(rs.getString("ten"));
                d.setGia(rs.getFloat("gia"));
                d.setMota(rs.getString("mota"));
                d.setAnh(rs.getString("anh"));
                d.setTrangthai(rs.getString("trangthai"));
                d.setThoigianchebien(rs.getInt("thoigianchebien"));
                // loai mon
                DishCategory1 c = new DishCategory1();
                c.setId(rs.getInt("idcategory"));
                c.setTen(rs.getString("tencategory"));
                c.setMota(rs.getString("motacategory"));
                d.setCategory(c);
                // don vi tinh
                Unit1 u = new Unit1();
                u.setId(rs.getInt("idunit"));
                u.setTen(rs.getString("tenunit"));
                d.setUnit(u);
                kq.add(d);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        // buoc 11: tra ket qua cho UISearchDish1.jsp
        return kq;
    }

    /**
     * Lay thong tin chi tiet cua mot mon an.
     * Bieu do tuan tu: buoc 17 - 21.
     * @param idDish: id cua mon an
     * @return mon an, null neu khong tim thay
     */
    public Dish1 getDishDetail(int idDish) {
        Dish1 kq = null;
        String sql = SELECT_DISH + " AND a.id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, idDish);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                // buoc 18 - 20: goi lop Dish1 dong goi thong tin
                kq = new Dish1();
                kq.setId(rs.getInt("id"));
                kq.setTen(rs.getString("ten"));
                kq.setGia(rs.getFloat("gia"));
                kq.setMota(rs.getString("mota"));
                kq.setAnh(rs.getString("anh"));
                kq.setTrangthai(rs.getString("trangthai"));
                kq.setThoigianchebien(rs.getInt("thoigianchebien"));
                // loai mon
                DishCategory1 c = new DishCategory1();
                c.setId(rs.getInt("idcategory"));
                c.setTen(rs.getString("tencategory"));
                c.setMota(rs.getString("motacategory"));
                kq.setCategory(c);
                // don vi tinh
                Unit1 u = new Unit1();
                u.setId(rs.getInt("idunit"));
                u.setTen(rs.getString("tenunit"));
                kq.setUnit(u);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        // buoc 21: tra ket qua cho UIDishDetail1.jsp
        return kq;
    }
}
