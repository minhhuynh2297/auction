<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.auctionSite.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.time.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title> Auction: <%=request.getParameter("auction_title") %></title>
<link rel="stylesheet" type="text/css" href="itemView.css">
</head>
<body>
	<%
	
	try{
		// Get the database connection	
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Creat SQL statements
		Statement stmt = con.createStatement();
		
		// Match session user to auction owner
		
		String email = request.getParameter("email");
		String name = request.getParameter("name");
		String address = request.getParameter("address");
		String credit_info = request.getParameter("credit");
		String password = request.getParameter("password");
		
		String update = "UPDATE Customer SET name = \"" + name + "\", Address = \"" + address + "\", creditCardNumber = \"" + credit_info +
				"\", password = \"" + password + "\" WHERE email = \"" + email + "\"";
		
		PreparedStatement ps = con.prepareStatement(update);
		
		int result = ps.executeUpdate();
		
		if(result > 0){
			if(session.getAttribute("isRep").equals(true)){
				response.sendRedirect("accounts_list.jsp");
			}else{
				response.sendRedirect("home.jsp");
			}
		}else{
			out.print(update);
			out.print("There was an error updating the account.");
		}

		con.close();
	}catch(Exception ex){
		out.print(ex);
	}
		
	%>	
</body>
</html>