package com.tech.blog.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.tech.blog.entities.Category;
import com.tech.blog.entities.Post;

public class PostDao {
	Connection con;

	public PostDao(Connection con) {
		super();
		this.con = con;
	}

	public ArrayList<Category> getAllCategories() {
		ArrayList<Category> list = new ArrayList<>();
		try {
			String q = "select * from categories";
			Statement st = this.con.createStatement();

			ResultSet set = st.executeQuery(q);

			while (set.next()) {
				int cid = set.getInt("cid");
				String name = set.getString("name");
				String description = set.getString("description");
				Category c = new Category(cid, name, description);
				list.add(c);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public boolean saveData(Post p) {
		boolean flag = false;
		try {
			String query = "insert into post(ptitle,pcontent,pcode,ppic,cid,userid) values (?,?,?,?,?,?)";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, p.getPtitle());
			ps.setString(2, p.getPcontent());
			ps.setString(3, p.getPcode());
			ps.setString(4, p.getPpic());
			ps.setInt(5, p.getCid());
			ps.setInt(6, p.getUserId());
			ps.executeUpdate();
			flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	public List<Post> getAllPosts() {
		List<Post> list = new ArrayList<>();
		try {
			String query = "select * from post";
			PreparedStatement ps = con.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				Post p = new Post();
				p.setPid(rs.getInt(1));
				p.setPtitle(rs.getString(2));
				p.setPcontent(rs.getString(3));
				p.setPcode(rs.getString(4));
				p.setPpic(rs.getString(5));
				p.setPdate(rs.getTimestamp(6));
				p.setCid(rs.getInt(7));
				p.setUserId(rs.getInt(8));
				
				list.add(p);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<Post> getPostByCatId(int catId) {
		List<Post> list = new ArrayList<>();
		try {
			String query = "select * from post where cid = ?";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, catId);
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				Post p = new Post();
				p.setPid(rs.getInt(0));
				p.setPtitle(rs.getString(1));
				p.setPcontent(rs.getString(2));
				p.setPcode(rs.getString(3));
				p.setPpic(rs.getString(4));
				p.setPdate(rs.getTimestamp(5));
				p.setCid(rs.getInt(6));
				p.setUserId(rs.getInt(7));
				
				list.add(p);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}	
		return list;
	}

}
