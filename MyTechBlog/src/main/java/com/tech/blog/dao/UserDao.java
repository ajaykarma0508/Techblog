package com.tech.blog.dao;

import java.sql.*;

import com.tech.blog.entities.User;

public class UserDao {
	private Connection con;

	public UserDao(Connection con) {
		this.con = con;
	}

	// Method to insert to data base

	public boolean saveData(User user) {

		boolean f = false;
		try {
			String query = "insert into user(name,email,password,gender,about) values(?,?,?,?,?)";
			PreparedStatement ps = this.con.prepareStatement(query);
			ps.setString(1, user.getName());
			ps.setString(2, user.getEmail());
			ps.setString(3, user.getPassword());
			ps.setString(4, user.getGender());
			ps.setString(5, user.getAbout());

			int x = ps.executeUpdate();
			f = true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return f;
	}

	public User getUserByEmailAndPassword(String email, String password) {
		User user = null;
		try {
			String query = "select * from user where email = ? and password = ?";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, email);
			ps.setString(2, password);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				user = new User();
				user.setName(rs.getString("name"));
				user.setId(rs.getInt("id"));
				user.setEmail(rs.getString("email"));
				user.setPassword(rs.getString("password"));
				user.setGender(rs.getString("gender"));
				user.setAbout(rs.getString("about"));
				user.setDatetime(rs.getTimestamp("rdate"));
				user.setProfile(rs.getString("profile"));
			}
		} catch (Exception e) {
			e.getStackTrace();
		}
		return user;
	}
	public boolean updateUser(User user) {
		boolean f = false;
		try {
			String query = "update user set name = ? , email = ? , password = ? , about = ? , profile = ? where id = ?";
			PreparedStatement ps = this.con.prepareStatement(query);
			ps.setString(1, user.getName());
			ps.setString(2, user.getEmail());
			ps.setString(3, user.getPassword());
			ps.setString(4, user.getAbout());
			ps.setString(5, user.getProfile());
			ps.setInt(6, user.getId());
			ps.executeUpdate();
			f = true;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return f;
	}

}
