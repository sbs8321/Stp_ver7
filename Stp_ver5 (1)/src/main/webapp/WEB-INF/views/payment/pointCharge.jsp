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

<title>STP - 포인트 충전</title>

<!-- Bootstrap core CSS-->
<link href="../resources/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom fonts for this template-->
<link href="../resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">

<!-- Custom styles for this template-->
<link href="../resources/css/sb-admin.css" rel="stylesheet">
</head>

<script type="text/javascript">
	function charge() {
		var addBalance = document.getElementById('payment_balance').value;
		var balance = document.getElementById('before_balance').value;
		document.getElementById('after_balance').value = Number(addBalance)
				+ Number(balance);

	}

	function payment() {
		var balance = document.getElementById('payment_balance').value; //입력한 

		if (balance > 0) {
			if (confirm("결제 하시겠습니까?") == true) {//true라면 (확인 버튼))
				chargeForm.submit();
			} else {//취소
				location.reload(); //창 새로고침
			}
		} else {
			alert('충전할 금액을 0원 이상 입력하세요.');
		}
	}
</script>
<body class="bg-dark">
	<div class="container">
		<div class="card card-login mx-auto mt-5">
			<div class="card-header">포인트 충전</div>
			<div class="card-body">
				<form name="chargeForm" action="payPage"	method="post">

					<br> <br>
					<div class="form-group">
						<div class="form-label-group">
							<input type="text" class="form-control"
								placeholder="1000원 이상의 금액 입력하세요." required="required"
								id="payment_balance" name="payment_balance" onkeyup="charge()"
								autofocus="autofocus"> <label for="payment_balance">충전
								금액</label>
						</div>
					</div>
					<div class="form-group">
						<div class="form-label-group">
							<input type="text" class="form-control" required="required" readonly="readonly"
								id="before_balance" name="before_balance" value="${memberInfo.point }">
							<label for="bBalance">충전 전</label>
						</div>
					</div>

					<div class="form-group">
						<div class="form-label-group">
							<input type="text" class="form-control" required="required" readonly="readonly"
								id="after_balance" name="after_balance">
							<label for="after_balance">충전 후</label>
						</div>
					</div>
					
					<input type="button" class="btn btn-primary btn-block"
						onclick="payment()" value="결제">
				</form>
			</div>
		</div>
	</div>

	<!-- Bootstrap core JavaScript-->
	<script src="../resources/vendor/jquery/jquery.min.js"></script>
	<script src="../resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="../resources/vendor/jquery-easing/jquery.easing.min.js"></script>
</body>
</html>