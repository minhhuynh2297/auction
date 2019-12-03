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

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			String str = "SELECT * FROM Employee";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			String rep_email;
			boolean isAdmin;

			int auction_days_left;
			
			while(result.next()){
				
				rep_email = result.getString("email");
				isAdmin = result.getBoolean("isAdmin");
				
				if(!isAdmin && !rep_email.equals("system@buyme.com")){
				%>
				<div>
					<h2><%=rep_email%></h2>
					<br>
						<form method="get" action="remove_rep.jsp">
							<input type="hidden" name="email" value=<%=rep_email%>>
							<button type="submit" value=<%=rep_email%>>Remove Rep</button>
						</form>
					<br>
				</div>
				<% 
				}
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