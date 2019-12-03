<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login Page</title>
<link rel="stylesheet" type="text/css" href="CSS/loginstyle.css">
</head>
<body>
    <form action="loginCheck.jsp" method="post">
        <h1 id="title"><b>Sign In</b></h1>
        <hr>
        <div>
            <label>Email:</label>
            <input type="text" placeholder="Email" id="mail" name="email">
        </div>
        <div>
            <label>Password:</label>
            <input type="password"  placeholder="Password" id="pswd" name="password">
        </div>
        <hr>
        <label class="signup">Don't have an account?</label>
        <a class="signup" href="newUser.jsp">Sign Up</a>
        <p>
        <label class="signup">Staff Login</label>
        <a class="signup" href="staff_login.jsp">Staff Login</a>
        <div class="button">
            <button type="submit">Enter</button>
        </div>

    </form>
</body>
</html>