package model;

public class DishIngredient1 {
    private int id;
    private float dinhluong;
    private Ingredient1 ingredient;

    public DishIngredient1() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public float getDinhluong() {
        return dinhluong;
    }

    public void setDinhluong(float dinhluong) {
        this.dinhluong = dinhluong;
    }

    public Ingredient1 getIngredient() {
        return ingredient;
    }

    public void setIngredient(Ingredient1 ingredient) {
        this.ingredient = ingredient;
    }
}
