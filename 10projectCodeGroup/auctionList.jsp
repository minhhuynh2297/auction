<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.auctionSite.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Auction List</title>
<link rel="stylesheet" type="text/css" href="CSS/auction_list.css">
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



	<%String sortBy = request.getParameter("dropDown");
	String searchBy = request.getParameter("search");
	
	boolean isCat = false;
	
	//out.print("sort: "+sortBy);
	//out.print("search: "+searchBy);%>
	<div class="content">
	
	<h1>Active Auctions</h2>
	<h3>Search Auctions</h3>
	<form>
		<input type="text" name="search" placeholder="Search by item tag contents.">
		<button type="submit" value="Search">Search</button>
	</form>
	<hr>
	<h3>Sort Auctions By:</h3>
	<form>
		<select name = "dropDown" id="dropDown">
		  <option value="none">EMPTY</option>
		  <option value="category">Category</option>
		  <option value="ending_soon">Closest to Ending</option>
		  <option value="priceHL">Price: High-Low</option>
		  <option value="priceLH">Price: Low-High</option>
		  <option value="itemsSold">Number of Item Sold By Seller</option>
		</select>
		<p>
		<button type="submit" value="Sort">Sort</button>
	</form>
	<hr>
	
	<%

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			Statement stmt2 = con.createStatement();
			Statement stmt3 = con.createStatement();
			Statement stmt4 = con.createStatement();
			Statement stmtrb = con.createStatement();
			Statement stmtrs = con.createStatement();
			//deterining if a sort has been input, sorting if necessary
			String str = "";
			String str2 = "";
			String str3 = "";
			
			if(searchBy == null){
				//out.print("HERE1");
				if(sortBy == null){
					str = "SELECT * from Auction";
				}else if(sortBy.equals("category")){
					isCat = true;
					//SPECIAL CASES WHERE 3 SQL STATEMENTS ARE NEEDED
					str = "SELECT *FROM Auction INNER JOIN item WHERE item.category_number = 1 AND Auction.item_number = item.item_number";
					str2 = "SELECT *FROM Auction INNER JOIN item WHERE item.category_number = 2 AND Auction.item_number = item.item_number";
					str3 = "SELECT *FROM Auction INNER JOIN item WHERE item.category_number = 3 AND Auction.item_number = item.item_number";
				}else if(sortBy.equals("ending_soon")){
					str = "SELECT * FROM Auction ORDER BY end_date ASC";
					
				}else if(sortBy.equals("priceHL")){
					//out.print("HERE2");
					str = "SELECT * FROM Auction INNER JOIN (select auction_number from Bids group by auction_number ORDER BY max(amount) DESC) AS ord WHERE Auction.auction_number = ord.auction_number";
				}else if(sortBy.equals("priceLH")){
					str = "SELECT * FROM Auction INNER JOIN (select auction_number from Bids group by auction_number ORDER BY max(amount) ASC) AS ord WHERE Auction.auction_number = ord.auction_number";
				}else if(sortBy.equals("itemSold")){
					str = "SELECT * FROM Auction INNER JOIN Seller WHERE Auction.email = Seller.email ORDER BY Seller.num_sold DESC";			
				}
			}else{
				//str = "SELECT * FROM Auction where item_number in (SELECT item_number from item where tag1 LIKE '%"+searchBy+"%' OR tag2 LIKE '%"+searchBy+"%' OR tag3 = '%"+searchBy+"%')";
				str = "SELECT * FROM Auction where item_number in (SELECT item_number from item where tag1 LIKE '"+searchBy+"' OR tag2 LIKE '"+searchBy+"' OR tag3 LIKE '"+searchBy+"')";

			}
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			if(!isCat){
			 	//out.print("HERE C "+str);

				while(result.next()){
				 %>
					 <%
					 	//getting item details for the auction
					 	String itemDetail = "SELECT * FROM item WHERE item_number = "+result.getString("item_number")+"";
					 	//<h2>Active Auctions</h2>
					 	ResultSet itemResult = stmt2.executeQuery(itemDetail);
					 	itemResult.next();
					 %>
					 			
					<div>
					<h2><%=result.getString("title")%></h2>
					<hr>
					<h4><%=itemResult.getString("item_name")%></h4>
					<br>
				 	<br>
						<form method="post" action="itemView.jsp">
						<input type="hidden" name="auctionNum" value=<%=result.getString("auction_number")%>> 
						<input type="hidden" name="itemNum" value=<%=itemResult.getString("item_number")%>> 
						<button type="submit" value=<%=itemResult.getString("item_name")%>>See More</button>
						</form>
					<br>
					</div>
				  <% 
				}
			}else{
				out.print("<h1>Athletic</h1><hr>");
				ResultSet result2 = stmtrb.executeQuery(str2);
				ResultSet result3 = stmtrs.executeQuery(str3);
				while(result.next()){
					 %>
						 <%
						 	//getting item details for the auction
						 	String itemDetail = "SELECT * FROM item WHERE item_number = "+result.getString("item_number")+"";
						 	//<h2>Active Auctions</h2>
						 	ResultSet itemResult = stmt2.executeQuery(itemDetail);
						 	itemResult.next();
						 %>
						 				 
					<div>
					<h2><%=result.getString("title")%></h2>
					<hr>
					<h4><%=itemResult.getString("item_name")%></h4>
					<br>
				 	<br>
						<form method="post" action="itemView.jsp">
						<input type="hidden" name="auctionNum" value=<%=result.getString("auction_number")%>> 
						<input type="hidden" name="itemNum" value=<%=itemResult.getString("item_number")%>> 
						<button type="submit" value=<%=itemResult.getString("item_name")%>>See More</button>
						</form>
					<br>
					</div>
					  <% 
					}
				out.print("<h1>Business</h1><hr>");
				while(result2.next()){
					 %>
						 <%
						 	Statement stmtb = con.createStatement();
						 	//getting item details for the auction
						 	String itemDetail2 = "SELECT * FROM item WHERE item_number = "+result2.getString("item_number")+"";
						 	//<h2>Active Auctions</h2>
						 	ResultSet itemResult2 = stmtb.executeQuery(itemDetail2);
						 	itemResult2.next();
						 %>
						 			
						 
					<div>
					<h2><%=result2.getString("title")%></h2>
					<hr>
					<h4><%=itemResult2.getString("item_name")%></h4>
					<br>
				 	<br>
						<form method="post" action="itemView.jsp">
						<input type="hidden" name="auctionNum" value=<%=result2.getString("auction_number")%>> 
						<input type="hidden" name="itemNum" value=<%=itemResult2.getString("item_number")%>> 
						<button type="submit" value=<%=itemResult2.getString("item_name")%>>See More</button>
						</form>
					<br>
					</div>
					  <% 
					}
				out.print("<h1>Sandals</h1><hr>");
				while(result3.next()){
					 %>
						 <%
							Statement stmts = con.createStatement();
						 	//getting item details for the auction
						 	String itemDetail3 = "SELECT * FROM item WHERE item_number = "+result3.getString("item_number")+"";
						 	//<h2>Active Auctions</h2>
						 	ResultSet itemResult3 = stmts.executeQuery(itemDetail3);
						 	itemResult3.next();
						 %>
						 				 
					<div>
					<h2><%=result3.getString("title")%></h2>
					<hr>
					<h4><%=itemResult3.getString("item_name")%></h4>
					<br>
				 	<br>
						<form method="post" action="itemView.jsp">
						<input type="hidden" name="auctionNum" value=<%=result3.getString("auction_number")%>> 
						<input type="hidden" name="itemNum" value=<%=itemResult3.getString("item_number")%>> 
						<button type="submit" value=<%=itemResult3.getString("item_name")%>>See More</button>
						</form>
					<br>
					</div>
					  <% 
					}

				
			}
			//close the connection.
			con.close();

		} catch (Exception e) {
		}
		%>
	</div>

</body>
</html>