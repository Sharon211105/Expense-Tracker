package model;

public class Category {

    private int id;
    private int userId;
    private String name;
    private double budget;

    public Category() {}

    public Category(int userId, String name, double budget) {
        this.userId = userId;
        this.name = name;
        this.budget = budget;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public double getBudget() { return budget; }
    public void setBudget(double budget) { this.budget = budget; }
}