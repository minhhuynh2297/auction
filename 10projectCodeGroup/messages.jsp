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
			
			String current_user = (String)session.getAttribute("email");
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			Statement stmt = con.createStatement();
			String str = "SELECT *, timestampdiff(day, date_time, current_timestamp) FROM Messages WHERE sent_to = \"" + current_user + "\" ORDER BY isRead asc, date_time desc";
			
			ResultSet result = stmt.executeQuery(str);
			
			if(!result.next())
				out.print("<h1>No New Messages</h1>");
			
			result.beforeFirst();
			
			while(result.next()){
				
				java.sql.Timestamp date_recv = result.getTimestamp("date_time");
				int date_since = result.getInt("timestampdiff(day, date_time, current_timestamp)");
				String subject = result.getString("email_subject");
				String from = result.getString("received_from");
				String content = result.getString("content");
				String sub_content;
				if(content.length() > 50)
					sub_content = content.substring(0,50);
				else
					sub_content = content;
				
				int email_num = result.getInt("email_number");
				
				%> 
				<div>
				<h3><%=subject%></h3>
				<h4><%=from%></h4>
				<p><%=date_recv%></p>
				<p>Received <%=date_since%> days ago</p>
				<hr>
				<p><%=sub_content%>...</p>
					<form method="post" action="message_detail.jsp">
						<input type="hidden" name="email_num" value=<%=email_num%>>
						<button type="submit" value=<%=email_num%>>View Full Msg</button>
					</form>
				<br>
				</div>
				<%
			}
			
		}catch (Exception ex){
			out.print(ex);
		}
	%>
	</div>

</body>
</html>