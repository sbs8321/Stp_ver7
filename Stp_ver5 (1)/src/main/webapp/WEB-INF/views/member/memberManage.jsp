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

<title>STP - 회원 관리</title>

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
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>

<script type="text/javascript">
	function userList() {
		$(".userList").show();
		$(".ownerList").hide();
	}
	function ownerList() {
		$(".userList").hide();
		$(".ownerList").show();
	}
</script>
<body>
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
					<i class="fas fa-table"></i> ${sessionScope.loginID } 회원 관리
					<div align="right">
						<input type="button" class="btn btn-secondary" value="개인 회원 목록"
							onclick="javascript:userList()"> <input type="button"
							class="btn btn-secondary" value="기업 회원 목록"
							onclick="javascript:ownerList()">
					</div>
				</div>
				<div class="userList">
					<div class="card-body">
						<div class="table-responsive">
						<i class="fas fa-table"></i> 개인 회원
							<table class="table table-bordered" id="dataTable" width="100%"
								cellspacing="0">
								<c:set var="lists" value="${userList }" />
								<c:choose>
									<c:when test="${not empty lists}">
										<!-- list가 비어있지 않으면 값을 출력하고 -->
										<thead>
											<tr>
												<td>아이디</td>
												<td>이름</td>
												<td>주소</td>
												<td>잔액 포인트</td>
												<td>회원 유형</td>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="list" items="${userList}">
												<tr>
													<td>${list.email }</td>
													<td>${list.name }</td>
													<td>${list.addr2 }${list.addr3 }</td>
													<td>${list.point }</td>
													<c:set var="state" value="${list.memberType }" />
													<c:choose>
														<c:when test="${state eq '0'}">
															<td>개인 회원</td>
														</c:when>
														<c:when test="${state eq '1'}">
															<td>기업 회원</td>
														</c:when>
													</c:choose>
												</tr>
											</c:forEach>
										</tbody>
									</c:when>

									<c:when test="${empty lists }">
										<tr>
											<td align="center">회원이 없습니다.</td>
										</tr>
									</c:when>
								</c:choose>
							</table>
						</div>
					</div>
				</div>
				<div class="ownerList" style="display: none">
					<div class="card-body">
						<div class="table-responsive">
						<i class="fas fa-table"></i> 기업 회원
							<table class="table table-bordered" id="dataTable" width="100%"
								cellspacing="0">
								<c:set var="lists" value="${ownerList }" />
								<c:choose>
									<c:when test="${not empty lists}">
										<!-- list가 비어있지 않으면 값을 출력하고 -->
										<thead>
											<tr>
												<td>아이디</td>
												<td>이름</td>
												<td>주소</td>
												<td>잔액 포인트</td>
												<td>회원 유형</td>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="list" items="${ownerList}">
												<tr>
													<td>${list.email }</td>
													<td>${list.name }</td>
													<td>${list.addr2 }${list.addr3 }</td>
													<td>${list.point }</td>
													<c:set var="state" value="${list.memberType }" />
													<c:choose>
														<c:when test="${state eq '0'}">
															<td>개인 회원</td>
														</c:when>
														<c:when test="${state eq '1'}">
															<td>기업 회원</td>
														</c:when>
													</c:choose>
												</tr>
											</c:forEach>
										</tbody>
									</c:when>

									<c:when test="${empty lists }">
										<tr>
											<td align="center">회원이 없습니다.</td>
										</tr>
									</c:when>
								</c:choose>
							</table>
						</div>
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

</body>
</html>