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
	
%>

<%

// TODO: Print Customer information
String sql = "SELECT * FROM customer WHERE userId = ?";
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
		out.println("<table style='background-color: #581845 ;width:50%;'  class=\"table\" border=\"1\">");
		out.println("<tr ><th>Id</th><td>"+rst.getString(1)+"</td></tr>");	
		out.println("<tr ><th>First Name</th><td>"+rst.getString(2)+"</td></tr>");
		out.println("<tr><th>Last Name</th><td>"+rst.getString(3)+"</td></tr>");
		out.println("<tr ><th>Email</th><td>"+rst.getString(4)+"</td></tr>");
		out.println("<tr ><th>Phone</th><td>"+rst.getString(5)+"</td></tr>");
		out.println("<tr ><th>Address</th><td>"+rst.getString(6)+"</td></tr>");
		out.println("<tr ><th>City</th><td>"+rst.getString(7)+"</td></tr>");
		out.println("<tr ><th>State</th><td>"+rst.getString(8)+"</td></tr>");
		out.println("<tr ><th>Postal Code</th><td>"+rst.getString(9)+"</td></tr>");
		out.println("<tr ><th>Country</th><td>"+rst.getString(10)+"</td></tr>");
		out.println("<tr ><th>User id</th><td>"+rst.getString(11)+"</td></tr>");		
		out.println("</table>");
	}
	out.println("<li ><a style = 'background-color: #FFC000; color:black;' href='changeUserId.jsp' >Change userID</a></h4>");
	out.println("<li><a style = 'background-color: #FFC000; color:black;' href='changepass.jsp' >Change password</a></h4>");
	out.println("<li><a style = 'background-color: #FFC000; color:black;' href= 'listCustOrders.jsp'> Show my orders!</a></h2>");
	conn.close();
	}catch (SQLException e){
		out.println(e);
	}
// Make sure to close connection
%>

</body>
</html>

