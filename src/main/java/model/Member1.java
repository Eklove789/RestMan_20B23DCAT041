package model;

import java.util.Date;

public abstract class Member1 {
    private int id;
    private Date ngaysinh;
    private String gioitinh;
    private String email;
    private String dt;
    private String ghichu;
    private FullName1 fullName;
    private Account1 account;
    private Address1 address;

    public Member1() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getNgaysinh() {
        return ngaysinh;
    }

    public void setNgaysinh(Date ngaysinh) {
        this.ngaysinh = ngaysinh;
    }

    public String getGioitinh() {
        return gioitinh;
    }

    public void setGioitinh(String gioitinh) {
        this.gioitinh = gioitinh;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getDt() {
        return dt;
    }

    public void setDt(String dt) {
        this.dt = dt;
    }

    public String getGhichu() {
        return ghichu;
    }

    public void setGhichu(String ghichu) {
        this.ghichu = ghichu;
    }

    public FullName1 getFullName() {
        return fullName;
    }

    public void setFullName(FullName1 fullName) {
        this.fullName = fullName;
    }

    public Account1 getAccount() {
        return account;
    }

    public void setAccount(Account1 account) {
        this.account = account;
    }

    public Address1 getAddress() {
        return address;
    }

    public void setAddress(Address1 address) {
        this.address = address;
    }
}
