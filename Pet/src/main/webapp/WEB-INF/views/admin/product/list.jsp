<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style>
		.admin_container {
			margin-top: -155px;
		    margin-left: 220px; /* 사이드바 너비와 여백만큼 오른쪽으로 옮김 */
		}
		
		.table.table-hover tr th {
		    background-color: #CCCCCC;
		  }
	</style>
</head>
<body>
<%@ include file="/WEB-INF/views/admin/main.jsp"%>
	<div class="container admin_container">
		<div class="row">
			<h1 class="jumbotron" style="text-align: center; margin: 50px 0;">상품 리스트</h1>
			<table class="table table-hover">
				<thead>
					<tr>
						<th>상품ID</th>
						<th>상품명</th>
						<th>상품가격</th>
						<th>재고</th>
						<th>상품분류</th>
						<th>상품 등록일</th>
						<th>최종 수정일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${productList}" var="dto">
						<tr>
							<td><a href="/admin/product/read/${dto.productId}">${dto.productId}</a></td>
							<td>${dto.productName}</td>
							<td>${dto.price}</td>
							<td>${dto.stock}</td>
							<td>${dto.productDist}</td>
							<td><fmt:formatDate value="${dto.regDate}" type="date" pattern="yyyy-MM-dd"/> </td>
							<td><fmt:formatDate value="${dto.updateDate}" type="date" pattern="yyyy-MM-dd"/></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>

</body>
</html>