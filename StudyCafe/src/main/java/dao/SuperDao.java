package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public abstract class SuperDao {
	
	public  Connection con ; 
	
	public void close() {
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	
	public Connection getConnection()
	{
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
	//		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/studycafe","root","12345");
			con = DriverManager.getConnection("jdbc:mysql://192.168.17.76:3306/studycafe","root","12345");

		} catch (Exception e) {
			e.printStackTrace();
		}

		return con;
	}
}
