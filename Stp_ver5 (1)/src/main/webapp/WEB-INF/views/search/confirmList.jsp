<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#jb-container {
	width: 100%;
	margin: 0px auto;
	padding: 5px;
	border: 1px solid #bcbcbc;
	margin-bottom: 10px;
}

#jb-img {

	margin-bottom: 5px;
	float: left;
	border: 1px solid #bcbcbc;
	margin-bottom: 10px;
}

#jb-contant {
	width: 70%;
	margin-bottom: 5px;
	float: right;
	border: 1px solid #bcbcbc;
	margin-bottom: 10px;
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
	
	<c:forEach var="bk" items="${parkList}" varStatus="status">
		<form id="detailParkForm+${status.count}" name="detailParkForm+${status.count}" action="../search/detailParkForm" method="post">
			<div id="jb-container" onclick="document.forms['detailParkForm+${status.count}'].submit();" style="cursor: pointer; border-style: solid; border-width: 1px; ">
					
				<table>
				<tr>
				<td style="width: 20%; height: 90px;">
				<img src="${bk.parkimg}" width="100" height="90"> </td>
				<td style="width: 10%; border-style: none;">
				</td>
				<td style="width: 70%">
					<h4><strong>${bk.prkplcenm}</strong></h4> 
					주소 : ${bk.lnmadr}<br> 
					구획수 :${bk.prkcmprt}<br>
					등록인 :${bk.owner} 
				</td>
				</tr>
				</table>
				<input type="hidden" id="prkplceno" name="prkplceno" value="${bk.prkplceno}">
			</div>
		</form>
			<table>
			<tr>
			<td>
			<form id="confirmpark+${status.count}" name="confirmpark+${status.count}" action="../search/confirmpark" method="post">
			<input type="hidden" id="prkplceno" name="prkplceno" value="${bk.prkplceno}">
			<input type="submit" value="승인">
			</form> 
			</td>
			</tr>	
			</table>
	</c:forEach>
	</div>



</body>
</html>