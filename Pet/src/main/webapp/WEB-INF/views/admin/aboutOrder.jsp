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
			<h1 class="jumbotron" style="text-align: center; margin: 50px 0; ">주문 현황</h1>
			<table class="table table-hover" style="border-bottom: 1px solid #D5D5D5; border-top: 1px solid #D5D5D5;">
				<thead>
					<tr>
						<th>주문ID</th>
						<th>상품ID</th>
						<th>상품명</th>
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
							<td>${dto.orderId}
								<input type="hidden" value="${dto.orderId}" name="orderId">
								</td>
							<td>${dto.productId}</td>
							<td>${dto.productName}</td>
							<td>${dto.order_Qty}</td>
							<td>${dto.selected_Opt}</td>
							<td><fmt:formatDate value="${dto.billingDate}" pattern="yyyy-MM-dd" type="date"/></td>
							<td><fmt:formatDate value="${dto.orderDate}" pattern="yyyy-MM-dd" type="date"/></td>
							<td>
								<select class="form-control" style="width: 80px; float: left;" name="deliver_situ">
								<option value=""></option>
								<option value="0">배송준비중</option>
								<option value="1">발송 완료</option>
								<option value="2">배송 완료</option>
							</select>
							&nbsp;
							<button class="btn btn-default update_deliver_situ">확인</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<!-- class = row -->

		<div class="row" style="text-align: center;">
			<h1 class="jumbotron">주문자 정보</h1>
			<table class="table table-hover"
				style="margin: 50px 0; border-bottom: 1px solid #D5D5D5; border-top: 1px solid #D5D5D5;">
				<thead>
					<tr>
						<th>회원ID</th>
						<th>주문자</th>
						<th>배송지</th>
						<th>전화번호</th>
						<th>배송메세지</th>
					</tr>
				</thead>
				<tbody style="text-align: left;">
					<tr>
						<c:forEach items="${list}" var="dto">
						<td>${dto.userId}</td>
						<td>${dto.username}</td>
						<td>${dto.postcode}<br>${dto.useraddress}</td>
						<td>${dto.tel}</td>
						<td>${dto.deliver_msg}</td>
						</c:forEach>
					</tr>
				</tbody>
			</table>

		</div>

		<div class="row" style="text-align: center; margin: 80px;">
			<button class="btn btn-default back_to_orderedlist">주문 현황으로 돌아가기</button>
		</div>
	</div>

	<script type="text/javascript">
	
	$(document).ready(function() {

		
		$(".update_deliver_situ").click(function() {
			
			var deliver_situ = $("select[name='deliver_situ']").val();
			var orderId = $("input[name='orderId']").val();
			
			$.ajax({
				
				type : 'post',
				url : '/admin/updateDelSitu',
				data : {
					orderId : orderId,
					deliver_situ : deliver_situ
				},
				dataType : 'text',
				success : function(result) {
					
					if (result == 1) {
						alert("배송현황을 변경하였습니다.");

					} else {
						alert("배송현황 변경을 실패했습니다.");
					}
				}
			});

		});
		
		$(".back_to_orderedlist").click(function() {
			location.assign("/admin/orderedlist");
		});
		
	
	});
	
</script>

</body>
</html>