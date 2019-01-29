<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Simple is The Bset - 결과 페이지</title>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>

<!-- Bootstrap core CSS-->
<link href="../resources/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom fonts for this template-->
<link href="../resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">

<!-- Custom styles for this template-->
<link href="../resources/css/sb-admin.css" rel="stylesheet">
<script type="text/javascript">

function resulthome(){
	//자식장 close, 부모창 gotohome
	
	var home = document.createElement("form");
	home.setAttribute("charset", "UTF-8");
	home.setAttribute("method", "POST");
	home.setAttribute("action", "../search/resultHome");

	document.body.appendChild(home);

	/* 자동 submit */
	home.submit();
}
function reservePage(){
	var home = document.createElement("form");
	home.setAttribute("charset", "UTF-8");
	home.setAttribute("method", "POST");
	home.setAttribute("action", "../search/reservePage");

	document.body.appendChild(home);

	/* 자동 submit */
	home.submit();
}
</script>
<body class="bg-dark">
	<div class="container">
		<div class="card card-login mx-auto mt-5">
			<div class="card-header">결제 완료 페이지</div>
			<div class="card-body">
				<b> 예약된 정보입니다.</b>
			</div>
			<div class="form-group">
				<div class="form-label-group">
					<input type="text" class="form-control" readonly="readonly"
						id="parking" name="parking" value="${parking.prkplcenm }">
					<label for="parking">주차장 </label>
				</div>
			</div>

			<div class="form-group">
				<div class="form-label-group">
					<input type="text" class="form-control" readonly="readonly"
						id="point" name="point"
						value="${booking.entrance_date }/${booking.entrance_time} 시">
					<label for="point">입차 일시 </label>
				</div>
			</div>
			<div class="form-group">
				<div class="form-label-group">
					<input type="text" class="form-control" readonly="readonly"
						id="point" name="point"
						value="${booking.exit_date }/${booking.exit_time} 시">
					<label for="point">출차 일시 </label>
				</div>
			</div>
			<div class="form-group">
				<div class="form-label-group">
					<input type="text" class="form-control" readonly="readonly"
						id="point" name="point" value="${booking.price } "> <label
						for="point">금액 </label>
				</div>
			</div>
				<div class="form-group">
				<div class="form-label-group">
					<input type="button" class="btn btn-secondary" onclick="resulthome()" value="첫 화면으로 이동">
					<input type="button" class="btn btn-secondary" onclick="reservePage()" value="예약 내역 페이지">
				</div>
			</div>
		</div>
	</div>
</body>
</html>