<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
	function fake(){
		alert('신고 기능 없음 ㅋ');
	}
	
	function del(num) {
		var result = confirm("댓글을 삭제하시겠습니까?");
	 	if (result == true) {
	 		replyDelete(num);
	 		alert("삭제되었습니다.");
		} else {
			return false;
		}
	}
	
	function replyDelete(num){
		console.log("댓글 삭제 ajax 호출");
		var id = $('#loginId').val();
		var replyNum = num;
		$.ajax({
			type: 'POST',
			url: '../search/replyDelete',
			data : {id: id,
					replyNum: replyNum},
			success: function(result){
				console.log("댓글 삭제 성공");
				console.log(id+"/"+replyNum);
				replyList();
			},
			error: function() {
				console.log("댓글 목록 ajax 실패");
			}
		});
	}
</script>
<title>Insert title here</title>
</head>
<body>
<c:forEach var="replyList" items="${replyList }">
<div id="replies">
	<input type="hidden" id="loginId" value="${sessionScope.loginID}">
	<table>
		<tr>
			<td colspan="2"><b>${replyList.reply_id } </b>&nbsp;<span style="font-size: small;">${replyList.reply_date }</span></td>
			
			<c:choose>
				<c:when test="${replyList.reply_id eq sessionScope.loginID }">
				<td style="text-align: right;"><a href="javascript:del(${replyList.reply_num })">삭제</a></td>
				</c:when>
				
				<c:otherwise>
				<td style="text-align: right;"><a href="javascript:fake()">신고</a></td>
				</c:otherwise>
			</c:choose>
			
		</tr>
		<tr>
			<td colspan=3 style="width: 550px; height: 40px; padding-bottom: 10px;">${replyList.reply_content }</td>
		</tr>
	</table>
</div>
</c:forEach>
</body>
</html>