<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.*, dao.*, java.util.*" %>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Edit Expense</title>

<link rel="stylesheet" href="style.css">

</head>

<body class="light">

<%
int id = Integer.parseInt(request.getParameter("id"));

ExpenseDAO dao = new ExpenseDAO();
List<Expense> expenses = dao.getExpensesByUser(((User)session.getAttribute("user")).getId());

Expense expense = null;

for(Expense e : expenses){
    if(e.getId() == id){
        expense = e;
        break;
    }
}

CategoryDAO cdao = new CategoryDAO();
List<Category> categories = cdao.getCategoriesByUser(((User)session.getAttribute("user")).getId());
%>

<div class="container">

<!-- NAVBAR -->

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


<!-- EDIT EXPENSE CARD -->

<div class="edit-expense-card">

<h2>Edit Expense</h2>

<form class="edit-expense-form" action="editExpense" method="post">

<input type="hidden" name="id" value="<%=expense.getId()%>">

<label>Title</label>
<input type="text" name="title" value="<%=expense.getTitle()%>">

<label>Amount</label>
<input type="number" step="0.01" name="amount" value="<%=expense.getAmount()%>">

<label>Date</label>
<input type="date" name="date" value="<%=expense.getDate()%>">

<label>Category</label>
<select name="categoryId">

<% for(Category c : categories){ %>

<option value="<%=c.getId()%>"
<%= c.getId()==expense.getCategoryId() ? "selected" : "" %>>

<%=c.getName()%>

</option>

<% } %>

</select>

<button type="submit">Update Expense</button>

</form>

</div>

</div>

<script src="theme.js"></script>

</body>
</html>