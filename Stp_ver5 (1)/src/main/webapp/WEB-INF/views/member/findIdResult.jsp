<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-Latest.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-Latest.js"></script>

<title>Insert title here</title>
</head>
<body>
   <div id="findResult" style="width:500px; text-align:center;">
      <hr>
      회원님의 아이디는 ${findMember.email} 입니다.<br><br>
      <a href="../"><input type="button" value="로그인"></a>
      <a href="findPasswordAction"><input type="button" value="비밀번호 찾기"></a>
   </div>
</body>
</html>