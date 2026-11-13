package dao;

import java.sql.PreparedStatement;
import java.util.ArrayList;

import model.BillDetail1;

public class BillDetailDAO1 extends DAO1 {

    public BillDetailDAO1() {
        super();
    }

    /**
     * Luu cac dong chi tiet cua hoa don.
     * Bieu do tuan tu: buoc 58 - 59 (duoc goi trong giao dich cua BillDAO1.saveBill()).
     * @param idBill: id cua hoa don vua them
     * @param details: cac dong chi tiet hoa don
     * @return true neu luu du cac dong
     */
    public boolean saveBillDetails(int idBill, ArrayList<BillDetail1> details) {
        boolean kq = false;
        String sql = "INSERT INTO tblBillDetail1 (soluong, dongia, tblBill1id, tblMenuItem1id) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            for (BillDetail1 dt : details) {
                ps.setInt(1, dt.getSoluong());
                ps.setFloat(2, dt.getDongia());
                ps.setInt(3, idBill);
                ps.setInt(4, dt.getMenuItem().getId());
                ps.executeUpdate();
            }
            kq = true;
        } catch (Exception e) {
            e.printStackTrace();
            kq = false;
        }
        return kq;
    }
}
