package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import model.Expense;
import Expensetracker.util.DBConnection;

public class ExpenseDAO {

    /* ================= ADD EXPENSE ================= */

    public boolean addExpense(Expense expense) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO expenses(user_id, category_id, title, amount, date) VALUES (?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, expense.getUserId());
            ps.setInt(2, expense.getCategoryId());
            ps.setString(3, expense.getTitle());
            ps.setDouble(4, expense.getAmount());
            ps.setDate(5, expense.getDate());

            int rows = ps.executeUpdate();

            if (rows > 0) {
                status = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }


    /* ================= GET EXPENSES BY USER ================= */

    public List<Expense> getExpensesByUser(int userId) {

        List<Expense> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM expenses WHERE user_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Expense e = new Expense();

                e.setId(rs.getInt("id"));
                e.setUserId(rs.getInt("user_id"));
                e.setCategoryId(rs.getInt("category_id"));
                e.setTitle(rs.getString("title"));
                e.setAmount(rs.getDouble("amount"));
                e.setDate(rs.getDate("date"));

                list.add(e);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }


    /* ================= GET SINGLE EXPENSE ================= */

    public Expense getExpenseById(int id) {

        Expense expense = null;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM expenses WHERE id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                expense = new Expense();

                expense.setId(rs.getInt("id"));
                expense.setUserId(rs.getInt("user_id"));
                expense.setCategoryId(rs.getInt("category_id"));
                expense.setTitle(rs.getString("title"));
                expense.setAmount(rs.getDouble("amount"));
                expense.setDate(rs.getDate("date"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return expense;
    }


    /* ================= DELETE EXPENSE ================= */

    public void deleteExpense(int id) {

        try {

            Connection con = DBConnection.getConnection();

            String sql = "DELETE FROM expenses WHERE id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, id);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    /* ================= UPDATE EXPENSE ================= */

    public void updateExpense(Expense expense){

    	try{

    	Connection con = DBConnection.getConnection();

    	String sql = "UPDATE expenses SET title=?, amount=?, date=?, category_id=? WHERE id=?";

    	PreparedStatement ps = con.prepareStatement(sql);

    	ps.setString(1, expense.getTitle());
    	ps.setDouble(2, expense.getAmount());
    	ps.setDate(3, expense.getDate());   // fixed
    	ps.setInt(4, expense.getCategoryId());
    	ps.setInt(5, expense.getId());

    	ps.executeUpdate();

    	}catch(Exception e){
    	e.printStackTrace();
    	}

    }


    /* ================= TOTAL EXPENSE BY CATEGORY ================= */

    public double getTotalExpenseByCategory(int userId, int categoryId) {

        double total = 0;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT SUM(amount) FROM expenses WHERE user_id=? AND category_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setInt(2, categoryId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                total = rs.getDouble(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }


    /* ================= TOTAL EXPENSE BY USER ================= */

    public double getTotalExpenseByUser(int userId) {

        double total = 0;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT SUM(amount) FROM expenses WHERE user_id=?";

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


    /* ================= MONTHLY EXPENSE ================= */

    public double getMonthlyExpense(int userId, String month) {

        double total = 0;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT SUM(amount) FROM expenses WHERE user_id=? AND DATE_FORMAT(date,'%Y-%m')=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setString(2, month);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                total = rs.getDouble(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }


    /* ================= RECENT EXPENSES ================= */

    public List<Expense> getRecentExpenses(int userId) {

        List<Expense> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM expenses WHERE user_id=? ORDER BY date DESC LIMIT 5";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Expense e = new Expense();

                e.setId(rs.getInt("id"));
                e.setTitle(rs.getString("title"));
                e.setAmount(rs.getDouble("amount"));
                e.setDate(rs.getDate("date"));
                e.setCategoryId(rs.getInt("category_id"));

                list.add(e);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }


    /* ================= CATEGORY EXPENSE BY MONTH ================= */

    public Map<String, Double> getCategoryExpenseByMonth(int userId, String month) {

        Map<String, Double> map = new HashMap<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql =
                    "SELECT c.name, SUM(e.amount) total " +
                    "FROM expenses e " +
                    "JOIN categories c ON e.category_id = c.id " +
                    "WHERE e.user_id=? AND DATE_FORMAT(e.date,'%Y-%m')=? " +
                    "GROUP BY c.name";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setString(2, month);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                map.put(rs.getString("name"), rs.getDouble("total"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return map;
    }
}