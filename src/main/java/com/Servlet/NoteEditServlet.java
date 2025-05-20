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

@WebServlet("/NoteEditServlet")
public class NoteEditServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		
		try {
			Integer noteid=Integer.parseInt(request.getParameter("noteid"));
			String title=request.getParameter("title");
			String content=request.getParameter("content");
			
		postDAO dao=new postDAO(DBConnect.getConn());
		boolean f=dao.PostUpdate(noteid, title, content);
		
		if(f) {
			System.out.println("data updated successfully");
			HttpSession session=request.getSession();
			session.setAttribute("updateMsg", "Note updated successfully");
			response.sendRedirect("showNotes.jsp");
		}
		else {
			System.out.println("data not updated");
		}
		
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
