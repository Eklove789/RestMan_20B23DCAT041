package model;

import java.util.ArrayList;

public class Area1 {
    private int id;
    private String ten;
    private int succhua;
    private String mota;
    private ArrayList<Table1> tables;

    public Area1() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTen() {
        return ten;
    }

    public void setTen(String ten) {
        this.ten = ten;
    }

    public int getSucchua() {
        return succhua;
    }

    public void setSucchua(int succhua) {
        this.succhua = succhua;
    }

    public String getMota() {
        return mota;
    }

    public void setMota(String mota) {
        this.mota = mota;
    }

    public ArrayList<Table1> getTables() {
        return tables;
    }

    public void setTables(ArrayList<Table1> tables) {
        this.tables = tables;
    }
}
