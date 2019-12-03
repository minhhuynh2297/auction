<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.auctionSite.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>

<%
	String tag,size,color;
	tag = request.getParameter("tag");
	size = request.getParameter("size");
	color = request.getParameter("color");
	
	try {
	
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		Statement stmt = con.createStatement();
		String insert = "INSERT INTO Interest(email, tag, size, color)"
			+ "VALUES (?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(insert);
		ps.setString(1, (String)session.getAttribute("email"));
		ps.setString(2, tag);
		ps.setString(3, size);
		ps.setString(4, color);
		ps.executeUpdate();
	
		con.close();
		out.print("alert has been set successfully");
	
	} catch (Exception e) {
	}
%>

</body>
</html>