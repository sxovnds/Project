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
		
		#fileDrop {
			float: left;
			width: 40%;
			border: 1px solid;
			height: 300px;
		}
		
		.fileDrop {
			float: left;
			width: 100%;
			height: 300px;
		}
		
		.uploadedList {
			padding: 0;
		}
		
		.uploadedList li {
			list-style: none;
			margin-right: 20px;
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
			<h1 class="jumbotron" style="text-align: center; margin: 50px 0;">상품 등록</h1>
			<div class="form-group hidden-xs" id="fileDrop">
				<label>업로드 할 이미지 파일을 드랍하세요.</label>	
					<div class="fileDrop"></div>
					<ul class="clearfix uploadedList col-xs-12"></ul>
			</div>
			<div class="form-group productInfo">
				<form action="/admin/product/insert" method="post">
					<div>
						<label>상품 ID</label> <input name="productId" value="${productInfo.productId}" class="form-control productId" required>
					</div>
					<div>
						<label>상품명</label> <input name="productName" value="${productInfo.productName}" class="form-control" required>
					</div>
					<div>
						<label>상품가격</label> <input name="price" value="${productInfo.price}" class="form-control" required>
					</div>
					<div>
						<label>상품분류</label>
						<div class="form-inline">
							<select class="form-control" id="productDist">
								<option value="outer">1. 의류</option>
								<option value="food">2. 먹이</option>
								<option value="toy">3. 장난감</option>
								<option value="house">4. 집</option>
							</select>
							<button class="btn btn-default btn_productDist">입력</button>
							<input name="productDist" value="${productInfo.productDist}"
								class="form-control" readonly>
						</div>
					</div>
					<div>
						<label>재고</label> <input name="stock" value="${productInfo.stock}" class="form-control" required>
					</div>
					<div>
						<label>상품정보</label> <input name="productInfo" value="${productInfo.productInfo}" class="form-control" required>
					</div>

					<div class="btns">
						<button class="btn btn-default" type="submit" id="btn_product_insert">상품 등록</button>
						<button class="btn btn-default" id="btn_product_back">상품 리스트로 돌아가기</button>
					</div>
				</form>
			</div>
		</div>

		<!-- class = row -->
	</div>

	<script type="text/javascript">
	
	$(document).ready(function() {
		
		$.getJSON("/admin/productList", function(result) {
			
			var str = '';
			
			$(result).each(function() {
				var data = this; 
				
				str += makeHtmlcode_list(data);
					
			});
			
			$(".products").html(str);
			
		});
		
		var productId = $("input[name='productId']").val();
		
		$(".uploadedList").on('click', '.delbtn', function(event) {
			
			var isOK = confirm("수정버튼이나 되돌아가기 버튼과 관계없이 첨부파일이 삭제됩니다.");
			
			if (isOK) {
				
				var that = $(this);
				
				$.ajax({
					type : 'post',
					url : '/deleteFile',
					data : {
						filename : that.attr("data-src")
					},
					dataType : 'text',
					success : function(result) {
						
						if (result =="O") {
							
							that.parent().parent().parent().remove();
							
							$.ajax({
								type : 'post',
								url : '/admin/product/deleteFile',
								data : {
									filename : that.attr("data-src")
								},
								dataType : 'text',
								success : function(result) {
									alert("파일이 삭제되었습니다.");
								}
							});
							
						} else {
							alert("삭제실패");
						}
					}
				});
				
			} else {
				
				alert("삭제를 취소했습니다.");
			}

		});
		
		$.getJSON("/admin/product/getAttaches/" + productId, function(result) {
			
			var str = '';
			$(result).each(function() {
				var data = this; 
				str += makeHtmlcode(data);
			});
	
			$(".uploadedList").html(str);

		});
		
		$(".fileDrop").on("dragenter dragover", function(event) {
			event.preventDefault();
		});
		
		$(".fileDrop").on("drop", function(event) {
			event.preventDefault();

			var files = event.originalEvent.dataTransfer.files;
			var file = files[0];
			
			var formData = new FormData();
			formData.append("file",file);
			
			$.ajax({
				
				type : 'post',
				url : '/ajaxtest', 
				data : formData,
				processData : false,
				contentType : false,
				dataType : 'text',
				success : function (data) {
					var str = makeHtmlcode(data);
					
					$(".uploadedList").append(str);
				}
			});

		});
		
		$("#btn_product_insert").click(function(){
			
			var str = '';
			$(".delbtn").each(function(index) {
				
				var data = $(this).attr("data-src");
				str += '<input type="hidden" value="' + data + '" name="files">';
			});
			
			$("form").append(str);

			$("form").submit();
		});
		
		
		var productId = $(".productId").val();
		
		
		
		$(".btn_productDist").on('click', function(event) {
			event.preventDefault();
			var productDist = $("#productDist option:selected").val();
			console.log(productDist);
			$("input[name='productDist']").val(productDist);
			var log = $("input[name='productDist']").val();
			console.log(log);
		
		});
		
		
		$("#btn_product_back").click(function() {
			location.assign("/admin/product/list");
		});
		
	
	});
	
</script>

</body>
</html>