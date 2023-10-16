package com.tech.blog.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

import com.tech.blog.entities.Message;
import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;

/**
 * Servlet implementation class RegServlet
 */
//@MultipartConfig
//@WebServlet("lsogin")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Login() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		try(PrintWriter pw = response.getWriter()) {
			String userEmail = request.getParameter("email");
			String userPassword = request.getParameter("password");
			UserDao dao = new UserDao(ConnectionProvider.getConnection());
			
			User u = dao.getUserByEmailAndPassword(userEmail, userPassword);
			if(u == null) {
				Message msg = new Message("Invalid Details ! try with another","error","alert-danger");
				HttpSession s =  request.getSession();
				s.setAttribute("msg", msg);
				response.sendRedirect("login.jsp");
			}
			else {
//				pw.println("valid Detail....try again");
				HttpSession s = request.getSession();
				s.setAttribute("currentUser", u);
				response.sendRedirect("profile.jsp");
			}
		} catch (Exception e) {
			e.getStackTrace();
		}

	}

}
