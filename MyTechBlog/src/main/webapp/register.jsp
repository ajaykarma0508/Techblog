<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registration page</title>
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

</head>
<body>
	<%@ include file="normal_navbar.jsp"%>

	<main class="primary-background p-5">
		<div class="container">
			<div class="col-md-6 offset-md-3">
				<div class="card">
					<div class="card-header text-center primary-background text-white">
						<span class="fa fa-user-circle fa-3x"></span><br> Register
						Here
					</div>
					<div class="card-body">
						<form action="RegServlet" method="post" id="reg-form">
							<div class="form-group">
								<label for="user_name">User Name</label> <input type="text"
									class="form-control" id="user_name" name="user_name"
									aria-describedby="emailHelp" placeholder="Enter your name">
							</div>


							<div class="form-group">
								<label for="exampleInputEmail1">Email address</label> <input
									type="email" class="form-control" id="user_email"
									name="user_email" aria-describedby="emailHelp"
									placeholder="Enter email"> <small id="emailHelp"
									class="form-text text-muted">We'll never share your
									email with anyone else.</small>
							</div>

							<div class="form-group">
								<label for="exampleInputPassword1">Password</label> <input
									name="user_password" type="password" class="form-control"
									id="user_password" placeholder="Password">
							</div>

							<div class="form-group">
								<label for="gender">Select Gender</label><br> <input
									type="radio" id="gender" value="M" name="gender">Male <input
									type="radio" id="gender" value="F" name="gender">Female
								<input type="radio" id="gender" value="Other" name="gender">Other
							</div>
							<div class="form-group">
								<textarea id="textarea" class="form-control" name="about"
									rows="5" placeholder="Enter something about yourself"></textarea>
							</div>

							<div class="form-check">
								<input type="checkbox" class="form-check-input"
									name="check_field" id="exampleCheck1"> <label
									class="form-check-label" for="exampleCheck1">Agree
									terms and condition</label>
							</div>
							<br>
							<div class="container text-center" id="loader"
								style="display: none">
								<span class="fa fa-refresh fa-spin fa-2x"></span>
								<h4 class="pl-4">Please Wait......</h4>
							</div>
							<button id="submit-btn" type="submit"
								class="btn btn-primary primary-background ">Submit</button>
						</form>
					</div>
					<div class="card-footer"></div>
				</div>
			</div>
		</div>
	</main>

	<script src="https://code.jquery.com/jquery-3.7.0.min.js"
		integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
		integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js"
		integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
		crossorigin="anonymous"></script>
	<script src="JS/myjs.js" type="text/javascript"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"
		type="text/javascript" s></script>
	<script>
		$(document).ready(function() {
			console.log("Loaded........")
			$('#reg-form').on('submit', function(event) {
				event.preventDefault();
				
				$("#submit-btn").hide();
				$("#loader").show();
				let form = new FormData(this);

				$.ajax({
					url : "RegServlet",
					type : 'POST',
					data : form,
					success : function(data, textStatus, jqXHR) {
						console.log(data)
						
						$("#submit-btn").show();
						$("#loader").hide();
						console.log(data.trim());
						if(data.trim() === 'Done'){
							swal("Register Successfully..we are redirecting to login page")
							   .then((value) => {
							   window.location = "login.jsp";
						       });						   
						}
						else{
							swal(data);
						}
					},
					error : function(jqXHR, textStatus, errorThrown) {
						$("#submit-btn").show();
						$("#loader").hide();
						swal("Something went wrong")
					},
					processData : false,
					contentType : false
				});
			});
		});
	</script>
</body>
</html>