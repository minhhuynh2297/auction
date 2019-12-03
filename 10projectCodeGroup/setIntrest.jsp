<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.auctionSite.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SetIntrest</title>
<link rel="stylesheet" type="text/css" href="CSS/itemView.css">

	<div class="navbar">
        <a href="home.jsp">Home</a>
        <a href="list_item_view.jsp">Sell</a>
        <a href="auctionList.jsp">Auctions</a>
        <%
        	boolean user_is_logged_in = session.getAttribute("email") != null;
        	String logout = "logout.jsp";
        	if(user_is_logged_in){
        		out.print("<a href = " + logout + "> Log Out</a>");
        	}else{
        		String href = "login.jsp";
        		out.print("<a href = " + href + "> Log In</a>");
        	} 
        %>
    </div>


<div class="content">
<h1>Set alerts for items you are interested in:</h1>
<h3> You can set alerts for items you are interested in buying that are not currently on auction.</h3>
<h3> Input a tag that describes your desired item (20 characters or less) and optionally select size and color to narrow the search.</h3>
<h3> We'll alert you when an auction matching your specifications has been listed.</h3>

	
	<br>
		<form method="post" action="intrestSQL.jsp">
		<table>
		<tr>    
		<td>Tag:</td><td><input type="text" name="tag" maxlength = "20"></td>
		</tr>
		<tr>
		<td>Size:</td><td><input type="text" name="size" maxlength = "20"></td>
		</tr>
		<tr>
		<td>Color:</td><td><input type="text" name="color" maxlength = "20"></td>
		</tr>
		</table>
		<button type="submit" value="Set Alert">Set Alert</button>
		</form>
	<br>

</div>


</head>
<body>

</body>
</html>