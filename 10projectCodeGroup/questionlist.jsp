<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.auctionSite.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Question Board</title>
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

<div class="content">
	<h1>View Questions:</h1>
	<hr>
	<br>
	<form method="post" action="questionlist.jsp">
  
	
	<label>Search</label>
	<input type="text" name="Search">
	

	<button type="submit" value="search">Search</button>
	<br>
</form>
	<%
		//List<String> list = new ArrayList<String>();
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			String search = request.getParameter("Search");
			//out.print(search);
			Statement stmt = con.createStatement();
			Statement stmt2 = con.createStatement();
			String str;
			if(search == null){
			 str = "SELECT * from Question";
			}
			else{
				 str = "SELECT *  FROM Question WHERE text Like '%"+search+"%'";
					//out.print(search);

				
			}
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			while(result.next()){
			 %>
			
				<div class = "question">
				<label><%= result.getString("text") %></label> 			
					 	<br>
					<form method="post" action="questionview.jsp">
					
					<input type="hidden" name="questionid" value=<%=result.getString("question_id")%>> 
					<hr>
					<button type="submit" value="Go")>View Question</button>
					
					</form>

				</div>

			  <% 
			}
		
			//close the connection.
			con.close();
		} catch (Exception e) {
		}
		%>
	
	</div>
</body>
</html>