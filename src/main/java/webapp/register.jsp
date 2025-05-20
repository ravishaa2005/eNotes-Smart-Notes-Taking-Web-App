<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="all_component/allcss.jsp"%>

<meta charset="UTF-8">
<title>Register</title>
</head>
<body class="register-page">
	<%@include file="all_component/navbar.jsp"%>
	<link rel="stylesheet" href="register_style.css">
	<div class="container-fluid div-color">
		<div class="row">
			<div class="col-md-6 offset-md-3">
				<div class="card mt-4">
					<div class="card-header text-center text-white bg-custom">
						<i class="fa fa-user-plus fa-2x" style="margin-right: 5px;"
							aria-hidden="true"></i>
						<h4>Registration</h4>
					</div>



					<%
					String regMsg = (String) session.getAttribute("reg-success");

					if (regMsg != null) {
					%><div class="alert alert-success" role="alert"><%=regMsg%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Login..<a
							href="login.jsp">Click here</a>
					</div>
					<%
					session.removeAttribute("reg-success");
					}
					%>


					<%
					String failedMsg = (String) session.getAttribute("failed-msg");

					if (failedMsg != null) {
					%><div class="alert alert-danger" role="alert">
						<%=failedMsg%>
					</div>
					<%
					session.removeAttribute("failed-msg");
					}
					%>

					<div class="card-body">
						<form action="registerServlet" method="post">
							<div class="form-group">
								<label>Enter Full Name</label> <input type="text"
									class="form-control" id="exampleInputEmail1"
									aria-describedby="emailHelp" name="user_name">
							</div>
							<div class="form-group">
								<label>Enter Email</label> <input type="email"
									class="form-control" id="exampleInputEmail1"
									aria-describedby="emailHelp" name="user_email">
							</div>
							<div class="form-group">
								<label for="exampleInputPassword1">Enter Password</label> <input
									type="password" class="form-control" id="exampleInputPassword1"
									name="user_password">
							</div>
							<button type="submit"
								class="btn btn-primary badge-pill btn-block container-fluid1">Register</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@include file="all_component/footer.jsp"%>
</body>
</html>