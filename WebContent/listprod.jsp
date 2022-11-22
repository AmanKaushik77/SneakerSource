<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>SneakerSource</title>
</head>
<body>

<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<% // Get product name to search for
String name = request.getParameter("productName");
		
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Make the connection
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String user = "SA";
String pw = "304#sa#pw";
try(Connection conn = DriverManager.getConnection(url,user,pw);
Statement stmt = conn.createStatement();){
	String sql = "SELECT productId, productName, productPrice FROM product";
	String sql2 = "SELECT productId, productName, productPrice FROM product WHERE productName LIKE ?";
	if(name == null || name.equals("") ){
		out.println("<h1 style = 'background-color: beige; color: maroon'> All Products </h1>");
		ResultSet rs = stmt.executeQuery(sql);
		out.println("<table border='1' style='background-color:beige;'><tr style='color:maroon;'><th></th><th>Product Name</th><th>Price</th>");
			
			while(rs.next()){
				out.println("<tr style='color:maroon'><td><a href = 'addcart.jsp?id= "+rs.getInt(1)+" &name= " +rs.getString(2) +" &price= "+rs.getDouble(3) +"' style = 'color : black;'  > Add to your cart</a> </td> <td>" + rs.getString(2) + "</td><td>"+"$"+ rs.getDouble(3)+"</td></tr>");
			}
			out.println("</table>");
			conn.close();
	}else{
		out.println("<h1 style = 'background-color: beige; color: maroon'> Products containing '"+name+"' </h1>");
		PreparedStatement prep = conn.prepareStatement(sql2);
		prep.setString(1,"%" + name + "%");
		ResultSet rs2 = prep.executeQuery();
		out.println("<table border='1' style='background-color:beige;'><tr style='color:maroon;'><th></th><th>Product Name</th><th>Price</th>");
		while(rs2.next()){ 
			out.println("<tr style='color:maroon'><td><a style = 'color : black;' > Add to your cart</a> </td> <td>" + rs2.getString(2) + "</td><td>"+"$"+ rs2.getDouble(3)+"</td></tr>");
		}
		out.println("</table>");
		conn.close();
	}

}catch(Exception e){
	//out.println(e);
}
// Print out the ResultSet

// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice
// Close connection

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00
%>

</body>
</html>