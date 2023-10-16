<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.dao.*"%>
<%@page errorPage="error.jsp"%>
<%@page import="com.tech.blog.entities.*"%>
<%@page import="com.tech.blog.helper.*"%>
<%@page import="java.util.*"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<%
		PostDao p1 = new PostDao(ConnectionProvider.getConnection());
		List<Post> l1 = p1.getAllPosts();
		for (Post po : l1) {
		%>
	<div class="col-md-4 mb-3">
		<div class="card" style="width: auto;">
			<img class="card-img-top" src="blog-pics/<%= po.getPpic() %>"
				alt="Card image cap">
			<div class="card-body">
				<h5 class="card-title"><%=po.getPtitle()%></h5>
				<p class="card-text"><%=po.getPcontent()%></p>
			</div>
		</div>
	</div>
	<%
		}
		%>
</body>
</html>