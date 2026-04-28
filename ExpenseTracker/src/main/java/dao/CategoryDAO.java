package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.Category;
import Expensetracker.util.DBConnection;

public class CategoryDAO {

    public boolean addCategory(Category category) {
        boolean status = false;

        try {
            Connection con = DBConnection.getConnection();
            String sql = "INSERT INTO categories(user_id, name, budget) VALUES (?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, category.getUserId());
            ps.setString(2, category.getName());
            ps.setDouble(3, category.getBudget());

            int rows = ps.executeUpdate();
            if (rows > 0) status = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    public List<Category> getCategoriesByUser(int userId) {
        List<Category> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM categories WHERE user_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Category c = new Category();
                c.setId(rs.getInt("id"));
                c.setUserId(rs.getInt("user_id"));
                c.setName(rs.getString("name"));
                c.setBudget(rs.getDouble("budget"));
                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public double getTotalBudgetByUser(int userId) {

        double total = 0;

        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT SUM(budget) FROM categories WHERE user_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                total = rs.getDouble(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }

}