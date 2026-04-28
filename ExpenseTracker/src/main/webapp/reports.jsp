<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.*, dao.*" %>

<%
User user = (User) session.getAttribute("user");

if(user == null){
response.sendRedirect("login.jsp");
return;
}

String selectedMonth = request.getParameter("month");

ExpenseDAO dao = new ExpenseDAO();

Map<String,Double> chartData = new HashMap<>();

if(selectedMonth != null){
chartData = dao.getCategoryExpenseByMonth(user.getId(), selectedMonth);
}
%>

<html>

<head>

<title>Reports</title>

<link rel="stylesheet" href="style.css">

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</head>

<body class="light">

<div class="container">

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


<h2>Monthly Expense Summary</h2>

<form method="get">

<input type="month" name="month" required>

<button type="submit">Generate</button>

</form>

<br>

<% if(selectedMonth != null){ %>

<div class="chart-container">
<canvas id="categoryChart"></canvas>
</div>

<% } %>

</div>


<script>

const labels = [
<%
for(String key : chartData.keySet()){
out.print("'" + key + "',");
}
%>
];

const data = [
<%
for(Double value : chartData.values()){
out.print(value + ",");
}
%>
];

if(labels.length > 0){

const ctx = document.getElementById('categoryChart');

new Chart(ctx,{
type:'pie',

data:{
labels:labels,

datasets:[{
data:data,
backgroundColor:[
'#4facfe',
'#43e97b',
'#ff6a6a',
'#f6d365',
'#a18cd1',
'#f093fb'
]
}]
},

options:{
	responsive:true,
	maintainAspectRatio:false,

	plugins:{
	legend:{
	position:'bottom',
	labels:{
	boxWidth:12,
	padding:15
	}
	}
	}
	}
});

}

</script>

<script src="theme.js"></script>

</body>

</html>