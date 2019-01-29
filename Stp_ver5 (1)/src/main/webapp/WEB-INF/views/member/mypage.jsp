<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>

</head>
<script>
//포인트 충전하기
function pointCharge(){
	//POST 방식
	var form = document.createElement("form");
	form.setAttribute("charset", "UTF-8");
	form.setAttribute("method", "POST");
	form.setAttribute("action", "../payment/pointCharge");
	/* input 태그 만들기 */

	document.body.appendChild(form);
	
	var myForm = form;
	var url = "../payment/pointCharge";
	 window.open("" ,"form", 
	       "toolbar=no, width=540, height=800, directories=no, status=no,    scrollorbars=no, resizable=no"); 
	 myForm.action =url; 
	 myForm.method="post";
	 myForm.target="form";
	 myForm.submit();

		
}

	//정보 수정하기
	function informationChange(){
		//POST 방식
		var form = document.createElement("form");
		form.setAttribute("charset", "UTF-8");
		form.setAttribute("method", "POST");
		form.setAttribute("action", "../payment/informationChange");
		/* input 태그 만들기 */

		document.body.appendChild(form);
		
		var myForm = form;
		var url = "../payment/informationChange";
		 window.open("" ,"form", 
		       "toolbar=no, width=540, height=800, directories=no, status=no,    scrollorbars=no, resizable=no"); 
		 myForm.action =url; 
		 myForm.method="post";
		 myForm.target="form";
		 myForm.submit();

	}
	//비밀번호 수정하기
	function passwordChange(){
		//POST 방식
		var form = document.createElement("form");
		form.setAttribute("charset", "UTF-8");
		form.setAttribute("method", "POST");
		form.setAttribute("action", "../payment/passwordChange");
		/* input 태그 만들기 */

		document.body.appendChild(form);
		
		var myForm = form;
		var url = "../payment/passwordChange";
		 window.open("" ,"form", 
		       "toolbar=no, width=540, height=800, directories=no, status=no,    scrollorbars=no, resizable=no"); 
		 myForm.action =url; 
		 myForm.method="post";
		 myForm.target="form";
		 myForm.submit();

		
	}
	
	//환전 신청하기
	function pointExchange() {	
		//팝업창으로 exchange 창 띄우기
		//POST 방식
		var form = document.createElement("form");
		form.setAttribute("charset", "UTF-8");
		form.setAttribute("method", "POST");
		form.setAttribute("action", "../payment/exchange");
		/* input 태그 만들기 */

		document.body.appendChild(form);
		
		var myForm = form;
		var url = "../payment/exchange";
		 window.open("" ,"form", 
		       "toolbar=no, width=540, height=800, directories=no, status=no,    scrollorbars=no, resizable=no"); 
		 myForm.action =url; 
		 myForm.method="post";
		 myForm.target="form";
		 myForm.submit();
	}
	
	//회원 관리하기
	function memberManage(){
		
		//POST 방식
		var form = document.createElement("form");
		form.setAttribute("charset", "UTF-8");
		form.setAttribute("method", "POST");
		form.setAttribute("action", "../payment/memberManage");
		/* input 태그 만들기 */

		document.body.appendChild(form);
		form.submit();
	}
	
		
	
	//환전 관리하기
	function exchangeManage(){
		//POST 방식
		var form = document.createElement("form");
		form.setAttribute("charset", "UTF-8");
		form.setAttribute("method", "POST");
		form.setAttribute("action", "../payment/exchangeManage");
		/* input 태그 만들기 */

		document.body.appendChild(form);
		form.submit();
	}
	
	}
	//처음 화면(검색)
	function home(){
		var home = document.createElement("form");
		home.setAttribute("charset", "UTF-8");
		home.setAttribute("method", "POST");
		home.setAttribute("action", "../search/gotoHome");

		document.body.appendChild(home);

		/* 자동 submit */
		home.submit();
	}
	//예약 내역
	function reserve(){
		//POST 방식
		var reserveList = document.createElement("form");
		reserveList.setAttribute("charset", "UTF-8");
		reserveList.setAttribute("method", "POST");
		reserveList.setAttribute("action", "../payment/reservationList");

		document.body.appendChild(reserveList);
		reserveList.submit();
	}
	//포인트 내역
	function point(){
		var pointList = document.createElement("form");
		pointList.setAttribute("charset", "UTF-8");
		pointList.setAttribute("method", "POST");
		pointList.setAttribute("action", "../payment/pointPage");

		document.body.appendChild(pointList);
		pointList.submit();
	}
</script>
<body>


	<input type="button" value="정보 수정하기 " onclick="informationChange()">
	<input type="button" value="비밀번호 수정하기" onclick="passwordChange()">
	<input type="button" onclick="home()" value="첫화면으로 이동">
	<input type="button" onclick="reserve()" value="예약 내역으로 이동">
	<input type="button" onclick="point()" value="포인트 내역으로 이동">
	<c:set var="type" value="${sessionScope.type }" />
	<!-- 0이면 개인회원, 1이면 기업회원, 2면 admin -->
	<c:choose>

		<c:when test="${type eq '1'}">
			<form name="popForm">
				<input type="button" value="포인트 환전하기" onclick="pointExchange()">
			</form>
		</c:when>

		<c:when test="${type eq '2'}">
			<input type="button" value="회원 관리하기" onclick="memberManage()">
			<input type="button" value="환전 관리하기" onclick="exchangeManage()">
		</c:when>
	</c:choose>

	<hr border=1>
	<h1>즐겨찾기</h1>
	<h1>즐겨찾기</h1>
	<h1>즐겨찾기</h1>
	<h1>즐겨찾기</h1>
	<h1>즐겨찾기</h1>
</body>
</html>