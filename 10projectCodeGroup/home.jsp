<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.auctionSite.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Home Page</title>
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
        
     <div class = "content2">
        <%
        	
    	try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
        
        	
  
        		
        		
        	
        		
        		String q = "SELECT * FROM Customer WHERE email = '"+session.getAttribute("email")+"'";
        		String name = "",address="",credit="",password="";
    			Statement stmt = con.createStatement();
    			ResultSet result = stmt.executeQuery(q);
    			
    			result.next();
    			name = result.getString("name");
    			address =  result.getString("Address");
    			credit =  result.getString("creditCardNumber");
    			password =  result.getString("password");
    			String email = (String)session.getAttribute("email");
        		
				%>
				<div>
	        		<form method="post" action="list_item_view.jsp">
	        		<button type="submit" value="Create An Auction">Create An Auction</button>
	        		</form>
				</div>
				
				<div>
	        		<form method="post" action="auctionList.jsp">
	        		<button type="submit" value="View Active Auctions">View Active Auctions</button>
	        		</form>
				</div>
				
				<div>
	        		<form method="post" action="questionlist.jsp">
	        		<button type="submit" value="View Asked Questions">View Asked Questions</button>
	        		</form>
				</div>
				
				<div>
			
	        		<form method="post" action="question.jsp">
	        		<button type="submit" value="Ask A Question">Ask A Question</button>
	        		</form>
	        	</div>
	        	
				<div>
			
	        		<form method="post" action="setIntrest.jsp">
	        		<button type="submit" value="Set Alerts For Items You Are Insterested In">Set Alerts For Items You Are Interested In</button>
	        		</form>
				</div>
				
				<div>
	        		<form method="post" action="messages.jsp">
	        		<button type="submit" value="View Your Messages">View Your Messages</button>
	        		</form>
				</div>
				
				<div>
	        		<form method="post" action="account_view.jsp">
	        		<input type = "hidden" name = "email" value = <%=email%>>
	        		<input type = "hidden" name = "name" value = <%=name%>>
	        		<input type = "hidden" name = "address" value = <%=address%>>
	        		<input type = "hidden" name = "credit_info" value = <%=credit%>>
	        		<input type = "hidden" name = "password" value = <%=password%>>
	        		<button type="submit" value="View Your Account">View Your Account</button>
	        		</form>
				</div>
				<%
				
        	
        	
        	con.close();

		} catch (Exception e) {
		}
        %>
    </div>
</body>
</html>