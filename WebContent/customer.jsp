<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
</head>
<body style = 'background-color:#D03D56;' >

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
	
%>

<%

// TODO: Print Customer information
String sql = "SELECT * FROM Customer WHERE userId = ?";
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
	String user = "SA";
	String pw = "304#sa#pw";
	
	try(Connection conn = DriverManager.getConnection(url,user,pw);
    	Statement stmt = conn.createStatement();){	
		PreparedStatement prep = conn.prepareStatement(sql);
		prep.setString(1, userName);	
		ResultSet rst = prep.executeQuery();
		out.println("<h1> Customer Information! </h1>");
	if (rst.next()){
		out.println("<table style='background-color:beige;'  class=\"table\" border=\"1\">");
		out.println("<tr style='color: maroon;'><th>Id</th><td>"+rst.getString(1)+"</td></tr>");	
		out.println("<tr style='color: maroon;'><th>First Name</th><td>"+rst.getString(2)+"</td></tr>");
		out.println("<tr style='color: maroon;'><th>Last Name</th><td>"+rst.getString(3)+"</td></tr>");
		out.println("<tr style='color: maroon;'><th>Email</th><td>"+rst.getString(4)+"</td></tr>");
		out.println("<tr style='color: maroon;'><th>Phone</th><td>"+rst.getString(5)+"</td></tr>");
		out.println("<tr style='color: maroon;'><th>Address</th><td>"+rst.getString(6)+"</td></tr>");
		out.println("<tr style='color: maroon;'><th>City</th><td>"+rst.getString(7)+"</td></tr>");
		out.println("<tr style='color: maroon;'><th>State</th><td>"+rst.getString(8)+"</td></tr>");
		out.println("<tr style='color: maroon;'><th>Postal Code</th><td>"+rst.getString(9)+"</td></tr>");
		out.println("<tr style='color: maroon;'><th>Country</th><td>"+rst.getString(10)+"</td></tr>");
		out.println("<tr style='color: maroon;'><th>User id</th><td>"+rst.getString(11)+"</td></tr>");		
		out.println("</table>");
	}
	conn.close();
	}catch (SQLException e){
		out.println(e);
	}
// Make sure to close connection
%>

</body>
</html>

