<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.auctionSite.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the HelloWorld.jsp
		String newEmail = request.getParameter("email");	
		String newPassword = request.getParameter("password");

		//Make an insert new Employee into the Employee table:
		String insert = "INSERT INTO Employee(email, password)"
				+ "VALUES (?, ?)";
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself

		ps.setString(1, newEmail);
		ps.setString(2, newPassword);
		
		int result = ps.executeUpdate();

		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

		if (result > 0){
		out.print("Account Creation Successful");
		response.sendRedirect("admin.jsp");
		}else{
			out.print("Account Creation Unsuccessful");
		}
		
	} catch (Exception ex) {
		out.print(ex);
	}
%>
</body>
</html>