<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Main</title>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		
		<style>
			.side_nav {
			    width: 210px; /* 필요에 따라 너비를 조정합니다. */
			    padding: 20px;
			    margin-top: 20px; /* 페이지 상단과 사이드 내비게이션 간의 간격을 추가합니다. */
			    margin-left:140px;
			}
			
			.side_nav ul {
			    list-style: none;
			    padding: 0;
			}
			
			.side_nav li {
			    margin-bottom: 10px; /* 링크 간의 간격을 추가합니다. */
			}
			
			.side_nav li a {
				text-align: center;
			    display: block;
			    padding: 5px;
			    text-decoration: none;
			    color: #333; /* 링크 색상을 설정합니다. */
			}
			
			.side_nav li.active {
			    background-color: #ddd; /* 활성 링크의 배경색을 설정합니다. */
			}
		</style>
	</head>
<body>
<%@ include file="/WEB-INF/views/index.jsp"%>
	<div class="row side_nav">
		<ul class="nav nav-pills nav-stacked">
			<li class="li_btns"><a href="/admin/orderedlist">주문 현황</a></li>
			<li class="li_btns"><a href="/admin/list">회원 관리</a></li>
			<li class="li_btns"><a href="/admin/product/insert">상품 등록</a></li>
			<li class="li_btns"><a href="/admin/product/list">상품 조회</a></li>
		</ul>
	</div>
	
	<script>
	$(document).ready(function () {
	    // 현재 페이지 URL 가져오기
	    var currentUrl = window.location.href;

	    // 각 버튼에 대한 URL 정보
	    var urls = [
	        "/admin/orderedlist",
	        "/admin/list",
	        "/admin/product/insert",
	        "/admin/product/list"
	    ];

	    // 추가 URL 패턴들
	    var additionalUrls = [
	        { urlPattern: "/admin/aboutOrder/", targetButton: "/admin/orderedlist" },
	        { urlPattern: "/admin/product/read/", targetButton: "/admin/product/list" }
	    ];

	    // 각 버튼의 링크 요소에 대해 순회
	    $(".nav-pills li").each(function (index) {
	        var buttonUrl = urls[index];
	        var isButtonActivated = false;

	        // 현재 URL과 버튼의 URL이 일치하면 버튼을 active로 설정
	        if (currentUrl.indexOf(buttonUrl) !== -1) {
	            $(this).addClass("active");
	            isButtonActivated = true;
	        }

	        // 추가 URL 패턴들에 대해 순회
	        for (var i = 0; i < additionalUrls.length; i++) {
	            var additionalUrl = additionalUrls[i].urlPattern;

	            // 현재 URL이 추가 URL 패턴을 포함하고 버튼의 URL과 같은지 확인
	            if (currentUrl.indexOf(additionalUrl) !== -1 && buttonUrl === additionalUrls[i].targetButton) {
	                $(this).addClass("active");
	                isButtonActivated = true;
	            }
	        }

	        // 만약 버튼이 활성화되지 않았다면 active 클래스 제거
	        if (!isButtonActivated) {
	            $(this).removeClass("active");
	        }
	    });
	});
    </script>
	
</body>
</html>