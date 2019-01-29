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

<title>STP - 주차장 예약</title>

<!-- Bootstrap core CSS-->
<link href="../resources/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom fonts for this template-->
<link href="../resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">

<!-- Custom styles for this template-->
<link href="../resources/css/sb-admin.css" rel="stylesheet">
</head>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript">
	//포인트 잔액 확인하기
	function pointCheck() {
		var reserveCharge = document.getElementById('reserveCharge').value;
		$.ajax({
			type : "post",
			url : "../payment/pointCheck",
			dataType : "text",
			data : {
				"email" : "${sessionScope.loginID }"
			},
			success : function(data) {
				if (data != "0") {
					document.getElementById('pointBalance').value = data;

					//point가 예약한 금액보다 많으면 포인트 사용 버튼 / 결제 버튼 생성
					var balance = document.getElementById('pointBalance').value
					if (Number(reserveCharge) < 1000) {
						$(".onlypoint").show();
					} else {
						if (Number(reserveCharge) <= Number(balance)) {
							$(".pointUse").show();
						} else {
							$(".payUse").show();
						}
					}
				} else {//그렇지 않으면 결제버튼 / 충전하기  생성
					document.getElementById('pointBalance').value = 0;
					$(".payUse").show();
				}

			}

		});
	}

	//포인트 사용하기 버튼
	function pointUse() {
		var parkingName = document.getElementById('parkingName').value;
		var balance = document.getElementById('reserveCharge').value;

		//POST 방식
		var form = document.createElement("form");
		form.setAttribute("charset", "UTF-8");
		form.setAttribute("method", "POST");
		form.setAttribute("action", "../payment/pointUse");
		/* input 태그 만들기 */

		var hiddenValue = document.createElement("input");
		hiddenValue.setAttribute("type", "hidden");
		hiddenValue.setAttribute("name", "balance");
		hiddenValue.setAttribute("value", balance);
		form.appendChild(hiddenValue);

		var hiddenValue = document.createElement("input");
		hiddenValue.setAttribute("type", "hidden");
		hiddenValue.setAttribute("name", "parkingName");
		hiddenValue.setAttribute("value", parkingName);
		form.appendChild(hiddenValue);

		document.body.appendChild(form);

		if (confirm(balance + "point 사용하시겠습니까?") == true) {
			/* 자동 submit */
			form.submit();
		} else {
			alert('포인트 사용을 취소했습니다. 다시 시도하세요.');
			return;
		}

	}

	//결제하기 버튼
	function payUse() {

		var parkingName = document.getElementById('parkingName').value;
		var balance = document.getElementById('reserveCharge').value;

		//POST 방식
		var form = document.createElement("form");
		form.setAttribute("charset", "UTF-8");
		form.setAttribute("method", "POST");
		form.setAttribute("action", "../payment/payUse");
		/* input 태그 만들기 */

		var hiddenValue = document.createElement("input");
		hiddenValue.setAttribute("type", "hidden");
		hiddenValue.setAttribute("name", "balance");
		hiddenValue.setAttribute("value", balance);
		form.appendChild(hiddenValue);

		var hiddenValue = document.createElement("input");
		hiddenValue.setAttribute("type", "hidden");
		hiddenValue.setAttribute("name", "parkingName");
		hiddenValue.setAttribute("value", parkingName);
		form.appendChild(hiddenValue);

		document.body.appendChild(form);

		if (confirm(balance + "원 결제하시겠습니까?") == true) {

			form.submit();

		} else {
			alert('결제를 취소했습니다. 다시 시도하세요.');
			return;
		}
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
</script>
<script>
	$(window)
			.on(
					'beforeunload',
					function() {
						var msg = "팝업창을 닫으시겠습니까?";
						var ua = navigator.userAgent.toLowerCase();
						if ((navigator.appName == 'Netscape' && ua
								.indexOf('trident') != -1)
								|| (ua.indexOf("msie") != -1))
							confirm(msg);
						else
							return confirm(msg);
					});
	function applyCancel() {
		if (confirm('창을 닫으시겠습니까?') == true) {
			var booking_id = document.getElementById('booking_id').value();
			console.log("joinCancel : " + booking_id);
			$.ajax({
				type : 'POST',
				url : '../search/applyCancel', // 컨트롤러 주소값.
				data : {
					booking_id : booking_id
				},

				success : function(data) { // 통신의 성공을 의미
					if (data == 1) {
						console.log("booking_list 삭제");
					} else {
						console.log("booking_list 삭제 실패");
					}
				},
				error : function() { // 통신의 실패를 의미
					alert("페이지 나가기 ajax 실패");
				}
			});
		}
	}
</script>


<body class="bg-dark" onBeforeUnload="applyCancel()">
	<div class="container">
		<input type="hidden" id="booking_id" name="booking_id"
			value="${booking.booking_id }">
		<div class="card card-login mx-auto mt-5">
			<div class="card-header">주차장 예약</div>
			<div class="card-body">
				<b> 예약 정보 </b>
			</div>
			<div class="form-group">
				<div class="form-label-group">
					<input type="text" class="form-control" readonly="readonly"
						id="parkingName" name="parkingName"
						value="${booking.parking.prkplcenm }"> <label
						for="parkingName">주차장</label>
				</div>
			</div>
			<div class="form-group">
				<div class="form-label-group">
					<input type="text" class="form-control" readonly="readonly"
						id="reserveCharge" name="reserveCharge" value="${booking.price }">
					<label for="reserveCharge">결제 금액</label>
				</div>
			</div>

			<div class="form-group">
				<div class="form-label-group">
					<input type="text" class="form-control" readonly="readonly"
						id="pointBalance" name="pointBalance"> <label
						for="pointBalance">포인트 잔액</label>
				</div>

			</div>
			<div class="form-group">
				<div class="form-label-group">
					<input type="button" class="btn btn-secondary btn-block"
						onclick="pointCheck()" value="조회">
				</div>

			</div>
			<div class="onlypoint" style="display: none;" align="center">
				<div class="form-group">
					<div class="form-label-group">
						<input type="button" class="btn btn-success " onclick="pointUse()"
							value="포인트 결제"> <input type="button"
							class="btn btn-success " onclick="pointCharge()" value="포인트 충전">
					</div>

				</div>
			</div>
			<div class="pointUse" style="display: none;" align="center">
				<div class="form-group">
					<div class="form-label-group">
						<input type="button" class="btn btn-warning " onclick="payUse()"
							value="카카오 페이"> <input type="button"
							class="btn btn-success " onclick="pointUse()" value="포인트 결제">
					</div>

				</div>
			</div>
			<div class="payUse" style="display: none">
				<div class="form-group">
					<div class="form-label-group">
						<input type="button" class="btn btn-warning " onclick="payUse()"
							value="카카오 페이"> <input type="button"
							class="btn btn-success " onclick="pointCharge()" value="포인트 충전">
					</div>

				</div>
			</div>
		</div>
	</div>
</body>
</html>