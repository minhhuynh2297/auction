<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.auctionSite.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.time.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="itemView.css">
</head>
<body>
	
	
	<!--  
	<h2><%=request.getParameter("itemNum")%></h2>
	<h2><%=request.getParameter("auctionNum")%></h2>
	-->
	<% 
	
	try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
		
			
			String bids_query = "SELECT * FROM Bids WHERE auction_number = "+request.getParameter("auctionNum")+" order by amount desc";
				
			ResultSet bids = stmt.executeQuery(bids_query);
				
				
			int count = 0;
			
			if(!bids.next()){
				
				%>
				<h2>Empty History</h2>
				<hr>
				<p>There are no bids to display. Check back later.</p>
				<% 
				
			}else{
				%>
				<h2>Bid History:</h2>
				<p>Bids in descending order:</p>
				<hr>
				<%
				bids.beforeFirst();
				while(bids.next()){	
					
				%>
				<div>
					<h3><%=count + 1 %></h3>
					<p>User: <%=bids.getString("email") %></p>
					<p>Posted at: <%=bids.getTimestamp("date_posted") %>
					<p>Amount: $<%=bids.getDouble("amount") %> </p>
					
				</div>
				<%
				
				String isRep = (String)session.getAttribute("isRep");
				
				if(isRep.equals("true") || session.getAttribute("email").equals(bids.getString("email"))){
					%>
						
						<form action="remove_bid.jsp">
							<input type="hidden" name="email" value="<%=bids.getString("email")%>" >
							<input type="hidden" name="auction_number" value="<%=bids.getString("auction_number")%>" >
							<input type="hidden" name="amount" value="<%=bids.getString("amount")%>" >
							<button type="submit">Remove Bid</button>
						</form>
						<hr>
					<%
				}
				count += 1;
				}
			}
			%>
			
			
			
			
		
		<% 
		con.close();
		} catch (Exception e) {
		}
		%>
	
	
	
	
	
	
</body>
</html>