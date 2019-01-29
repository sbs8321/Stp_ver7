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

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<!-- Bootstrap core CSS -->
<link href="../resources/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Custom styles for this template -->
<link href="../resources/css/modern-business.css" rel="stylesheet">
<title>Insert title here</title>

<style>
#jb-container {
	width: 100%;
	height: 33%;
	margin: 0px auto;
	padding: 5px;
	border: 1px solid #bcbcbc;
	margin: 0px auto;
}

#jb-comment {
	width: 73%;
	height: 98%;
	padding: 10px;
	margin-bottom: 5px;
	float: right;
	padding: 3px;
}

#jb-time {
	width: 25%;
	height: 98%;
	padding: 10px;
	margin-bottom: 5px;
	float: left;
}
</style>
<script>
	function addbookmark() {
		var email = $('#email').val();
		var prkplcenm = $('#prkplcenm').val();
		var prkplceno = $('#prkplceno').val();
		var lnmadr = $('#lnmadr').val();
		var parkimg = $('#parkimg').val();
		var prkcmprt = $('#prkcmprt').val();

		$.ajax({
			type : 'POST',
			url : '../search/addbookmark', // 컨트롤러에서 사용 할 주소값
			data : {
				email : email,
				prkplcenm : prkplcenm,
				prkplceno : prkplceno,
				lnmadr : lnmadr,
				parkimg : parkimg,
				prkcmprt : prkcmprt
			},
			success : function(data) { // 통신의 성공을 의미
				$("#bookmark").html(data);
			},
			error : function() { // 통신의 실패를 의미
				alert("아이디 중복확인 ajax 실패");
			}
		});
	}

	function delbookmark() {
		var email = $('#email').val();
		var prkplcenm = $('#prkplcenm').val();
		var prkplceno = $('#prkplceno').val();
		var lnmadr = $('#lnmadr').val();
		var parkimg = $('#parkimg').val();
		var prkcmprt = $('#prkcmprt').val();

		$.ajax({
			type : 'POST',
			url : '../search/delbookmark', // 컨트롤러에서 사용 할 주소값
			data : {
				email : email,
				prkplceno : prkplceno
			},
			success : function(data) { // 통신의 성공을 의미
				$("#bookmark").html(data);
			},
			error : function() { // 통신의 실패를 의미
				alert("아이디 중복확인 ajax 실패");
			}
		});
	}
</script>
<script>
	//user로 로그인했다면
	window.onload = function() {
		var type = '${sessionScope.type}';
		if (type == 0) {
			$(".userButton").show();
		} else if (type == 1) {
			$(".ownerButton").show();
		} else if (type == 2) {
			$(".adminButton").show();
			$(".listButton").hide();
		}

	}
</script>
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
								<a class="dropdown-item" href="javascript:parkingReserve()">주차장
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
									<a class="dropdown-item" href="javascript:parkingReserve()">환전
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
	<br>
	<br>
	<br>

	
		<input type="hidden" id="prkplcenm" name="prkplcenm"
			value="${parkDetail.prkplcenm}">
		<input type="hidden" id="prkplceno" name="prkplceno"
			value="${parkDetail.prkplceno}">
		<input type="hidden" id="lnmadr" name="lnmadr"
			value="${parkDetail.lnmadr}">
		<input type="hidden" id="parkimg" name="parkimg"
			value="${parkDetail.parkimg}">
		<input type="hidden" id="prkcmprt" name="prkcmprt"
			value="${parkDetail.prkcmprt}">
		<input type="hidden" id="email" name="email"
			value="${sessionScope.loginID}">
		<input type="hidden" id="latitude" name="latitude"
			value="${parkDetail.latitude}">
		<input type="hidden" id="hardness" name="hardness"
			value="${parkDetail.hardness}">

	<div class="container">
		<div style="width: 100%; text-align: center;" id="container">
			<h3>주차 예약</h3>
			<div style="display: inline-block; width: 90%;">
				<hr>
				<form name="bookTime" id="bookTime" action="bookable" method="post">
					<input type="hidden" name="parking_id"
						value="${parkDetail.prkplceno }">
					<table style="margin: auto;">
						<tr>
							<td style="width: 120px">이용 날짜</td>
							<td style="text-align: left;"><input type="date"
								style="text-align: center; height: 25px" id="currentDate1"
								name="entrance_date"></td>
						</tr>
						<tr>
							<td colspan="2"><br></td>
						</tr>
						<tr>
							<td>이용 시간</td>
							<td style="text-align: left;"><select style="height: 26px;"
								name="entrance_time" id="entrance_time" size="1" required>
									<option SELECTED DISABLED>시간 선택</option>
									<option VALUE="1">01:00</option>
									<option VALUE="2">02:00</option>
									<option VALUE="3">03:00</option>
									<option VALUE="4">04:00</option>
									<option VALUE="5">05:00</option>
									<option VALUE="6">06:00</option>
									<option VALUE="7">07:00</option>
									<option VALUE="8">08:00</option>
									<option VALUE="9">09:00</option>
									<option VALUE="10">10:00</option>
									<option VALUE="11">11:00</option>
									<option VALUE="12">12:00</option>
									<option VALUE="13">13:00</option>
									<option VALUE="14">14:00</option>
									<option VALUE="15">15:00</option>
									<option VALUE="16">16:00</option>
									<option VALUE="17">17:00</option>
									<option VALUE="18">18:00</option>
									<option VALUE="19">19:00</option>
									<option VALUE="20">20:00</option>
									<option VALUE="21">21:00</option>
									<option VALUE="22">22:00</option>
									<option VALUE="23">23:00</option>
									<option VALUE="24">24:00</option>
							</select> &nbsp;~&nbsp; <select style="height: 26px" name="exit_time"
								id="exit_time" size="1" required>
									<option SELECTED DISABLED>시간 선택</option>
									<option VALUE="1">01:00</option>
									<option VALUE="2">02:00</option>
									<option VALUE="3">03:00</option>
									<option VALUE="4">04:00</option>
									<option VALUE="5">05:00</option>
									<option VALUE="6">06:00</option>
									<option VALUE="7">07:00</option>
									<option VALUE="8">08:00</option>
									<option VALUE="9">09:00</option>
									<option VALUE="10">10:00</option>
									<option VALUE="11">11:00</option>
									<option VALUE="12">12:00</option>
									<option VALUE="13">13:00</option>
									<option VALUE="14">14:00</option>
									<option VALUE="15">15:00</option>
									<option VALUE="16">16:00</option>
									<option VALUE="17">17:00</option>
									<option VALUE="18">18:00</option>
									<option VALUE="19">19:00</option>
									<option VALUE="20">20:00</option>
									<option VALUE="21">21:00</option>
									<option VALUE="22">22:00</option>
									<option VALUE="23">23:00</option>
									<option VALUE="24">24:00</option>
							</select></td>
						</tr>
					</table>
					<br>
					<div align="center">
						<a href="javascript:bookable()" class="btn btn-primary " style="margin-left: 70%;"	>검색</a>
					</div>
				</form>
			</div>
	</div>
		<div id="bookable_result" style="display: inline-block; width: 70%;"></div><br>
	</div>


		<div class="container">
			<div id="" style=" width: 100%; margin: auto;">
				<hr>
				<div style="float: left; width: 230px; height: 210px; margin-left:220px; border: 1px solid blue;">
					<img src="${parkDetail.parkimg}" width="100%" height="210">
				</div>
	
			

			<div style="margin: auto;">
				<table class="table table-hover" style="width: 400px; text-align: left; height: 180px;">
					<tr>
						<td colspan=2><b style="font-size: large;">
								${parkDetail.prkplcenm } </b> <span style="font-size: small;">${parkDetail.prkplcese }·${parkDetail.prkplcetype }</span></td>
					</tr>
					<tr>
						<td colspan=2>${parkDetail.rdnmadr }</td>
					</tr>
					<tr>
						<td rowspan=3 style="text-align: center; line-height: 85px">이용
							요금</td>
						<td>${parkDetail.hourPayment }원/1시간</td>
					</tr>
					<tr>
						<td>${parkDetail.daycmmtkt }원/1일</td>
					</tr>
					<tr>
						<td>${parkDetail.monthcmmtkt }원/1개월</td>
					</tr>
					<tr>
						<td colspan=2><span style="font-size: small;">최소 이용 시간
								<b>1시간</b> / 이용 시간 단위 <b>1시간</b>
						</span></td>
					</tr>
				</table>
			</div>
			</div>	
		</div>
		
		<div class="container">
			<div style="width: 50%; margin: auto;">
				<a href="javascript:void plusFriendChat()"> <img src="https://developers.kakao.com/assets/img/about/logos/plusfriend/consult_small_yellow_pc.png" /></a>
				<div id="bookmark" style=" float: right;"></div> 
			</div>
			
			<div id="staticMap" style=" height: 350px; margin: auto; "></div><hr>
	
		
	
			<div id="" style="width: 100%; text-align: left; margin: auto;">
				<input type="hidden" name="sessionId" id="sessionId" value=<%=session.getAttribute("loginID")%>>
				
				<div style="margin: auto; width: 100%">
					<input style="width: 80%; padding-left: 10px; height: 32px;"type="text" placeholder="댓글 작성.." class="reply_content" name="reply_content" id="reply_content" onkeyup="enterkey();"> &nbsp;
					<input type="button" class="btn btn-outline-success" onclick="replySubmit()" value="작성" >
				</div>
	
				<br>
				<div style="margin-left: 100%; margin: auto;" id="replies"></div>
			</div>
	
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




	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d86cac5bb236368c66b4f9c0139790c9"></script>
	<script>
		// 이미지 지도에서 마커가 표시될 위치입니다 
		var markerPosition = new daum.maps.LatLng('${parkDetail.latitude }',
				'${parkDetail.hardness }');

		// 이미지 지도에 표시할 마커입니다
		// 이미지 지도에 표시할 마커는 Object 형태입니다
		var marker = {
			position : markerPosition
		};

		var staticMapContainer = document.getElementById('staticMap'), // 이미지 지도를 표시할 div  
		staticMapOption = {
			center : new daum.maps.LatLng('${parkDetail.latitude }',
					'${parkDetail.hardness }'), // 이미지 지도의 중심좌표
			level : 3, // 이미지 지도의 확대 레벨
			marker : marker
		// 이미지 지도에 표시할 마커 
		};

		// 이미지 지도를 생성합니다
		var staticMap = new daum.maps.StaticMap(staticMapContainer,
				staticMapOption);
	</script>

	<script type="text/javascript">
		function enterkey() {
			if (window.event.keyCode == 13) {
				replySubmit();
			}
		}

		function replySubmit() {
			var content = $('#reply_content').val();
			var sessionId = $('#sessionId').val();
			var parkingId = $('#prkplceno').val();
			console.log("replySubmit 함수 호출 / 파라미터 : " + content);
			console.log("replySubmit 함수 호출 / 파라미터 : " + sessionId);
			$.ajax({
				type : 'POST',
				url : '../search/replySubmit',
				data : {
					content : content,
					sessionId : sessionId,
					parkingId : parkingId
				},

				success : function(data) {
					if (data == 1) {
						console.log("댓글 작성 성공");
						$('.reply_content').val("");
						replyList();
					} else {
						console.log("댓글 작성 실패");
					}
				},
				error : function() {
					console.log("댓글 작성 ajax 실패");
				}
			});
		}

		function replyList() {
			var parkingId = $('#prkplceno').val();
			console.log("replyList 함수 호출 ");
			$.ajax({
				type : 'POST',
				url : '../search/replyList',
				data : {
					parkingId : parkingId
				},
				success : function(result) {
					console.log("댓글 목록 불러오기 성공");
					$("#replies").html(result);
				},
				error : function() {
					console.log("댓글 목록 ajax 실패");
				}
			});
		}
	</script>


	<script>
		window.onload = function() {
			replyList();
			var email = $('#email').val();
			var prkplceno = $('#prkplceno').val();

			$.ajax({
				type : 'POST',
				url : '../search/isbookmark', // 컨트롤러에서 사용 할 주소값
				data : {
					email : email,
					prkplceno : prkplceno
				},
				success : function(data) { // 통신의 성공을 의미
					$("#bookmark").html(data);
				},
				error : function() { // 통신의 실패를 의미
					alert("북마크 ajax 실패");
				}
			});
		}
	</script>

	<script type='text/javascript'>
		//<![CDATA[
		// 사용할 앱의 JavaScript 키를 설정해 주세요.
		Kakao.init('d86cac5bb236368c66b4f9c0139790c9');
		function plusFriendChat() {
			Kakao.PlusFriend.chat({
				plusFriendId : '_WBsaj' // 플러스친구 홈 URL에 명시된 id로 설정합니다.
			});
		}
		//]]>
	</script>


	<script type="text/javascript">
		document.getElementById('currentDate1').value = new Date()
				.toISOString().substring(0, 10);

		function bookable() {
			var entTime = $('#entrance_time').val();
			var exitTime = $('#exit_time').val();
			if (entTime == null) {
				alert('입차 시간을 선택해주세요');
			} else if (exitTime == null) {
				alert('출차 시간을 선택해주세요');
			} else {
				console.log("bookable 함수 호출 ");
				var bookData = $("form[name=bookTime]").serialize();

				$.ajax({
					type : 'POST',
					url : '../search/bookable',
					data : bookData,

					success : function(result) {
						console.log("예약가능여부 조회 성공");
						$("#bookable_result").html(result);
					},
					error : function() {
						console.log("예약가능여부 조회 실패");
					}
				});
			}
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
		function parkingReserve() {
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