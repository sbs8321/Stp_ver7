<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<meta charset="UTF-8">
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
	modifyparking.submit();
}
</script>

</head>
<body>
	<!-- http://zzznara2.tistory.com/774 네비게이션 바 참조 -->
	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#navbar" aria-expanded="false"
					aria-controls="navbar">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="home">ST</a>
			</div>
			<div id="navbar" class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
					<li class="active"><a href="home">홈으로 마이페이지</a></li>
					<li><a href="findIdAction">아이디 찾기 결제내역</a></li>
					<li><a href="joinTypeAction">회원 타입 포인트 충전</a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">Dropdown <span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="#">Action</a></li>
							<li><a href="#">Another action</a></li>
							<li><a href="#">Something else here</a></li>
							<li role="separator" class="divider"></li>
							<li class="dropdown-header">Nav header</li>
							<li><a href="#">Separated link</a></li>
							<li><a href="#">One more separated link</a></li>
						</ul></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="../navbar/">Default</a></li>
					<li><a href="../navbar-static-top/">Static top</a></li>
					<li class="active"><a href="./">Fixed top <span
							class="sr-only">(current)</span></a></li>
				</ul>
			</div>
			<!--/.nav-collapse -->
		</div>
	</nav><br><br><br>
	
	
	<div style="margin-top: 100px;" align="center">
	<h1>주차장 수정</h1>
	<form name="modifyparking" id="modifyparking" action="../search/modifyparking"
		method="post">
		<p>
			<input type="text" name="prkplcenm" id="prkplcenm" value="${parkinfo.prkplcenm}" style="width: 300px;" required="required">
		</p>
		<p>
			<select name="prkplcese" style="width: 150px;" required="required">
			  <option value="공영">공영</option>
			  <option value="민영">민영</option>
			</select>
			
			<select name="prkplcetype" style="width: 150px;" required="required">
			  <option value="노상">노상</option>
			  <option value="노외">노외</option>
			  <option value="부">부설</option>
			  <option value="기계">기계식</option>
			  <option value="자주식">자주식</option>
			</select>
		</p>
		<p>
			<input type="text" name="prkcmprt" id="prkcmprt" value="${parkinfo.prkcmprt}" required="required">
			<input type="text" name="basictime" id="basictime" value="${parkinfo.basictime}" required="required">분
		</p>
		<p>
			<input type="text" name="basiccharge" id="basiccharge" value="${parkinfo.basiccharge}" style="width: 90px;" required="required">원
			<input type="text" name="daycmmtkt" id="daycmmtkt" value="${parkinfo.daycmmtkt}" style="width: 90px;" required="required">원
			<input type="number" name="hourPayment" id="hourPayment" placeholder="${parkinfo.hourPayment}" style="width: 90px;" required="required">원
		</p>
		<p>
			<select name="metpay" id="metpay" style="width: 150px;" required="required">
			  <option value="결제방식">결제방식</option>
			  <option value="현금">현금</option>
			  <option value="카드">카드</option>
			  <option value="현금+카드">현금+카드</option>
			</select>
			
			<select name="spcmnt" id="spcmnt" style="width: 150px;" required="required">
			  <option value="운영방식">운영방식</option>
			  <option value="24시간(회원제)">24시간(회원제)</option>
			  <option value="월정기차량만">월정기차량만</option>
			  <option value="24시간(누구나)">24시간(누구나)</option>
			  <option value="주중24시간,주말12시간">주중24시간,주말12시간</option>
			</select>
		</p>
		
		<p>
			<input type="text" id="addr1" name="addr1" placeholder="우편번호 입력" style="width: 210px;" required="required">
			<input type="button" onclick="exePostCode()" value="우편번호 찾기">
		</p>
		<p>
			<input type="text" id="addr2" name="addr2" placeholder="도로명 주소" required="required">  <input type="text" id="addr3" name="addr3" placeholder="상세 주소" required="required">
		</p>
		<p>
			<input type="button" onclick="parksearch();" value="검색">
		</p>	
		
		<div id="map" style="width:400px; height:300px;margin-top: 20px; margin-bottom: 20px;" align="center"></div>
		
		<p>
			<input type="hidden" id="prkplceno" name="prkplceno" value="${parkinfo.prkplceno}">
			<input type="button" onclick="Button();" value="등록" >
		</p>
	
	
	
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d86cac5bb236368c66b4f9c0139790c9&libraries=services"></script>
	<script>
	
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new daum.maps.LatLng(37.43864944368575, 126.67543284487502), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  
	
	// 지도를 생성합니다    
	var map = new daum.maps.Map(mapContainer, mapOption); 
	
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new daum.maps.services.Geocoder();
	
	function parksearch() {
		
	var addr2 = $('#addr2').val();
	var addr3 = $('#addr3').val();
	
	if(addr2 == '' || addr3 == '' ){
		alert("정확한 주소를 입력 하세요");
	}else{
		var addr = addr2+addr3;
	}
	
	
	// 장소 검색 객체를 생성합니다
	var ps = new daum.maps.services.Places();

	// 키워드로 장소를 검색합니다
	ps.keywordSearch(addr2, placesSearchCB); // '' 검색 결과가 들어올수 있도록설정

	
	// 키워드 검색 완료 시 호출되는 콜백함수 입니다
	function placesSearchCB(data, status, pagination) {
		if (status === daum.maps.services.Status.OK) {

			// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
			// LatLngBounds 객체에 좌표를 추가합니다
			var bounds = new daum.maps.LatLngBounds();

			for (var i = 0; i < data.length; i++) {

				bounds.extend(new daum.maps.LatLng(data[i].y, data[i].x));
			}

			// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
			map.setBounds(bounds);
			
			// 지도를 클릭한 위치에 표출할 마커입니다
			var marker = new daum.maps.Marker({ 
			    // 지도 중심좌표에 마커를 생성합니다 
			    position: map.getCenter() 
			}); 
			// 지도에 마커를 표시합니다
			marker.setMap(map);

			// 지도에 클릭 이벤트를 등록합니다
			// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
			daum.maps.event.addListener(map, 'click', function(mouseEvent) {        
			    
			    // 클릭한 위도, 경도 정보를 가져옵니다 
			    var latlng = mouseEvent.latLng; 
			    
			    // 마커 위치를 클릭한 위치로 옮깁니다
			    marker.setPosition(latlng);
			    
			    var latitude = latlng.getLat();
			    var hardness = latlng.getLng();	   

				document.modifyparking.latitude.value = latitude; 
				document.modifyparking.hardness.value = hardness; 
			    
			});
			
		}
	}
	
	

	}
	</script>

		<input type="hidden" name="latitude" id="latitude" value="">
		<input type="hidden" name="hardness" id="hardness" value="">
		<input type="hidden" name="owner" id="owner" value="${sessionScope.loginID}">
	</form>
	</div>
	
	
	
	
	
</body>
</html>