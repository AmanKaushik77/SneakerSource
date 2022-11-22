<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order Processing</title>
</head>
<body>

<% 
// Get customer id
String custId = request.getParameter("customerId");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

// Determine if valid customer id was entered
// Determine if there are products in the shopping cart
// If either are not true, display an error message

// Make connection
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String user = "SA";
String pw = "304#sa#pw";
try(Connection conn = DriverManager.getConnection(url,user,pw);
	Statement stmt = conn.createStatement();){
	boolean used = false;
	String sql = "SELECT customerId FROM customer";
	String sql2 = "SELECT address, city, state, postalcode, country FROM customer WHERE customerId = ?";

	ResultSet rs = stmt.executeQuery(sql);
		while(rs.next()){
			if(custId.equals(rs.getInt(1))){
				if(productList != null){
					used = true;
					out.println("<h1>Shopping cart is empty</h1>");
					conn.close();
				}
			}else if(custId.equals(rs.getInt(1))){
				out.println("<h1>Invalid ID, please try again</h1>");
				conn.close();
			}
		}
		
			out.println("<h1>Your Order Summary</h1>");
			//PreparedStatement pstmt = con.prepareStatement(sql2, Statement.RETURN_GENERATED_KEYS);			
			//ResultSet keys = pstmt.getGeneratedKeys();
			//keys.next();
			//int orderId = keys.getInt(1);
			
			
		conn.close();
}catch(Exception e){
	out.println(e);
}
// Save order information to database


	/*
	// Use retrieval of auto-generated keys.
	
	*/

// Insert each item into OrderProduct table using OrderId from previous INSERT

// Update total amount for order record

// Here is the code to traverse through a HashMap
// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price

/*
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext())
	{ 
		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		String productId = (String) product.get(0);
        String price = (String) product.get(2);
		double pr = Double.parseDouble(price);
		int qty = ( (Integer)product.get(3)).intValue();
            ...
	}
*/

// Print out order summary

// Clear cart if order placed successfully
%>
</BODY>
</HTML>

