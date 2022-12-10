<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="styles.css">
<title>Login Screen</title>
<%@ include file="header.jsp" %>
</head>
<body >
        <br>
<h1 align="center" style = 'color:#FFC000'>Please login to your Sneaker Source Account!</h1>
<div style="margin:0 auto;text-align:center;display:inline">
<br>
<h3>Please Login to System</h3>

<%
// Print prior error login message if present
if (session.getAttribute("loginMessage") != null)
	out.println("<p>"+session.getAttribute("loginMessage").toString()+"</p>");
%>


<form name="MyForm" method=post action="validateLogin.jsp">
<table style="display:inline">
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
<input class="submit" type="submit" name="Submit2" value="Log In">
</form>


</div>
<li ><a style = 'background-color: #FFC000; color:black;' href='newCust.jsp' >Sign Up!</a></li>
<li ><a style = 'background-color: #FFC000; color:black;' href='forgotPass.jsp' >Forgot Password?</a></li>

</body>
</html>

