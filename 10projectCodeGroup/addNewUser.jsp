<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.auctionSite.pkg.*"%>
<!--Import some libraries that have classes that we need -->
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

		//Get parameters from the HTML form at the HelloWorld.jsp
		String newCreditCard = request.getParameter("CreditCardInfo");
		String newEmail = request.getParameter("email");	
		String newAddress = request.getParameter("Address");
		String newPassword = request.getParameter("password");
		String newName = request.getParameter("name");

		//Make an insert new User into the User table:
		String insert = "INSERT INTO Customer(creditCardNumber, email, Address, password, name)"
				+ "VALUES (?, ?, ?, ?, ?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, newCreditCard);
		ps.setString(2, newEmail);
		ps.setString(3, newAddress);
		ps.setString(4, newPassword);
		ps.setString(5, newName);
		
		//Customer(credit card number varchar(50), email varchar(50), Address varchar(50), password varchar(50), primary key(email))
		//Run the query against the DB
		ps.executeUpdate();
		
		String insert_buyer = "INSERT INTO Buyer(creditCardNumber, email, Address, password)" + "VALUES (?, ?, ?, ?)";
		String insert_seller = "INSERT INTO Seller(creditCardNumber, email, Address, password)" + "VALUES (?, ?, ?, ?)";
		
		ps = con.prepareStatement(insert_buyer);
		
		ps.setString(1, newCreditCard);
		ps.setString(2, newEmail);
		ps.setString(3, newAddress);
		ps.setString(4, newPassword);
		
		ps.executeUpdate();
		
		ps = con.prepareStatement(insert_seller);
		
		ps.setString(1, newCreditCard);
		ps.setString(2, newEmail);
		ps.setString(3, newAddress);
		ps.setString(4, newPassword);
		
		int result = ps.executeUpdate();
		

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

		response.sendRedirect("login.jsp");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Account Creation Unsuccessful");
	}
%>
</body>
</html>