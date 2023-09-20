<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>

<style>
	.desc_find {
		text-align:center;
	    margin-bottom: 25px;
	    font-size: 20px;
	    font-weight: bold;
	    line-height: 15px;
	    color: #444;
	}
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/index.jsp"%>
<div class="container">
		<div class="row">
		<p class="desc_find">*회원님의 비밀번호를 재설정해주세요.</p>
			<form class="form-horizontal" action="/member/password_reset" method="post" id="passwordResetForm">
				<div class="form-group">
					<label for="userId" class="col-sm-4 control-label">아이디</label>
					<div class="col-sm-4">
						<input id="userId" class="form-control" name="userId" value="${vo.userId}" readonly>
					</div>
				</div>
				<div class="form-group">
					<label for="input_userPass" class="col-sm-4 control-label">비밀번호</label>
					<div class="col-sm-4">
						<input type="password" id="userPass" class="form-control" name="userPass" placeholder="비밀번호를 입력하세요.">
					</div>
				</div>
				<div class="form-group">
					<label for="input_userPass" class="col-sm-4 control-label">비밀번호 확인</label>
					<div class="col-sm-4">
						<input type="password" class="form-control" id="userPassOK" name="userPassOK" placeholder="비밀번호를 입력하세요.">
					</div>
				</div>
				 <div class="form-group text-center">
			        <button type="button" class="btn btn-default" id="btn-confirm">확인</button>
			    </div>
			</form>
		</div>			
</div>

<script>
$(document).ready(function() {
    $("#btn-confirm").click(function(event) {
        event.preventDefault();

        var userPass = $("#userPass").val();
        var userPassOK = $("#userPassOK").val();
        var userId = getUrlParameter('userId'); // URL 파라미터에서 userId를 가져옴

        if (userPass === userPassOK) {
            // 비밀번호와 비밀번호 확인이 일치하면 서버로 요청을 보냅니다.
            $.ajax({
                type: 'post',
                url: '/member/password_reset',
                data: {
                    userPass: userPass,
                    userId: userId // userId를 서버로 전달
                },
                dataType: 'text',
                success: function(data) {
                    if (data === 'success') {
                        alert("비밀번호가 변경되었습니다. 로그인해주세요.");
                        window.location.href = '/member/login'; // 로그인 페이지로 이동
                    } else {
                        alert("비밀번호 변경에 실패했습니다.");
                    }
                }
            });
        } else {
            alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
        }
    });
});

function getUrlParameter(name) {
    name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
    var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
    var results = regex.exec(location.search);
    return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
}
</script>
</body>
</html>