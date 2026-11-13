package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.DishIngredient1;
import model.Ingredient1;

public class DishIngredientDAO1 extends DAO1 {

    public DishIngredientDAO1() {
        super();
    }

    /**
     * Lay cac nguyen lieu chinh cua mot mon an.
     * Bieu do tuan tu: buoc 23 - 27.
     * @param idDish: id cua mon an
     * @return danh sach DishIngredient1, moi dong kem Ingredient1
     */
    public ArrayList<DishIngredient1> getIngredientsByDish(int idDish) {
        ArrayList<DishIngredient1> kq = new ArrayList<DishIngredient1>();
        String sql = "SELECT a.id, a.dinhluong, b.id AS idingredient, b.ten"
                + " FROM tblDishIngredient1 a, tblIngredient1 b"
                + " WHERE a.tblDish1id = ? AND b.id = a.tblIngredient1id ORDER BY a.id";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, idDish);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                // buoc 24 - 26: goi lop DishIngredient1 dong goi thong tin
                DishIngredient1 di = new DishIngredient1();
                di.setId(rs.getInt("id"));
                di.setDinhluong(rs.getFloat("dinhluong"));
                // nguyen lieu
                Ingredient1 in = new Ingredient1();
                in.setId(rs.getInt("idingredient"));
                in.setTen(rs.getString("ten"));
                di.setIngredient(in);
                kq.add(di);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        // buoc 27: tra ket qua cho UIDishDetail1.jsp
        return kq;
    }
}
