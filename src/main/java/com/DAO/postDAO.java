package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.DB.DBConnect;
import com.User.Post;

public class postDAO {
	
	private Connection conn;

	public postDAO(Connection conn) {
		super();
		this.conn = conn;
	}
	
	public boolean addPost(Post post, int uid) {
	    boolean f = false;
	    try {
	        String sql = "INSERT INTO post(title, content, date, uid, latitude, longitude) VALUES(?,?,?,?,?,?)";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setString(1, post.getTitle());
	        ps.setString(2, post.getContent());
	        ps.setTimestamp(3, new java.sql.Timestamp(post.getPdate().getTime()));
	        ps.setInt(4, uid);
	        ps.setDouble(5, post.getLat());
	        ps.setDouble(6, post.getLon());

	        int i = ps.executeUpdate();
	        f = i == 1;
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return f;
	}

	
	public List<Post> getData(int uid) {
	    List<Post> list = new ArrayList<>();
	    try {
	        String sql = "SELECT * FROM post WHERE uid = ? ORDER BY id DESC";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setInt(1, uid);
	        ResultSet rs = ps.executeQuery();

	        while (rs.next()) {
	            Post p = new Post();
	            p.setId(rs.getInt("id"));
	            p.setTitle(rs.getString("title"));
	            p.setContent(rs.getString("content"));
	            p.setPdate(rs.getTimestamp("date"));
	            p.setLat(rs.getDouble("latitude"));
	            p.setLon(rs.getDouble("longitude"));
	            list.add(p);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}

	
	public Post getDataById(int noteId) {
		Post p=null;
		try {
			String query="select * from post where id=?";
			PreparedStatement ps=conn.prepareStatement(query);
			ps.setInt(1, noteId);
			
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				p=new Post();
				p.setId(rs.getInt(1));
				p.setTitle(rs.getString(2));
				p.setContent(rs.getString(3));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return p;
	}
	
	public boolean PostUpdate(int nid,String ti,String co) {
		boolean f=false;
		try {
			String query="update post set title=?,content=? where id=?";
			PreparedStatement ps=conn.prepareStatement(query);
			ps.setString(1, ti);
			ps.setString(2, co);
			ps.setInt(3, nid);
			int i=ps.executeUpdate();
			
			if(i==1) {
				f=true;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return f;
	}
	
	
	
	public boolean deleteNoteAndResetIds(int noteId) {
	    boolean success = false;
	    try {
	        Connection conn = DBConnect.getConn();

	        // Delete the note
	        PreparedStatement ps = conn.prepareStatement("DELETE FROM post WHERE id = ?");
	        ps.setInt(1, noteId);
	        int rowsDeleted = ps.executeUpdate();

	        if (rowsDeleted > 0) {
	            success = true;

	            // Re-sequence IDs
	            Statement st = conn.createStatement();
	            st.execute("SET @count = 0;");
	            st.execute("UPDATE post SET id = @count := @count + 1;");
	            st.execute("ALTER TABLE post AUTO_INCREMENT = 1;");
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return success;
	}

}
