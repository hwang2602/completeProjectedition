package com.bkacad.completeproj.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
	public static Connection getSqlConn() throws SQLException{
		Connection conn = null;
		String strConnection = "jdbc:sqlserver://localhost:1433;databaseName=doan2QLnhansu;user=sa;password=1234";
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			conn = DriverManager.getConnection(strConnection);
		} catch (ClassNotFoundException ex) {
			System.out.println("Cannot find jdbc driver for SQL Server");
		}
		return conn;
	}
	
	public static void closeQuietly(Connection conn) {
	       try {
	           conn.close();
	       } catch (Exception e) {
	       }
	   }
	 
	   public static void rollbackQuietly(Connection conn) {
	       try {
	           conn.rollback();
	       } catch (Exception e) {
	       }
	   }
}
