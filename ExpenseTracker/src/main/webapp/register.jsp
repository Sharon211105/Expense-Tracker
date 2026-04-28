<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

<title>Register</title>

<link rel="stylesheet" href="style.css">

</head>

<body>

<div class="auth-page">

<div class="auth-left">

<h1>💰 Expense Tracker</h1>

<p>Take control of your finances and monitor your spending easily.</p>

</div>


<div class="auth-right">

<div class="auth-card">

<h2>Create Account</h2>

<form action="register" method="post">

<input type="text" name="name" placeholder="Name" required>

<input type="email" name="email" placeholder="Email" required>

<input type="password" name="password" placeholder="Password" required>

<button type="submit">Register</button>

</form>

<p class="auth-link">
Already have an account? <a href="login.jsp">Login</a>
</p>

</div>

</div>

</div>

</body>

</html>