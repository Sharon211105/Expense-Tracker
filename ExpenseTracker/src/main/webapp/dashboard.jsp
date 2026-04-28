<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.*, dao.*" %>

<%
User user = (User) session.getAttribute("user");

if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}

/* DAO */
CategoryDAO categoryDao = new CategoryDAO();
ExpenseDAO expenseDao = new ExpenseDAO();

/* Monthly calculation FIRST (so currentMonth exists) */

Calendar cal = Calendar.getInstance();
int year = cal.get(Calendar.YEAR);
int month = cal.get(Calendar.MONTH) + 1;

String currentMonth = year + "-" + (month < 10 ? "0" + month : month);

/* Smart Insight */

Map<String, Double> categoryExpenses =
        expenseDao.getCategoryExpenseByMonth(user.getId(), currentMonth);

String topCategory = "";
double highest = 0;

for(Map.Entry<String, Double> entry : categoryExpenses.entrySet()){
    if(entry.getValue() > highest){
        highest = entry.getValue();
        topCategory = entry.getKey();
    }
}

/* Other Data */

List<Expense> recentExpenses = expenseDao.getRecentExpenses(user.getId());
List<Category> categories = categoryDao.getCategoriesByUser(user.getId());

double totalBudget = categoryDao.getTotalBudgetByUser(user.getId());
double totalSpent = expenseDao.getTotalExpenseByUser(user.getId());
double overallRemaining = totalBudget - totalSpent;

double monthlySpent = expenseDao.getMonthlyExpense(user.getId(), currentMonth);
double monthlySavings = totalBudget - monthlySpent;
%>

<!DOCTYPE html>
<html>

<head>
<title>Dashboard</title>
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

<!-- WELCOME -->
<div class="welcome-box">
<h2>Welcome, <%= user.getName() %> 👋</h2>
<p>Track your expenses and manage your budget smartly.</p>
</div>

<!-- DASHBOARD CARDS -->
<h2 style="margin-top:25px;">Dashboard Summary</h2>

<div class="dashboard-cards">

<div class="card budget">
<h3>💰 Total Budget</h3>
<p>₹ <%= totalBudget %></p>
</div>

<div class="card spent">
<h3>💸 Total Spent</h3>
<p>₹ <%= totalSpent %></p>
</div>

<div class="card remaining">
<h3>📊 Remaining Balance</h3>

<% if(overallRemaining < 0){ %>
<p style="color:red;">⚠ Budget Exceeded</p>
<% } else { %>
<p>₹ <%= overallRemaining %></p>
<% } %>

</div>

</div>

<!-- MONTHLY SAVINGS -->
<h2 style="margin-top:30px;">Monthly Savings</h2>

<div class="section-card">

<% if(monthlySavings >= 0){ %>

<span class="badge badge-success">
💰 Saved ₹ <%= monthlySavings %> this month
</span>

<% } else { %>

<span class="badge badge-danger">
⚠ Overspent ₹ <%= Math.abs(monthlySavings) %> this month
</span>

<% } %>

</div>

<!-- SMART INSIGHT -->
<div class="section-card insight-box">

<h3>📊 Smart Insight</h3>

<% if(highest > 0){ %>

<p>
You spent the most on <strong><%= topCategory %></strong> this month
(₹ <%= highest %>).
Consider reducing this to increase your savings.
</p>

<% } else { %>

<p>No expenses recorded this month.</p>

<% } %>

</div>

<!-- BUDGET ALERTS -->
<h2 style="margin-top:30px;">Budget Alerts</h2>

<div class="section-card">

<%
for(Category c : categories){

double spent = expenseDao.getTotalExpenseByCategory(user.getId(), c.getId());
double percentUsed = (spent / c.getBudget()) * 100;

if(percentUsed >= 80 && percentUsed < 100){
%>

<span class="badge badge-warning">
⚠ <%= c.getName() %> budget reached 80%
</span><br>

<%
}else if(percentUsed >= 100){
%>

<span class="badge badge-danger">
⚠ <%= c.getName() %> budget exceeded
</span><br>

<%
}

}
%>

</div>

<!-- RECENT EXPENSES -->
<h2 style="margin-top:30px;">Recent Expenses</h2>

<table>

<tr>
<th>Title</th>
<th>Amount</th>
<th>Date</th>
</tr>

<% for(Expense e : recentExpenses){ %>

<tr>
<td><%= e.getTitle() %></td>
<td>₹ <%= e.getAmount() %></td>
<td><%= e.getDate() %></td>
</tr>

<% } %>

</table>

<p style="margin-top:20px;">
Use the navigation menu above to manage your expenses and budgets.
</p>

</div>

<script src="theme.js"></script>

</body>
</html>