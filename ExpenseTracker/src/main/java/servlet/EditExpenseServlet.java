package servlet;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.ExpenseDAO;
import model.Expense;

@WebServlet("/editExpense")
public class EditExpenseServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        double amount = Double.parseDouble(request.getParameter("amount"));
        Date date = Date.valueOf(request.getParameter("date"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));

        Expense expense = new Expense();
        expense.setId(id);
        expense.setTitle(title);
        expense.setAmount(amount);
        expense.setDate(date);
        expense.setCategoryId(categoryId);

        ExpenseDAO dao = new ExpenseDAO();
        dao.updateExpense(expense);

        response.sendRedirect("expenses.jsp");
    }
}