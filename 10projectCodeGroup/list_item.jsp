<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.auctionSite.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>List Item</title>
</head>
<body>
<%
	try{
		
		// Get the database connection
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		
		// Create SQL Statement
		Statement stmt = con.createStatement();
		
		// Get Session User
		String current_user = (String)session.getAttribute("email");
		
		// Get form entries
		String title = request.getParameter("title");
		String brand = request.getParameter("brand");
		String model = request.getParameter("model");
		double min = Double.parseDouble(request.getParameter("minimum"));
		double increment = Double.parseDouble(request.getParameter("increment"));
		String description = request.getParameter("description");
		String tag1 = request.getParameter("tag1");
		String tag2 = request.getParameter("tag2");
		String tag3 = request.getParameter("tag3");
		String category = request.getParameter("category");
		String start_date = request.getParameter("start_date");
		String start_time = request.getParameter("start_time");
		String end_date = request.getParameter("end_date");
		String end_time = request.getParameter("end_time");
		String size = request.getParameter("size");
		String color = request.getParameter("color");
	
		
		// Convert Strings to Dates
			
		String start_datetime = start_date + " " + start_time;
		String end_datetime = end_date + " " + end_time;
		
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		
		java.util.Date s_date = sdf1.parse(start_datetime);
		java.util.Date e_date = sdf1.parse(end_datetime);
		java.sql.Timestamp sql_start_date = new java.sql.Timestamp(s_date.getTime());
		java.sql.Timestamp sql_end_date = new java.sql.Timestamp(e_date.getTime());
		
		int category_num;
		String table;
		
		if(category.equals("Athletic")){
			category_num = 1;
			table = "Athletic";
		}else if(category.equals("Business")){
			category_num = 2;
			table = "Business";
		}else{
			category_num = 3;
			table = "Sandal";
		}
		
		String insert_item = "INSERT INTO item(seller_email, category_number, item_name, brand, model, description, tag1, tag2, tag3)" + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(insert_item, Statement.RETURN_GENERATED_KEYS);
		
		ps.setString(1, current_user);
		ps.setInt(2, category_num);
		ps.setString(3, title);
		ps.setString(4, brand);
		ps.setString(5, model);
		ps.setString(6, description);
		ps.setString(7, tag1);
		ps.setString(8, tag2);
		ps.setString(9, tag3);
		
		ps.executeUpdate();
		
		ResultSet rs = null;
		rs = ps.getGeneratedKeys();
		
		rs.next();
		int pk = rs.getInt(1);
		
		String insert_category = "INSERT INTO " + table + "(item_number, color, size)" + "VALUES (?, ?, ?)";
		
		ps = con.prepareStatement(insert_category);
		ps.setInt(1, pk);
		ps.setString(2, color);
		ps.setString(3, size);
		
		ps.executeUpdate();
		
		String insert_auction = "INSERT INTO Auction(hidden_minimum, email, title, auction_number, end_date, start_date, item_number, increment)" 
			+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		ps = con.prepareStatement(insert_auction);
		
		ps.setDouble(1, min);
		ps.setString(2, current_user);
		ps.setString(3, title);
		ps.setInt(4, pk);
		ps.setTimestamp(5, sql_end_date);
		ps.setTimestamp(6, sql_start_date);
		ps.setInt(7, pk);
		ps.setDouble(8, increment);
		
		ps.executeUpdate();
		
		
		Statement istmt = con.createStatement();
		String interests = "SELECT email FROM Interest WHERE color LIKE '"+color+"' AND size = '"+size+"' AND (tag LIKE '"+tag1+"'  OR tag LIKE '"+tag2+"' OR tag LIKE '"+tag3+"')";
		ResultSet intrestResult = istmt.executeQuery(interests);
		
		while(intrestResult.next()){
			String interested = intrestResult.getString("email");
			
			String q1 = "INSERT INTO Messages (content, email_subject,received_from,sent_to) VALUES (?,?,?,?)";
			PreparedStatement ms1 = con.prepareStatement(q1);
			String msg = "An item you are interested in is on auction. Auciton Title: "+title;
			String sub = "Item you are insterested in is on sale";
			String smail = "system@buyme.com";
			ms1.setString(1,msg);
			ms1.setString(2,sub);
			ms1.setString(3,smail);
			ms1.setString(4,interested);
			
			ms1.executeUpdate();
		}
		
		
		out.print("Inserted Succesfully!");
		response.sendRedirect("auctionList.jsp");
		
	}catch(Exception ex){
		out.print(ex);
	}
%> 

</body>
</html>