<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
    <link rel="stylesheet" href="styles.css">
<title>Sneaker Source New Customer</title>
</head>
<body>
<%@ include file="header.jsp" %>
<form name="MyForm" >
    <table style="display:inline">
     <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">FirstName:</font></div></td>
        <td><input type="text" name="firstName"  size=10 maxlength=10></td>
    </tr>   
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">LastName:</font></div></td>
        <td><input type="text" name="lastName"  size=10 maxlength=10></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Email:</font></div></td>
        <td><input type="text" name="email"  size=10 maxlength=10></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Phone Number:</font></div></td>
        <td><input type="text" name="phoneNum"  size=10 maxlength=10></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Address:</font></div></td>
        <td><input type="text" name="address"  size=10 maxlength=10></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">City:</font></div></td>
        <td><input type="text" name="city"  size=10 maxlength=10></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">State/Province:</font></div></td>
        <td><input type="text" name="state"  size=10 maxlength=10></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Postal Code:</font></div></td>
        <td><input type="text" name="postalCode"  size=10 maxlength=10></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Country:</font></div></td>
        <td><input type="text" name="country"  size=10 maxlength=10></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Username:</font></div></td>
        <td><input type="text" name="username"  size=10 maxlength=10></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Password:</font></div></td>
        <td><input type="password" name="password" size=10 maxlength="10"></td>
    </tr>
    </table>
    <br/>
    <input class="submit" type="submit" name="Submit2" value="Sign Up!">
    </form>

    <%
    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
	String userN = "SA";
	String pw = "304#sa#pw";
	
    
    String fn = request.getParameter("firstName");
    String ln = request.getParameter("lastName");
    String email = request.getParameter("email");
    String phonenum = request.getParameter("phoneNum");
    String address = request.getParameter("address");
    String city = request.getParameter("city");
    String state = request.getParameter("state");
    String postalcode = request.getParameter("postalCode");
    String country = request.getParameter("country");
    String userid = request.getParameter("username");
    String password = request.getParameter("password");
    int custId = (int) Math.random()*100;
    
    if(fn != null && ln != null && email != null && phonenum != null && address != null && city != null && state != null && postalcode != null && country != null && userid != null && password != null){
        try(Connection conn = DriverManager.getConnection(url,userN,pw);
    	Statement stmt = conn.createStatement();){
            String sql = "INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalcode, country, userid, password) VALUES (?,?,?,?,?,?,?,?,?,?,?) ";
            PreparedStatement prep = conn.prepareStatement(sql);
           
            prep.setString(1, fn);
            prep.setString(2,ln);
            prep.setString(3,email);
            prep.setString(4,phonenum);
            prep.setString(5, address);
            prep.setString(6,city);
            prep.setString(7,state);
            prep.setString(8,postalcode);
            prep.setString(9,country);
            prep.setString(10,userid);
            prep.setString(11,password);
            

            prep.executeUpdate();;

            conn.close();
            response.sendRedirect("index.jsp");


        }catch (SQLException e){
            out.println(e);
        }
    }



    %>
</body>