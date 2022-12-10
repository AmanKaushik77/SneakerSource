<H1 align="center"><font face="cursive" color="#800000"><a href="index.jsp" style = 'color:#FFC000;'>Sneaker Source</a></font></H1>      
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
<hr>
