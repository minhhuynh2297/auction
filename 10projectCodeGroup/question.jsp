<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>List Item</title>
<link rel="stylesheet" type="text/css" href="CSS/question.css">
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

    <form method="post" action="questiondb.jsp">
    <h1>Ask a question</h1>
        <div class="title_field">
            <label>What do you need to know?</label>
            <p>
            <input type="text" name="Question">
        </div>
<div>
            <button type="submit">Confirm</button>
            <hr>
            <a href="auctionList.jsp">
            	<input type="button" value="Cancel"> 
            </a>
        </div>

    </form>

</body>
</html>