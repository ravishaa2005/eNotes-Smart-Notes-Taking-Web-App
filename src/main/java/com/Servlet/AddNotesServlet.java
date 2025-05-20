package com.Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;


import com.DAO.postDAO;
import com.DB.DBConnect;
import com.User.Post;
import com.User.UserDetails;

@WebServlet("/AddNotesServlet")
public class AddNotesServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    UserDetails user = (UserDetails) request.getSession().getAttribute("userD");
	    int uid = user.getId();
	    String title = request.getParameter("title");
	    String content = request.getParameter("content");

	    // Get coordinates
	    double lat = 0.0;
	    double lon = 0.0;
	    try {
	        lat = Double.parseDouble(request.getParameter("lat"));
	        lon = Double.parseDouble(request.getParameter("lon"));
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    Post p = new Post();
	    p.setTitle(title);
	    p.setContent(content);
	    p.setPdate(new Date());
	    p.setLat(lat);
	    p.setLon(lon);

	    postDAO dao = new postDAO(DBConnect.getConn());
	    boolean f = dao.addPost(p, uid);

	    if (f) {
	        request.getSession().setAttribute("updateMsg", "Note Added Successfully!");
	        response.sendRedirect("showNotes.jsp");
	    } else {
	        request.getSession().setAttribute("wrongMsg", "Something went wrong!");
	        response.sendRedirect("addNotes.jsp");
	    }
	}


}
