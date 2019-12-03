<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.auctionSite.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>List Item</title>
</head>
<body>
<%
	try{
		
		// Get the database connection
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Create SQL Statement
		Statement stmt = con.createStatement();
		
		// Get form entries
		String log = (String)session.getAttribute("email");
		String text = request.getParameter("Question");
		
		String insert_question = "INSERT INTO Question(email,text)" + "VALUES (?, ?)";
		PreparedStatement ps = con.prepareStatement(insert_question);


		ps = con.prepareStatement(insert_question);
		ps.setString(1, log);
		ps.setString(2, text);
		
		ps.executeUpdate();
		
	
		//out.print("Inserted Succesfully!");
		response.sendRedirect("questionlist.jsp");
		
	}catch(Exception ex){
		out.print(ex);
	}
%> 

</body>
</html>