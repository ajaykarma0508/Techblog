<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sorry something went wrong</title>
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
	<div class="container text-center">
		<img alt="" src="img/computer.png" class="img-fluid" style="height:400px;">
		<h3 class="display-3">sorry ! Something went wrong.......</h3>
		<%= exception %><br>
		<a href="index.jsp"><button class="btn primary-background btn-lg text-white mt-3">Home</button></a>
	</div>
</body>
</html>