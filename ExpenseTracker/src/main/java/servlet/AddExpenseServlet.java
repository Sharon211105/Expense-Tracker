package servlet;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.ExpenseDAO;
import model.Expense;
import model.User;

@WebServlet("/addExpense")
public class AddExpenseServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String title = request.getParameter("title");
        double amount = Double.parseDouble(request.getParameter("amount"));
        Date date = Date.valueOf(request.getParameter("date"));

        Expense expense = new Expense(user.getId(), categoryId, title, amount, date);

        ExpenseDAO dao = new ExpenseDAO();
        dao.addExpense(expense);

        response.sendRedirect("expenses.jsp");
    }
}