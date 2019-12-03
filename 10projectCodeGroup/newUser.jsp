<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>New User Page</title>
<link rel="stylesheet" type="text/css" href="CSS/loginstyle.css">
</head>
<body>
	<br>
		<!--  will direct to new account creation page with the submitted credentials  -->
	<form method="post" action="addNewUser.jsp">  
	<h1 id="title"><b>Sign Up</b></h1>
	<hr>
	<label>Name:</label>
	<input type="text" name="name" placeholder=" Name">

	<label>Email:</label>
	<input type="text" name="email" placeholder=" Email">

	<label>Password:</label>
	<input type="text" name="password" placeholder=" Password">

	<label>Credit Card Info:</label>
	<input type="text" name="CreditCardInfo" placeholder=" Credit Card Info">

	<label>Address:</label>
	<input type="text" name="Address" placeholder=" Address">
	<hr>
	<label class="signup">Have an account?</label>
	<a class="signup" href="login.jsp">Sign In</a>
	<button type="submit">Create New User</button>
	</form>
<br>
</body>
</html>