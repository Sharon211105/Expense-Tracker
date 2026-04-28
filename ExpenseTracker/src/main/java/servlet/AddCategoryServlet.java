package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CategoryDAO;
import model.Category;
import model.User;

@WebServlet("/addCategory")
public class AddCategoryServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String name = request.getParameter("name");
        double budget = Double.parseDouble(request.getParameter("budget"));

        model.Category category=new model.Category(user.getId(), name, budget);
        CategoryDAO dao = new CategoryDAO();
        dao.addCategory(category);

        response.sendRedirect("categories.jsp");
    }
}