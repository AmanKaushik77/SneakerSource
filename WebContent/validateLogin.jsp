<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%
	String authenticatedUser = null;
	session = request.getSession(true);

	try
	{
		authenticatedUser = validateLogin(out,request,session);
	}
	catch(IOException e)
	{	System.err.println(e); }

	if(authenticatedUser != null)
		response.sendRedirect("index.jsp");		// Successful login
	else
		response.sendRedirect("login.jsp");		// Failed login - redirect back to login page with a message 
%>


<%!
	String validateLogin(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String retStr = null;

		if(username == null || password == null)
				return null;
		if((username.length() == 0) || (password.length() == 0))
				return null;

		String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
		String user = "SA";
		String pw = "304#sa#pw";
		String pId = request.getParameter("id");
		try(Connection conn = DriverManager.getConnection(url,user,pw);
			Statement stmt = conn.createStatement();){
			String sql = "SELECT * FROM Customer WHERE userId = ? AND password = ?";
			PreparedStatement prep = conn.prepareStatement(sql);
			prep.setString(1,username);
			prep.setString(2,password);
			ResultSet rs = prep.executeQuery();
			if(rs.next()){
			// TODO: Check if userId and password match some customer account. If so, set retStr to be the username.
				retStr = username;
			}	
			conn.close();		
		} 
		catch (SQLException ex) {
			out.println(ex);
		}
		finally
		{
			
		}	
		
		if(retStr != null)
		{	session.removeAttribute("loginMessage");
			session.setAttribute("authenticatedUser",username);
		}
		else
			session.setAttribute("loginMessage","Could not connect to the system using that username/password.");

		return retStr;
	}
%>

