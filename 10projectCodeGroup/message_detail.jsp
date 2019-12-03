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
			
			int email_num = Integer.parseInt(request.getParameter("email_num"));
			
			String current_user = (String)session.getAttribute("email");
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			Statement stmt = con.createStatement();
			String str = "SELECT * FROM Messages WHERE email_number = " + email_num;
			String set_read = "UPDATE Messages SET isRead = True WHERE email_number = " + email_num;
			
			PreparedStatement ps = con.prepareStatement(set_read);
			
			ps.executeUpdate();
			
			ResultSet result = stmt.executeQuery(str);
			
			result.next();
			
			java.sql.Timestamp date_recv = result.getTimestamp("date_time");
			String subject = result.getString("email_subject");
			String from = result.getString("received_from");
			String content = result.getString("content");
			
			//out.print(subject);
			
			%>
			
			<div class="message">
			
			<h1><%=subject%></h1>
			<h2><%=from%></h2>
			<hr>
			<p> >> <%=content%></p>
			<a href="messages.jsp">All Messages</a>
			</div>
			
			<div class="message">
			<h1>Reply:</h1>
				<form action="send_message.jsp" method="post">
					<input type="hidden" name="subject" value="<%=subject%>">
					<input type="hidden" name="reply_to" value="<%=from%>">
					<p>
					<textarea name="content" required=""></textarea>
					<hr>
					<button type="submit">Send</button>
				</form>
			</div>
			<%
		
			con.close();
			
		}catch (Exception ex){
			out.print(ex);
		}
	%>
	</div>

</body>
</html>