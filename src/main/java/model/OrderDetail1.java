package model;

import java.util.Date;

public class OrderDetail1 {
    private int id;
    private int soluong;
    private float dongia;
    private float thanhtien;
    private Date thoigiangoi;
    private String trangthai;
    private MenuItem1 menuItem;

    public OrderDetail1() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getSoluong() {
        return soluong;
    }

    public void setSoluong(int soluong) {
        this.soluong = soluong;
    }

    public float getDongia() {
        return dongia;
    }

    public void setDongia(float dongia) {
        this.dongia = dongia;
    }

    public float getThanhtien() {
        return thanhtien;
    }

    public void setThanhtien(float thanhtien) {
        this.thanhtien = thanhtien;
    }

    public Date getThoigiangoi() {
        return thoigiangoi;
    }

    public void setThoigiangoi(Date thoigiangoi) {
        this.thoigiangoi = thoigiangoi;
    }

    public String getTrangthai() {
        return trangthai;
    }

    public void setTrangthai(String trangthai) {
        this.trangthai = trangthai;
    }

    public MenuItem1 getMenuItem() {
        return menuItem;
    }

    public void setMenuItem(MenuItem1 menuItem) {
        this.menuItem = menuItem;
    }
}
