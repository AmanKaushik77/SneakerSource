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
<title>YOUR NAME Grocery Shipment Processing</title>
</head>
<body>
        
<%@ include file="header.jsp" %>

<%
	// TODO: Get order id
	String orderId = request.getParameter("orderId");
	int ordId = Integer.parseInt(orderId);
	String sql = "SELECT year(orderDate), month(orderDate), day(orderDate), SUM(totalAmount) FROM OrderSummary GROUP BY year(orderDate), month(orderDate), day(orderDate)";
	String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
	String user = "SA";
	String pw = "304#sa#pw";
	String sql = "SELECT orderId, productId, quantity, price FROM orderProduct WHERE orderId = ?"
	try(Connection conn = DriverManager.getConnection(url,user,pw);
    	Statement stmt = conn.createStatement();){
          
	// TODO: Check if valid order id
		if(ordId == null){
			out.println("<h2> Invalid order Id. Please try again.</h2>");
		}else{
			PreparedStatement prep = conn.prepareStatement(sql);
			prep.setInt(1,ordId);
			ResultSet rs = prep.executeQuery();
			if(rs.next()){ 
				conn.setAutoCommit(false);

				String sql2 = "INSERT INTO shipments (shipmentDate, warehouseId) VALUES (?,1)";
				String sql3 = "SELECT quantity FROM productInventory WHERE warehouseId = 1 AND productId = ?";
				prep = conn.prepareStatement(sql2);
				prep.setTimestamp(1, new java.sql.Timestamp(new Date().getTime()));
				prep.executeUpdate();

				boolean check = true;
				PreparedStatement prep2 = conn.prepareStatement(sql3);
				ResultSet rs2 = prep2.executeQuery();
				while(rs2.next()) {
					if (!rs2.next() || rs2.getInt(1) < rs.getInt(3)) {
						check = false;
						out.println("<h1>Shipment cannot be complete :(. Insufficient inventory for product id: "+prodId+"</h1>");
						conn.setAutoCommit(true);
						break;
					}
				out.println("<h2>Ordered product: "+prodId+" Qty: "+rs.getInt(3)+" Previous inventory: "+rs2.getInt(1)+" New inventory: "+(rs.getInt(3) - rs2.getInt(1))+"</h2><br>");
				prep.setInt(1, rs.getInt(3) - rs2.getInt(1));
				prep.setInt(2, rs.getInt(2));
				}
			}
		}
		if(!check){
			conn.rollback();
		}else{
			out.println("<h1>Shipment successfully processed.</h1>");
   			conn.commit();   
		}
	}catch(Exception e){
		out.println(e);
	}
	// TODO: Start a transaction (turn-off auto-commit)
	
	// TODO: Retrieve all items in order with given id
	// TODO: Create a new shipment record.
	// TODO: For each item verify sufficient quantity available in warehouse 1.
	// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
	
	// TODO: Auto-commit should be turned back on
%>                       				

<h2><a href="shop.html">Back to Main Page</a></h2>

</body>
</html>
