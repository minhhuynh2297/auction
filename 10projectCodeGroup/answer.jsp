<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.auctionSite.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Auction List</title>
<link rel="stylesheet" type="text/css" href="CSS/auction_list.css">
</head>
<body>
	<div class="content">
	<h1>Representatives</h1>
	<%
		try {
			int question_id = Integer.parseInt(request.getParameter("question_id"));
			
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			String answer=request.getParameter("answer");
			//Create a SQL statement
			String stmt1 = "UPDATE Question SET answer = ? WHERE question_id = '"+question_id+"'";
			PreparedStatement ps1 = con.prepareStatement(stmt1);
			ps1.setString(1, answer);
			ps1.executeUpdate();
						
			
			
				response.sendRedirect("questionlist.jsp");

			//close the connection.
			con.close();
		} catch (Exception e) {
			out.print(e);
		}
		%>
	</div>

</body>
</html>