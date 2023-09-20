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
		.container{
			margin-top: 50px;
		}
		
		.products li, .products_new li{
			list-style: none;
		}
		
		.products li .scale, .products_new li .scale{
			text-align: center;
			font-family: '나눔명조 Bold';
		}
	</style>
</head>
<body>
<%@ include file="/WEB-INF/views/index.jsp"%>
<div class="container">
		<div class="content">
			<h1 class="page-header">애견상품&nbsp;&nbsp;<small>*먹이,장난감,의류 등..</small></h1>
			<div class="row products"></div>
		</div>
</div>

<script type="text/javascript">
	
	$(document).ready(function() {
		
		$.getJSON("/admin/productList", function(result) {
			
			var str = '';
			
			$(result).each(function() {
			
				var data = this; 
				console.log(data);
				str += makeHtmlcode_list(data);
					
			});
			
			$(".products").html(str);
			
		});
	
	});
	
</script>


</body>
</html>