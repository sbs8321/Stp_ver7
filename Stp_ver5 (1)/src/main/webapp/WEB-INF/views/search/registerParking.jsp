<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
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

table.type04 {
	border-collapse: separate;
	border-spacing: 1px;
	text-align: left;
	line-height: 1.5;
	border-top: 1px solid #ccc;
	margin: 20px 10px;
}

table.type04 th {
	width: 150px;
	padding: 10px;
	font-weight: bold;
	vertical-align: top;
	border-bottom: 1px solid #ccc;
}

table.type04 td {
	width: 350px;
	padding: 10px;
	vertical-align: top;
	border-bottom: 1px solid #ccc;
}
</style>
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
<script>
	function exePostCode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var addr = ''; // 주소 변수
				var extraAddr = ''; // 참고항목 변수

				//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					addr = data.jibunAddress;
				}

				// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
				if (data.userSelectedType === 'R') {
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', '
								+ data.buildingName : data.buildingName);
					}
					// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					if (extraAddr !== '') {
						extraAddr = ' (' + extraAddr + ')';
					}

				}
				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('addr1').value = data.zonecode;
				document.getElementById("addr2").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("addr3").focus();
			}
		}).open();
	}

	function Button() {
		registerParking.submit();
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

	<div style="margin: 50px 0 0 0;" align="center">
		<h1>주차장 등록</h1>
		<br>
		<form name="registerParking" id="registerParking"
			action="registerParking" method="post">
			<table class="type04">
				<tr>
					<th scope="row">주차장 이름</th>
					<td><input type="text" name="prkplcenm" id="prkplcenm"
						placeholder="주차장 이름" style="width: 305px;" required="required">
					</td>
				<tr>
					<th scope="row">주차장 구분</th>
					<td><select name="prkplcese" style="width: 150px;"
						required="required">
							<option selected disabled>구분1</option>
							<option value="공영">공영</option>
							<option value="민영">민영</option>
					</select> <select name="prkplcetype" style="width: 150px;"
						required="required">
							<option selected disabled>구분2</option>
							<option value="노상">노상</option>
							<option value="노외">노외</option>
							<option value="부설">부설</option>
							<option value="기계식">기계식</option>
							<option value="자주식">자주식</option>
					</select></td>
				</tr>
				<tr>
					<th scope="row">구획 수</th>
					<td><input type="text" name="prkcmprt" id="prkcmprt"
						required="required"> 대</td>
				</tr>
				<tr>
					<th scope="row">최소 이용 시간</th>
					<td>1시간<input type="hidden" name="basictime" id="basictime"
						value="60"></td>
				</tr>
				<tr>
					<th scope="row" rowspan=3>이용 요금</th>
					<td><input type="text" name="hourPayment" id="hourPayment"
						style="width: 90px;" required="required"> 원 / 시간</td>
				</tr>
				<tr>
					<td><input type="text" name="daycmmtkt" id="daycmmtkt"
						style="width: 90px;" required="required"> 원 / 일</td>
				</tr>
				<tr>
					<td><input type="text" name="monthcmmtkt" id="monthcmmtkt"
						style="width: 90px;" required="required"> 원 / 월</td>
				</tr>
				<tr>
					<th scope="row">결제 방식</th>
					<td><select name="metpay" id="metpay" style="width: 150px;"
						required="required">
							<option value="현금">현금</option>
							<option value="카드">카드</option>
							<option value="현금+카드">현금+카드</option>
					</select></td>
				</tr>
				<tr>
					<th scope="row">운영 방식</th>
					<td><select name="spcmnt" id="spcmnt" style="width: 150px;"
						required="required">
							<option value="24시간(누구나)">24시간(누구나)</option>
							<option value="24시간(회원제)">24시간(회원제)</option>
							<option value="월정기차량만">월 정기차량만</option>
							<option value="주중24시간,주말12시간">주중24시간,주말12시간</option>
					</select></td>
				</tr>
				<tr>
					<th scope="row" rowspan=3>주차장 위치</th>
					<td><input type="text" id="addr1" name="addr1"
						required="required"> <input type="button"
						onclick="exePostCode()" value="우편번호 찾기"></td>
				</tr>
				<tr>
					<td><input type="text" id="addr2" name="addr2"
						placeholder="도로명 주소" required="required"></td>
				</tr>
				<tr>
					<td><input type="text" id="addr3" name="addr3"
						placeholder="상세 주소" required="required"></td>
				</tr>
			</table>

			<input type="button" onclick="parksearch();" value="검색">



			<div id="map"
				style="width: 550px; height: 400px; margin-top: 20px; margin-bottom: 20px;"
				align="center"></div>

			<p>
				<input type="button" onclick="Button();" value="등록">
			</p>

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
			<script
				src="../resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>



			<script type="text/javascript"
				src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d86cac5bb236368c66b4f9c0139790c9&libraries=services"></script>
			<script>
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				mapOption = {
					center : new daum.maps.LatLng(37.43864944368575,
							126.67543284487502), // 지도의 중심좌표
					level : 3
				// 지도의 확대 레벨
				};

				// 지도를 생성합니다    
				var map = new daum.maps.Map(mapContainer, mapOption);

				// 주소-좌표 변환 객체를 생성합니다
				var geocoder = new daum.maps.services.Geocoder();

				function parksearch() {

					var addr2 = $('#addr2').val();
					var addr3 = $('#addr3').val();

					if (addr2 == '' || addr3 == '') {
						alert("정확한 주소를 입력 하세요");
					} else {
						var addr = addr2 + addr3;
					}

					// 장소 검색 객체를 생성합니다
					var ps = new daum.maps.services.Places();

					// 키워드로 장소를 검색합니다
					ps.keywordSearch(addr2, placesSearchCB); // '' 검색 결과가 들어올수 있도록설정

					var latitude;
					var hardness;

					// 키워드 검색 완료 시 호출되는 콜백함수 입니다
					function placesSearchCB(data, status, pagination) {
						if (status === daum.maps.services.Status.OK) {

							// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
							// LatLngBounds 객체에 좌표를 추가합니다
							var bounds = new daum.maps.LatLngBounds();

							for (var i = 0; i < data.length; i++) {

								bounds.extend(new daum.maps.LatLng(data[i].y,
										data[i].x));
							}

							// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
							map.setBounds(bounds);

							// 지도를 클릭한 위치에 표출할 마커입니다
							var marker = new daum.maps.Marker({
								// 지도 중심좌표에 마커를 생성합니다 
								position : map.getCenter()
							});
							// 지도에 마커를 표시합니다
							marker.setMap(map);

							// 지도에 클릭 이벤트를 등록합니다
							// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
							daum.maps.event
									.addListener(
											map,
											'click',
											function(mouseEvent) {

												// 클릭한 위도, 경도 정보를 가져옵니다 
												var latlng = mouseEvent.latLng;

												// 마커 위치를 클릭한 위치로 옮깁니다
												marker.setPosition(latlng);

												latitude = latlng.getLat();
												hardness = latlng.getLng();

												document.registerParking.latitude.value = latitude;
												document.registerParking.hardness.value = hardness;

											});

						}
					}

				}
			</script>

			<input type="hidden" name="latitude" id="latitude" value="">
			<input type="hidden" name="hardness" id="hardness" value="">
			<input type="hidden" name="owner" id="owner"
				value="${sessionScope.loginID}">
		</form>
	</div>
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