<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body style = 'background-color:#D03D56;'>
<%@ include file="../auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<%
// TODO: Include files auth.jsp and jdbc.jsp
String userName = (String) session.getAttribute("authenticatedUser");
%>
<%
// TODO: Write SQL query that prints out total order amount by day
String sql = "SELECT year(orderDate), month(orderDate), day(orderDate), SUM(totalAmount) FROM OrderSummary GROUP BY year(orderDate), month(orderDate), day(orderDate)";
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String user = "SA";
String pw = "304#sa#pw";
String pId = request.getParameter("id");
try(Connection conn = DriverManager.getConnection(url,user,pw);
    Statement stmt = conn.createStatement();){
    ResultSet rs = stmt.executeQuery(sql);
    out.println("<table style = 'background-color:white;'  class=\"table\" border=\"1\">");
    out.println("<tr><th>Order Date</th><th>Total Order Amount</th>");
    while (rs.next()){
        out.println("<tr><td>"+rs.getString(1)+"-"+rs.getString(2)+"-"+rs.getString(3)+"</td><td>"+"$"+rs.getDouble(4)+"</td></tr>");
    }
    out.println("</table>");
    conn.close();
}catch (SQLException e){
    out.println(e);
}


%>

</body>
</html>

