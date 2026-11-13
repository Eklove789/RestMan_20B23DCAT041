package model;

import java.util.Date;

public class MemberCard1 {
    private int id;
    private String sothe;
    private Date ngaycap;
    private int diemtichluy;
    private String trangthai;
    private Customer1 customer;
    private CardRank1 rank;

    public MemberCard1() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSothe() {
        return sothe;
    }

    public void setSothe(String sothe) {
        this.sothe = sothe;
    }

    public Date getNgaycap() {
        return ngaycap;
    }

    public void setNgaycap(Date ngaycap) {
        this.ngaycap = ngaycap;
    }

    public int getDiemtichluy() {
        return diemtichluy;
    }

    public void setDiemtichluy(int diemtichluy) {
        this.diemtichluy = diemtichluy;
    }

    public String getTrangthai() {
        return trangthai;
    }

    public void setTrangthai(String trangthai) {
        this.trangthai = trangthai;
    }

    public Customer1 getCustomer() {
        return customer;
    }

    public void setCustomer(Customer1 customer) {
        this.customer = customer;
    }

    public CardRank1 getRank() {
        return rank;
    }

    public void setRank(CardRank1 rank) {
        this.rank = rank;
    }
}
