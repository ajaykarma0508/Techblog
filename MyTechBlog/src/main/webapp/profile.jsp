<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.dao.*"%>
<%@page errorPage="error.jsp"%>
<%@page import="com.tech.blog.entities.*"%>
<%@page import="com.tech.blog.helper.*"%>
<%@page import="java.util.*"%>




<%
User user = (User) session.getAttribute("currentUser");

if (user == null) {
	response.sendRedirect("login.jsp");
}
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">
<link rel="stylesheet" href="CSS/mystyle.css" type="text/CSS">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
.banner-background {
	clip-path: polygon(0 0, 100% 0, 100% 30%, 100% 87%, 70% 100%, 27% 93%, 0 100%, 0%
		30%);
}
</style>
<title>Insert title here</title>
</head>
<body>
	<!-- START OF NAVBAR -->
	<nav class="navbar navbar-expand-lg navbar-dark primary-background">
		<a class="navbar-brand" href="index.jsp"><span
			class="fa fa-asterisk"></span>Tech Blog</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link" href="#"><span
						class="fa fa-bell"></span> LearnCode with ajay <span
						class="sr-only">(current)</span></a></li>

				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> <span class="fa fa-external-link-square"></span>
						Categories
				</a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="#">Programming Language</a> <a
							class="dropdown-item" href="#">Project Implementation</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="#">Data Structure</a>
					</div></li>
				<li class="nav-item"><a class="nav-link" href="#"> <span
						class="fa fa-address-card"></span> Contact
				</a></li>
				<li class="nav-item active"><a class="nav-link" href="#"
					data-toggle="modal" data-target="#add-post-modal"> <span
						class="fa fa-arrow-circle-up"></span> post
				</a></li>
			</ul>
			<ul class="navbar-nav mr-right">
				<li class="nav-item active"><a class="nav-link" href="#"
					data-toggle="modal" data-target="#profile-model"> <span
						class="fa fa-user-circle"></span> <%=user.getName()%>
				</a></li>
				<li class="nav-item"><a class="nav-link active"
					href="LogoutServlet"> <span class="fa fa-sign-out"></span>
						Logout
				</a></li>
			</ul>
		</div>
	</nav>
	<!--  END OF NAVBAR-->
	<%
	Message m = (Message) session.getAttribute("msg");
	if (m != null) {
	%>
	<div class="alert <%=m.getCssClass()%>" role="alert">
		<%=m.getContent()%>
	</div>
	<%
	session.removeAttribute("msg");
	}
	%>

	<!-- MAIN BODY OF THE PAGE START -->



	<main>
		<div class="container">
			<div class="row mt-5">
				<div class="col-md-4">
					<!-- categroies -->
					<div class="list-group">
						<a href="#"
							class="list-group-item primary-background list-group-item-action active">All
							Posts </a>
						<%
						PostDao cpost = new PostDao(ConnectionProvider.getConnection());
						ArrayList<Category> al = cpost.getAllCategories();
						for (Category c : al) {
						%>
						<a href="#" class="list-group-item list-group-item-action"><%=c.getName()%></a>
						<%
						}
						%>
					</div>
				</div>
				<div class="col-md-8">
					<!-- posts -->
					<div class="container text-center" id="loader">
						<i class="fa fa-refresh fa-4x fa-spin"></i>
						<h3 class="mt-3">Loading..</h3>
					</div>
					<div class="container">
						<div class="row" id="post-container">
							
						</div>
					</div>

				</div>
			</div>
		</div>
	</main>






	<!-- MAIN BODY OF THE PAGE END -->

	<!-- PROFILE MODAL -->

	<div class="modal fade" id="profile-model" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header primary-background text-white text-center">
					<h5 class="modal-title" id="exampleModalLabel">TechBlog</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="container text-center">
						<img alt="userImage" src="pics/<%=user.getProfile()%>"
							style="border-radius: 50%" width=150px height=150px> <br>
						<h5 class="modal-title" id="exampleModalLabel">
							<%=user.getName()%>
						</h5>
						<!-- DETAILS -->
						<div id="profile-details">
							<table class="table">
								<tbody>
									<tr>
										<th scope="row">ID:</th>
										<td><%=user.getId()%></td>

									</tr>
									<tr>
										<th scope="row">Email:</th>
										<td><%=user.getEmail()%></td>
									</tr>
									<tr>
										<th scope="row">Gender:</th>
										<td><%=user.getGender()%></td>
									</tr>
									<tr>
										<th scope="row">Status:</th>
										<td><%=user.getAbout()%></td>
									</tr>
									<tr>
										<th scope="row">Registered On:</th>
										<td><%=user.getDatetime().toString()%></td>
									</tr>
								</tbody>
							</table>
						</div>

						<!-- PROFILE EDIT -->

						<div id="profile-edit" style="display: none">
							<h3 class="mt-2">Please Edit Carefully</h3>
							<form action="EditServlet" method="post"
								enctype="multipart/form-data">
								<table class="table">
									<tr>
										<td scope="row">ID :</td>
										<td><%=user.getId()%></td>
									</tr>
									<tr>
										<td scope="row">Gender:</td>
										<td><%=user.getGender()%></td>
									</tr>
									<tr>
										<td scope="row">Name :</td>
										<td><input type="text" class="form-control"
											name="user_name" value="<%=user.getName()%>"></td>
									</tr>
									<tr>
										<td scope="row">Email :</td>
										<td><input type="email" class="form-control"
											name="user_email" value="<%=user.getEmail()%>"></td>
									</tr>
									<tr>
										<td scope="row">Password :</td>
										<td><input type="password" class="form-control"
											name="user_password" value="<%=user.getPassword()%>"></td>
									</tr>
									<tr>
										<td scope="row">About :</td>
										<td><textarea rows="3" name="user_about"
												class="form-control"><%=user.getAbout()%></textarea></td>
									</tr>
									<tr>
										<td scope="row">New Profile:</td>
										<td><input type="file" name="image" class="form-control">
										</td>
									</tr>
								</table>
								<div class="container">
									<button class="btn btn-outline-primary text-black">Save</button>
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<button id="edit-profile-button" type="button"
						class="btn btn-primary">Edit</button>
				</div>
			</div>
		</div>
	</div>
	<!-- END OF PROFILE MODEL -->


	<!--  Add PSOT MODAL -->

	<!-- Modal -->
	<div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content" id="check">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Provide the
						post details</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="AddPostServlet" method="post" id="add-post-form">
						<div class="from-group">
							<select class="form-control" name="cid">
								<option selected disabled>---Select categories---</option>
								<%
								PostDao post = new PostDao(ConnectionProvider.getConnection());
								ArrayList<Category> list = post.getAllCategories();
								for (Category c : list) {
								%>

								<option value="<%=c.getCid()%>">
									<%=c.getName()%></option>

								<%
								}
								%>
							</select>
						</div>
						<br> <br>
						<div class="form-group">
							<input type="text" placeholder="Enter post title"
								class="form-control" name="pTitle" required />
						</div>
						<div class="form-group">
							<textarea rows="5" cols="5" class="form-control"
								placeholder="Enter your content" name="pContent" required></textarea>
						</div>
						<div class="form-group">
							<textarea rows="5" cols="5" class="form-control"
								placeholder="Enter your program (if any)" name="pCode"></textarea>
						</div>
						<div class="form-group">
							<label>Select your pic</label><br> <input type="file"
								name="pic" required />
						</div>
						<div class="container text-center">
							<button type="submit" class="btn btn-outline-primary" id="post">Post</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!--  END POST MODAL -->



	<!-- START OF JAVASCRIPT -->
	<script src="https://code.jquery.com/jquery-3.7.0.min.js"
		integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
		crossorigin="anonymous">
		
	</script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
		integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
		crossorigin="anonymous">
		
	</script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js"
		integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
		crossorigin="anonymous">
		
	</script>
	<script src="JS/myjs.js" type="text/javascript"></script>
	<script type="text/javascript"
		src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			let editStatus = false;
			$('#edit-profile-button').click(function() {
				if (editStatus == false) {
					$('#profile-details').hide();
					$('#profile-edit').show();
					$(this).text("Back");
					editStatus = true;

				} else {
					$('#profile-details').show();
					$('#profile-edit').hide();
					$(this).text("Edit");
					editStatus = false;
				}
			});
		});
	</script>
	<!-- now add post JS -->
	<script>
		$(document)
				.ready(
						function() {
							$("#add-post-form")
									.on(
											"submit",
											function(event) {
												event.preventDefault();
												console
														.log("You have clicked on submit ");

												let form = new FormData(this);
												$
														.ajax({
															url : "AddPostServlet",
															type : 'POST',
															data : form,
															success : function(
																	data,
																	textStatus,
																	jqXHR) {
																console
																		.log(data);
																if (data.trim() == "done") {
																	swal(
																			"Good job!",
																			"Saved successfully",
																			"success");

																} else {
																	swal(
																			"Error !",
																			"Something went wrong try again later !",
																			"error");
																}
															},
															error : function(
																	jqXHR,
																	textStatus,
																	errorThrown) {
																swal(
																		"Error !",
																		"Something went wrong try again later !",
																		"error");
															},
															processData : false,
															contentType : false
														})
											});
						});
	</script>
	<script type="text/javascript">
		$(document).ready(function() {
			$.ajax({
				url : "load_post.jsp",
				success : function(data, textStatus, jqXHR) {
					console.log(data);
					$("#loader").hide();
					$("#post-container").html(data);
				}
			});
		});
	</script>

	<!-- END OF JAVASCRIPT -->
</body>
</html>