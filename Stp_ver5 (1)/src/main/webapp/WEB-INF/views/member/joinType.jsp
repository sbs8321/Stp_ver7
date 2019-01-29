<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script>
	function joinUserAction() {
		location.href = "joinUser";
	}
	function joinOwnerAction() {
		location.href = "joinOwner";
	}
</script>
<meta charset="UTF-8">
<title>joinType</title>
</head>
<body>
	<h1 style="align-content: center;">
		<a href="home" style="color: black;">ST</a>
	</h1>
	<p>
		<input type="button" value="개인 회원가입" onclick="joinUserAction()">
	</p>
	<p>
		<input type="button" value="기업 회원가입" onclick="joinOwnerAction()">
	</p>
</body>
</html>