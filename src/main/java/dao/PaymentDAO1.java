package dao;

import java.sql.PreparedStatement;
import java.sql.Types;
import java.util.ArrayList;

import model.Payment1;

public class PaymentDAO1 extends DAO1 {

    public PaymentDAO1() {
        super();
    }

    /**
     * Luu cac khoan thanh toan cua hoa don (ngoai le 11.2: nhieu hinh thuc).
     * Bieu do tuan tu: buoc 61 - 62 (duoc goi trong giao dich cua BillDAO1.saveBill()).
     * @param idBill: id cua hoa don vua them
     * @param payments: cac khoan thanh toan
     * @return true neu luu du cac khoan
     */
    public boolean savePayments(int idBill, ArrayList<Payment1> payments) {
        boolean kq = false;
        String sql = "INSERT INTO tblPayment1 (hinhthuc, sotien, tienkhachdua, magiaodich, tblBill1id)"
                + " VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            for (Payment1 pm : payments) {
                ps.setString(1, pm.getHinhthuc());
                ps.setFloat(2, pm.getSotien());
                // tien khach dua chi co voi tien mat; ma giao dich chi co voi the, chuyen khoan, vi
                if ("Tiền mặt".equals(pm.getHinhthuc())) {
                    ps.setFloat(3, pm.getTienkhachdua());
                } else {
                    ps.setNull(3, Types.FLOAT);
                }
                if (pm.getMagiaodich() == null || pm.getMagiaodich().length() == 0) {
                    ps.setNull(4, Types.VARCHAR);
                } else {
                    ps.setString(4, pm.getMagiaodich());
                }
                ps.setInt(5, idBill);
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
