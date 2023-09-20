<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	 	<title>게시판</title>
	 	
	 <style>
		.container {
		  width: 800px;
		  border: 2px solid black; /* 모든 테두리를 2px 굵기의 빨간색으로 설정 */
		  padding: 20px; /* 전체 여백을 위한 패딩 (선택사항) */
		  margin: 0 auto; /* 좌우 여백을 자동으로 조정하여 중앙에 배치 */
		}
		
		.board_page {
		  text-align: center;
		  padding-right: 20px;
		}
		
		#tbl_boardInsert {
		  margin: 0 auto;
		}
		
		#tbl_boardInsert .btitle {
		  border-top: 1px solid black;
		}
		
		#tbl_boardInsert tr {
		  border-bottom: 1px solid #dedede;
		}
		
		#tbl_boardInsert td {
		  padding: 10px;
		  font-family: 'SBAggroL'
		}
		
		.title {
		  font-weight: bold;
		}
		
		.write_btn,
		.cancel_btn {
		  padding: 15px 30px;
		  background: #fa9678;
		  border: none;
		  color: white;
		  font-family: 'SBAggroL';
		  font-weight: bold;
		  border-radius: 5px;
		  cursor: pointer;
		}
		
		.cancel_btn {
		  background: #232323;
		}
	</style>
	</head>
	<script type="text/javascript">
		$(document).ready(function(){
			var formObj = $("form[name='writeForm']");
			$(".write_btn").on("click", function(){
				if(fn_valiChk()){
					return false;
				}
				formObj.attr("action", "/board/write");
				formObj.attr("method", "post");
				formObj.submit();
			});
		})
		function fn_valiChk(){
			var regForm = $("form[name='writeForm'] .chk").length;
			for(var i = 0; i<regForm; i++){
				if($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null){
					alert($(".chk").eq(i).attr("title"));
					return true;
				}
			}
		}
	</script>
	
	<body>
	<%@ include file="/WEB-INF/views/index.jsp"%>
	
		<div id="root">
			<header>
				<h1 style="text-align:center; margin-right:600px; font-family: 'SBAggroL'"> 게시글 작성</h1>
			</header>
			
			
			<div class="container">
				<div class="board_page">
					<form name="writeForm" method="post" action="/board/write">
						<table id="tbl_boardInsert">
							<tr class="btitle">
								<td class="title"width="100">제목</td>
								<td><input type="text" id="title" name="title" class="chk" title="제목을 입력하세요" size="78"/></td>
							</tr>
							<tr>
								<td class="title" width="100">작성자</td>
								<td><input type="text" id="writer" name="writer" value="${member.userName}" size="78" readonly="readonly"/></td>
							</tr>
							<tr>
								<td class="title" width="100">내용</td>
								<td><textarea rows="10" cols="80" id="content" name="content" class="chk" title="내용을 입력하세요"></textarea></td>
							</tr>
						</table>
						<div style="text-align:center; margin-top:10px;">
							<input class="write_btn" type="submit" value="게시물 등록"> 
							<input class="cancel_btn" type="button" value="등록 취소" onClick="location.href='/board/list'">
						</div>
					</form>
				</div>
			</div>
			
		</div>
	</body>
</html>