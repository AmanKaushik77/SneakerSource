<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<link rel="stylesheet" href="styles.css">
<title style = 'background-color:#232323;'>AK Grocery - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body style = 'background-color:#232323; color: white'>

<%@ include file="header.jsp" %>

<%
// Get product name to search for
// TODO: Retrieve and display info for the product
// String productId = request.getParameter("id");
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String user = "SA";
String pw = "304#sa#pw";
String pId = request.getParameter("id");
int productId = Integer.parseInt(pId);
try(Connection conn = DriverManager.getConnection(url,user,pw);
    Statement stmt = conn.createStatement();){
    String sql = "SELECT productId, productName, productPrice, productImageURL, productImage FROM product WHERE productId LIKE ?";
    
    PreparedStatement prep = conn.prepareStatement(sql);
    prep.setInt(1, productId);

    ResultSet rs = prep.executeQuery();
    if(rs.next()){
        if(rs.getString(4) !=null ){
            out.println("<img src=\""+rs.getString(4)+"\">");
        }
        if(rs.getString(5) !=null){
            out.println("<img src=\"displayImage.jsp?id="+rs.getInt(1)+"\">");
        }
        out.println("<h3> Product: "+rs.getString(2)+"</h3>");
        out.println("<h3> ID: "+rs.getInt(1)+"</h3>");
        out.println("<h3> Price: $"+rs.getDouble(3)+"</h3>");
        out.println("<h2><a style = 'color:#FFC000;' href=\"addcart.jsp?id=" + rs.getInt(1) + "&name=" + rs.getString(2) + "&price=" + rs.getDouble(3) + "\">Add to Cart</a></h2>");
        out.println("<h2><a style = 'color:#FFC000;'href=\"listprod.jsp\">Continue Shopping</a>");
        
    }else{
         out.println("Invalid product");
    }
    conn.close();

// TODO: If there is a productImageURL, display using IMG tag
		
// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
		
// TODO: Add links to Add to Cart and Continue Shopping

}catch (Exception e){
    out.println(e);
}

%>

</body>
</html>

