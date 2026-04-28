<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.*, dao.*" %>

<%
User user = (User) session.getAttribute("user");

if(user == null){
response.sendRedirect("login.jsp");
return;
}

CategoryDAO dao = new CategoryDAO();
List<Category> categories = dao.getCategoriesByUser(user.getId());

ExpenseDAO expDao = new ExpenseDAO();
%>

<html>

<head>
<title>Categories</title>
<link rel="stylesheet" href="style.css">
</head>

<body class="light">

<div class="navbar">

<div class="nav-left">
<a href="dashboard.jsp">Dashboard</a>
<a href="expenses.jsp">Expenses</a>
<a href="categories.jsp">Categories</a>
<a href="reports.jsp">Reports</a>
</div>

<div class="nav-right">
<span class="theme-toggle" onclick="toggleTheme()">🌙</span>
<a href="logout" class="logout-btn">Logout</a>
</div>

</div>
<h2>Add Category</h2>

<form action="addCategory" method="post">

Category Name:
<input type="text" name="name" required>

Budget:
<input type="number" name="budget" required>

<input type="submit" value="Add Category">

</form>

<h2>Your Categories</h2>

<table border="1">

<tr>
<th>Name</th>
<th>Budget</th>
<th>Spent</th>
<th>Remaining</th>
</tr>

<% for(Category c : categories){

double spent = expDao.getTotalExpenseByCategory(user.getId(), c.getId());
double remaining = c.getBudget() - spent;
%>

<tr>

<td><%=c.getName()%></td>
<td><%=c.getBudget()%></td>
<td><%=spent%></td>

<td>
<% if(remaining < 0){ %>
<span style="color:red;">Exceeded</span>
<% } else { %>
<%=remaining%>
<% } %>
</td>

</tr>

<% } %>

</table>

<script src="theme.js"></script>

</body>

</html>