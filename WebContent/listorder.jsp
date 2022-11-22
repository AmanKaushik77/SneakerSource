<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order List</title>
</head>
<body>

<h1>Order List!</h1>

<% 
//Note: Forces loading of SQL Server driver

try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00

// Make connection
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String user = "SA";
String pw = "304#sa#pw";
try(Connection conn = DriverManager.getConnection(url,user,pw);
Statement stmt = conn.createStatement();){

String sql = "SELECT O.orderId, C.customerId, C.firstname, C.lastname, O.totalAmount FROM orderSummary O JOIN customer C ON O.customerId = C.customerId";
ResultSet rst = stmt.executeQuery(sql);
String sql2 = "SELECT productId, quantity, price FROM orderProduct WHERE orderId = ?";
PreparedStatement prep = conn.prepareStatement(sql2);
out.println("<table border='1' style='background-color:beige;'><tr style='color: maroon;'><th>Order Id</th><th>Customer Id</th><th>Customer Name</th><th>Total Amount</th>");

while(rst.next()){
	out.println("<tr style='color: maroon;'><td>"+rst.getInt(1)+"</td><td>"+rst.getInt(2)+"</td><td>"+rst.getString(3)+" "+rst.getString(4)+"</td><td>"+ "$" + rst.getDouble(5)+"</td></tr>");
	
	prep.setInt(1,rst.getInt(1));
	ResultSet rst2 = prep.executeQuery();
	out.println("<tr style='color: maroon;'><td colspan='5'><table border='1' ><th>Product Id</th><th>Quantity</th><th>Price</th>");
	while(rst2.next()){
		out.println("<tr style='color: maroon;'><td>"+rst2.getInt(1)+"</td><td>"+rst2.getInt(2)+"</td><td>"+"$" + rst2.getDouble(3)+"</td></tr>");
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

</body>
</html>

