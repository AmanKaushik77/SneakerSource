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