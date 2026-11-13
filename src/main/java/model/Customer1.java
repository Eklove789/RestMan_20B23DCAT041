package model;

import java.util.Date;

public class Customer1 extends Member1 {
    private Date ngaydangki;

    public Customer1() {
        super();
    }

    public Date getNgaydangki() {
        return ngaydangki;
    }

    public void setNgaydangki(Date ngaydangki) {
        this.ngaydangki = ngaydangki;
    }
}
