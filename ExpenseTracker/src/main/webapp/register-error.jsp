<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registration Failed</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/style.css">
</head>

<body class="error-page">

<div class="error-card">

    <div class="error-icon">⚠</div>

    <h2>Registration Failed</h2>

    <p>Unable to create account. Email may already exist.</p>

    <a href="register.jsp" class="error-btn">Try Again</a>

</div>

</body>
</html>