<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://cdn.bootpay.co.kr/js/bootpay-2.0.20.min.js"
	type="application/javascript"></script>
<script>
window.onload = function (){
	BootPay.request({
		price : ${charge}, // 결제할 금액 
		application_id : '5c3e97c6396fa67f6f55abd3',
		name : '${paymentOption}', // 아이템 이름,
		phone : '${phone}',
		order_id : '20190116',
		show_agree_window : 1, // 결제 동의창 띄우기 여부 1 - 띄움, 0 - 띄우지 않음
		items : [ // 결제하려는 모든 아이템 정보 ( 통계 데이터로 쓰이므로 입력해주시면 좋습니다. 입력하지 않아도 결제는 가능합니다.)
		{
			item_name : '${paymentOption}',
			qty : 1, // 판매한 아이템의 수량
			unique : '1111',
			price :  ${charge} 
		// 아이템 하나의 단가
		} ],
		user_info : { // 구매한 고객정보 ( 통계 혹은 PG사에서 요구하는 고객 정보 )
			email : '${memberInfo.email}',
			phone : '${phone}',
			username :  '${memberInfo.name}',
			addr : '${addr}'
		}
	}).error(function(data) {
		// 결제가 실패했을 때 호출되는 함수입니다.
		var msg = "결제 에러입니다.: " + JSON.stringify(data);
		if(confirm(msg)==true){
			window.opener.location.reload(); self.close();
		}
		console.log(data);
	}).cancel(function(data) {
		// 결제창에서 결제 진행을 하다가 취소버튼을 눌렀을때 호출되는 함수입니다.
		var msg = "결제 취소입니다.: " + JSON.stringify(data);
		if(confirm(msg)==true){
			window.opener.location.reload(); self.close();
		}
		console.log(data);
	}).confirm(function(data) {
		// 결제가 진행되고 나서 승인 이전에 호출되는 함수입니다.
		// 일부 결제는 이 함수가 호출되지 않을 수 있습니다. ex) 가상계좌 및 카드 수기결제는 호출되지 않습니다.        
		// 만약 이 함수를 정의하지 않으면 바로 결제 승인이 일어납니다.
		if (confirm('결제를 정말 승인할까요?')) {
			console.log("do confirm data: " + JSON.stringify(data));
			//------------------------------>Json 값을 이용하면 좋을 거 같은데 어떻게 해야할까?
			// 이 함수를 반드시 실행해야 결제가 완전히 끝납니다.
			// 부트페이로 서버로 결제를 승인함을 보내는 함수입니다.
			this.transactionConfirm(data);
			
		} else {
			var msg = "결제가 승인거절되었습니다.: " + JSON.stringify(data);
			if(confirm(msg)==true){
				window.opener.location.reload(); self.close();
			}
			console.log(data);
		}
	}).done(function(data) {
		// 결제가 모두 완료되었을 때 호출되는 함수입니다.
		alert("결제가 완료되었습니다.");
		console.log(data);
		
		var form = document.createElement("form");
		form.setAttribute("charset", "UTF-8");
		form.setAttribute("method", "POST");
		form.setAttribute("action", "../payment/result");
		/* input 태그 만들기 */
		var hiddenValue = document.createElement("input");
		hiddenValue.setAttribute("type", "hidden");
		hiddenValue.setAttribute("name", "data");
		hiddenValue.setAttribute("value", encodeURI(JSON.parse(JSON.stringify(data)).amount));
		form.appendChild(hiddenValue);
		
		var hiddenValue = document.createElement("input");
		hiddenValue.setAttribute("type", "hidden");
		hiddenValue.setAttribute("name", "parkingName");
		hiddenValue.setAttribute("value", encodeURI(JSON.parse(JSON.stringify(data)).name));
		form.appendChild(hiddenValue);
		
		var hiddenValue = document.createElement("input");
		hiddenValue.setAttribute("type", "hidden");
		hiddenValue.setAttribute("name", "payment");
		hiddenValue.setAttribute("value",'${paymentOption}');
		form.appendChild(hiddenValue);
		document.body.appendChild(form);
		
		form.submit();
			
	}).ready(function(data) {
		// 가상계좌 번호가 체번(발급) 되었을 때 호출되는 함수입니다.
		console.log(data);
	});
}


</script>
<body>
</body>
</html>