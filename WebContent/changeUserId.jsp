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
    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String userN = "SA";
    String pw = "304#sa#pw";
    String oldId = (String)session.getAttribute("authenticatedUser");
    out.println("<form name='form1'>");
    out.println("<h2 align = center> Old UserId: " + oldId + "</h2>");
    out.println("<h2 align = center> New UserId: <input type = 'text' name = 'newUserId'></h2>");
    out.println("<tr><td><input  class='submit' type='submit' name='Submit2' value='Submit'></td>");
    out.println("</form>");
    String newUserId = request.getParameter("newUserId");
    if(newUserId != null){
        try(Connection conn = DriverManager.getConnection(url,userN,pw);
    	Statement stmt = conn.createStatement();){

        String sql = "UPDATE customer SET userid = '"+newUserId+"' WHERE userId = ?";
        PreparedStatement prep = conn.prepareStatement(sql);
        prep.setString(1, oldId);
        prep.executeUpdate();
        session.setAttribute("authenticatedUser", newUserId);
        conn.close();
        response.sendRedirect("customer.jsp");
        }catch (SQLException e){
            out.println(e);
        }
    }else{
        out.println("<h3 align =center>Please enter new userId</h3>");
    }
%>