<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<!-- 합쳐지고 최소화된 최신 CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<!-- 부가적인 테마 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	 	<title>게시판</title>
	 	
	 	<style>
	 		.tit {
				text-align:center;
				font-family: 'SBAggroL';
				margin-top: -20px;
			}
			
			#container {
				  margin-top: -10px;
				  font-family: 'SBAggroL'
			}
	 	</style>
	</head>
	<script type="text/javascript">
		$(document).ready(function(){
			var formObj = $("form[name='updateForm']");
			
			$(".cancel_btn").on("click", function(){
				event.preventDefault();
				location.href = "/board/list";
			})
			
			$(".update_btn").on("click", function(){
				if(fn_valiChk()){
					return false;
				}
				formObj.attr("action", "/board/update");
				formObj.attr("method", "post");
				formObj.submit();
			})
		})
			
		function fn_valiChk(){
			var updateForm = $("form[name='updateForm'] .chk").length;
			for(var i = 0; i<updateForm; i++){
				if($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null){
					alert($(".chk").eq(i).attr("title"));
					return true;
				}
			}
		}
		
	</script>
	<body>
	<%@ include file="/WEB-INF/views/index.jsp"%>
		<div class="container">
			<header>
				<h1 class="tit"> 게시글 수정</h1>
			</header>
			
			<section id="container">
				<form name="updateForm" role="form" method="post" action="/board/update">
					<input type="hidden" name="bno" value="${update.bno}" readonly="readonly"/>
					
						<div class="form-group">
						    <label for="title" class="col-sm-2 control-label">제목</label>
						    <input type="text" id="title" name="title" class="form-control chk" value="${update.title}" title="제목을 입력하세요" />
						</div>
						
						<div class="form-group">
						    <label for="content" class="col-sm-2 control-label">내용</label>
						    <textarea rows="10" cols="80" id="content" name="content" class="form-control chk" title="내용을 입력하세요"><c:out value="${update.content}" /></textarea>
						</div>
						
						<div class="form-group">
						    <label for="writer" class="col-sm-2 control-label">작성자</label>
						    <input type="text" id="writer" name="writer" class="form-control" value="${update.writer}" readonly="readonly" /> 
						</div>
						
						<div class="form-group">
						    <label for="regdate" class="col-sm-2 control-label">작성날짜</label>
						    <fmt:formatDate value="${update.regdate}" pattern="yyyy-MM-dd" />
						</div>
					
					<div>
						<button type="button" class="update_btn btn btn-primary">저장</button>
						<button type="button" class="cancel_btn btn btn-danger">취소</button>
					</div>
				</form>
			</section>
		</div>
	</body>
</html>