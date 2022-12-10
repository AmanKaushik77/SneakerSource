<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="styles.css">
<title>Login Screen</title>
<%@ include file="header.jsp" %>

<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
</head>

<body >
<%
    out.println("<form name='form1'>");
    out.println("<h2 align = center> Enter your username:<input type = 'text' name = 'userName'> </h2>");
    out.println("<h2 align = center> Enter your email: <input type = 'text' name = 'email'></h2>");
    out.println("<tr><td><input  class='submit' type='submit' name='Submit2' value='Submit'></td>");
    out.println("</form>");
    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String userN = "SA";
    String pw = "304#sa#pw";
    try(Connection conn = DriverManager.getConnection(url,userN,pw);
    Statement stmt = conn.createStatement();){
        String vUser = request.getParameter("userName");
        String vemail = request.getParameter("email");

        if(vUser != null && vemail != null){
                String sql = "SELECT email, userid, password FROM customer WHERE userid = '" + vUser + "' AND email = '" + vemail + "'";
                ResultSet rs = stmt.executeQuery(sql);
                if(rs.next()){
                    out.println("<h1 align='center'> Valid information given </h1>");
                    out.println("<h2 align='center'> Your Password is: " + rs.getString(3) +" </h2>");
                }
            }
    }catch (SQLException e){
        out.println(e);
    }

%>


</body>