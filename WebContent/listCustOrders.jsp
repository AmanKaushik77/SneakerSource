<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
<link rel="stylesheet" href="styles.css">
</head>
<body  >
<%@ include file="header.jsp" %>
<br>
<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
String userName = (String) session.getAttribute("authenticatedUser");

String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String userN = "SA";
String pw = "304#sa#pw";
try(Connection conn = DriverManager.getConnection(url,userN,pw);
Statement stmt = conn.createStatement();){

String sql = "SELECT O.orderId, C.customerId, C.firstname, C.lastname, O.totalAmount FROM orderSummary O JOIN customer C ON O.customerId = C.customerId WHERE C.userid = ?";
PreparedStatement prep = conn.prepareStatement(sql);
prep.setString(1, userName);	
ResultSet rst = prep.executeQuery();

String sql2 = "SELECT productId, quantity, price FROM orderProduct WHERE orderId = ?";
PreparedStatement prep2 = conn.prepareStatement(sql2);
out.println("<table border='1'style='background-color: #581845 ;width:50%;'><tr style='color: beige;'><th>Order Id</th><th>Customer Id</th><th>Customer Name</th><th>Total Amount</th>");

while(rst.next()){
	out.println("<tr style='color: beige;'><td>"+rst.getInt(1)+"</td><td>"+rst.getInt(2)+"</td><td>"+rst.getString(3)+" "+rst.getString(4)+"</td><td>"+ "$" + rst.getDouble(5)+"</td></tr>");
	
	prep2.setInt(1,rst.getInt(1));
	ResultSet rst2 = prep2.executeQuery();
	out.println("<tr style='color: beige;'><td colspan='5'><table border='1' ><th>Product Id</th><th>Quantity</th><th>Price</th>");
	while(rst2.next()){
		out.println("<tr style='color: beige;'><td>"+rst2.getInt(1)+"</td><td>"+rst2.getInt(2)+"</td><td>"+"$" + rst2.getDouble(3)+"</td></tr>");
	}
	out.println("</table>");
}
out.println("</table>");
conn.close();
}catch (SQLException e){
	//System.out.println(e);
	out.println("<h1>Error</h1>");
	out.println(e);
}
// Write query to retrieve all order summary records

// For each order in the ResultSet

	// Print out the order summary information
	// Write a query to retrieve the products in the order
	//   - Use a PreparedStatement as will repeat this query many times
	// For each product in the order
		// Write out product information 

// Close connection

%>