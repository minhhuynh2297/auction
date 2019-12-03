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

	<% 
	
	try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			String q1 = "SELECT * from Question WHERE question_id = "+request.getParameter("questionid")+"";
			Statement stmt3 = con.createStatement();
			
			//Run the query against the database.
			ResultSet questionResult = stmt.executeQuery(q1);
			questionResult.next();
			%>
				
				<h2> <%=questionResult.getString("text") %></h2>
					
				
			<%  
					String temp = questionResult.getString("answer"); 
			        String question_id=questionResult.getString("question_id");
					
			if(temp == null){
				temp="No answer yet";
				out.print(temp);
			}
			else{    
					
				out.print(temp);

				
			}

			String isRep = (String)session.getAttribute("isRep");
			String current_user = (String)session.getAttribute("email");
			if(isRep.equals("true")){

				%>
				<hr>
				<h2 style="color:red;">Answer Question</h2>
				<form action="answer.jsp">
				<textarea name="answer"></textarea> 
					<input type="hidden" name="question_id" value="<%=question_id%>" >
					<button type="submit">Answer</button>
				</form>
				<%
				
				
				
			}

				%> 
		
										
						
				
				<!-- BID HTML -->

			<% 
						
		} catch (Exception e) {
		}
	%>

</body>
</html>