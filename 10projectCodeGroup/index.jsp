<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome Page </title>
</head>
<body>
<h2>Welcome</h2>
	<br>
		<!--  directs user to login  -->
		<form method="post" action="login.jsp">
		<input type="submit" value="Login With Existing Account">
		</form>
	<br>
	
	<br>
		<!--  directs user to create new account  -->
		<form method="post" action="newUser.jsp">
		<input type="submit" value="Create a New Account">
		</form>
	<br>
	
	
	
</body>
</html>