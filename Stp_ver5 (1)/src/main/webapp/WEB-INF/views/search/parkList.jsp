
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script>
	
</script>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
.but {
	width: 100%;
}

.info {
	height: 120px;
	border-radius: 5px;
	border-bottom: 2px solid #ccc;
	border-right: 1px solid #ccc;
	overflow: hidden;
	background: #fff;
}

.info:nth-child(1) {
	border: 0;
	box-shadow: 0px 1px 2px #888;
}

.info .title {
	padding: 5px 0 0 10px;
	height: 30px;
	background: #eee;
	border-bottom: 1px solid #ddd;
	font-size: 18px;
	font-weight: bold;
}

.info .close {
	position: absolute;
	top: 10px;
	right: 10px;
	color: #888;
	width: 17px;
	height: 17px;
	background:
		url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');
}

.info .close:hover {
	cursor: pointer;
}

.info .body {
	position: relative;
	overflow: hidden;
}

.info .desc {
	position: relative;
	margin: 10px 0 0 90px;
	height: 75px;
}

.desc .jibun {
	font-size: 20px;
	color: #888;
	margin-top: -20px;
}

.desc .iss {
	width: auto;
	height: 15px;
}

.info .img {
	position: absolute;
	top: 6px;
	left: 5px;
	width: 87px;
	height: 83px;
	border: 1px solid #ddd;
	color: #888;
	overflow: hidden;
}

.info:after {
	content: '';
	position: absolute;
	margin-left: -12px;
	left: 50%;
	bottom: 0;
	width: 22px;
	height: 12px;
	background:
		url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')
}

.info .link {
	color: #5085BB;
}

#jb-infomation {
	width: 73%;
	height: 98%;
	padding: 10px;
	margin-bottom: 5px;
	float: right;
	padding: 3px;
}

#jb-image {
	width: 25%;
	height: 98%;
	padding: 10px;
	margin-bottom: 5px;
	float: left;
}
</style>
</head>
<body>

	<c:forEach var="pk" items="${parkList}" varStatus="status">
		<form id="detailParkForm+${status.count }"
			name="detailParkForm+${status.count }" action="detailParkForm"
			method="post">
			<div id="jb-content"
				onclick="document.forms['detailParkForm+${status.count }'].submit();"
				style="cursor: pointer;">
				<div id="jb-infomation">
					이름 : ${pk.prkplcenm}<br> 주소 : ${pk.lnmadr}<br> 구획수 :
					${pk.prkcmprt}<br> 시간당 가격 : ${pk.basiccharge}<br> 
					<input type="hidden" name="prkplceno" value="${pk.prkplceno}">
				</div>
				<div id="jb-image">
					<img src="${pk.parkimg}" width="73"
						height="70">				
						</div>
			</div>
		</form>
	</c:forEach>


</body>
</html>