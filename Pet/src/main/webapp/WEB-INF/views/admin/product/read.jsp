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
		
		.productInfo {
			float: right;
			text-align: left;
			width: 50%;
		}
		
		.productInfo .btns {
			text-align: center;
			margin-top: 50px;
		}
		
		.uploadedList {
			padding: 0;
			width: 40%;
			float: left;
			height: 500px;
		}
		
		.uploadedList li{
			list-style: none;
		}
		
		.uploadedList img{
			width: 95%;
			height: auto;
		}
		
		.uploadedList p {
			overflow: hidden;
			text-overflow: ellipsis;
			white-space: nowrap;
		}
	</style>
</head>
<body>
<%@ include file="/WEB-INF/views/admin/main.jsp"%>
	<div class="container admin_container">
		<div class="row">
			<h1 class="jumbotron" style="text-align: center; margin: 50px 0;">${productInfo.productId}</h1>
		<div class="form-group">
			<ul class="clearfix uploadedList">
				<li></li>
			</ul>
		</div>
			<div class="form-group productInfo">
				<div>
					<label>상품 ID</label>
					<input name="productId" value="${productInfo.productId}" class="form-control productId" readonly>
				</div>
				<div>
					<label>상품명</label>
					<input name="productName" value="${productInfo.productName}" class="form-control" readonly>
				</div>
				<div>
					<label>상품가격</label>
					<input name="price" value="${productInfo.price}" class="form-control" readonly>
				</div>
				<div>
					<label>상품분류</label>
					<input name="productDist" value="${productInfo.productDist}" class="form-control" readonly>
				</div>										
				<div>
					<label>재고</label>
					<input name="stock" value="${productInfo.stock}" class="form-control" readonly>
				</div>	
				<div>
					<label>상품정보</label>
					<input name="stock" value="${productInfo.productInfo}" class="form-control" readonly>
				</div>	
				<div>
					<label>상품 등록일</label>
					<input name="stock" value="${productInfo.regDate}" class="form-control" readonly>
				</div>	
				<div>
					<label>최종 수정일</label>
					<input name="stock" value="${productInfo.updateDate}" class="form-control" readonly>
				</div>			
				<div class="btns">
					<button class="btn btn-default" id="btn_product_update">상품정보 수정</button>
					<button class="btn btn-default" id="btn_product_delete">상품 삭제</button>
					<button class="btn btn-default" id="btn_product_back">돌아가기</button>
				</div>														
			</div>
		</div>
	</div>

	<script type="text/javascript">
	
	$(document).ready(function() {
		
		$("li").on('click', function() {
			var productDist = $(this).attr("value");
			
			if (productDist == 'qna') {
				location.assign("/board/qna");
			} else {
				location.assign("/product/" + productDist);
			}		
		});
		
		$.getJSON("/admin/productList", function(result) {
			
			var str = '';
			
			$(result).each(function() {
				var data = this; 
				console.log(data);
				
				str += makeHtmlcode_list(data);
					
			});
			
			$(".products").html(str);
			
		});
		
		
		var productId = $(".productId").val()
		
		$.getJSON("/admin/product/getAttaches/" + productId, function(result) {
			
			var str = '';
			$(result).each(function() {
				var data = this; 
				str += makeHtmlcode_read(data);
			});
			
			$(".uploadedList").html(str);
			
		});
		
		$("#btn_product_update").click(function() {
			
			location.assign("/admin/product/update/" + productId);
		});
		
		$("#btn_product_delete").click(function() {
			
			var isOk = confirm("상품을 삭제하시겠습니까? (삭제하시면 상품 정보를 되돌릴 수 없습니다.)");
			
			if (isOk) {
				location.assign("/admin/product/delete/" + productId);
			}
		});
		
		$("#btn_product_back").click(function() {
			location.assign("/admin/product/list");
		});
		
	
	});
	
</script>

</body>
</html>