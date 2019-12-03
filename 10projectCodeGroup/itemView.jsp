<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.auctionSite.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*,java.text.*"%>
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
		Statement stmt2 = con.createStatement();
		
		String request_auction_number = request.getParameter("auctionNum");
		String request_item_number = request.getParameter("itemNum");
		
		String q1 = "SELECT *, timestampdiff(day, current_timestamp, end_date),timestampdiff(minute, current_timestamp, end_date),timestampdiff(minute, current_timestamp, start_date) from" +
			" Auction WHERE auction_number = " + request_auction_number;
		
		String q2 = "SELECT * from item WHERE item_number = " + request_item_number;
		
		ResultSet auctionResult = stmt.executeQuery(q1);
		ResultSet itemResult = stmt2.executeQuery(q2);
		
		auctionResult.next();
		itemResult.next();
		String smail = "system@buyme.com";
		
		String current_user = (String)session.getAttribute("email");
		String auction_user = auctionResult.getString("email");
		
		java.sql.Timestamp auction_end_date = auctionResult.getTimestamp("end_date");
		int auction_days_left = auctionResult.getInt("timestampdiff(day, current_timestamp, end_date)");
		int auction_minutes_left = auctionResult.getInt("timestampdiff(minute, current_timestamp, end_date)");
		int auction_minutes_to_start = auctionResult.getInt("timestampdiff(minute, current_timestamp, start_date)");
		
		int auction_number = auctionResult.getInt("auction_number");
		
		String auction_title = auctionResult.getString("title");
		Double increment = auctionResult.getDouble("increment");
		String item_name = itemResult.getString("item_name");
		String item_desc = itemResult.getString("description");
		int item_number = itemResult.getInt("item_number");
		
		//LocalDate current_datetime = LocalDate.now();
		java.util.Date d = new java.util.Date();
		java.sql.Date current_datetime = new java.sql.Date(d.getTime());
		
		Statement stmt3 = con.createStatement();
		String q3 = "SELECT * from Bids WHERE auction_number = " + auction_number + " order by amount desc"; 
		ResultSet bids = stmt3.executeQuery(q3);
		double hidden_minimum = auctionResult.getDouble("hidden_minimum");

		boolean bids_exist = false;
		double highest_bid = 0.0;
		
		if(bids.next()){
			highest_bid = bids.getDouble("amount");
			bids_exist = true;
		}
		
		Statement stmt4 = con.createStatement();
		String q4;
		
		%>
			<h1><%=auction_title%></h1>
			<h2><%=item_name%></h2>
			<p>Listed By: <%=auction_user%></p>
		<% 
		int cat = Integer.parseInt(itemResult.getString("category_number"));
					
		if(cat ==1){
			q4 = "SELECT * from Athletic WHERE item_number = "+request.getParameter("itemNum");
		}else if(cat == 3){
			q4 = "SELECT * from Sandal WHERE item_number = "+request.getParameter("itemNum");
		}else{
			q4 = "SELECT * from Business  WHERE item_number = "+request.getParameter("itemNum");	
		}
			ResultSet categoryResult = stmt4.executeQuery(q4);
			
		if(categoryResult.next()){
		%>
		<p> Details: <%=categoryResult.getString("color")%> <%=categoryResult.getString("size") %></p>
		<% 
		}
					
		%>
			
			
				<p>Auction Ends: <%=auction_end_date%></p>
				<p>Current Date: <%=current_datetime%></p>
				<p>Current Highest Bid: $<%=highest_bid%></p>
			
			<a href="auctionList.jsp">Back to Auctions</a>
		<%
		
		if((auction_minutes_left+240) > 0){
			out.println("<p>Days Left: " + auction_days_left + "</p>");
		}else{
			String closedCheck = "SELECT * FROM Auction WHERE closed = 1 AND auction_number = "+request_auction_number;
			Statement cc = con.createStatement();
			ResultSet closedResult = cc.executeQuery(closedCheck);
			
			boolean isClosed = closedResult.next();
			
			out.println("<p>Auction is closed</p>");
			if(bids_exist){
				if(highest_bid >= hidden_minimum){
					out.print("<hr>");
					out.print("<p> Winner is: " + bids.getString("email") + " with amount = " + highest_bid + " Hidden Minimum: " + hidden_minimum + "</p>");
					
						if(!isClosed){
							
							//out.print("1");
							String earn = "SELECT earnings FROM Seller WHERE email = '"+auction_user+"'";
							Statement er = con.createStatement();
							ResultSet ear = er.executeQuery(earn);
							ear.next();
							double earnings = ear.getDouble("earnings");
							earnings +=highest_bid;
							
							//out.print("2");
							String sellearn = "UPDATE Seller SET earnings = ? WHERE email = '"+auction_user+"'";
							PreparedStatement earnUpdate = con.prepareStatement(sellearn);
							earnUpdate.setDouble(1,earnings);
							earnUpdate.executeUpdate();
							
							
							
							//out.print("1");
							//update num_purchased
							String getP = "Select * FROM Buyer WHERE email = '"+bids.getString("email")+"'";
							Statement p = con.createStatement();
							ResultSet pResult = p.executeQuery(getP);
							pResult.next();
							int numP = pResult.getInt("num_purchases");
							numP++;
							
							//out.print("2");                               
							String buy = "UPDATE Buyer SET num_purchases = ? WHERE email = '"+bids.getString("email")+"'";
							PreparedStatement buyerUpdate = con.prepareStatement(buy);
							buyerUpdate.setInt(1,numP);
							buyerUpdate.executeUpdate();
							
							//out.print("3");
							//update num_sold
							String getS = "Select * FROM Seller WHERE email = '"+auction_user+"'";
							Statement sl = con.createStatement();
							ResultSet sResult = sl.executeQuery(getS);
							sResult.next();
							int numS = sResult.getInt("num_sold");
							numS++;
							
							//out.print("4");
							String se = "UPDATE Seller SET num_sold = ? WHERE email = '"+auction_user+"'";
							PreparedStatement sellerUpdate = con.prepareStatement(se);
							sellerUpdate.setInt(1,numS);
							sellerUpdate.executeUpdate();
							
							
							
							String win = "You won an auction ["+auction_title+"] for "+highest_bid;
							String sell = "You sold an item in an auction ["+auction_title+"] for "+highest_bid;
							String winSub = "Auction Won";
							String sellSub = "Item Sold";
							String winMail =  bids.getString("email");
							String sellMail = auction_user;
							
							
							String s = "INSERT INTO Messages (content, email_subject,received_from,sent_to) VALUES (?,?,?,?)";
							PreparedStatement ms1 = con.prepareStatement(s);
							ms1.setString(1,sell);
							ms1.setString(2,sellSub);
							ms1.setString(3,smail);
							ms1.setString(4,sellMail);
							
							ms1.executeUpdate();
							
							String b = "INSERT INTO Messages (content, email_subject,received_from,sent_to) VALUES (?,?,?,?)";
							PreparedStatement ms2 = con.prepareStatement(b);
							ms2.setString(1,win);
							ms2.setString(2,winSub);
							ms2.setString(3,smail);
							ms2.setString(4,winMail);
							
							ms2.executeUpdate();
						}
					
					
				}else{
					out.print("<hr>");
					out.print("<p>No amount reached hidden minimum. Auction is closed without a winner.</p>");
					
					if(!isClosed){
						String sell = "Your item did not sell in auction ["+auction_title+"] . The hidden minimum was not reached";
						String sellSub = "Item  Not Sold";
						String sellMail = auction_user;
						
						
						String s = "INSERT INTO Messages (content, email_subject,received_from,sent_to) VALUES (?,?,?,?)";
						PreparedStatement ms1 = con.prepareStatement(s);
						ms1.setString(1,sell);
						ms1.setString(2,sellSub);
						ms1.setString(3,smail);
						ms1.setString(4,sellMail);
						
						ms1.executeUpdate();
					}
				
					
				}
			}else{
				out.print("<hr>");
				out.print("<p> No bids made to this item. Auction is closed without a winner.</p>");
				
				if(!isClosed){
					String sell = "Your item did not sell in auction ["+auction_title+"]. There were no bids.";
					String sellSub = "Item Not Sold";
					String sellMail = auction_user;
					
					
					String s = "INSERT INTO Messages (content, email_subject,received_from,sent_to) VALUES (?,?,?,?)";
					PreparedStatement ms1 = con.prepareStatement(s);
					ms1.setString(1,sell);
					ms1.setString(2,sellSub);
					ms1.setString(3,smail);
					ms1.setString(4,sellMail);
					
					ms1.executeUpdate();
				}
				
				
			}
			//set closed to true
			if(!isClosed){
				String close = "UPDATE Auction SET closed = ? WHERE auction_number = "+ request_auction_number;
				PreparedStatement c = con.prepareStatement(close);
				c.setInt(1,1);
				
				c.executeUpdate();
			}
		}
			
		// Match session user to auction owner
		boolean current_user_is_not_auction_user = (current_user != null && !current_user.equals(auction_user));
		
		%>
			<hr>
			<p>Description:</p>
			<p><%=item_desc %></p>
		<%
		
		if(current_user_is_not_auction_user && auction_minutes_left+240 > 0  && auction_minutes_to_start+240<=0){
			
			%>
				<form method= "post" action="similarItems.jsp">
				 
					<input type="hidden" name="tag1" value=<%=itemResult.getString("tag1")%>>  
					<input type="hidden" name="tag2" value=<%=itemResult.getString("tag2")%>> 
					<input type="hidden" name="tag3" value=<%=itemResult.getString("tag3")%>> 
					
					<input type = "submit" value = "View similar items on auction in the previous month"/>
				</form>
			
				
				<hr>
				<h2>Bidding:</h2>
				<form method="post" action="autoBid.jsp">
					<p>You will only be allowed to bid an amount greater than the current highest bid.</p>
					<label>Bid Amount:</label>
					<input type="hidden" name="auctionNum" value="<%=auction_number%>" >
					<input type="hidden" name="current_user" value="<%=current_user%>" >
					<input type="hidden" name="auction_title" value="<%=auction_title%>" >
					<input type="hidden" name="highest_bid" value="<%=highest_bid%>" >
					<input type="hidden" name="increment" value="<%=increment%>" >
					<input type="number" required="" step=".01" min=<%=highest_bid + increment%> required="" name="amount">
					
					<h2 style="color:red;">Automatic Bidding:</h2>
					<p>If you would like for bids to be set in your place automatically enter an amount.
					   Otherwise, leave empty.
					</p>
					<label>Upper Limit:</label>
					<input type="number" step=".01" min="0" name="upper_limit">
					<hr>
					<button type="submit">Confirm</button>
				</form>
			<%
			
		}
		%>
		<hr>
		<h2>View Bid History</h2>
		<form method = "post" action="bidhistory.jsp">
			<input type="hidden" name="auctionNum" value="<%=auctionResult.getInt("auction_number")%>">
			<button type="submit">View Bid History</button>
		</form>
		<%
		
		String isRep = (String)session.getAttribute("isRep");
		
		if(current_user != null && (!current_user_is_not_auction_user || isRep.equals("true"))){
			%>
				<hr>
				<h2 style="color:red;">Edit Auction</h2>
				<form action="edit_auction.jsp">
				<label class="min">Hidden Minimum:</label>
                <input type="number" name="minimum" step="0.01" min="0" value= <%=hidden_minimum%> >

            <label>Title:</label>
            <input type="text" name="title" value= <%=auction_title%>>
 
				
				
				
					<input type="hidden" name="auction_number" value="<%=auction_number%>" >
					<button type="submit">Edit</button>
				</form>		
				<hr>
				<h2 style="color:red;">Remove Auction</h2>
				<form action="remove_auction.jsp">
					<input type="hidden" name="item_number" value="<%=item_number%>" >
					<button type="submit">Remove Auction</button>
				</form>
				
				
				
			<%
		}
		
		con.close();
	}catch(Exception ex){
		out.print(ex);
	}
		
	%>	
	</div>
</body>
</html>