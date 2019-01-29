<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="http://code.jquery.com/jquery-Latest.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-Latest.js"></script>

<script type="text/javascript">
   function findId(){
      var memberType=$('input[name="memberType"]:checked').val();
      var name=$('#name').val();
      var phone_mid=$('#phone_mid').val();
      var phone_end=$('#phone_end').val();
      console.log("findId 함수 실행 : "+memberType+" / "+name+" / "+phone_mid+" / "+phone_end);
      
      $.ajax({
         type: 'POST',
         url: 'findId',
         data: {memberType: memberType,
            name: name,
            phone_mid: phone_mid,
            phone_end: phone_end},
         success: function(result) {
            $('#findResult').html(result);
         },
         error: function() { // 통신의 실패를 의미
            alert("일치하는 정보가 없습니다. 다시 시도해주세요.");
         }
      });
   }
</script>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
   <h1 style="align-content: center;">
      <a href="home" style="color: black;">ST</a>
   </h1>
   <form name="findIdForm" id="findIdForm" action="findIdAction"
      method="post">
      <!-- <p>
         <label for="memberType"></label>
         <input type="radio" name="memberType" id="memberType" value="0">일반 
         <input type="radio" name="memberType" id="memberType" value="1">기업
      </p> -->
      <table style="width:500px; text-align:center">
         <tr>
            <td></td>
            <td ><input type="radio" name="memberType" id="memberType" value="0">일반 
               <input type="radio" name="memberType" id="memberType" value="1">기업</td>
            <td></td>
         </tr>
         <tr>
            <td>이름</td>
            <td><input type="text" name="name" id="name" style="width:224px"></td>
            <td rowspan="2"><a href="javascript:findId()"><input type="button" value="아이디 찾기"></a></td>
         </tr>
         <tr>
            <td>휴대전화번호</td>
            <td><input type="text" name="phone_front" id="phone_front" style="width:60px"> -
               <input type="text" name="phone_mid" id="phone_mid" style="width:60px"> -
               <input type="text" name="phone_end" id="phone_end" style="width:60px"></td>
         </tr>
      </table>
   </form>
   <div id="findResult"></div>
</body>
</html>