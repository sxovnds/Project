<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="icon" href="data:;base64,iVBORw0KGgo=">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<script src="/resources/js/upload.js" type="text/javascript"></script>
<title>Insert title here</title>
	<style>
		.admin_container {
			margin-top: -155px;
		    margin-left: 220px; /* 사이드바 너비와 여백만큼 오른쪽으로 옮김 */
		}
	</style>
</head>
<body>
<%@ include file="/WEB-INF/views/admin/main.jsp"%>
	<div class="container admin_container">
		<div class="row">
			<h1 class="jumbotron" style="text-align: center; margin: 50px 0;">주문 현황</h1>
			<table class="table table-hover">
				<thead>
					<tr>
						<th>주문ID</th>
						<th>주문자ID</th>
						<th>주문자명</th>
						<th>결제금액</th>
						<th>주문량</th>
						<th>상품옵션</th>
						<th>결제일</th>
						<th>주문일</th>
						<th>배송현황</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="dto">
						<tr>
							<td><a href="/admin/aboutOrder/${dto.orderId}">${dto.orderId}</a></td>
							<td>${dto.userId}</td>
							<td>${dto.username}</td>
							<td>${dto.totalAmount}</td>
							<td>${dto.order_Qty}</td>
							<td>${dto.selected_Opt}</td>
							<td><fmt:formatDate value="${dto.billingDate}" pattern="yyyy-MM-dd" type="date"/></td>
							<td><fmt:formatDate value="${dto.orderDate}" pattern="yyyy-MM-dd" type="date"/></td>
							<td>${dto.deliver_situ == 0 ? "배송준비중" : 
															dto.deliver_situ == 1 ? "배송중" : "배송완료"}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>

<script type="text/javascript">
	
	
	
</script>

</body>
</html>