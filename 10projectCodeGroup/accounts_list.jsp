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
<body class="auctionList">
	<div class="content">
	<h1>Manage Accounts</h1>

	<hr>
	<%
	
		try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			Statement stmt2 = con.createStatement();
			String str = "SELECT * FROM Customer";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			String credit_info;
			String email;
			String address;
			String name;
			String password;
			
			while(result.next()){
				
				credit_info = result.getString("creditCardNumber");
				email = result.getString("email");
				address = result.getString("Address");
				name = result.getString("name");
				password = result.getString("password");
				
				%>
				<div>
					<h2><%=email%></h2>
					<h4><%=name%></h4>
					<br>
						<form method="post" action="account_view.jsp">
							<input type="hidden" name="name" value=<%=name%>>
							<input type="hidden" name="credit_info" value=<%=credit_info%>>
							<input type="hidden" name="address" value=<%=address%>>
							<input type="hidden" name="password" value=<%=password%>>
							<input type="hidden" name="email" value=<%=email%>>
							<button type="submit">Edit Account</button>
						</form>
					<br>
					<hr>
				</div>
				<% 
			}
		
			//close the connection.
			con.close();
		} catch (Exception e) {
		}
		%>
	</div>

</body>
</html>