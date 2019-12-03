<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.auctionSite.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.time.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title> Auction: <%=request.getParameter("auction_title") %></title>
<link rel="stylesheet" type="text/css" href="CSS/itemView.css">
</head>
<body>

	 <div class="navbar">
        <a href="home.jsp">Home</a>
        <a href="list_item_view.jsp">Sell</a>
        <a href="auctionList.jsp">Auctions</a>
        <%
        	boolean user_is_logged_in = session.getAttribute("email") != null;
        	String logout = "logout.jsp";
        	if(user_is_logged_in){
        		out.print("<a href = " + logout + "> Log Out</a>");
        	}else{
        		String href = "login.jsp";
        		out.print("<a href = " + href + "> Log In</a>");
        	} 
        %>
    </div>

<div class="content">
	<%
	
	try{
		// Get the database connection	
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// Creat SQL statements
		Statement stmt = con.createStatement();
		
		// Match session user to auction owner
		
		String account_user = request.getParameter("email");
		String name = request.getParameter("name");
		String address = request.getParameter("address");
		String credit_info = request.getParameter("credit_info");
		String password = request.getParameter("password");
		
		String current_user = (String)session.getAttribute("email");
		String isRep = (String)session.getAttribute("isRep");
		
		boolean current_user_is_rep = current_user != null && isRep.equals("true");
		boolean current_user_is_account_user = current_user != null && current_user.equals(account_user);
		
		if(current_user_is_rep || current_user_is_account_user){
			%>
				<div>
				<form action="edit_account.jsp" method="post">
				<h1><%=account_user%></h1>
				<hr>
				<h2>Edit Account Information:</h2>
				
					<label>Edit Name:</label>
					<input type="text" required="" name="name" value=<%=name%>>
					
					<label>Edit Address:</label>
					<input type="text" required="" name="address" value=<%=address%>>
					
					<label>Edit Credit Info:</label>
					<input type="text" required="" name="credit" value=<%=credit_info%>> 
					
					<label>Edit Password:</label>
					<input type="password" required="" name="password" value=<%=password%>>
					<input type="hidden" name ="email" value=<%=account_user%>>
					
					<button type="submit">Confirm</button>
				</form>

				<form action="remove_account.jsp" method="post">
				<h2 style="color:red;">Delete Account:</h2>
				<input type="hidden" name ="email" value=<%=account_user%>>
				<button type="submit">Remove Account</button>
				</form>
				</div>
				
			<%
			
			if(current_user_is_rep){
				out.println("<a href=\"accounts_list.jsp\">Return to  Accounts</a> |");
				out.println("<a href=\"auctionList.jsp\">Auction List</a>");
			}
		}
		
		con.close();
	}catch(Exception ex){
		out.print(ex);
	}
		
	%>	
	</div>
</body>
</html>