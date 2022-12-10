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

<form name = "form1">
<%
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String userN = "SA";
String pw = "304#sa#pw";
String id = (String)session.getAttribute("authenticatedUser");

try(Connection conn = DriverManager.getConnection(url,userN,pw);
       Statement stmt = conn.createStatement();){	
        String sql = "SELECT * FROM customer WHERE userid = '" + id +"'";
        ResultSet res = stmt.executeQuery(sql);
        if(res.next()){
            String fn = res.getString(2);
            String ln = res.getString(3);
            String email = res.getString(4);
            String phonenum = res.getString(5);
            String address = res.getString(6);
            String city = res.getString(7);
            String state = res.getString(8);
            String postalCode = res.getString(9);
            String country = res.getString(10);
     
        out.println("<h1>" + fn + "</h1>");
        out.println("<table>");

            out.println("<tr><td >*First Name:</div></td>");
            out.println("<td><input type='text' name='firstname'  size=20 maxlength=40 value ="+ fn +"> </td></tr>");
            out.println("<tr><td >*Last Name:</td>");
            out.println("<td><input type='text' name='lastname'  size=20 maxlength=40 value ="+ ln +"></td></tr>");
            out.println("<tr><td >*Email:</div></td>");
            out.println("<td><input type='text' name='email'  size=20 maxlength=40 value ="+ email +"> </td></tr>");  
            out.println("<tr><td >Phone Number:</div></td>");
            out.println("<td><input type='text' name='phonenum'  size=20 maxlength=40 value ="+ phonenum +"> </td></tr>"); 
            out.println("<tr><td >Address:</div></td>");
            out.println("<td><input type='text' name='address'  size=20 maxlength=40 value ="+ address +"> </td></tr>");
            out.println("<tr><td >City:</div></td>");
            out.println("<td><input type='text' name='city'  size=20 maxlength=40 value ="+ city +"> </td></tr>");
            out.println("<tr><td >State:</div></td>");
            out.println("<td><input type='text' name='state'  size=20 maxlength=40 value ="+ state +"> </td></tr>");
            out.println("<tr><td >Postal Code:</div></td>");
            out.println("<td><input type='text' name='postalCode'  size=20 maxlength=40 value ="+ postalCode +"> </td></tr>");
            out.println("<tr><td >Country:</div></td>");
            out.println("<td><input type='text' name='country'  size=20 maxlength=40 value ="+ country +"> </td></tr>");
            out.println("<tr><td><input class='submit' type='submit' name='Submit2' value='Update'></td></tr>");
        out.println("</table>");
        if(request.getParameter("firstname") != null && request.getParameter("lastname") != null && request.getParameter("email") != null){
        String sql2 = "UPDATE customer SET firstName = ?, lastName = ?, email = ?, phonenum = ?, address = ?, city = ?, state = ?, postalCode = ?, country = ? WHERE userid = '" + id +"'";
        PreparedStatement prep = conn.prepareStatement(sql2); 
        prep.setString(1, request.getParameter("firstname"));
        prep.setString(2, request.getParameter("lastname"));
        prep.setString(3, request.getParameter("email"));
        prep.setString(4, request.getParameter("phonenum"));
        prep.setString(5, request.getParameter("address"));
        prep.setString(6, request.getParameter("city"));
        prep.setString(7, request.getParameter("state"));
        prep.setString(8, request.getParameter("postalCode"));
        prep.setString(9, request.getParameter("country"));
        prep.executeUpdate();
        conn.close();
        response.sendRedirect("customer.jsp");
        }else{
            out.println("<h2> Enter the mandatory parameters (*) to update</h2>");
        }      

    }   
    }catch(Exception e){
        out.println(e);
    }
%>