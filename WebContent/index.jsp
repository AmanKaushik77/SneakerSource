<!DOCTYPE html>
<html>
<head style = 'background-color:black; '>
        <link rel="stylesheet" href="styles.css">
        <title>Sneaker Source Main Page</title>
</head>
<body >
<h1 align="center" style = 'color:#FFC000'>Welcome to Sneaker Source</h1>
<h3 align="center" style = 'color:white'>Your one stop shop for Sneakers!</h3>

<ul >
        <li ><a href="login.jsp">Login</a></li>

        <li ><a href="listprod.jsp">Begin Shopping</a></li>

        <li ><a href="listorder.jsp">List All Orders</a></li>

        <li ><a href="customer.jsp">Customer Info</a></li>

        <li ><a href="admin.jsp">Administrators</a></li>

        <li ><a href="showcart.jsp">My Cart!</a></li>

        <li ><a href="logout.jsp">Log out</a></li>
</ul>
<%
// TODO: Display user name that is logged in (or nothing if not logged in)	
        String user = (String) session.getAttribute("authenticatedUser");
        if(user == null){
                out.println("<p> User not signed in yet </p>");
        }else{
                out.println("<p> Welcome: " + user + "</p>");
        }
%>

<img src="sneakerSourceLogo.png" alt="Sneaker Source Logo" style="width:750px;height:550px; padding-left: 9cm;">

</body>
</head>



