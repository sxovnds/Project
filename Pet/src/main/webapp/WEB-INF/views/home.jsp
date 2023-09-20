<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Home</title>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <link href="${pageContext.request.contextPath}/resources/css/main.css" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
</head>

<style>
	.containers {
        height:730px;
        width:100%;
        background-color:#ACD5DE;
	}
	.mainimg {
	  position: relative;
	  width: 300px; /* 원하는 컨테이너 너비로 설정 */
	  height: 200px; /* 원하는 컨테이너 높이로 설정 */
	}
	
	.mainimg img {
		  position: absolute;
		  bottom: -510px;
		  right: -1600px; /* 이미지를 오른쪽으로 이동 */
	}
	
	.maintext {
		 margin-left:65px;
		 font-family: 'SBAggroL';
		 font-size:65px;
		 color: #1A4E8D;
	}
	
	.maintext1{
		margin-left:65px;
		font-family: 'SBAggroL';
		color: #1A4E8D;
	}
</style>

<body>

<div id="pages">
		<div id="header">
			<a href="/"><img src="${pageContext.request.contextPath}/resources/img/logo.jpg" style="width:200px; margin-top:-43px;"></a>
		</div>
		
		<div class="nav">
			<div id="menu" style="position: sticky;">
				<span><a href="/board/list">자유게시판</a></span>
				<span><a href="/admin/petshop">애견용품</a></span>
				<span><a href="/hospital/petmap">동물병원찾기</a></span>
				<span>
					<c:if test="${member == null}"><a href="/member/login">Log in/Join</a></c:if>
					<c:if test="${member != null}">
					    <a href="javascript:void(0);" onclick="confirmLogout()">로그아웃</a>
					</c:if>
				</span>
				<span>
					<c:if test="${member != null && member.userId != 'admin'}">
						<a href="/member/mypage/${member.userId}">마이페이지(${member.userName}님)</a>
					</c:if>
					<c:if test="${member.userId == 'admin'}">
						<a href="/admin/main">관리자페이지</a>
					</c:if>
				</span>
				<input type="hidden" value="${member.userId}" id="member_userId">
			</div>
		</div>
		
		<div class="containers">
			<div class="mainimg">
				<img src="${pageContext.request.contextPath}/resources/img/mainpage.jpg">
			</div>
			
			<h1 class="maintext">A space for people <br>who love pets</h1>
			<h1 class="maintext1">Put it to good use</h1>
		</div>
</div>



<script>
    function confirmLogout() {
        if (confirm("로그아웃 하시겠습니까?")) {
        	
            window.location.href = "/member/logout"; // 로그아웃 컨트롤러 URL로 이동
        }
    }
</script>
</body>
</html>
