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

<title>Simple is The Bset - 주차장 예약하기</title>
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
	window.onload = load;

	function load() {
		var msg = document.getElementById("msg");

		$.ajax({
			type : "post",
			url : "ownerInfo",
			dataType : "text",
			success : function(data) {
				if (data != null) { //null이 아니면 값이 있으면
					document.getElementById('point').value = data;
					var balance = Number(data);
					if (balance >= 1000) {//1000원 이상이면
						msg.innerHTML = "환전 가능합니다."
					} else {
						msg.innerHTML = "환전이 불가능합니다."
					}

				}
			},
			error : function() {
				alert("point 가져오기 ajax 에러");
			}

		});
	}

	//환전 신청 버튼 - submit
	//<form action="exchangeApply" name="exchangebalance" method="POST">
	function exchange() {

		var balance = document.getElementById("exchangeBalance").value;

		if (Number(balance) >= 1000) {
			/* form 태그 만들기 */
			var exchangebalance = document.createElement("form");
			exchangebalance.setAttribute("charset", "UTF-8");
			exchangebalance.setAttribute("method", "POST");
			exchangebalance.setAttribute("action", "exchangeApply");

			/* input 태그 만들기 */

			var hiddenValue = document.createElement("input");
			hiddenValue.setAttribute("type", "hidden");
			hiddenValue.setAttribute("name", "exchangeBalance");
			hiddenValue.setAttribute("value", balance);

			exchangebalance.appendChild(hiddenValue);
			document.body.appendChild(exchangebalance);

			/* 자동 submit */
			exchangebalance.submit();
		} else {
			alert('1000포인트 이상 입력하세요.');
			window.reload();
		}
	}

	//입력한 값이 1000이 넘으면 submit 버튼 생성하기
	function balanceCheck() {
		var balance = document.getElementById('exchangeBalance').value;

		if (Number(balance) >= 1000) {//입력한 금액이 1000원 이상이면 submit 버튼 생성
			$(".exchangeApply").show()
		}
	}

	//전환된 금액 조회하기 
	function changeBalance() {
		var balance = document.getElementById('exchangeBalance').value;
		var minusBalance = (Number(balance) * 0.2);//20% 차감된 가격
		var changeBalance = Number(balance) - Number(minusBalance);

		document.getElementById('changeMsg').value = changeBalance + " 원 "
	}
</script>
<body class="bg-dark">
	<div class="container">
		<div class="card card-login mx-auto mt-5">
			<div class="card-header">환전 신청 페이지</div>
			<div class="card-body">
				<b> 1000p 이상 환전 가능합니다.</b>
			</div>
			<div class="form-group">
				<div class="form-label-group">
					<input type="text" class="form-control" readonly="readonly"
						id="point" name="point"> <label for="point">환전 가능
						포인트</label>
				</div>
				<div class="card-body">
					<b><span id="msg"></span></b>
				</div>
			</div>

			<div class="form-group">
				<div class="form-label-group">
					<input type="text" class="form-control"
						placeholder="100p단위로 입력하세요." required="required"
						id="exchangeBalance" name="exchangeBalance" autofocus="autofocus"
						onkeyup="balanceCheck()"> <label for="exchangeBalance">환전
						포인트</label>
				</div>
			</div>

			<div class="exchangeApply" style="display: none">
				<div class="card-body">
					<b><span style="color: red;">환전 신청시 전환되는 금액은 <br>20%
							차감된 가격입니다.
					</span></b>
					<div align=right>
						<input type="button" class="btn btn-secondary" value="금액 조회"
							onclick="changeBalance()">
					</div>
				</div>
				<div class="form-group">
					<div class="form-label-group">
						<input type="text" class="form-control" readonly="readonly"
							id="changeMsg" name="changeMsg"> <label for="changeMsg">환전
							금액</label>
					</div>
				</div>
				<div align=center>
					<input type="button" class="btn btn-primary" value="환전 신청"
						onclick="exchange()">
				</div>
			</div>
		</div>
	</div>

</body>
</html>