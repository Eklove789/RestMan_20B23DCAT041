package model;

import java.util.ArrayList;
import java.util.Date;

public class Bill1 {
    private int id;
    private Date ngaylap;
    private float tongtien;
    private float giamgia;
    private float tiencoc;
    private float sotienphaitra;
    private int diemcong;
    private Order1 order;
    private SaleStaff1 staff;
    private MemberCard1 card;
    private ArrayList<BillDetail1> details;
    private ArrayList<Payment1> payments;

    public Bill1() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getNgaylap() {
        return ngaylap;
    }

    public void setNgaylap(Date ngaylap) {
        this.ngaylap = ngaylap;
    }

    public float getTongtien() {
        return tongtien;
    }

    public void setTongtien(float tongtien) {
        this.tongtien = tongtien;
    }

    public float getGiamgia() {
        return giamgia;
    }

    public void setGiamgia(float giamgia) {
        this.giamgia = giamgia;
    }

    public float getTiencoc() {
        return tiencoc;
    }

    public void setTiencoc(float tiencoc) {
        this.tiencoc = tiencoc;
    }

    public float getSotienphaitra() {
        return sotienphaitra;
    }

    public void setSotienphaitra(float sotienphaitra) {
        this.sotienphaitra = sotienphaitra;
    }

    public int getDiemcong() {
        return diemcong;
    }

    public void setDiemcong(int diemcong) {
        this.diemcong = diemcong;
    }

    public Order1 getOrder() {
        return order;
    }

    public void setOrder(Order1 order) {
        this.order = order;
    }

    public SaleStaff1 getStaff() {
        return staff;
    }

    public void setStaff(SaleStaff1 staff) {
        this.staff = staff;
    }

    public MemberCard1 getCard() {
        return card;
    }

    public void setCard(MemberCard1 card) {
        this.card = card;
    }

    public ArrayList<BillDetail1> getDetails() {
        return details;
    }

    public void setDetails(ArrayList<BillDetail1> details) {
        this.details = details;
    }

    public ArrayList<Payment1> getPayments() {
        return payments;
    }

    public void setPayments(ArrayList<Payment1> payments) {
        this.payments = payments;
    }
}
