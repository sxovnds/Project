<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Top</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="icon" href="data:;base64,iVBORw0KGgo=">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<script src="/resources/js/upload.js" type="text/javascript"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style type="text/css">
	
	.container{
		margin-top: 50px;
	}
	
	.products li{
		list-style: none;
	}
	
	.products li .scale{
		text-align: center;
		font-family: '나눔명조 Bold';
	}
	
	.nav li{
		cursor: pointer;
	}
	
	.table.table-hover tr th {
		text-align:center;
	}

	
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/index.jsp"%>
	<div class="container">
		<c:set value="${orderDTO}" var="dto"/>
		<div class="row" style="text-align: center;">
			<h1 class="page-header" style="margin-bottom: 50px;">주문이 완료되었습니다.</h1>
			<table class="table table-hover" style="margin: auto; border-bottom: 1px solid #D5D5D5;">
				<thead>
					<tr>
						<th>상품이미지</th>
						<th>상품명</th>
						<th>가격</th>
						<th>수량</th>
						<th>옵션</th>
						<th>결제금액</th>
					</tr>
				</thead>
				<tbody>
						<tr>
							<td style="text-align: center;"><img alt="thumbnail" src="/resources/upload${dto.fullname}" width="30%">
							<input type="hidden" value="${dto.productId}" name="productId" id="productId">
							</td>
							<td>${dto.productName}</td>
							<td><fmt:formatNumber type="number" value="${dto.price}"/>&nbsp;원</td>
							<td>${dto.order_Qty}</td>
							<td>${dto.selected_Opt}</td>
							<td><fmt:formatNumber type="number" value="${dto.totalAmount}"/>&nbsp;원</td>
						</tr>
				</tbody>
			</table>
		</div>
		
		<hr>
		
		<div class="row" style="text-align: center;">
			
			<table class="table table-hover" style="margin: auto; border-bottom: 1px solid #D5D5D5;">
				<thead>
					<tr>
						<th>주문자</th>
						<th>배송지</th>
						<th>전화번호</th>
						<th>배송상태</th>
						<th>배송메세지</th>
					</tr>
				</thead>
				<tbody>
						<tr>
							<td>${dto.username}</td>
							<td>${dto.postcode}<br>${dto.useraddress}</td>
							<td>${dto.tel}</td>
							<td id="del_situ"></td>
							<td>${dto.deliver_msg}</td>
						</tr>
				</tbody>
			</table>
		</div>
		
		<div class="row" style="margin: 80px 0; text-align: center;">
			<button class="btn btn-default back_btn">쇼핑을 계속하기</button>
			<button class="btn btn-default mycart_btn">장바구니로 이동하기</button>
		</div>
	</div>

<script type="text/javascript">
	
	$(document).ready(function() {
		
		var userId = $("#member_userId").val();
		var productId = $("#productId").val();
		
		del_situ();
		
		
		$(".back_btn").click(function(event) {
			event.preventDefault();
			location.assign("/admin/petshop");
		});

		$(".mycart_btn").click(function(event) {
			event.preventDefault();
			location.assign("/order/mycart/" + userId);
			
		});
		
		$("#searchAdd").click(function(event) {
			event.preventDefault();
			postcode();

		});
	    
	    function del_situ() {
	    	var situ = "<c:out value='${dto.deliver_situ}'/>";
	    	if (situ == '0') {
				situ = "배송 준비중";
			} else if (situ == '1') {
				situ = "배송중";
			} else if (situ == '2') {
				situ = "배송 완료";
			}
	    	
	    	$("#del_situ").html(situ);
		}
	
	});
	
</script>

</body>
</html>