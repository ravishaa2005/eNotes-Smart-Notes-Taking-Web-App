package com.Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import com.DAO.UserDAO;
import com.DB.DBConnect;
import com.User.UserDetails;

@WebServlet("/registerServlet")
public class registerServlet extends HttpServlet {
	public void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException,IOException {
		String name=request.getParameter("user_name");
		String email=request.getParameter("user_email");
		String password=request.getParameter("user_password");
		
		UserDetails us=new UserDetails();//created object of userDetails class
		us.setName(name);
		us.setEmail(email);
		us.setPassword(password);
		
		UserDAO dao=new UserDAO(DBConnect.getConn());//created object of UserDAO inorder to store data to db
		boolean f=dao.addUser(us);
		PrintWriter out =response.getWriter();
		HttpSession session;
		
		if(f) {
			session=request.getSession();
			session.setAttribute("reg-success", "Registred Successfully..");
			response.sendRedirect("register.jsp");
		}
		else {
			session=request.getSession();
			session.setAttribute("failed-msg", "Something went wrong on Server");
			response.sendRedirect("register.jsp");
		}
	}
}