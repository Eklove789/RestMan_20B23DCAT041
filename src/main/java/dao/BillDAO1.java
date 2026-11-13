package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.Types;

import model.Bill1;

public class BillDAO1 extends DAO1 {

    public BillDAO1() {
        super();
    }

    /**
     * Luu hoa don trong mot giao dich: hoa don, cac dong chi tiet, cac khoan thanh toan,
     * cong diem the thanh vien (neu co the), dong phieu goi mon va tra ban. Loi o buoc nao thi rollback.
     * Bieu do tuan tu: buoc 56 - 69.
     * @param bill: hoa don da dong goi (id duoc gan sau khi luu = ma hoa don)
     * @return true neu luu thanh cong toan bo
     */
    public boolean saveBill(Bill1 bill) {
        boolean kq = false;
        String sql = "INSERT INTO tblBill1 (ngaylap, giamgia, tblOrder1id, tblSaleStaff1id, tblMemberCard1id)"
                + " VALUES (?, ?, ?, ?, ?)";
        try {
            con.setAutoCommit(false);
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setTimestamp(1, new Timestamp(bill.getNgaylap().getTime()));
            ps.setFloat(2, bill.getGiamgia());
            ps.setInt(3, bill.getOrder().getId());
            ps.setInt(4, bill.getStaff().getId());
            if (bill.getCard() != null) {
                ps.setInt(5, bill.getCard().getId());
            } else {
                ps.setNull(5, Types.INTEGER);
            }
            ps.executeUpdate();
            // lay id tu tang cua hoa don vua them
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                bill.setId(rs.getInt(1));
            }
            // buoc 57 - 59: luu cac dong chi tiet hoa don
            boolean ok = (new BillDetailDAO1()).saveBillDetails(bill.getId(), bill.getDetails());
            // buoc 60 - 62: luu cac khoan thanh toan
            if (ok) {
                ok = (new PaymentDAO1()).savePayments(bill.getId(), bill.getPayments());
            }
            // buoc 63 - 65: cong diem tich luy vao the thanh vien
            if (ok && bill.getCard() != null) {
                ok = (new MemberCardDAO1()).addPoints(bill.getCard().getId(), bill.getDiemcong());
            }
            // buoc 66 - 68: dong phieu goi mon, chuyen ban ve trong
            if (ok) {
                ok = (new OrderDAO1()).closeOrder(bill.getOrder().getId());
            }
            // buoc 69: xac nhan giao dich
            if (ok) {
                con.commit();
            } else {
                con.rollback();
            }
            kq = ok;
        } catch (Exception e) {
            e.printStackTrace();
            try {
                con.rollback();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            kq = false;
        } finally {
            try {
                con.setAutoCommit(true);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        return kq;
    }
}
