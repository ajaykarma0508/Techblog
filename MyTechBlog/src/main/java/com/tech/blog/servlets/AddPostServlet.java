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

import com.tech.blog.dao.PostDao;
import com.tech.blog.entities.Post;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;

/**
 * Servlet implementation class AddPostServlet
 */
@WebServlet("/AddPostServlet")
@MultipartConfig
public class AddPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public AddPostServlet() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try(PrintWriter out = response.getWriter()) {
			
			int cid = Integer.parseInt(request.getParameter("cid"));
			String pTitle = request.getParameter("pTitle");
			String pContent = request.getParameter("pContent");
			String pCode = request.getParameter("pCode");
			Part part = request.getPart("pic");
			HttpSession s = request.getSession();
			User user = (User) s.getAttribute("currentUser");		
			
			Post p = new Post(pTitle , pContent , pCode , part.getSubmittedFileName(),null ,cid , user.getId())	;
			
			PostDao dao = new PostDao(ConnectionProvider.getConnection());
			boolean b = dao.saveData(p);
			if(b) {
				String path = "/home/vijay/eclipse-workspace/MyTechBlog/src/main/webapp/blog-pics/"+part.getSubmittedFileName();
				Helper.saveFile(part.getInputStream(), path);
				out.println("done");
			}
			else {
				out.println("error");
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
	}

}
