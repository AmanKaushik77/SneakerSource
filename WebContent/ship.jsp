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
<body style = 'background-color:beige'>
        
<%@ include file="header.jsp" %>

<%
	// TODO: Get order id
	String orderId = request.getParameter("orderId");
	
	String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
	String user = "SA";
	String pw = "304#sa#pw";
	String sql = "SELECT orderId, productId, quantity, price FROM orderproduct WHERE orderId = ?";	
	boolean check = true;
	try(Connection conn = DriverManager.getConnection(url,user,pw);
    	Statement stmt = conn.createStatement();){
		conn.setAutoCommit(false);
	// TODO: Check if valid order id
		if(orderId == null || orderId.equals("")){
			out.println("<h2> Invalid order Id. Please try again.</h2>");
		}else{
			PreparedStatement prep = conn.prepareStatement(sql);
			int ordId = Integer.parseInt(orderId);
			prep.setInt(1,ordId);
			ResultSet rs = prep.executeQuery();
			if(rs.next()){ 
				

				sql = "INSERT INTO shipment (shipmentDate, warehouseId) VALUES (?,1)";
				String sql3 = "SELECT quantity FROM productInventory WHERE warehouseId = 1 AND productId = ?";
				prep = conn.prepareStatement(sql);
				prep.setTimestamp(1, new java.sql.Timestamp(new Date().getTime()));
				prep.executeUpdate();

				
				PreparedStatement prep2 = conn.prepareStatement(sql3);
				sql = "UPDATE productinventory SET quantity = ? WHERE warehouseId = 1 and productId = ?";
				prep = conn.prepareStatement(sql); 

				prep2.setInt(1, rs.getInt(2));
				ResultSet rs2 = prep2.executeQuery();
				int pId = rs.getInt(2);
				int inv = rs2.getInt(1);
				int quan = rs.getInt(3);
				while(rs2.next()) {
					if (!rs2.next() || inv < quan) {
						
						out.println("<h1>Shipment cannot be complete :(. Insufficient inventory for product id: "+rs.getInt(1)+"</h1>");
						check = false;
						break;
					}
				prep.setInt(1, inv - quan);
				prep.setInt(2, pId);
				prep.executeUpdate();
				out.println("<h2>Ordered product: "+pId+" Qty: "+ quan +" Previous inventory: "+ inv + " New inventory: "+(inv - quan)+"</h2>");
				
				
				}
				
			}else{
				out.println("<h1>Invalid order id or no items in order.</h1>");
			}
			conn.close();
		}
		if(check == false) {
			conn.rollback();
		}else{
			out.println("<h1>Shipment successfully processed.</h1>");
   			conn.commit();   
			conn.setAutoCommit(true);
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

<h2><a href="index.jsp">Back to Main Page</a></h2>

</body>
</html>
