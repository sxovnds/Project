<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="icon" href="data:;base64,iVBORw0KGgo=">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<script src="/resources/js/upload.js" type="text/javascript"></script>
	
	<style>
		.table.table-hover tr th {
			text-align:center;
		}
		
		.btn-3d {
		  position: relative;
		  display: inline-block;
		  font-size: 22px;
		  padding: 10px 30px;
		  color: black;
		  margin: 20px 10px 10px;
		  border-radius: 6px;
		  text-align: center;
		  transition: top .01s linear;
		  text-shadow: 0 1px 0 rgba(0,0,0,0.15);
		}
		.btn-3d.cyan:hover   {background-color: #82D1E3;}
		
		.btn-3d:active {
		  top: 9px;
		}
		.btn-3d.cyan {
		  background-color: #7fccde;
		  box-shadow: 0 0 0 1px #7fccde inset,
		        0 0 0 2px rgba(255,255,255,0.15) inset,
		        0 8px 0 0 rgba(102, 164, 178, .6),
		        0 8px 0 1px rgba(0,0,0,.4),
		        0 8px 8px 1px rgba(0,0,0,0.5);
		}
		.btn-3d.cyan:active {
		  box-shadow: 0 0 0 1px #7fccde inset,
		        0 0 0 2px rgba(255,255,255,0.15) inset,
		        0 0 0 1px rgba(0,0,0,0.4);
		}
		
		.mypagebtn {
            text-align: center;
        }
	</style>
</head>
<script type="text/javascript">
	$(document).ready(function(){
		
		$("#memberUpdateBtn").on("click", function(){
			location.href="/member/memberUpdateView";
		})
		
		$("#memberDeleteBtn").on("click", function(){
			location.href="/member/memberDeleteView";
		})
		
		var userId = $("#member_userId").val();
	    // input태그를 hidden속성으로 숨겨서 값을 가져왔다.
	    $("#mycart_btn").click(function(event) {
		event.preventDefault();
		location.assign("/order/mycart/" + userId);			
		});
	})
</script>
<body>
<%@ include file="/WEB-INF/views/index.jsp"%>
			<div class="mypagebtn">
		        <button id="memberUpdateBtn" type="button" class="btn-3d cyan">회원정보수정</button>
		        <button id="memberDeleteBtn" type="button" class="btn-3d cyan">회원탈퇴</button>
		        <button id="mycart_btn" type="button" class="btn-3d cyan">장바구니</button>
		    </div>
			
				<div class="form-group">
					<div class="row" style="text-align: center; margin-top:10px;">
						<h1 class="page-header" style="margin-bottom: 50px;">나의 주문 내역</h1>
						<table class="table table-hover"
							style="margin: auto; border-bottom: 1px solid #D5D5D5;">
							<thead>
								<tr>
									<th>상품이미지</th>
									<th>상품명</th>
									<th>가격</th>
									<th>수량</th>
									<th>옵션</th>
									<th>결제금액</th>
									<th>결제일</th>
									<th>배송현황</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${orderList == null}">
										<tr style="text-align: center;"><td colspan="8"><h3>주문 내역이 없습니다.</h3></td></tr>
									</c:when>
									<c:otherwise>
										<c:forEach items="${orderList}" var="dto">
											<tr>
												<td style="text-align: center;"><img alt="thumbnail"
													src="/resources/upload${dto.fullname}" width="40%"> <input
													type="hidden" value="${dto.productId}" name="productId"
													id="productId"></td>
												<td>${dto.productName}<br>${dto.productInfo}</td>
												<td><fmt:formatNumber type="number"
														value="${dto.price}" />&nbsp;원</td>
												<td>${dto.order_Qty}</td>
												<td>${dto.selected_Opt}</td>
												<td><fmt:formatNumber type="number"
														value="${dto.totalAmount}" />&nbsp;원</td>
												<td><fmt:formatDate value="${dto.billingDate}"
														type="date" pattern="yyyy-MM-dd" /></td>
												<td>${dto.deliver_situ == 0 ? "배송준비중" : 
															dto.deliver_situ == 1 ? "배송중" : "배송완료"}</td>
												<c:choose>
													<c:when test="${dto.deliver_situ != 0}">
														<td>
															<button class="btn btn-default disable"
																disabled="disabled">주문취소</button>
															<br>
															<button class="btn btn-default disable"
																disabled="disabled">주문변경</button>
															<br>
														</td>
													</c:when>
													<c:otherwise>
														<td>
															<button class="btn btn-default order_cancel" 
															data-oId="${dto.orderId}" 
															data-pId="${dto.productId}"
															data-price="${dto.totalAmount}"
															data-qty="${dto.order_Qty}"
															>주문취소</button>
															<br>
														</td>
													</c:otherwise>
												</c:choose>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
				</div>
				
	<script type="text/javascript">
	$(document).ready(function () {
		
		var userId = $("#member_userId").val();
		
		$(".order_cancel").click(function(event) {
			event.preventDefault();
			
			var item = $(this);
			var orderId = item.attr("data-oId");
			var order_Qty = item.attr("data-qty");
			var productId = item.attr("data-pId");
			var aPoint = parseInt(item.attr("data-price") / 100);

 			$.ajax({
				
				type : 'post',
				url : '/order/cancel',
				data : {
					orderId : orderId,
					getPoint : aPoint,
					order_Qty : order_Qty,
					productId : productId,
					userId : userId
				},
				dataType : 'text',
				success : function(result) {
					if (result == 1) {
						
						alert("주문이 취소되었습니다.");
						location.assign("/member/mypage/" + userId);
					} else {
						
						alert("주문을 취소할 수 없습니다.");
					}
				}
			});  
			
		});
		
	});
</script>

</body>
</html>