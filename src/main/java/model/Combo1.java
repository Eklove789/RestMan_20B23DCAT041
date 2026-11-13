package model;

import java.util.ArrayList;
import java.util.Date;

public class Combo1 extends MenuItem1 {
    private Date ngaybatdau;
    private Date ngayketthuc;
    private ArrayList<ComboDetail1> details;

    public Combo1() {
        super();
    }

    public Date getNgaybatdau() {
        return ngaybatdau;
    }

    public void setNgaybatdau(Date ngaybatdau) {
        this.ngaybatdau = ngaybatdau;
    }

    public Date getNgayketthuc() {
        return ngayketthuc;
    }

    public void setNgayketthuc(Date ngayketthuc) {
        this.ngayketthuc = ngayketthuc;
    }

    public ArrayList<ComboDetail1> getDetails() {
        return details;
    }

    public void setDetails(ArrayList<ComboDetail1> details) {
        this.details = details;
    }
}
