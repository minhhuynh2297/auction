<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>List Item</title>
<link rel="stylesheet" type="text/css" href="CSS/list_item.css">
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

    <form method="post" action="list_item.jsp">
    <h1>Auction Creation:</h1>
        <div class="title_field">
            <label>Title:</label>
            <input type="text" name="title">
        </div>

        <div>
            <label>Brand:</label>
            <input type="text" name="brand" required="">
            <label class="model">Model:</label>
            <input type="text" name="model" required="">

            <label class="min">Hidden Minimum:</label>
            <input type="number" name="minimum" step="0.01" min="0" required="">
            
            <label class="min">Increment:</label>
            <input type="number" name="increment" step="0.01" min="0" required="">
        </div>

        <div>
            <label>Description:</label>
            <textarea name="description"></textarea>
            
            <h3>Tags</h3>
            <hr>
            <p>Tags will be used for interest searches later.</p>   
            <label>Tag One:</label>
            <input type="text" name="tag1" required="" placeholder=" Write something short and descriptive." maxlength = "20">
            <label>Tag Two:</label>
            <input type="text" name="tag2" required="" placeholder=" Write something short and descriptive." maxlength = "20">
            <label>Tag Three:</label>
            <input type="text" name="tag3" required="" placeholder=" Write something short and descriptive." maxlength = "20">
        </div>

        <div>
            <label class="cat">Athletic</label>
            <input type="radio" required="" value="Athletic" name="category">

        </div>

        <div>
            <label class="cat">Business</label>
            <input type="radio" required="" value="Business" name="category">
        </div>

        <div>
            <label class="cat">Sandal</label>
            <input type="radio" required="" value="Sandal" name="category">
        </div>
        
        <div>
        	<label class="color">Color:</label>
        	<input class="color" type="text" required="" name="color" default="N/A">
        </div>
        
        <div>
        <label class="sel">Size:</label>
        	<select name="size">
        		<option value="N/A">N/A</option>
  				<option value="5">5</option>
  				<option value="5-1/2">5-1/2</option>
  				<option value="6">6</option>
  				<option value="6-1/2">6-1/2</option>
  				<option value="7">7</option>
  				<option value="7-1/2">7-1/2</option>
  				<option value="8">8</option>
  				<option value="8-1/2">8-1/2</option>
  				<option value="9">9</option>
  				<option value="9-1/2">9-1/2</option>
  				<option value="10">10</option>
  				<option value="10-1/2">10-1/2</option>
  				<option value="11">11</option>
  				<option value="11-1/2">11-1/2</option>
  				<option value="12">12</option>
  				<option value="12-1/2">12-1/2</option>
  				<option value="13">13</option>
  				<option value="13-1/2">13-1/2</option>
  				<option value="14">14</option>
		</select>
        </div>

        <div>
            <label>Start Time/Date:</label>
            <input type="date" required="" name="start_date">
            <input type="time" required="" name="start_time"> 
        </div>
   		
        <div>
            <label>End Time/Date:</label>
            <input type="date" required="" name="end_date">
            <input type="time" required="" name="end_time"> 
        </div>

        <div>
            <button type="submit">Confirm</button>
            <hr>
            <a href="login.jsp">
            	<input type="button" value="Cancel"> 
            </a>
        </div>
    </form>

</body>
</html>