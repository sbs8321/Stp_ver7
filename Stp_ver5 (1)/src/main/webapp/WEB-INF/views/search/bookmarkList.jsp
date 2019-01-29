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
	  background:#ffffff;
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
	  background:#ffffff;
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



	
	
	
	<div style="margin-top: 50px;">
	<div style="width: 700px; margin: auto;">
	
	<c:forEach var="bk" items="${book}" varStatus="status">
	<button>
		<form id="detailParkForm+${status.count}" name="detailParkForm+${status.count}" action="../search/detailParkForm" method="post">
			<div id="jb-content" style="background-color:#ffffff" onclick="document.forms['detailParkForm+${status.count}'].submit();" style="cursor: pointer;">
				<div style="margin: auto; "> <img src="${bk.parkimg }" width="70" height="50"></div>
				<div style="width: 70px; "> <h6>${bk.prkplcenm }</h6></div>
				<input type="hidden" id="prkplceno" name="prkplceno" value="${bk.prkplceno}">
			</div>
		</form>
	</button>
	</c:forEach>
	</div>
	</div>


</body>
</html>