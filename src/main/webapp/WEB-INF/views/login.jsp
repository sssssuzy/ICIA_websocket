<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<style>
body {
	background: #f8f8f8;
	padding: 60px 0;
}

#login-form>div {
	margin: 15px 0;
}

#divLogin {
	width: 500px;
	margin: 0px auto;
}
</style>
<title>Login</title>
</head>
<body>
	<div id="divLogin">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">채팅</h3>
			</div>
			<div class="panel-body">
				<form id="login-form" method="post" action="login">
					<div>
						<input type="text" name="id" class="form-control" name="userName"
							placeholder="아이디 입력" />
					</div>
					<div>
						<button type="submit" class="form-control btn btn-primary">로그인</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>