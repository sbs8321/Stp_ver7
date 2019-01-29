<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script>
	function modifyPasswordButton() {
		//form 이름이 loginAction인 form의 action값에 해당하는 controller로 이동.
		modifyPasswordForm.submit();
	}
</script>
<title>Home</title>
</head>
<body>
	<h1 style="align-content: center;">
		<a href="home" style="color: black;">ST</a>
	</h1>

	<form name="modifyPasswordForm" id="modifyPasswordForm"
		action="modifyPasswordAction" method="post">

		<p>
			<input type="password" name="password" id="password"
				placeholder="PASSWORD">
		</p>
		<p>
			<input type="password" name="checkpassword" id="checkpassword"
				placeholder="PASSWORD">
		</p>
		<p>
			<input type="hidden" id="email" name="email" value="${user.email}">
			<input type="hidden" id="memberType" name="memberType" value="${user.memberType}">
			<input type="button" value="비밀번호변경" onclick="modifyPasswordButton()">
		</p>

	</form>
</body>
</html>
