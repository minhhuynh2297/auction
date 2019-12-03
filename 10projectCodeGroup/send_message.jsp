<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.auctionSite.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="CSS/messages.css">
</head>
<body>
	<% 
		try{
			
			String current_user = (String)session.getAttribute("email");
			String reply_to = request.getParameter("reply_to");
			String content = request.getParameter("content");
			String subject = "RE: " + request.getParameter("subject");
			
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			Statement stmt = con.createStatement();
			
			String send_email = "INSERT INTO Messages(content, email_subject, received_from, reply_to)" + "VALUES (?, ?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(send_email);
		
			ps.setString(1, content);
			ps.setString(2, subject);
			ps.setString(3, current_user);
			ps.setString(4, reply_to);
			
			
			int result = ps.executeUpdate();
			
			con.close();
			
			if(result > 0)
				response.sendRedirect("messages.jsp");
			else
				out.print("There was a problem sending your message.");
			
		}catch (Exception ex){
			out.print(ex);
		}
	%>
</body>
</html>