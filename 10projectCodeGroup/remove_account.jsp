<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.auctionSite.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Auction List</title>
</head>
<body>
	<div class="content">
	<%
		try {

			String email = request.getParameter("email");
			
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			String str = "DELETE FROM Customer WHERE email = \"" + email + "\"";
			
			PreparedStatement ps = con.prepareStatement(str);
			//Run the query against the database.

			int result = ps.executeUpdate();
			
			if(result > 0){
				response.sendRedirect("accounts_list.jsp");
			}else{
				out.print(str);
				out.print("There was an error deleting the account.");
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