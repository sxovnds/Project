<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style>
		.admin_container {
			margin-top: -155px;
		    margin-left: 220px; /* 사이드바 너비와 여백만큼 오른쪽으로 옮김 */
		}
		.table.table-hover tr th {
		    background-color: #CCCCCC;
		  }
	</style>
</head>
<body>
<%@ include file="/WEB-INF/views/admin/main.jsp"%>
	<div class="container admin_container">
		<div class="row">
			<h1 style="text-align: center; margin: 50px 0;">회원 리스트</h1>
			<table class="table table-hover">
				<thead>
					<tr>
						<th>회원ID</th>
						<th>이름</th>
						<th>Email</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="vo">
						<tr>
							<td>${vo.userId}</td>
							<td>${vo.userName}</td>
							<td>${vo.userEmail}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>

</body>
</html>