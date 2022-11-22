import  java.sql.*;


public class FooCode{
    public static void main(String[] args) {
        String url = "jdbc:sqlserver://cosc304_sqlserver:1433; DatabaseName=orders; TrustServerCertificate=True";
        String user = "testuser";
        String pw = "304testpw";
        try ( Connection con = DriverManager.getConnection(url, user, pw);
	          Statement stmt = con.createStatement();) 
	    {			
			ResultSet rst = stmt.executeQuery("SELECT ename,salary FROM emp");
			System.out.println("Employee Name,Salary");
			while (rst.next())
			{	System.out.println(rst.getString("ename")+","+rst.getDouble("salary"));
			}
		}
		catch (SQLException ex)
		{
			System.err.println("SQLException: " + ex);
		}		
    }
}