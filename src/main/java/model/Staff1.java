package model;

import java.util.Date;

public abstract class Staff1 extends Member1 {
    private String vitri;
    private Date ngayvaolam;

    public Staff1() {
        super();
    }

    public String getVitri() {
        return vitri;
    }

    public void setVitri(String vitri) {
        this.vitri = vitri;
    }

    public Date getNgayvaolam() {
        return ngayvaolam;
    }

    public void setNgayvaolam(Date ngayvaolam) {
        this.ngayvaolam = ngayvaolam;
    }
}
