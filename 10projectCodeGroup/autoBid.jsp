<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.auctionSite.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	
	
	<h1>autoBid</h1>
	<%
	try {
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			
			int auction_num = Integer.parseInt(request.getParameter("auctionNum"));
			//out.print("auction num: "+auction_num);
			
			String outBid = "Your have been ou-bid on the auction ["+request.getParameter("auction_title")+"]";
			String autoBid = "You have auto-bid on the auction ["+request.getParameter("auction_title")+"]";
			String outAutobid = "Your upper limit has been out-bid on the auction ["+request.getParameter("auction_title")+"]";
			
			String outBidSub = "Out Bid Notification";
			String autoBidSub = "Auto-bid Notification";
			String outAutobidSub = "Upper-limit Surpassed Notificaiton";
			String smail = "system@buyme.com";
			
			boolean firstBid = false;
			double increment = Double.parseDouble(request.getParameter("increment"));
			
			
			//info for new bid
			double oldUl = 0;
			double newUl = 0;
			double oldAmount;
			String oldEmail = "";
			boolean newAuto = true;
			boolean oldAuto = true;

			try{
				newUl =Double.parseDouble(request.getParameter("upper_limit"));
				//isAuto = true;

			}catch(Exception ex){
				newUl = 0.0;
				newAuto = false;
			}
			//out.print("newUl: "+newUl);
			String newEmail = request.getParameter("current_user");
			//out.print("newEmail: "+newEmail);
			double newAmount = Double.parseDouble(request.getParameter("amount"));
			//out.print("newAmount: "+newAmount);

			//out.print("increment: "+increment);
			//info for old highest bid
			//String q = "SELECT MAX(upper_limit),email,MAX(amount) FROM Bids WHERE auction_number = "+auction_num;
			String q = "SELECT * from Bids WHERE auction_number = "+auction_num+" order by amount desc";
			ResultSet bidResult = stmt.executeQuery(q);
			
			if(bidResult.next()){
				//out.print("inside if");
				oldUl = bidResult.getDouble("upper_limit");
				//out.print("1");

				oldEmail = bidResult.getString("email");
				//out.print("2");

				oldAmount = bidResult.getDouble("amount");
				//out.print("3");

				
				if(oldUl <= 0.0){
					//out.print("old isnt auto");
					oldAuto = false;
				}
			}else{
				//out.print("start else");

				firstBid = true;
				oldAuto = false;
				oldEmail = "no bids";
				oldAmount = -1;
				oldUl = -1;
				//out.print("end else");
			}
			
			//out.print("oldUl: "+oldUl);
			//out.print("oldEmail: "+oldEmail);
			//out.print("oldAmount: "+oldAmount);
			
			//out.print("new auto: "+newAuto);
			//out.print("old auto: "+oldAuto);
			

				

			if(!newAuto/*newUl == 0.0*/){
				if(oldAuto/*oldUl != 0.0*/){
					if(oldUl >= newAmount+increment){
						//out.print("new not auto, old is auto, ould ul higher than new amount");
						
						
						//out.print("Messaging new user");
						//new user outbid
						String q1 = "INSERT INTO Messages (content, email_subject,received_from,sent_to) VALUES (?,?,?,?)";
						PreparedStatement ms1 = con.prepareStatement(q1);
						ms1.setString(1,outBid);
						ms1.setString(2,outBidSub);
						ms1.setString(3,smail);
						ms1.setString(4,newEmail);
						
						ms1.executeUpdate();
						
						//out.print("messaging old user");
						//old user autobid
						String q2 = "INSERT INTO Messages (content, email_subject,received_from,sent_to) VALUES (?,?,?,?)";
						PreparedStatement ms2 = con.prepareStatement(q2);
						ms2.setString(1,autoBid);
						ms2.setString(2,autoBidSub);
						ms2.setString(3,smail);
						ms2.setString(4,oldEmail);
						
						ms2.executeUpdate();
						
						
						//out.print("instering new bid");
						
						//old is auto, new isnt auto, old's ul is higher than bid
						//bid newAmount (newEmail)
						String stmt1 = "INSERT INTO Bids (amount, email, auction_number) VALUES (?,?,?)";
						PreparedStatement ps1 = con.prepareStatement(stmt1);
						ps1.setDouble(1, newAmount);
						ps1.setString(2, newEmail);
						ps1.setDouble(3, auction_num);
						
						ps1.executeUpdate();
						
						
						//out.print("set old bid that was beat to not auto");
						//setting the old bid that will be beat to not auto
						String stmtz = "UPDATE Bids SET upper_limit = ?,isAuto = ? WHERE email = '"+oldEmail+"' AND amount = '"+oldAmount+"' AND auction_number ="+auction_num;
						//out.print(stmt0);
						PreparedStatement u0 = con.prepareStatement(stmtz);
						u0.setDouble(1, 0);
						u0.setInt(2, 0);
						u0.executeUpdate();
						
						//out.print("inserting old auto bid");
						//bid newAmount+1 (oldEmail)
						String stmt2 = "INSERT INTO Bids (amount, email, auction_number, upper_limit,isAuto) VALUES (?,?,?,?,?)";
						PreparedStatement ps2 = con.prepareStatement(stmt2);
						double d = newAmount+increment;
						//double d = newAmount+1.0;
						ps2.setDouble(1, d);
						ps2.setString(2, oldEmail);
						ps2.setDouble(3, auction_num);
						ps2.setDouble(4,oldUl);
						ps2.setBoolean(5,true);

						ps2.executeUpdate();
						
					}else{
						//out.print("new not auto, old is auto, new amount higher than old ul");
						//old bid's ul not high enought to beat new bid
						//set oldBid to not auto
						
						//out.print("messaging old user");
						//old user out auto bid
						String q1 = "INSERT INTO Messages (content, email_subject,received_from,sent_to) VALUES (?,?,?,?)";
						PreparedStatement ms1 = con.prepareStatement(q1);
						ms1.setString(1,outAutobid);
						ms1.setString(2,outAutobidSub);
						ms1.setString(3,smail);
						ms1.setString(4,oldEmail);
						
						ms1.executeUpdate();
						
						//out.print("setting old auto bid to not auto");
						String stmt1 = "UPDATE Bids SET upper_limit = ?,isAuto = ? WHERE email = '"+oldEmail+"' AND amount = '"+oldAmount+"' AND auction_number ="+auction_num;
						PreparedStatement ps1 = con.prepareStatement(stmt1);
						ps1.setDouble(1, 0);
						ps1.setInt(2, 0);
						
						ps1.executeUpdate();
						
						

						
						//out.print("inserting new bid");
						//bid newAmount (newEmail)
						String stmt2 = "INSERT INTO Bids (amount, email, auction_number) VALUES (?,?,?)";
						PreparedStatement ps2 = con.prepareStatement(stmt2);
						ps2.setDouble(1, newAmount);
						ps2.setString(2, newEmail);
						ps2.setDouble(3, auction_num);
						
						ps2.executeUpdate();

					}
				}else{
					
					//out.print("both bids are not auto");
					
					
					//both are not auto, may or maynot be first bid
					
					if(!firstBid){
						//out.print("not the first bid");
						//out.print("message old user they've been outbid");
						//old user outbid
						String q1 = "INSERT INTO Messages (content, email_subject,received_from,sent_to) VALUES (?,?,?,?)";
						PreparedStatement ms1 = con.prepareStatement(q1);
						ms1.setString(1,outBid);
						ms1.setString(2,outBidSub);
						ms1.setString(3,smail);
						ms1.setString(4,oldEmail);	
						
						ms1.executeUpdate();
					}
					
					//out.print("place new bid");
					//place bid normally
					String stmt1 = "INSERT INTO Bids (amount, email, auction_number) VALUES (?,?,?)";
					PreparedStatement ps1 = con.prepareStatement(stmt1);
					ps1.setDouble(1, newAmount);
					ps1.setString(2, newEmail);
					ps1.setDouble(3, auction_num);
					
					ps1.executeUpdate();

				}
				
			//new bid is an auto bid
			}else{
				if(oldAuto/*oldUl != 0.0*/){
					if(oldUl >= newUl){
						//both are auto, old has higher UL
						//out.print("both are auto, old ul is higher than new ul");
						
						//out.print("message new they have been outbid");
						//new user out auto bid
						String q1 = "INSERT INTO Messages (content, email_subject,received_from,sent_to) VALUES (?,?,?,?)";
						PreparedStatement ms1 = con.prepareStatement(q1);
						ms1.setString(1,outAutobid);
						ms1.setString(2,outAutobidSub);
						ms1.setString(3,smail);
						ms1.setString(4,newEmail);
						
						ms1.executeUpdate();
						
						//out.print("message old they have auto bid");
						//old user autobid
						String q2 = "INSERT INTO Messages (content, email_subject,received_from,sent_to) VALUES (?,?,?,?)";
						PreparedStatement ms2 = con.prepareStatement(q2);
						ms2.setString(1,autoBid);
						ms2.setString(2,autoBidSub);
						ms2.setString(3,smail);
						ms2.setString(4,oldEmail);
						
						ms2.executeUpdate();
						
						
						//out.print("set old bid that was beat to not auto");
						//setting the old bid that will be beat to not auto
						String stmt0 = "UPDATE Bids SET upper_limit = ?,isAuto = ? WHERE email = '"+oldEmail+"' AND amount = '"+oldAmount+"' AND auction_number ="+auction_num;
						//out.print(stmt0);
						PreparedStatement ps0 = con.prepareStatement(stmt0);
						ps0.setDouble(1, 0);
						ps0.setInt(2, 0);
						ps0.executeUpdate();
						
						
						//out.print("insert new bid as not auto");
						//bid (newEmail) new amount
						//set new.autobid as false
						String stmt1 = "INSERT INTO Bids (amount, email, auction_number) VALUES (?,?,?)";
						PreparedStatement ps1 = con.prepareStatement(stmt1);
						ps1.setDouble(1, newAmount);
						ps1.setString(2, newEmail);
						ps1.setDouble(3, auction_num);
						
						ps1.executeUpdate();

						//out.print("insert old rebid as auto");
						//bid (oldEmail) as new.ul+1
						String stmt2 = "INSERT INTO Bids (amount, email, auction_number, upper_limit,isAuto) VALUES (?,?,?,?,?)";
						PreparedStatement ps2 = con.prepareStatement(stmt2);
						double d = newUl+increment;
						//double d = newUl+1.0;
						ps2.setDouble(1, d);
						ps2.setString(2, oldEmail);
						ps2.setDouble(3, auction_num);
						ps2.setDouble(4,oldUl);
						ps2.setBoolean(5,true);
						
						ps2.executeUpdate();
						
						
					}else{
						//both are auto, new has higher UL
						//out.print("both are auto, new ul higher than old ul");
						
						
						//out.print("message old user they have been out auto bid");
						//old user out auto bid
						String q1 = "INSERT INTO Messages (content, email_subject,received_from,sent_to) VALUES (?,?,?,?)";
						PreparedStatement ms1 = con.prepareStatement(q1);
						ms1.setString(1,outAutobid);
						ms1.setString(2,outAutobidSub);
						ms1.setString(3,smail);
						ms1.setString(4,oldEmail);
						
						ms1.executeUpdate();
						
						//out.print("message new user they have auto bid");
						//new user autobid
						String q2 = "INSERT INTO Messages (content, email_subject,received_from,sent_to) VALUES (?,?,?,?)";
						PreparedStatement ms2 = con.prepareStatement(q2);
						ms2.setString(1,autoBid);
						ms2.setString(2,autoBidSub);
						ms2.setString(3,smail);
						ms2.setString(4,newEmail);
						
						ms2.executeUpdate();
						
						//out.print("set old auto as false");
						//checked
						//set old.autobid as false
						String stmt1 = "UPDATE Bids SET upper_limit = ?,isAuto = ? WHERE email = '"+oldEmail+"' AND amount = '"+oldAmount+"' AND auction_number ="+auction_num;
						PreparedStatement ps1 = con.prepareStatement(stmt1);
						ps1.setDouble(1, 0);
						ps1.setInt(2, 0);
						ps1.executeUpdate();
						
						
						//out.print("bid new bid as auto");
						//bid (newEmail) as oldUl +1
						//insert into bid (newEmail,newUL,newAmount)
						String stmt2 = "INSERT INTO Bids (amount, email, auction_number, upper_limit,isAuto) VALUES (?,?,?,?,?)";
						PreparedStatement ps2 = con.prepareStatement(stmt2);
						double d = oldUl+increment;
						//double d = oldUl+1.0;
						ps2.setDouble(1, d);
						ps2.setString(2, newEmail);
						ps2.setDouble(3, auction_num);
						ps2.setDouble(4, newUl);
						ps2.setBoolean(5,true);
						
					
						ps2.executeUpdate();

					}
				}else{
					
					
					//out.print("new is auto, old is not");
					///insert new bid normally
					//new is auto, old isnt auto
					
					//out.print("message old theyve been outbid");
					//old has benn out bid
					//new user outbid
					if(!firstBid){
						String q1 = "INSERT INTO Messages (content, email_subject,received_from,sent_to) VALUES (?,?,?,?)";
						PreparedStatement ms1 = con.prepareStatement(q1);
						ms1.setString(1,outBid);
						ms1.setString(2,outBidSub);
						ms1.setString(3,smail);
						ms1.setString(4,oldEmail);	
						
						ms1.executeUpdate();
					}
					
					//out.print("insert new as an auto bid");
					//set is auto to true
					//String stmt1 = "INSERT INTO Bids (amount, email, auction_number, upper_limit,isAuto) VALUES (newAmount,newEmail,auction_num,newUl,1)";
					
					String stmt1 = "INSERT INTO Bids (amount, email, auction_number, upper_limit,isAuto) VALUES (?,?,?,?,?)";
					PreparedStatement ps1 = con.prepareStatement(stmt1);
					ps1.setDouble(1, newAmount);
					ps1.setString(2, newEmail);
					ps1.setDouble(3, auction_num);
					ps1.setDouble(4, newUl);
					ps1.setBoolean(5,true);
					
					ps1.executeUpdate();
					
				}
			}
			
			out.print("Your bid has been placed");
			%>
			<br>
	    		<form method="post" action="auctionList.jsp">
	    		<input type="submit" value="Return to Active Auction List">
	    		</form>
			<br>
			<br>
	    		<form method="post" action="home.jsp">
	    		<input type="submit" value="Return to Home Page">
	    		</form>
			<br>
			<% 
			
			%>
				<!--  
				<jsp:include page="itemView.jsp" flush="true" >
				   <jsp:param name="auctionNum" value="<%=auction_num %>" />	
				   <jsp:param name="itemNum" value="<%=auction_num %>" />
				</jsp:include>
				-->
			<%
			
		} catch (Exception e) {
				}
	%>