package model;

import java.util.ArrayList;
import java.util.Date;

public class Booking1 {
    private int id;
    private Date ngaydat;
    private Date thoigianden;
    private int soluongkhach;
    private float tiencoc;
    private String ghichu;
    private String trangthai;
    private Date ngayxacnhan;
    private String lidotuchoi;
    private Customer1 customer;
    private Table1 table;
    private SaleStaff1 confirmStaff;
    private ArrayList<BookingDetail1> details;

    public Booking1() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getNgaydat() {
        return ngaydat;
    }

    public void setNgaydat(Date ngaydat) {
        this.ngaydat = ngaydat;
    }

    public Date getThoigianden() {
        return thoigianden;
    }

    public void setThoigianden(Date thoigianden) {
        this.thoigianden = thoigianden;
    }

    public int getSoluongkhach() {
        return soluongkhach;
    }

    public void setSoluongkhach(int soluongkhach) {
        this.soluongkhach = soluongkhach;
    }

    public float getTiencoc() {
        return tiencoc;
    }

    public void setTiencoc(float tiencoc) {
        this.tiencoc = tiencoc;
    }

    public String getGhichu() {
        return ghichu;
    }

    public void setGhichu(String ghichu) {
        this.ghichu = ghichu;
    }

    public String getTrangthai() {
        return trangthai;
    }

    public void setTrangthai(String trangthai) {
        this.trangthai = trangthai;
    }

    public Date getNgayxacnhan() {
        return ngayxacnhan;
    }

    public void setNgayxacnhan(Date ngayxacnhan) {
        this.ngayxacnhan = ngayxacnhan;
    }

    public String getLidotuchoi() {
        return lidotuchoi;
    }

    public void setLidotuchoi(String lidotuchoi) {
        this.lidotuchoi = lidotuchoi;
    }

    public Customer1 getCustomer() {
        return customer;
    }

    public void setCustomer(Customer1 customer) {
        this.customer = customer;
    }

    public Table1 getTable() {
        return table;
    }

    public void setTable(Table1 table) {
        this.table = table;
    }

    public SaleStaff1 getConfirmStaff() {
        return confirmStaff;
    }

    public void setConfirmStaff(SaleStaff1 confirmStaff) {
        this.confirmStaff = confirmStaff;
    }

    public ArrayList<BookingDetail1> getDetails() {
        return details;
    }

    public void setDetails(ArrayList<BookingDetail1> details) {
        this.details = details;
    }
}
