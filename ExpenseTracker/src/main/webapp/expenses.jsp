<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.*, dao.*" %>

<%
User user = (User) session.getAttribute("user");

if(user == null){
    response.sendRedirect("login.jsp");
    return;
}

CategoryDAO categoryDao = new CategoryDAO();
List<Category> categories = categoryDao.getCategoriesByUser(user.getId());

ExpenseDAO expenseDao = new ExpenseDAO();
List<Expense> expenses = expenseDao.getExpensesByUser(user.getId());
%>

<!DOCTYPE html>
<html>

<head>

<title>Expenses</title>

<link rel="stylesheet" href="style.css">

</head>

<body class="light">

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

<!-- ADD EXPENSE SECTION -->

<div class="section-card">

<h2>Add Expense</h2>

<form class="expense-form" action="addExpense" method="post">

<input type="text" name="title" placeholder="Title" required>

<input type="number" step="0.01" name="amount" placeholder="Amount" required>

<input type="date" name="date" required>

<select name="categoryId">

<% for(Category c : categories){ %>

<option value="<%=c.getId()%>"><%=c.getName()%></option>

<% } %>

</select>

<button type="submit">➕ Add Expense</button>

</form>

</div>


<!-- EXPENSE TABLE -->

<div class="section-card">

<h2>Your Expenses</h2>

<table>

<tr>
<th>Title</th>
<th>Amount</th>
<th>Date</th>
<th>Action</th>
</tr>

<% for(Expense e : expenses){ %>

<tr>

<td><%= e.getTitle() %></td>

<td>₹ <%= e.getAmount() %></td>

<td><%= e.getDate() %></td>

<td>
<a href="editExpense.jsp?id=<%=e.getId()%>">Edit</a> |
<a href="deleteExpense?id=<%=e.getId()%>">Delete</a>
</td>

</tr>

<% } %>

</table>

</div>

</div>

<script src="theme.js"></script>

</body>

</html>