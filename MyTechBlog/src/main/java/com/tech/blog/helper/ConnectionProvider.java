package com.tech.blog.helper;

import java.sql.*;

public class ConnectionProvider {
	public static Connection con;

	public static Connection getConnection() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/techblog", "root", "root");

		} catch (Exception e) {
			System.out.println(e);
		}
		
		return con;
	}
}
