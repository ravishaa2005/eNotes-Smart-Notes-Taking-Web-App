package com.Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.DAO.postDAO;
import com.DB.DBConnect;

@WebServlet("/deleteServlet")
public class deleteServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Integer nodeid=Integer.parseInt(request.getParameter("node_id"));
		postDAO dao=new postDAO(DBConnect.getConn());
		boolean f = dao.deleteNoteAndResetIds(nodeid);
		
		HttpSession session=null;
		
		if(f) {
			session=request.getSession();
			session.setAttribute("DeleteMsg", "Note deleted successfully");
			response.sendRedirect("showNotes.jsp");
		}else {
			session=request.getSession();
			session.setAttribute("wrongMsg", "Something went wrong on server side");
			response.sendRedirect("showNotes.jsp");
		}
		
	}

}
