<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>New Representative</title>
</head>
<body>
	<h1>Create a Representative</h1>
	<br>
	<form method="post" action="addNewRep.jsp">
	<table>
	<tr>
	<td>Email</td><td><input type="text" name="email"></td>
	</tr>
	<tr>
	<td>Password</td><td><input type="text" name="password"></td>
	</tr>
	</table>
	<hr>
	<input type="submit" value="Create New Rep">
	</form>
<br>
</body>
</html>