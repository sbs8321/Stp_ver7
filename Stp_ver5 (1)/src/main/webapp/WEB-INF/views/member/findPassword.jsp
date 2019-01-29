<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script>
   function findPasswordActionButton() {
      findPasswordForm.submit();
   }
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
   <h1 style="align-content: center;">
      <a href="../" style="color: black;">ST</a>
   </h1>
   <form name="findPasswordForm" id="findPasswordForm" action="findPasswordAction"
      method="post">
      <p>
         <input type="radio" name="memberType" id="memberType"
            checked="checked" value=0>일반 <input type="radio"
            name="memberType" id="memberType" value=1>기업
      </p>
      <p>
         <input type="email" name="email" id="email" placeholder="email">
      </p>
      <p>
         <input type="text" name="name" id="name" placeholder="name">
      </p>
      <p>
         <input type="text" name="phone_front" id="phone_front" placeholder="010" style="width:40px"> -
         <input type="text" name="phone_mid" id="phone_mid" placeholder="1234" style="width:50px"> -
         <input type="text" name="phone_end" id="phone_end" placeholder="5678" style="width:50px">
      </p>

      <p>
         <input type="button" value="찾기" onclick="findPasswordActionButton()">
      </p>
      <p>
         <a href="../">로그인</a> / <a href="joinTypeAction">회원가입</a>
      </p>
   </form>
</body>
</html>