<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Simple is The Best - 주차장 예약하기</title>

<!-- Bootstrap core CSS -->
<link href="../resources/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom styles for this template -->
<link href="../resources/css/modern-business.css" rel="stylesheet">

<style type="text/css">
button {
	background: #EEEEEEE;
	color: #eeeeeee;
	border: none;
	position: relative;
	height: 120px;
	font-size: 1.6em;
	padding: 0 2em;
	cursor: pointer;
	transition: 800ms ease all;
	outline: none;
}

button:hover {
	background: #fff;
	color: #eeeeee;
}

button:before, button:after {
	content: '';
	position: absolute;
	top: 0;
	right: 0;
	height: 2px;
	width: 0;
	background: #1AAB8A;
	transition: 400ms ease all;
}

button:after {
	right: inherit;
	top: inherit;
	left: 0;
	bottom: 0;
}

button:hover:before, button:hover:after {
	width: 100%;
	transition: 800ms ease all;
}
</style>
<script>
	function serchActionButton() {
		//form 이름이 loginAction인 form의 action값에 해당하는 controller로 이동.
		serchForm.submit();
	}
</script>

<!-- 버튼 관련 js 파일 첨부 -->
</head>
<body>
	<!-- Navigation -->
	<nav
		class="navbar fixed-top navbar-expand-lg navbar-dark bg-dark fixed-top">
		<div class="container">
			<a class="navbar-brand" href="javascript:home()">Start Parking
				Reservation</a>
			<button class="navbar-toggler navbar-toggler-right" type="button"
				data-toggle="collapse" data-target="#navbarResponsive"
				aria-controls="navbarResponsive" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ml-auto">
					<!-- 마이페이지 드롭다운 -->
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#"
						id="navbarDropdownPortfolio" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false"> 마이페이지 </a>
						<div class="dropdown-menu dropdown-menu-right"
							aria-labelledby="navbarDropdownPortfolio">
							<a class="dropdown-item" href="portfolio-1-col.html">정보 수정</a> <a
								class="dropdown-item" href="portfolio-2-col.html">비밀번호 변경</a>

							<!-- user인 경우 -->
							<div class="userButton" style="display: none">
								<a class="dropdown-item" href="portfolio-3-col.html">즐겨찾기 </a> <a
									class="dropdown-item" href="javascript:pointCharge()">포인트
									충전 </a>
							</div>
							<!-- owner인 경우 -->
							<div class="ownerButton" style="display: none">
								<a class="dropdown-item" href="javascript:parkingReserve();">주차장
									등록</a> <a class="dropdown-item" href="javascript:pointExchange()">포인트
									환전</a>
							</div>

						</div></li>

					<li class="nav-item dropdown">
						<div class="listButton">
							<a class="nav-link dropdown-toggle" href="#"
								id="navbarDropdownBlog" data-toggle="dropdown"
								aria-haspopup="true" aria-expanded="false"> 내역 보기 </a>
							<div class="dropdown-menu dropdown-menu-right"
								aria-labelledby="navbarDropdownBlog">
								<div class="userButton" style="display: none">
									<a class="dropdown-item" href="javascript:reserve()">예약 내역</a>
									<a class="dropdown-item" href="javascript:payment()">결제 내역</a>
									<a class="dropdown-item" href="javascript:point()">포인트 내역</a>
								</div>
								<!-- owner인 경우 -->
								<div class="ownerButton" style="display: none">
									<a class="dropdown-item" href="javascript:exchangeList()">환전
										신청 내역</a>
								</div>
							</div>
						</div>
					</li>


					<li class="nav-item dropdown">
						<div class="adminButton" style="display: none">
							<a class="nav-link dropdown-toggle" href="#"
								id="navbarDropdownBlog" data-toggle="dropdown"
								aria-haspopup="true" aria-expanded="false"> 관리 </a>
							<div class="dropdown-menu dropdown-menu-right"
								aria-labelledby="navbarDropdownBlog">
								<a class="dropdown-item" href="javascript:memberManage()">회원
									관리</a> <a class="dropdown-item" href="sidebar.html">주차장 관리</a> <a
									class="dropdown-item" href="javascript:exchangeManage()">환전
									관리</a> <a class="dropdown-item" href="javascript:reserveManage()">예약
									관리</a>
							</div>
						</div>
					</li>

				</ul>
			</div>
		</div>
	</nav>


	<div class="container">
		<div align="center" style="margin-top: 150px;">
			<h1 style="align-content: center;">
				<img src="../resources/img/logo/logo.png" width="60%"
					style="margin: auto">
			</h1>
		</div>


		<div align="center" style="margin-top: 70px;">
			<form action="../search/search" method="post">
				<input type="text" id="place" name="place"
					style="width: 100%; height: 50px; background-color: #dcdcdc; margin: auto;" />
				<button type="submit" style="height: 60px; width: 200px;">검색</button>
			</form>
		</div>

		<c:choose>
			<c:when test="${sessionScope.type eq 0}">
				<div id="bookmarkList"></div>
			</c:when>
			<c:when test="${sessionScope.type eq 1}">
				<div id="myparkingkList"></div>
			</c:when>
			<c:otherwise>
				<div id="confirmList"></div>
			</c:otherwise>
		</c:choose>
	</div>




	<!-- Footer -->
	<footer class="py-5 bg-dark">
		<div class="container">
			<p class="m-0 text-center text-white">Copyright &copy; Your
				Website 2019</p>
		</div>
		<!-- /.container -->
	</footer>

	<!-- Bootstrap core JavaScript -->
	<script src="../resources/vendor/jquery/jquery.min.js"></script>
	<script src="../resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>


	<input type="hidden" id=email name="email"
		value="${sessionScope.loginID}">
	<script>
		var type = '${sessionScope.type}';
		if (type == 0) {
			window.onload = function() {
				var email = $('#email').val();
				$.ajax({
					type : 'POST',
					url : '../search/bookmarkList', // 컨트롤러에서 사용 할 주소값
					data : {
						email : email,
					},
					success : function(data) { // 통신의 성공을 의미
						$("#bookmarkList").html(data);
					},
					error : function() { // 통신의 실패를 의미
						alert("북마크 리스트 실패");
					}
				});
			}
		} else if (type == 1) {
			window.onload = function() {
				var email = $('#email').val();
				$.ajax({
					type : 'POST',
					url : '../search/myparkingkList', // 컨트롤러에서 사용 할 주소값
					data : {
						email : email,
					},
					success : function(data) { // 통신의 성공을 의미
						$("#myparkingkList").html(data);
					},
					error : function() { // 통신의 실패를 의미
						alert("아이디 중복확인 ajax 실패");
					}
				});
			}
		} else {
			window.onload = function() {
				var email = $('#email').val();
				$.ajax({
					type : 'POST',
					url : '../search/stateparking', // 컨트롤러에서 사용 할 주소값
					data : {
						email : email,
					},
					success : function(data) { // 통신의 성공을 의미
						$("#confirmList").html(data);
					},
					error : function() { // 통신의 실패를 의미
						alert("아이디 중복확인 ajax 실패");
					}
				});
			}
		}

		var type = '${sessionScope.type}';
		if (type == 0) {
			$(".userButton").show();
		} else if (type == 1) {
			$(".ownerButton").show();
		} else if (type == 2) {
			$(".adminButton").show();
			$(".listButton").hide();
		}
	</script>
	<script>
		//정보 수정하기
		function informationChange() {
			// POST 방식
			var form = document.createElement("form");
			form.setAttribute("charset", "UTF-8");
			form.setAttribute("method", "POST");
			form.setAttribute("action", "../payment/informationChange");
			/* input 태그 만들기 */

			document.body.appendChild(form);

			var myForm = form;
			var url = "../payment/informationChange";
			window
					.open(
							"",
							"form",
							"toolbar=no, width=540, height=800, directories=no, status=no,    scrollorbars=no, resizable=no");
			myForm.action = url;
			myForm.method = "post";
			myForm.target = "form";
			myForm.submit();

		}

		//비밀번호 수정하기
		function passwordChange() {
			//POST 방식
			var form = document.createElement("form");
			form.setAttribute("charset", "UTF-8");
			form.setAttribute("method", "POST");
			form.setAttribute("action", "../payment/passwordChange");
			/* input 태그 만들기 */

			document.body.appendChild(form);

			var myForm = form;
			var url = "../payment/passwordChange";
			window
					.open(
							"",
							"form",
							"toolbar=no, width=540, height=800, directories=no, status=no,    scrollorbars=no, resizable=no");
			myForm.action = url;
			myForm.method = "post";
			myForm.target = "form";
			myForm.submit();

		}

		//포인트 충전하기
		function pointCharge() {
			//POST 방식
			var form = document.createElement("form");
			form.setAttribute("charset", "UTF-8");
			form.setAttribute("method", "POST");
			form.setAttribute("action", "../payment/pointCharge");
			/* input 태그 만들기 */

			document.body.appendChild(form);

			var myForm = form;
			var url = "../payment/pointCharge";
			window
					.open(
							"",
							"form",
							"toolbar=no, width=540, height=800, directories=no, status=no,    scrollorbars=no, resizable=no");
			myForm.action = url;
			myForm.method = "post";
			myForm.target = "form";
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
			window
					.open(
							"",
							"form",
							"toolbar=no, width=540, height=800, directories=no, status=no,    scrollorbars=no, resizable=no");
			myForm.action = url;
			myForm.method = "post";
			myForm.target = "form";
			myForm.submit();
		}

		//회원 관리하기
		function memberManage() {

			//POST 방식
			var form = document.createElement("form");
			form.setAttribute("charset", "UTF-8");
			form.setAttribute("method", "POST");
			form.setAttribute("action", "../member/memberManage");
			/* input 태그 만들기 */

			document.body.appendChild(form);
			form.submit();
		}

		//환전 관리하기
		function exchangeManage() {
			//POST 방식
			var form = document.createElement("form");
			form.setAttribute("charset", "UTF-8");
			form.setAttribute("method", "POST");
			form.setAttribute("action", "../payment/exchangeManage");
			/* input 태그 만들기 */

			document.body.appendChild(form);
			form.submit();
		}

		//처음 화면(검색)
		function home() {
			var home = document.createElement("form");
			home.setAttribute("charset", "UTF-8");
			home.setAttribute("method", "POST");
			home.setAttribute("action", "../search/gotoHome");

			document.body.appendChild(home);

			/* 자동 submit */
			home.submit();
		}
		//예약 내역
		function reserve() {
			//POST 방식
			var reserveList = document.createElement("form");
			reserveList.setAttribute("charset", "UTF-8");
			reserveList.setAttribute("method", "POST");
			reserveList.setAttribute("action", "../search/reservationList");

			document.body.appendChild(reserveList);
			reserveList.submit();
		}
		//포인트 내역
		function point() {
			var pointList = document.createElement("form");
			pointList.setAttribute("charset", "UTF-8");
			pointList.setAttribute("method", "POST");
			pointList.setAttribute("action", "../payment/pointPage");

			document.body.appendChild(pointList);
			pointList.submit();
		}
		//결제 내역
		function payment() {
			var payment = document.createElement("form");
			payment.setAttribute("charset", "UTF-8");
			payment.setAttribute("method", "POST");
			payment.setAttribute("action", "../payment/paymentList");

			document.body.appendChild(payment);
			payment.submit();
		}
		//주차장 등록
		function parkingReserve() {
			var payment = document.createElement("form");
			payment.setAttribute("charset", "UTF-8");
			payment.setAttribute("method", "POST");
			payment.setAttribute("action", "../search/registerParingForm");

			document.body.appendChild(payment);
			payment.submit();
		}
		//환전 신청 내역
		function exchangeList() {
			var payment = document.createElement("form");
			payment.setAttribute("charset", "UTF-8");
			payment.setAttribute("method", "POST");
			payment.setAttribute("action", "../payment/exchangeList");

			document.body.appendChild(payment);
			payment.submit();
		}

		//예약 관리
		function reserveManage() {
			var payment = document.createElement("form");
			payment.setAttribute("charset", "UTF-8");
			payment.setAttribute("method", "POST");
			payment.setAttribute("action", "../search/reserveList");

			document.body.appendChild(payment);
			payment.submit();
		}

		//주차장 관리
	</script>



</body>
</html>