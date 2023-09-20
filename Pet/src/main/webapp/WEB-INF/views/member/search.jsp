<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>

</head>
<body>
<%@ include file="/WEB-INF/views/index.jsp"%>
	<div class="container">
		<div class="row">
			<div class="form-group text-center">
				<h3>ID와 비밀번호를 잊어버리셨나요?</h3>
				<Br>
				<button class="btn btn-default" id="find_id">ID 찾기</button>
				<button class="btn btn-default" id="find_pw">비밀번호 찾기</button>
			</div>

			<div class="collapse form-horizontal" id="find_id_Collapse" style="text-align: center; margin-top: 50px;">
				<div class="form-group">
					<label for="input_username" class="col-sm-4 control-label">이름</label>
					<div class="col-sm-4">
						<input class="form-control input_userName" name="userName" placeholder="이름을 입력하세요.">
					</div>
				</div>
				<div class="form-group">
					<label for="input_email" class="col-sm-4 control-label">E-mail</label>
					<div class="col-sm-4">
						<input class="form-control input_userEmail" name="userEmail" placeholder="E-mail 주소를 입력하세요.">
					</div>
				</div>
				<div class="form-group">
					<button class="btn btn-default" id="btn-findId">ID찾기</button>
				</div>				
			</div>		
		</div>

			<div class="collapse form-horizontal" id="find_pw_Collapse" style="text-align: center; margin-top: 50px;">
				<div class="form-group">
					<label for="input_userid" class="col-sm-4 control-label">ID</label>
					<div class="col-sm-4">
						<input class="form-control" id="input_userId" name="userId" placeholder="ID를 입력하세요.">
					</div>
				</div>
				<div class="form-group">
					<label for="input_username" class="col-sm-4 control-label">이름</label>
					<div class="col-sm-4">
						<input class="form-control" id="input_userName" name="userName" placeholder="이름을 입력하세요.">
					</div>
				</div>				
				<div class="form-group">
					<label for="input_email" class="col-sm-4 control-label">E-mail</label>
					<div class="col-sm-4">
						<input class="form-control" id="input_userEmail" name="userEmail" placeholder="E-mail 주소를 입력하세요.">
					</div>
				</div>
				<div class="form-group">
					<button class="btn btn-default" id="btn-findPw">비밀번호 찾기</button>
				</div>	
			</div>		
	</div>
	
<script type="text/javascript">
	
	$(document).ready(function() {
		
		$("#find_id").click(function(event) {
			event.preventDefault();
			$("#find_id_Collapse").collapse("toggle");
			$("#find_pw_Collapse").collapse("hide");

		});
		
		$("#btn-findId").click(function(evnet) {
			event.preventDefault();
					
			var userName = $(".input_userName").val();
			var userEmail = $(".input_userEmail").val();
			
			
  			$.ajax({
				
				type : 'post',
				url : '/member/findId',
				data : {
					userName : userName,
					userEmail : userEmail
				},
				dataType : 'text',
				success : function(result) {
					
					if (result) {			
						var userId = result;
						alert("회원님의 ID는 "+ userId + "입니다.");
						$("#inputId").val(userId);
						$("#find_id_Collapse").collapse("hide");
						$(".input_userName").val('');
						$(".input_userEmail").val('');
					} else {
						alert("ID를 찾을 수 없습니다.");
						$(".input_userName").val('');
						$(".input_userEmail").val('');
					}
				}
			});  	
		});
		
		$("#find_pw").click(function(event) {
			event.preventDefault();
			$("#find_pw_Collapse").collapse("toggle");
			$("#find_id_Collapse").collapse("hide");
		});
		
		$("#btn-findPw").click(function(event) {
			event.preventDefault();
			
			var userName = $("#input_userName").val();
			var userEmail = $("#input_userEmail").val();
			var userId = $("#input_userId").val();
			
 			$.ajax({
				
				type : 'post',
				url : '/member/findPw',
				data : {
					userId : userId,
					userName : userName,
					userEmail : userEmail
				},
				dataType : 'text',
				success : function(data){
					if(data == 1){
						window.location.href = '/member/password_resetView?userId=' + userId;
					}else if(data == 0){
						alert("입력된 정보 불일치.");
					}
				}
			}); 
		});
		
	});
</script>
</body>
</html>