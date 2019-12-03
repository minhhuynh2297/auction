<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.auctionSite.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Search</title>
</head>
<body>
	<h2>User Search</h2>
	<br>
	<form method="post" action="user_search.jsp">
  
	
	<td>Search</td><td><input type="text" name="Email"></td>
	

	<input type="submit" value="search">
	<br>
</form>
	<%
		//List<String> list = new ArrayList<String>();
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			String Email = request.getParameter("Email");
			//out.print(search);
			Statement stmt = con.createStatement();
			Statement stmt2 = con.createStatement();
			String str;
			 //str = "Select Distinct auction_number From Bids WHERE email= '"+Email+"'";
			 
			str= "SELECT * FROM Auction INNER JOIN  (Select Distinct auction_number From Bids WHERE email= '"+Email+"') AS a WHERE Auction.auction_number = a.auction_number";
				//out.print(search);

			
		
		
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(str);
			if(Email == null){
			 
			}
			else{

				while(result.next()){
					%>
					<%
					//getting item details for the auction
					String itemDetail = "SELECT * FROM item WHERE item_number = "+result.getString("item_number")+"";
					//<h2>Active Auctions</h2>
					ResultSet itemResult = stmt2.executeQuery(itemDetail);
					itemResult.next();
					%>


					<br>
					<form method="post" action="itemView.jsp">
					<input type="hidden" name="auctionNum" value=<%=result.getString("auction_number")%>> 
					<input type="hidden" name="itemNum" value=<%=itemResult.getString("item_number")%>> 
					<input type="submit" value=<%=itemResult.getString("item_name")%>>
					</form>
					<br>
					<%
					}}
		
			//close the connection.
			con.close();
		} catch (Exception e) {
		}
		%>
	

</body>
</html>