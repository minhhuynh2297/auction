<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.auctionSite.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
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
			int auction_number = Integer.parseInt(request.getParameter("auction_number"));
			
			
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			String title=request.getParameter("title");
			double min = Double.parseDouble(request.getParameter("minimum"));



			//Create a SQL statement
String stmt1 = "UPDATE Auction SET title = ?,hidden_minimum=? WHERE auction_number = '"+auction_number+"'";
						PreparedStatement ps1 = con.prepareStatement(stmt1);
						ps1.setString(1, title);
						ps1.setDouble(2,min);
						ps1.executeUpdate();
						
			
			
				response.sendRedirect("auctionList.jsp");

			//close the connection.
			con.close();
		} catch (Exception e) {
			out.print(e);
		}
		%>
	</div>

</body>
</html>