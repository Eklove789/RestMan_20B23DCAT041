package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

import model.CardRank1;
import model.Customer1;
import model.FullName1;
import model.MemberCard1;

public class MemberCardDAO1 extends DAO1 {

    public MemberCardDAO1() {
        super();
    }

    /**
     * Tim the thanh vien dang hoat dong theo so the hoac so dien thoai cua chu the.
     * Bieu do tuan tu: buoc 33 - 37.
     * @param key: so the hoac so dien thoai (ngoai le 10.2)
     * @return the kem hang the va chu the; null neu khong co hoac the bi khoa (ngoai le 10.1)
     */
    public MemberCard1 findValidCard(String key) {
        MemberCard1 kq = null;
        String sql = "SELECT a.id, a.sothe, a.ngaycap, a.diemtichluy, a.trangthai,"
                + " b.id AS idrank, b.ten AS tenrank, b.diemtoithieu, b.tilegiamgia,"
                + " d.id AS idmember, d.ho, d.tendem, d.ten, d.dt, c.ngaydangki"
                + " FROM tblMemberCard1 a, tblCardRank1 b, tblCustomer1 c, tblMember1 d"
                + " WHERE a.tblCardRank1id = b.id AND a.tblCustomer1id = c.tblMember1id AND c.tblMember1id = d.id"
                + " AND (a.sothe = ? OR d.dt = ?) AND a.trangthai = 'Hoạt động'";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, key);
            ps.setString(2, key);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                // buoc 34 - 36: goi lop MemberCard1 dong goi thong tin
                kq = new MemberCard1();
                kq.setId(rs.getInt("id"));
                kq.setSothe(rs.getString("sothe"));
                kq.setNgaycap(rs.getDate("ngaycap"));
                kq.setDiemtichluy(rs.getInt("diemtichluy"));
                kq.setTrangthai(rs.getString("trangthai"));
                CardRank1 rk = new CardRank1();
                rk.setId(rs.getInt("idrank"));
                rk.setTen(rs.getString("tenrank"));
                rk.setDiemtoithieu(rs.getInt("diemtoithieu"));
                rk.setTilegiamgia(rs.getFloat("tilegiamgia"));
                kq.setRank(rk);
                FullName1 fn = new FullName1();
                fn.setHo(rs.getString("ho"));
                fn.setTendem(rs.getString("tendem"));
                fn.setTen(rs.getString("ten"));
                Customer1 cs = new Customer1();
                cs.setId(rs.getInt("idmember"));
                cs.setDt(rs.getString("dt"));
                cs.setNgaydangki(rs.getDate("ngaydangki"));
                cs.setFullName(fn);
                kq.setCustomer(cs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        // buoc 37: tra ket qua cho UITempBill1.jsp
        return kq;
    }

    /**
     * Cong diem tich luy vao the thanh vien.
     * Bieu do tuan tu: buoc 64 - 65 (duoc goi trong giao dich cua BillDAO1.saveBill()).
     * @param idCard: id cua the
     * @param points: so diem duoc cong
     * @return true neu cap nhat duoc the
     */
    public boolean addPoints(int idCard, int points) {
        boolean kq = false;
        String sql = "UPDATE tblMemberCard1 SET diemtichluy = diemtichluy + ? WHERE id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, points);
            ps.setInt(2, idCard);
            kq = (ps.executeUpdate() == 1);
        } catch (Exception e) {
            e.printStackTrace();
            kq = false;
        }
        return kq;
    }
}
