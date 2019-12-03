<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>reports</title>
</head>
<body>

	<h1>Generate a sales report for:</h1>
	
	<form method="post" action= "reportView.jsp" >
	<input type="hidden" name="type" value= "totalEarnings"> 
	<input type = "submit" value = "Total Earnings">
	</form>
	
	<form method="post" action= "reportView.jsp" >
		<input type="hidden" name="type" value= "earningsPerItem"> 
	<input type = "submit" value = "Earnings Per Item">
	</form>
	
	<form method="post" action= "reportView.jsp" >
	<input type="hidden" name="type" value= "earningsPerItemType"> 
	<input type = "submit" value = "Earnings Per Item Type">
	</form>
	
	<form method="post" action= "reportView.jsp" >
	<input type="hidden" name="type" value= "earningsPerEndUser"> 
	<input type = "submit" value = "Earnings Per End-User">
	</form>
	
	<form method="post" action= "reportView.jsp" >
	<input type="hidden" name="type" value= "bestSellingItems"> 
	<input type = "submit" value = "See Best Selling Items">
	</form>
	
	<form method="post" action= "reportView.jsp" >
	<input type="hidden" name="type" value= "bestBuyers"> 
	<input type = "submit" value = "See Best Buyers">
	</form>

</body>
</html>