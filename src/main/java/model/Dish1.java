package model;

import java.util.ArrayList;

public class Dish1 extends MenuItem1 {
    private int thoigianchebien;
    private DishCategory1 category;
    private Unit1 unit;
    private ArrayList<DishIngredient1> ingredients;

    public Dish1() {
        super();
    }

    public int getThoigianchebien() {
        return thoigianchebien;
    }

    public void setThoigianchebien(int thoigianchebien) {
        this.thoigianchebien = thoigianchebien;
    }

    public DishCategory1 getCategory() {
        return category;
    }

    public void setCategory(DishCategory1 category) {
        this.category = category;
    }

    public Unit1 getUnit() {
        return unit;
    }

    public void setUnit(Unit1 unit) {
        this.unit = unit;
    }

    public ArrayList<DishIngredient1> getIngredients() {
        return ingredients;
    }

    public void setIngredients(ArrayList<DishIngredient1> ingredients) {
        this.ingredients = ingredients;
    }
}
