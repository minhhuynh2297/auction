<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.auctionSite.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<h2>Displaying Similar Auctions</h2>
	
	<%
		//out.print(request.getParameter("tag1")+"\n");
		//out.print(request.getParameter("tag2")+"\n");
		//out.print(request.getParameter("tag3")+"\n");
		String t1,t2,t3;
		t1 = request.getParameter("tag1");
		t2 = request.getParameter("tag2");
		t3 = request.getParameter("tag3");
	%>
	
	
		<%

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			Statement stmt2 = con.createStatement();
			//deterining if a sort has been input, sorting if necessary
			
			//String str = "SELECT DISTINCT* FROM Auction where item_number in ((SELECT item_number from item where tag1 = '%"+t1+"%' OR tag2 = '"+t1+"' OR tag3 = '"+t1+"') UNION (SELECT item_number from item where tag1 = '"+t2+"' OR tag2 = '"+t2+"' OR tag3 = '"+t2+"') UNION (SELECT item_number from item where tag1 = '"+t3+"' OR tag2 = '"+t3+"' OR tag3 = '"+t3+"'))";
			String str = "SELECT DISTINCT* FROM Auction where item_number in ((SELECT item_number from item where (tag1 LIKE '"+t1+"' OR tag1 LIKE '"+t1+"' OR tag1 LIKE '"+t1+"')OR (tag2 LIKE '"+t2+"' OR tag2 LIKE '"+t2+"' OR tag2 LIKE '"+t2+"') OR (tag3 LIKE '"+t3+"' OR tag3 LIKE '"+t3+"' OR tag3 LIKE '"+t3+"')))";
			//String str = "SELECT * FROM Auction";
			//out.print(str);
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			
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
				}
		
			//close the connection.
			con.close();

		} catch (Exception e) {
		}
		%>
</body>
</html>