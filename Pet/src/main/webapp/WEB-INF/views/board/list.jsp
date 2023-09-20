<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<!-- 합쳐지고 최소화된 최신 CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<!-- 부가적인 테마 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
		<link href="${pageContext.request.contextPath}/resources/css/main.css" rel="stylesheet">
		
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	
	 	<title>게시판</title>
	 	<style>
		  .table.table-hover {
		    font-family: 'SBAggroL';
		  }
		  
		  .table.table-hover tr th {
		    background-color: #CCCCCC;
		  }
		  
		  .table.table-hover tr td a{
	        color: black;
	      }
	      .pagination li a{
	      	color: black;
	      }
		</style>
	</head>
	<body>
	<%@ include file="/WEB-INF/views/index.jsp"%>
		<div class="container">
			<header>
				<h1 style="font-family: 'SBAggroL'">자유게시판</h1>
			</header>
			
			<c:if test="${member.userId != null}"> 
				<div style="text-align: right; margin-right: 40px; border-top: none; border-bottom: none;">
				    <a href="/board/writeView" style="font-family:'SBAggroL'; color:black; font-size: 23px;">게시글 작성</a>
				</div>
			</c:if>
			<c:if test="${member.userId == null}">
				<div style="text-align: right; margin-right: 40px; border-top: none; border-bottom: none;">
				    <a href="/member/login" style="font-family:'SBAggroL'; color:black; font-size: 23px;">게시글 작성</a>
				</div>
			</c:if>
			
			<section id="container">
				<form role="form" method="get">
					<table class="table table-hover">
						<tr><th>번호</th><th>제목</th><th>작성자</th><th>등록일</th><th>조회수</th></tr>
						
						<c:forEach items="${list}" var = "list">
							<tr>
								<td width="10%"><c:out value="${list.bno}" /></td>
								<td width="50%">
									<a href="/board/readView?bno=${list.bno}"><c:out value="${list.title}" /></a>
								</td>
								<td width="12%"><c:out value="${list.writer}" /></td>
								<td width="20%"><fmt:formatDate value="${list.regdate}" pattern="yyyy-MM-dd"/></td>
								<td width="8%"><c:out value="${list.hit}" /></td>
							</tr>
						</c:forEach>
					</table>
					
					<div class="search row">
						<div class="col-xs-2 col-sm-2">
							<select name="searchType" class="form-control">
								<option value="n"<c:out value="${scri.searchType == null ? 'selected' : ''}"/>>-----</option>
								<option value="t"<c:out value="${scri.searchType eq 't' ? 'selected' : ''}"/>>제목</option>
								<option value="c"<c:out value="${scri.searchType eq 'c' ? 'selected' : ''}"/>>내용</option>
								<option value="w"<c:out value="${scri.searchType eq 'w' ? 'selected' : ''}"/>>작성자</option>
								<option value="tc"<c:out value="${scri.searchType eq 'tc' ? 'selected' : ''}"/>>제목+내용</option>
							</select>
						</div>
						 
						<div class="col-xs-10 col-sm-10">
							<div class="input-group">
								<input type="text" name="keyword" id="keywordInput" value="${scri.keyword}" class="form-control"/>
								<span class="input-group-btn">
									<button id="searchBtn" type="button" class="btn btn-default">검색</button> 	
								</span>
							</div>
						</div>
						 
						<script>
							 $(function(){
								 $('#searchBtn').click(function() {
									 self.location = "list" + '${pageMaker.makeQuery(1)}' + "&searchType=" + $("select option:selected").val() + "&keyword=" + encodeURIComponent($('#keywordInput').val());
								 });
							 });   
						</script>
					</div>
					<div class="col-md-offset-3">
						<ul class="pagination">
							<c:if test="${pageMaker.prev}">
								<li><a href="list${pageMaker.makeSearch(pageMaker.startPage - 1)}">이전</a></li>
							</c:if> 
							
							<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
								<li <c:out value="${pageMaker.cri.page == idx ? 'class=info' : ''}" />>
								<a href="list${pageMaker.makeSearch(idx)}">${idx}</a></li>
							</c:forEach>
							
							<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
								<li><a href="list${pageMaker.makeSearch(pageMaker.endPage + 1)}">다음</a></li>
							</c:if>  
					  </ul>
					</div>
				</form>
			</section>
		</div>
	</body>
</html>