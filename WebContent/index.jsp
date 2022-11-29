<!DOCTYPE html>
<html>
<head>
        <title>AK Grocery Main Page</title>
</head>
<body style = 'background-color:beige;' >
<h1 align="center">Welcome to AK Grocery</h1>

<h2 align="center"><a href="login.jsp">Login</a></h2>

<h2 align="center"><a href="listprod.jsp">Begin Shopping</a></h2>

<h2 align="center"><a href="listorder.jsp">List All Orders</a></h2>

<h2 align="center"><a href="customer.jsp">Customer Info</a></h2>

<h2 align="center"><a href="admin.jsp">Administrators</a></h2>

<h2 align="center"><a href="logout.jsp">Log out</a></h2>

<%
// TODO: Display user name that is logged in (or nothing if not logged in)	
        String user = (String) session.getAttribute("authenticatedUser");
        if(user == null){
                out.println("<h1> User not signed in yet </h1>");
        }else{
                out.println("<h1> Welcome: " + user + "</h1>");
        }
%>
</body>
</head>



