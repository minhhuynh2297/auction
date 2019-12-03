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
	<%

		try {

			int auction_number = Integer.parseInt(request.getParameter("auction_number"));
			String email = request.getParameter("email");
			double amount = Double.parseDouble(request.getParameter("amount"));
			
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			String str = "DELETE FROM Bids WHERE auction_number = " + auction_number + " AND email = \"" + email + "\" AND amount = " + amount;
			
			PreparedStatement ps = con.prepareStatement(str);
			//Run the query against the database.

			int result = ps.executeUpdate();
			
			if(result > 0){
				response.sendRedirect("auctionList.jsp");
			}else{
				out.print("There was an error deleting the bid.");
			}
		
			//close the connection.
			con.close();

		} catch (Exception e) {
			out.print(e);
		}
		%>
	</div>

</body>
</html>