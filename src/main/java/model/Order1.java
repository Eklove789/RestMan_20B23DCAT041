package model;

import java.util.ArrayList;
import java.util.Date;

public class Order1 {
    private int id;
    private String tenkhach;
    private int soluongkhach;
    private Date thoigianmo;
    private Date thoigiandong;
    private String trangthai;
    private Table1 table;
    private SaleStaff1 staff;
    private Booking1 booking;
    private ArrayList<OrderDetail1> details;

    public Order1() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTenkhach() {
        return tenkhach;
    }

    public void setTenkhach(String tenkhach) {
        this.tenkhach = tenkhach;
    }

    public int getSoluongkhach() {
        return soluongkhach;
    }

    public void setSoluongkhach(int soluongkhach) {
        this.soluongkhach = soluongkhach;
    }

    public Date getThoigianmo() {
        return thoigianmo;
    }

    public void setThoigianmo(Date thoigianmo) {
        this.thoigianmo = thoigianmo;
    }

    public Date getThoigiandong() {
        return thoigiandong;
    }

    public void setThoigiandong(Date thoigiandong) {
        this.thoigiandong = thoigiandong;
    }

    public String getTrangthai() {
        return trangthai;
    }

    public void setTrangthai(String trangthai) {
        this.trangthai = trangthai;
    }

    public Table1 getTable() {
        return table;
    }

    public void setTable(Table1 table) {
        this.table = table;
    }

    public SaleStaff1 getStaff() {
        return staff;
    }

    public void setStaff(SaleStaff1 staff) {
        this.staff = staff;
    }

    public Booking1 getBooking() {
        return booking;
    }

    public void setBooking(Booking1 booking) {
        this.booking = booking;
    }

    public ArrayList<OrderDetail1> getDetails() {
        return details;
    }

    public void setDetails(ArrayList<OrderDetail1> details) {
        this.details = details;
    }
}
