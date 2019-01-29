<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Simple is The Bset - 주차장 예약하기</title>

<!-- Bootstrap core CSS-->
<link href="resources/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom fonts for this template-->
<link href="resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">

<!-- Custom styles for this template-->
<link href="resources/css/sb-admin.css" rel="stylesheet">

<script>
	function loginActionButton() {
		//form 이름이 loginAction인 form의 action값에 해당하는 controller로 이동.
		loginForm.submit();
	}
</script>
</head>

<body class="bg-dark">
	<div class="container">
		<div class="card card-login mx-auto mt-5">
			<div class="card-header">로그인</div>
			<div class="card-body">
				<form name="loginForm" id="loginForm" action="member/loginAction"
					method="post">
					<div class="btn-group btn-group-toggle" data-toggle="buttons"
						style="align-content: center;">
						<label class="btn btn-secondary"> <input type="radio"
							name="memberType" id="memberType" value="0"> 개인 회원
						</label>&nbsp;&nbsp; <label class="btn btn-secondary"> <input
							type="radio" name="memberType" id="memberType" value="1">
							기업 회원
						</label>
					</div>
					<br>
					<br>
					<div class="form-group">
						<div class="form-label-group">
							<input type="email" class="form-control"
								placeholder="Email address" required="required" id="email"
								name="email" autofocus="autofocus"> <label
								for="inputEmail">Email address</label>
						</div>
					</div>
					<div class="form-group">
						<div class="form-label-group">
							<input type="password" class="form-control"
								placeholder="Password" required="required" id="password"
								name="password"> <label for="inputPassword">Password</label>
						</div>
					</div>

					<input type="button" class="btn btn-primary btn-block"
						onclick="loginActionButton()" value="로그인">
				</form>
				<div class="text-center">
					<a class="d-block small mt-3" href="member/findIdAction">아이디 찾기</a>
					<a class="d-block small" href="member/findPasswordAction">비밀번호
						찾기</a> <a class="d-block small" href="member/joinTypeAction">회원가입</a>
				</div>
			</div>
		</div>
	</div>

	<!-- Bootstrap core JavaScript-->
	<script src="resources/vendor/jquery/jquery.min.js"></script>
	<script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="resources/vendor/jquery-easing/jquery.easing.min.js"></script>
</body>
</html>
