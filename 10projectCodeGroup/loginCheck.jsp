<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.auctionSite.pkg.*"%>
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
		//List<String> list = new ArrayList<String>();
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the combobox from the index.jsp
			String entity = request.getParameter("email");
			//Make a SELECT query from the user table where the given email is present
			String str = "SELECT password FROM Customer WHERE email = '"+entity+"'";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			if (result.next()) {
				//the password user entered matches the password in the db
				if(request.getParameter("password").equals(result.getString("password"))){
					//out.print("Login Success:");
					String login = request.getParameter("email");
					session.setAttribute("email",login);
					session.setAttribute("isRep", "false");
					response.sendRedirect("home.jsp");%>
					<br><a href="#">Go to Account</a> 
			
				 <%}
				
				//password mismatch
				else{				
					out.print("Login Failure: Wrong Password:");%>
					<br><a href="http://localhost:8080/auctionSite/login.jsp#">Log In Again</a>
				<%}
			}else{
				out.print("No account exists with this email:");%>
				<br><a href="http://localhost:8080/auctionSite/newUser.jsp#">Create Account</a>
				<br><a href="http://localhost:8080/auctionSite/login.jsp#">Log In Again</a>
			<%}
			//close the connection.
			con.close();
		} catch (Exception e) {
		}
	%>

</body>
</html>