<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cart</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
 href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<script
 src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
 src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script
 src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script src="/resources/js/upload.js" type="text/javascript"></script>
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
<script type="text/javascript">
function itemSum(){
    var sum = 0;

    $(".chkbox:checked").each(function() {
        var row = $(this).closest("tr"); // 현재 체크박스가 속한 행
        var price = parseFloat($(this).data("price"));
        var qty = parseFloat(row.find("[name='order_Qty']").val());
        sum += price * qty;
    });

    $("#total_sum").html(sum.toLocaleString() + " 원");
    $("#amount").val(sum);
}



</script>
</head>
<body>
<%@ include file="/WEB-INF/views/index.jsp"%>
	<div class="container">

	<c:set value="${cartMap.cartList}" var="cartList"/>
	<c:set value="${cartMap.productList}" var="productList"/>
	
	<c:forEach items="${cartList}" var="cList">
		<input type="hidden" value="${cList.cartId}" name="cartId">
	</c:forEach>
		
		<div class="row qnas" style="text-align: center;">
		<form action="/order/cartOrder" method="post" id="orderForm">
			<h1 class="page-header">장바구니</h1>
			<table class="table table-hover" style="margin: auto; border-bottom: 1px solid #D5D5D5;">
				<thead>
					<tr>
						<th>상품이미지</th>
						<th>상품명</th>
						<th>가격</th>
						<th>수량</th>
						<th>옵션</th>
					</tr>
				</thead>
				<tbody>
					<c:choose><c:when test="${productList != null}">
					<c:forEach items="${productList}" var="vo" varStatus="status">
						<tr>
							<td class="product-close">
							<input type="checkbox" class="chkbox" name="selectedItems" onClick="itemSum()" 
							 value="${vo.productId}" data-cartNum="${vo.productId}"  style="margin-right: 30px;"  data-price="${vo.price}">
							<img alt="thumbnail" src="/resources/upload${vo.filename}">
							</td>
							<td><a href="/product/show/${vo.productId}">${vo.productName}</a>
								<input value="${vo.productId}" name="productId" type="hidden">
							</td>
							<td><fmt:formatNumber type="number" value="${vo.price}"/>&nbsp;원<br>
								<span><fmt:parseNumber var="test" value="${vo.price / 100}" integerOnly="true"/> ${test}&nbsp;원
										<input value="${test}" type="hidden" name="getPoint" id="point"></span></td>
								<td><c:choose>
										<c:when test="${vo.stock == 0}">
											<span>품절된 상품입니다.</span>
										</c:when>
										<c:otherwise>
											<select class="form-control" id="select_count" name="order_Qty">
												<c:forEach var="count" begin="1" end="${vo.stock > 5 ? 5 : vo.stock}">
													<option value="${count}">${count}</option>
												</c:forEach>
											</select>
										</c:otherwise>
									</c:choose>
									</td>
										<td><c:choose>
												<c:when test="${vo.productDist == 'outer'}">
													<div class="form-horizontal" style="text-align: left;">
														<select class="form-control opt_select" name="selected_Opt">
															<option value="S">S</option>
															<option value="M">M</option>
															<option value="L">L</option>
														</select>
													</div>
												</c:when>
												<c:otherwise></c:otherwise>
											</c:choose></td>
							<td>	
								<c:choose>
									<c:when test="${vo.stock == 0}">
										<button class="btn btn-default del_from_cart" value="${vo.productId}">삭제하기</button>
									</c:when>
									<c:otherwise>
										<button class="btn btn-default del_from_cart" value="${vo.productId}">삭제하기</button>
									</c:otherwise>
								</c:choose> 
							</td>
						</tr>
					</c:forEach>
					</c:when>
					<c:otherwise>
						<tr><td colspan="5"><h3>장바구니에 내역이 없습니다.</h3></td></tr>
					</c:otherwise></c:choose>
				</tbody>
			</table>
		</form>
	</div>
		
		<div class="row" style="text-align: center; margin: 40px 0;">
			<button type="button" onclick="goOrder()" class="btn btn-warning">주문하기</button>
			<button class="btn btn-default btn-back_to_shop">쇼핑을 계속하기</button>
		</div>
	
	</div>


<script type="text/javascript">
	
	$(document).ready(function() {
		
		$(".del_from_cart").click(function(event) {
			event.preventDefault();
			var item = $(this);
			var productId = item.val();
			var userId = $("#member_userId").val();
			
			$.ajax({
				
				type : 'post',
				url : '/order/delFromCart',
				data : {
					productId : productId,
					userId : userId
				},
				dataType : 'text',
				success : function(result) {
					
					if (result == 'ok') {
						alert("장바구니에서 삭제되었습니다.");
						location.assign("/order/mycart/" + userId);
					} else {
						alert("이미 삭제 된 상품입니다.");
					}
				}
			});
			
			
		});
		
		
		$(".btn-back_to_shop").click(function() {
			location.assign("/admin/petshop");
		});
	});
	
	
	function goOrder() {
	    // 1. 선택한 상품의 ID를 배열로 수집
	    var selectedItems = [];

	    $(".chkbox:checked").each(function() {
	        var productId = $(this).val();
	        selectedItems.push(productId);
	    });

	    // 2. 선택한 상품이 없는 경우 알림을 표시하고 리턴
	    if (selectedItems.length === 0) {
	        alert('주문할 상품을 체크하세요');
	        return;
	    }

	    // 3. 폼에 선택한 상품 정보를 추가
	    var orderForm = $("#orderForm");
	    for (var i = 0; i < selectedItems.length; i++) {
	        var input = $("<input>")
	            .attr("type", "hidden")
	            .attr("name", "selectedItems")
	            .val(selectedItems[i]);
	        orderForm.append(input);
	    }

	    // 4. 주문하기 폼을 서버로 제출
	    orderForm.submit();
	}
	
</script>

</body>
</html>