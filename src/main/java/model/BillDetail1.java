package model;

public class BillDetail1 {
    private int id;
    private int soluong;
    private float dongia;
    private float thanhtien;
    private MenuItem1 menuItem;

    public BillDetail1() {
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

    public MenuItem1 getMenuItem() {
        return menuItem;
    }

    public void setMenuItem(MenuItem1 menuItem) {
        this.menuItem = menuItem;
    }
}
