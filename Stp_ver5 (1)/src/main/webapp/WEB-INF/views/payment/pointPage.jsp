<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>STP - 포인트 내역 목록</title>

<!-- Bootstrap core CSS-->
<link href="../resources/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom fonts for this template-->
<link href="../resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">

<!-- Page level plugin CSS-->
<link href="../resources/vendor/datatables/dataTables.bootstrap4.css"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="../resources/css/sb-admin.css" rel="stylesheet">
</head>
<script>
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
</script>
<script>
//user로 로그인했다면
window.onload = function(){
	var type = '${sessionScope.type}';
	if(type == 0){
		$(".userButton").show();	
	}else if(type==1){
		$(".ownerButton").show();	
	}else if(type == 2){
		$(".adminButton").show();
		$(".listButton").hide();	
	}
	
}
</script>
<body>
<!-- Navigation -->
	<nav
		class="navbar fixed-top navbar-expand-lg navbar-dark bg-dark fixed-top">
		<div class="container">
			<a class="navbar-brand" href="javascript:home()">Start Parking Reservation</a>
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
									<a class="dropdown-item" href="javascript:parkingReserve()">환전 신청
										내역</a>
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
									관리</a> <a class="dropdown-item" href="javascript:reserveManage()">예약 관리</a>
							</div>
						</div>
					</li>

				</ul>
			</div>
		</div>
	</nav>

	<div id="content-wrapper">

		<div class="container-fluid">

			<!-- Breadcrumbs-->
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">Dashboard</a></li>
				<li class="breadcrumb-item active">Tables</li>
			</ol>

			<!-- DataTables Example -->
			<div class="card mb-3">
				<div class="card-header">
					<i class="fas fa-table"></i>잔액 : ${pointBalance } 원 <input
						type="button" value="충전" class="btn btn-warning"
						onclick="pointCharge()">
				</div>
				<c:set var="lists" value="${pointList }" />
				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable" align="center" width="80%"
							cellspacing="0">
							<c:choose>
								<c:when test="${not empty lists}">
									<!-- list가 비어있지 않으면 값을 출력하고 -->
									<thead>
										<tr>
											<th>사용일자</th>
											<th>사용구분</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="list" items="${pointList}">
											<tr>
												<td>${list.use_date }</td>
												<c:set var="division" value="${list.division }" />
												<c:choose>
													<c:when test="${division eq '0'}">
														<td>포인트 충전</td>
													</c:when>
													<c:when test="${division eq '1'}">
														<td>포인트 사용</td>
													</c:when>
													<c:when test="${division eq '2'}">
														<td>포인트 환불</td>
													</c:when>
												</c:choose>
										</c:forEach>
									</tbody>
								</c:when>

								<c:when test="${empty lists }">
									<tr>
										<td align="center">결제된 내용이 없습니다.</td>
									</tr>
								</c:when>
							</c:choose>
						</table>
					</div>
				</div>
			</div>
		</div>
		<!-- /.container-fluid -->
	</div>

	<!-- /.content-wrapper -->

	<!-- /#wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fas fa-angle-up"></i>
	</a>
	<!-- Footer -->
	<footer class="py-5 bg-dark">
		<div class="container">
			<p class="m-0 text-center text-white">Copyright &copy; Your
				Website 2019</p>
		</div>
		<!-- /.container -->
	</footer>


	<!-- Bootstrap core JavaScript-->
	<script src="../resources/vendor/jquery/jquery.min.js"></script>
	<script src="../resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="../resources/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Page level plugin JavaScript-->
	<script src="../resources/vendor/datatables/jquery.dataTables.js"></script>
	<script src="../resources/vendor/datatables/dataTables.bootstrap4.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="../resources/js/sb-admin.min.js"></script>

	<!-- Demo scripts for this page-->
	<script src="../resources/js/demo/datatables-demo.js"></script>
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
		form.setAttribute("action", "../member/memberManage");
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
		reserveList.setAttribute("action", "../search/reservationList");

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
	//결제 내역
	function payment(){
		var payment = document.createElement("form");
		payment.setAttribute("charset", "UTF-8");
		payment.setAttribute("method", "POST");
		payment.setAttribute("action", "../payment/paymentList");

		document.body.appendChild(payment);
		payment.submit();
	}
	//주차장 등록
	function parkingReserve(){
		var payment = document.createElement("form");
		payment.setAttribute("charset", "UTF-8");
		payment.setAttribute("method", "POST");
		payment.setAttribute("action", "../search/registerParingForm");
		
		document.body.appendChild(payment);
		payment.submit();
	}
	//환전 신청 내역
	function parkingReserve(){
		var payment = document.createElement("form");
		payment.setAttribute("charset", "UTF-8");
		payment.setAttribute("method", "POST");
		payment.setAttribute("action", "../payment/exchangeList");
		
		document.body.appendChild(payment);
		payment.submit();
	}
	

	//예약 관리
	function reserveManage(){
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