package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BookingDAO1 extends DAO1 {

    public BookingDAO1() {
        super();
    }

    /**
     * Lay tien coc cua phieu dat ban gan voi phieu goi mon (ngoai le 10.3).
     * Bieu do tuan tu: buoc 26 - 27.
     * @param idOrder: id cua phieu goi mon
     * @return tien coc; 0 neu khach vao truc tiep (phieu goi mon khong gan phieu dat ban)
     */
    public float getDepositByOrder(int idOrder) {
        float kq = 0;
        String sql = "SELECT b.tiencoc FROM tblOrder1 a, tblBooking1 b"
                + " WHERE a.tblBooking1id = b.id AND a.id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, idOrder);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                kq = rs.getFloat("tiencoc");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return kq;
    }
}
