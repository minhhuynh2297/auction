<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.auctionSite.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>reportView</title>
</head>
<body>

<h1>Report:</h1>

<%

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			String type = request.getParameter("type");				

			if(type.equals("totalEarnings")){
				Statement stmt = con.createStatement();
				//String str = "SELECT SUM(a.amount)AS earnings FROM (SELECT MAX(cs336.Bids.amount) AS amount FROM cs336.Bids GROUP BY cs336.Bids.auction_number) AS a";
				String str = "SELECT SUM(earnings) as earnings from Seller";
				ResultSet result = stmt.executeQuery(str);
				result.next();
				out.print("Total Earnings: "+result.getDouble("earnings"));				

				
			}
			else if(type.equals("earningsPerItem")){
				out.print("Earnings Per Item(Brand/Model)");
				Statement stmt = con.createStatement();
				//String str = "SELECT C.brand, C.model, SUM(C.amount) FROM(SELECT brand, model, B.item_number, B.amount, B.auction_number FROM cs336.item INNER JOIN (SELECT item_number, A.amount, cs336.Auction.auction_number FROM cs336.Auction INNER JOIN (SELECT MAX(amount) as amount, auction_number FROM cs336.Bids GROUP BY auction_number) as A WHERE A.auction_number = cs336.Auction.auction_number) as B WHERE cs336.item.item_number = B.item_number) as C GROUP BY C.brand, C.model";
				String str = "SELECT C.brand, C.model, SUM(C.amount)"+
				" FROM"+
				" (SELECT brand, model, B.item_number, B.amount, B.auction_number"+
				" FROM cs336.item"+
				" INNER JOIN"+
				" (SELECT item_number, A.amount, cs336.Auction.auction_number"+
				" FROM cs336.Auction"+
				" INNER JOIN"+
				" (SELECT MAX(amount) as amount, auction_number"+
				" FROM cs336.Bids"+
				" GROUP BY auction_number) as A"+
				" WHERE A.auction_number = cs336.Auction.auction_number AND cs336.Auction.closed=1) as B"+
				" WHERE cs336.item.item_number = B.item_number) as C"+
				" GROUP BY C.brand, C.model";
				
				
				ResultSet result = stmt.executeQuery(str);
				%>
				<table>
					<tr>
					    <th>Brand</th>
					    <th>Model</th>
					    <th>Earnings</th>
					</tr>
				<% 
				while(result.next()){
					%>
					<tr>
					    <td><%=result.getString("brand")%></td>
					    <td><%=result.getString("model")%></td>
					    <td><%=result.getString("SUM(C.amount)")%></td>
					</tr>
					<%
				}
				
				%></table><% 
			}
			else if(type.equals("earningsPerItemType")){
				
				
				Statement stmt1 = con.createStatement();
				Statement stmt2 = con.createStatement();
				Statement stmt3 = con.createStatement();
				
				//String str1 = "SELECT SUM(B.amount)FROM (SELECT MAX(cs336.Bids.amount) as amount FROM cs336.Bids INNER JOIN (SELECT auction_number as auction_number FROM cs336.Auction INNER JOIN cs336.Athletic WHERE cs336.Auction.item_number = cs336.Athletic.item_number) as A WHERE cs336.Bids.auction_number = A.auction_number GROUP BY cs336.Bids.auction_number) as B";
				//String str2 = "SELECT SUM(B.amount)FROM (SELECT MAX(cs336.Bids.amount) as amount FROM cs336.Bids INNER JOIN (SELECT auction_number as auction_number FROM cs336.Auction INNER JOIN cs336.Business WHERE cs336.Auction.item_number = cs336.Business.item_number) as A WHERE cs336.Bids.auction_number = A.auction_number GROUP BY cs336.Bids.auction_number) as B";
				//String str3 = "SELECT SUM(B.amount)FROM (SELECT MAX(cs336.Bids.amount) as amount FROM cs336.Bids INNER JOIN (SELECT auction_number as auction_number FROM cs336.Auction INNER JOIN cs336.Sandal WHERE cs336.Auction.item_number = cs336.Sandal.item_number) as A WHERE cs336.Bids.auction_number = A.auction_number GROUP BY cs336.Bids.auction_number) as B";

				String str1 ="SELECT SUM(B.amount)"+
						" FROM"+
						" (SELECT MAX(cs336.Bids.amount) as amount "+
						" FROM cs336.Bids"+
						" INNER JOIN"+
						" (SELECT auction_number as auction_number, closed"+
						" FROM cs336.Auction"+
						" INNER JOIN cs336.Athletic"+
						" WHERE cs336.Auction.item_number = cs336.Athletic.item_number) as A"+
						" WHERE cs336.Bids.auction_number = A.auction_number AND A.closed = 1"+
						" GROUP BY cs336.Bids.auction_number) as B";
				String str2 ="SELECT SUM(B.amount)"+
						" FROM"+
						" (SELECT MAX(cs336.Bids.amount) as amount "+
						" FROM cs336.Bids"+
						" INNER JOIN"+
						" (SELECT auction_number as auction_number, closed"+
						" FROM cs336.Auction"+
						" INNER JOIN cs336.Business"+
						" WHERE cs336.Auction.item_number = cs336.Business.item_number) as A"+
						" WHERE cs336.Bids.auction_number = A.auction_number AND A.closed = 1"+
						" GROUP BY cs336.Bids.auction_number) as B";
				String str3 ="SELECT SUM(B.amount)"+
						" FROM"+
						" (SELECT MAX(cs336.Bids.amount) as amount "+
						" FROM cs336.Bids"+
						" INNER JOIN"+
						" (SELECT auction_number as auction_number, closed"+
						" FROM cs336.Auction"+
						" INNER JOIN cs336.Sandal"+
						" WHERE cs336.Auction.item_number = cs336.Sandal.item_number) as A"+
						" WHERE cs336.Bids.auction_number = A.auction_number AND A.closed = 1"+
						" GROUP BY cs336.Bids.auction_number) as B";
				
				
				ResultSet resultAthletic = stmt1.executeQuery(str1);
				ResultSet resultBuisness = stmt2.executeQuery(str2);
				ResultSet resultSandal = stmt3.executeQuery(str3);

				resultAthletic.next();
				resultBuisness.next();
				resultSandal.next();
				
				out.print("Earnings for Athletic Shoes: "+resultAthletic.getDouble("SUM(B.amount)"));
				%><br><% 
				out.print("Earnings for Buisness Shoes: "+resultBuisness.getDouble("SUM(B.amount)"));
				%><br><% 
				out.print("Earnings for Sandals: "+resultSandal.getDouble("SUM(B.amount)"));


				
				
			}
			else if(type.equals("earningsPerEndUser")){
				
				//"SELECT
				
				Statement stmt = con.createStatement();
				//String str = "SELECT SUM(A.amount), A.email FROM (SELECT MAX(amount) as amount, auction_number, cs336.Bids.email as email FROM cs336.Bids INNER JOIN cs336.Seller WHERE cs336.Bids.email = cs336.Seller.email GROUP BY auction_number) as A GROUP BY A.email";
				String str = "SELECT earnings, email FROM Seller ORDER BY earnings DESC";
				ResultSet result = stmt.executeQuery(str);
				%>
				<table>
					<tr>
					    <th>User</th>
					    <th>Earnings</th>
					</tr>
				<% 
				while(result.next()){
					%>
					<tr>
					    <td><%=result.getString("email")%></td>
					    <td><%=result.getString("earnings")%></td>
					</tr>
					<%
				}
				
				%></table><% 
				
				
				
			}
			else if(type.equals("bestSellingItems")){
				out.print("Best Selling Items");
				Statement stmt = con.createStatement();
				//String str = "SELECT C.brand, C.model, SUM(C.amount) FROM (SELECT brand, model, B.item_number, B.amount, B.auction_number FROM cs336.item INNER JOIN (SELECT item_number, A.amount, cs336.Auction.auction_number FROM cs336.Auction INNER JOIN (SELECT MAX(amount) as amount, auction_number FROM cs336.Bids GROUP BY auction_number) as A WHERE A.auction_number = cs336.Auction.auction_number) as B WHERE cs336.item.item_number = B.item_number) as C GROUP BY C.brand, C.model ORDER BY SUM(C.amount) DESC";
				String str = "SELECT C.brand, C.model, SUM(C.amount)"+
							" FROM"+
							" (SELECT brand, model, B.item_number, B.amount, B.auction_number"+
							" FROM cs336.item"+
							" INNER JOIN"+
							" (SELECT item_number, A.amount, cs336.Auction.auction_number"+
							" FROM cs336.Auction"+
							" INNER JOIN"+
							" (SELECT MAX(amount) as amount, auction_number"+
							" FROM cs336.Bids"+
							" GROUP BY auction_number) as A"+
							" WHERE A.auction_number = cs336.Auction.auction_number AND cs336.Auction.closed = 1) as B"+
							" WHERE cs336.item.item_number = B.item_number) as C"+
							" GROUP BY C.brand, C.model"+
							" ORDER BY SUM(C.amount) DESC";
				ResultSet result = stmt.executeQuery(str);
				%>
				<table>
					<tr>
					    <th>Brand</th>
					    <th>Model</th>
					    <th>Earnings</th>
					</tr>
				<% 
				while(result.next()){
					%>
					<tr>
					    <td><%=result.getString("brand")%></td>
					    <td><%=result.getString("model")%></td>
					    <td><%=result.getString("SUM(C.amount)")%></td>
					</tr>
					<%
				}
				
				%></table><% 
			}
			else if(type.equals("bestBuyers")){
				out.print("Best buyers");
				Statement stmt = con.createStatement();
				String str = "SELECT email, num_purchases FROM cs336.Buyer ORDER BY num_purchases DESC";
				
				ResultSet result = stmt.executeQuery(str);
				%>
				<table>
					<tr>
					    <th>Email</th>
					    <th>Number of Purchases</th>
					</tr>				<% 
				while(result.next()){
					%>
					<tr>
					    <td><%=result.getString("email")%></td>
					    <td><%=result.getString("num_purchases")%></td>
					</tr>
					<%
				}
				
				%></table><% 
				
			}

			
			//ResultSet result = stmt.executeQuery(str);

			con.close();

		} catch (Exception e) {
		}
	%>




</body>
</html>