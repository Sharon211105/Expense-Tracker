<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

<title>Login</title>

<link rel="stylesheet" href="style.css">

</head>

<body>


<div class="auth-page">

<div class="auth-left">

<h1>💰 Expense Tracker</h1>

<p>Manage your expenses smartly and track your financial health.</p>

</div>


<div class="auth-right">

<div class="auth-card">

<h2>Login</h2>

<form action="login" method="post">

<input type="email" name="email" placeholder="Email" required>

<input type="password" name="password" placeholder="Password" required>

<button type="submit">Login</button>

</form>

<p class="auth-link">
Don't have an account? <a href="register.jsp">Register</a>
</p>

</div>

</div>

</div>


</body>

</html>