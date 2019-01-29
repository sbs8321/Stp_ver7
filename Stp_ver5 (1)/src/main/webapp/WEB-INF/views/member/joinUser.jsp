<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-Latest.min.js"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-Latest.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	function joinUserAction() {
		//form 이름이 joinUserAction인 form의 action값에 해당하는 controller로 이동.
		joinUserForm.submit();
	}

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

	var checkUnload = false;
	var done = false;

	/* 아이디 중복확인 함수 */

	function idOverlap() {
		console.log("idOverlap 함수 호출");
		var email = $('#email').val();
		console.log("email var 값 : " + email);
		$.ajax({
			type : 'POST',
			url : 'idOverlap', // 컨트롤러에서 사용 할 주소값
			data : {
				email : email
			},
			success : function(data) { // 통신의 성공을 의미
				if (data == 1) {
					alert("사용 가능한 아이디입니다.");
					checkUnload = true;
				} else {
					alert("사용 할 수 없는 아이디 입니다.");
				}
			},
			error : function() { // 통신의 실패를 의미
				alert("아이디 중복확인 ajax 실패");
			}
		});
	}

	window.onbeforeunload = function() {
		if (checkUnload && !done) {
			joinCancel();
			return "페이지를 나가시겠습니까?";
		}

	}

	function joinCancel() {
		var email = $('#email').val();
		console.log("joinCancel 함수 호출 / 파라미터 : " + email);
		$.ajax({
			type : 'GET',
			url : 'joinCancel', // 컨트롤러에서 사용  할 주소값+-+
			data : {
				email : email
			},

			success : function(data) { // 통신의 성공을 의미
				if (data == 1) {
					console.log("중복확인 이메일 삭제 완료");
				} else {
					console.log("중복확인 이메일 삭제 실패");
				}
			},
			error : function() { // 통신의 실패를 의미
				alert("페이지 나가기 ajax 실패");
			}
		});
	}

	function joinSubmit() {
		done = true;
		if (!checkUnload && done) {
			alert('이메일 중복확인을 해주세요.');
			return;
		} else if (checkUnload && done) {
			var f = document.joinUserForm;
			f.method = "post";
			f.submit();
		}
	}
	function passConfirm() {
		/* 비밀번호, 비밀번호 확인 입력창에 입력된 값을 비교해서 같다면 비밀번호 일치,
		   다르면 비밀번호 불일치라는 텍스트를 출력함 */
		var password = document.getElementById('password');
		var passwordConfirm = document.getElementById('passwordConfirm');
		var confirmMsg = document.getElementById('confirmMsg');
		var correctColor = "#00ff00";
		var wrongColor = "#ff0000";
		if (password.value == passwordConfirm.value) {
			confirmMsg.style.color = correctColor;
			confirmMsg.innerHTML = "비밀번호 일치";
		} else {
			confirmMsg.style.color = wrongColor;
			confirmMsg.innerHTML = "비밀번호 불일치";
		}
	}
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>일반 회원 가입 페이지</h1>
	<form name="joinUserForm" id="joinUserForm" action="joinUserAction"
		method="post">
		<p>
			<input type="email" name="email" id="email" placeholder="email">
			<input type="button" onclick="idOverlap()" value="중복확인">
		</p>
		<p>
			<input type="password" name="password" id="password"
				placeholder="PASSWORD">
		</p>
		<p>
			<input type="password" name="passwordConfirm" id="passwordConfirm"
				onkeyup="passConfirm()" placeholder="CHECKPASSWORD">&nbsp;<span
				id="confirmMsg"></span>
		</p>
		<p>
			<input type="text" name="name" id="name" placeholder="name">
		</p>
		<p>
			<input type="text" name="phone_front" id="phone_front" placeholder="010" style="width:40px"> -
        	 <input type="text" name="phone_mid" id="phone_mid" placeholder="1234" style="width:50px"> -
         	<input type="text" name="phone_end" id="phone_end" placeholder="5678" style="width:50px">
		</p>
		<p>
			<input type="text" id="addr1" name="addr1" placeholder="우편번호 입력">
			<input type="button" onclick="exePostCode()" value="우편번호 찾기">
		</p>
		<p>
			<input type="text" id="addr2" name="addr2" placeholder="도로명 주소">
		</p>
		<p>
			<input type="text" id="addr3" name="addr3" placeholder="상세 주소">
		</p>
		<p>
			<input type="hidden" name="point" id="point" value="0">
		</p>
		<p>
			<input type="hidden" name="memberType" id="memberType" value="0">
		</p>

		<p>
			<a href="javascript:joinSubmit();"><input type="button"
				value="가입"></a>
		</p>
	</form>
</body>
</html>