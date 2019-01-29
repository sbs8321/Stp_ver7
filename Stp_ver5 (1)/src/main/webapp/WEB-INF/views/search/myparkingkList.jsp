<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	button{
	  background:#EEEEEEE;
	  color:#eeeeeee;
	  border:none;
	  position:relative;
	  height:120px;
	  font-size:1.6em;
	  padding:0 2em;
	  cursor:pointer;
	  transition:800ms ease all;
	  outline:none;
	}
	button:hover{
	  background:#fff;
	  color:#eeeeee;
	}
	button:before,button:after{
	  content:'';
	  position:absolute;
	  top:0;
	  right:0;
	  height:2px;
	  width:0;
	  background: #1AAB8A;
	  transition:400ms ease all;
	}
	button:after{
	  right:inherit;
	  top:inherit;
	  left:0;
	  bottom:0;
	}
	button:hover:before,button:hover:after{
	  width:100%;
	  transition:800ms ease all;
	}
</style>
<script type="text/javascript">

		function selectParking() {
		var prkplceno = $('#prkplceno').val();
		location.href = "../search/selectParking?prkplceno="+prkplceno
		}

</script>
</head>
<body>

	
	<div style="margin-top: 50px;">	</div>
	<div style="width: 700px; margin-left:380px; height: 300px; overflow: auto">
	
	<c:forEach var="bk" items="${myparking}" varStatus="status">
		<form id="detailParkForm+${status.count}" name="detailParkForm+${status.count}" action="../search/detailParkForm" method="post">
			<div id="jb-container" onclick="document.forms['detailParkForm+${status.count}'].submit();" style="cursor: pointer; border-style: solid; border-width: 1px; ">
					
				<table>
				<tr>
				<td style="width: 120px; height: 90px; ">
				<img src="${bk.parkimg}" width="100" height="90"> </td>
				<td style="width: 20px;">
				</td>
				<td style="width: 400px;">
					<h4><strong>${bk.prkplcenm}</strong></h4> 
					주소 : ${bk.lnmadr}<br> 
					구획수 :${bk.prkcmprt}<br> 
				</td>
				
				<td style="width: 150px; ">
				승인 여부 :  <br>
				
				
				<c:choose>
				<c:when test="${bk.state eq 0}">
				<h5 style="color: red;">미승인</h5>
			    </c:when>
			    <c:when test="${bk.state eq 1}">
				<h5 style="color: blue;">승인</h5>
			    </c:when>
				</c:choose>
				
				</td>
				</tr>
				</table>
				<input type="hidden" id="prkplceno" name="prkplceno" value="${bk.prkplceno}">
			</div>
		</form>
			<table>
			<tr>
			<td>
			<form id="modifyparkForm+${status.count}" name="modifyparkForm+${status.count}" action="../search/modifyparkForm" method="post">
			<input type="hidden" id="prkplceno" name="prkplceno" value="${bk.prkplceno}">
			<input type="submit" value="정보수정">
			</form> 
			</td>
			
			<td>
			<form id="deletePark+${status.count}" name="deletePark+${status.count}" action="../search/deletePark" method="post">
			<input type="hidden" id="prkplceno" name="prkplceno" value="${bk.prkplceno}">
			<input type="submit" value="주차장 삭제">
			</form> 
			</td>
			</tr>
					
			</table>
	</c:forEach>
	</div>



</body>
</html>