package com.tech.blog.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;

/**
 * Servlet implementation class EditServlet
 */
@MultipartConfig
@WebServlet("/EditServlet")
public class EditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Default constructor.
	 */
	public EditServlet() {
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
		try {
			String userName = request.getParameter("user_name");
			String userEmail = request.getParameter("user_email");
			String userPassword = request.getParameter("user_password");
			String userAbout = request.getParameter("user_about");
			Part part = request.getPart("image");
			String imageName = part.getSubmittedFileName();

			HttpSession s = request.getSession();
			User user = (User) s.getAttribute("currentUser");
			user.setName(userName);
			user.setEmail(userEmail);
			user.setPassword(userPassword);
			user.setAbout(userAbout);
			String oldFile = user.getProfile();
			user.setProfile(imageName);
			UserDao userDao = new UserDao(ConnectionProvider.getConnection());
			boolean check = userDao.updateUser(user);
			PrintWriter out = response.getWriter();
			if (check) {
				System.out.println(part.getSize());
				if (part.getSize() != 0) {

					String path = request.getServletContext().getRealPath("/") + "pics" + File.separator
							+ user.getProfile();
					String pathOldFile = request.getServletContext().getRealPath("/") + "pics" + File.separator
							+ oldFile;
					Helper.deleteFile(pathOldFile);
					if (Helper.saveFile(part.getInputStream(), path)) {
						Message msg = new Message("Profile Updated", "success", "alert-success");
						s.setAttribute("msg", msg);
					}

				}
				else {
					
				}
			} else {
				Message msg = new Message("Something Went Wrong", "error", "alert-danger");
				s.setAttribute("msg", msg);
			}
			response.sendRedirect("profile.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
