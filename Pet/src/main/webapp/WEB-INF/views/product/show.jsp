<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shop</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="icon" href="data:;base64,iVBORw0KGgo=">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
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
	
	.about_product li{
		list-style: none;
	}

	.about_product li img{
		margin: 70px 0;
	}

</style>
</head>
<body>
<%@ include file="/WEB-INF/views/index.jsp"%>
	<div class="container" style="width: 60%">
		<form action="/order/insert" method="post">
		<div class="row"><h1 class="page-header" style="text-align: center; margin-bottom: 50px;">${productInfo.productName}</h1>
			<input type="hidden" name="productId" value="${productInfo.productId}" id="productId">
		</div>
		<div class="row" style="float: left; text-align: center; width:35%; margin-left:50px;">
			<img alt="productPhoto" src="/resources/upload${productInfo.filename}" width="120%">
		</div>

		<div class="row productInfo" style="width: 40%; float: right; margin-top:40px;" >
			<div class="form-group" style="text-align: left;">
				<label>가격 : </label><span>&nbsp;<fmt:formatNumber value="${productInfo.price}" type="number"/></span><span>&nbsp;원</span>
				<input type="hidden" value="${productInfo.price}" id="price">
			</div>
			<div class="form-group" style="text-align: left;">
				<label>배송비 : </label><span>&nbsp;2500원</span>
				<p>3만원 이상 결제시 무료배송</p>
			</div>
			<div class="form-group" style="text-align: left;">
				<label>적립금 : </label><span><fmt:parseNumber var="test" value="${productInfo.price / 100}" integerOnly="true"/> ${test}&nbsp;원
				<input value="${test}" type="hidden" name="getPoint" id="point"></span>
			</div>

			<c:choose>
				<c:when test="${productInfo.productDist == 'outer'}">
					<div class="form-horizontal" style="text-align: left;">
						<label>옵션 : </label> 
						<select class="form-control opt_select" name="selected_Opt">
							<option value="S">S</option>
							<option value="M">M</option>
							<option value="L">L</option>
						</select>
					</div>
				</c:when>
				<c:otherwise></c:otherwise>
			</c:choose>		
			<div class="form-horizontal" style="text-align: left;">
				<label>구매수량 : </label> 
				<c:choose>
					<c:when test="${productInfo.stock == 0}">
						<span>품절된 상품입니다.</span>
					</c:when>
					<c:otherwise>
						<select class="form-control" id="select_count" name="order_Qty">
						<c:forEach begin="1" end="${productInfo.stock > 5 ? 5 : productInfo.stock}" var="count">
						<option value="${count}">${count}</option></c:forEach>
						</select>					
					</c:otherwise>
				</c:choose>
			</div>	
			<hr>
			
			<div class="row">
				<div class="selected_option" style="text-align: right;">
				</div>
				<div style="text-align: center;">
				<c:choose>
					<c:when test="${productInfo.stock == 0}">
						<button class="btn btn-default btn-order" disabled="disabled">주문하기</button>
						<button class="btn btn-default btn-cart" disabled="disabled">장바구니 담기</button>
					</c:when>
					<c:otherwise>
						<button class="btn btn-default btn-order" type="submit">주문하기</button>
						<button class="btn btn-default btn-cart">장바구니 담기</button>					
					</c:otherwise>
				</c:choose>

				</div>
			</div>
			<hr>		
		</div>
		</form>
	</div>

	<div class="container">
		<div class="row" style="margin:50px 0;">
			<div class="jumbotron">
			<h3 style="margin-top:-85px;">상품 정보</h3>
				<div class="container">
					<hr>
					<h4 style="margin-top:-70px;">${productInfo.productInfo}</h4>
				</div>
			</div>
		</div>

		<div class="row about_product"
			style="text-align: center; height: auto;">
			<h1 class="page-header">상품 상세</h1>

		</div>

	</div>

	<script type="text/javascript">
	
	$(document).ready(function() {
		
		var productId = $("#productId").val();
		
		$(".btn-cart").click(function(event) {
			event.preventDefault();
			var qty = $("#select_count").val();
			var price = "<c:out value='${test}'/>";
			
			var point = Number(price) * Number(qty);
			$("#point").val(point);

		});
		
		$(".btn-order").click(function(event) {
			
			event.preventDefault();
			if (${member == null ? 'true' : 'false'}) {
				alert("로그인이 필요합니다.");
				location.assign("/member/login");
			} else {
				$("form").submit();
			}
			
		});
		
		$(".btn-cart").click(function(event) {
			
			event.preventDefault();
			
			if (${member == null ? 'true' : 'false'}) {
				alert("로그인이 필요합니다.");
				location.assign("/member/login");
				
			} else {
				
				$.ajax({
					
					type : "post",
					url : "/order/cart/" + productId,
					data : {
						productId : productId
					},
					dataType : "text",
					success : function(result) {
						
						if (result.trim() == 'add_success') {
							alert("카트에 등록되었습니다.");
			
						} else if (result.trim() == 'already_existed') {
							alert("이미 카트에 등록된 상품입니다.");
						}
					}
				});
			}

		});
		
		$.getJSON("/admin/product/getAttaches/" + productId, function(result) {
			
			var str = '';
			
			$(result).each(function() {
				var data = this;
				
				str += aboutProductPhotos(data);
					
			});
			
			$(".about_product").append(str);
			
		});
		
		$("#mycart_btn").click(function(event) {
			event.preventDefault();
			location.assign("/order/mycart/" + userid);
			
		});
		
		$("#review").click(function() {
			
			var scrollPosition = $(".reviews").offset().top;
			$("html").animate({scrollTop: scrollPosition}, 500); 
		});
		
		$("#about").click(function() {
			
			var scrollPosition = $(".about_product").offset().top;
			$("html").animate({scrollTop: scrollPosition}, 500); 
		});
		
		$("#select_count").on('blur', function() {
			var count = $(this).val();
			var price = $("#price").val();
			var opt = $(".opt_select").val();
			
			
			if (count*price >= 30000) {
				var shipping = '무료배송';
				var finalPrice = count*price;
			} else {
				var shipping = 2500;
				var finalPrice = (count*price) + shipping;
			}
			
			var str = '';
			
			str += '<p><label>수량 : </label><span>&nbsp;' + count + '</span>&nbsp;&nbsp;&nbsp;';	
			
			if (opt != 'S' && opt != 'M' && opt != 'L') {
				str += '<lable></lable>';
			} else {
				str += '<label>옵션 : </label><span>&nbsp;' + opt + '</span>&nbsp;&nbsp;&nbsp;';	
			}
			
			str += '<label>배송비 : </label><span>&nbsp;' + shipping + '</span>&nbsp;&nbsp;&nbsp;';
			str	+= '<label>가격 : </label><span>&nbsp;' + price + ' 원</span></p>';
			str += '<h4><label>결제금액 : </label><span>&nbsp;' + finalPrice + ' 원</span></h4>'; 
			
			$(".selected_option").html(str);
			console.log(opt);
		});	
	});
	
</script>

</body>
</html>
