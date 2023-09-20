<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Top</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="icon" href="data:;base64,iVBORw0KGgo=">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<script src="/resources/js/upload.js" type="text/javascript"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
</head>
<body>
<%@ include file="/WEB-INF/views/index.jsp"%>
	<div class="container">
		<form action="/order/cartorderResult" method="post">
		<c:set value="2500" var="del_fee"/>
		<div class="row qnas" style="text-align: center;">
			<h1 class="page-header">주문하기</h1>
			<table class="table table-hover" style="width: 70%; margin: auto; border-bottom: 1px solid #D5D5D5;">
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
			    <c:forEach items="${selectedProducts}" var="vo">
			        <tr>
			            <td>
			                <img alt="thumbnail" src="/resources/upload${vo.filename}" width="40%">
			                <input type="hidden" value="${vo.productId}" name="selectedItems">
			            </td>
			            <td>${vo.productName}</td>
			            <td>
				            <span class="productPrice" data-price="${vo.price}">
							    <c:out value="${vo.price}"/>원 <br>
							</span>
			                <label class="totalPrice"></label>&nbsp;<br>
			            </td>
			            <td>
			                <select name="order_Qty" class="form-control order_Qty">
			                    <c:forEach begin="1" end="${vo.stock > 5 ? 5 : vo.stock}" var="stock">
			                        <option value="${stock}">${stock}</option>
			                    </c:forEach>
			                </select>
			            </td>
			            <td>
			                <c:choose>
			                    <c:when test="${vo.productDist == 'outer'}">
			                        <div class="form-horizontal" style="text-align: left;">
			                            <select class="form-control" name="selected_Opt">
			                                <option value="S">S</option>
			                                <option value="M">M</option>
			                                <option value="L">L</option>
			                            </select>
			                        </div>
			                    </c:when>
			                    <c:otherwise>
			                        <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
			                    </c:otherwise>
			                </c:choose>
			            </td>
			            <td>
			                <button class="btn btn-default confirm">확인</button>
			            </td>
			        </tr>
			    </c:forEach>
			</tbody>
			</table>
		</div>
		
		<div class="row" style="text-align: center; margin: 80px 0;">
		<c:set value="${memberInfo}" var="vo"/>
			<h1 class="page-header">주문정보 확인</h1>
			<h4 style="color: red;">배송지는 직접 입력해야 합니다.</h4>
		</div>
		<div class="row">
			<div class="form-horizontal">
				<div class="form-group">
					<label for="inputId" class="col-sm-2 control-label">ID</label>
					<div class="col-sm-10">
						<input class="form-control" id="inputId" placeholder="ID" name="userid" value="${vo.userId}" readonly>
					</div>
				</div>
				
				<div class="form-group">
					<label for="inputName" class="col-sm-2 control-label">Name</label>
					<div class="col-sm-10">
						<input class="form-control" id="inputName" placeholder="Name" name="username" value="${vo.userName}">
					</div>
				</div>				
				<div class="form-group">
					<label for="inputAdd" class="col-sm-2 control-label">Address</label>
					<div class="col-sm-10">
						<input type="text" id="postcode" name="postcode">&nbsp;
						<input type="button" class="btn btn-default btn-sm" id="searchAdd" value="우편번호 찾기"><br>
						<input class="form-control" type="text" id="roadAddress" name="useraddress">
						<input class="form-control" type="text" id="detailAddress" name="detailAddress" placeholder="상세주소">
					</div>
				</div>				
				<div class="form-group">
					<label for="inputEmail" class="col-sm-2 control-label">Email</label>
					<div class="col-sm-10">
						<input type="email" class="form-control" id="inputEmail" placeholder="Email" name="email" value="${vo.userEmail}">
					</div>
				</div>
				<div class="form-group">
					<label for="inputTel" class="col-sm-2 control-label">Tel</label>
					<div class="col-sm-10">
						<input type="tel" class="form-control" id="inputTel" placeholder="Tel" name="tel">
					</div>
				</div>
				<div class="form-group">
					<label for="inputTel" class="col-sm-2 control-label">배송 메세지</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="deliver_msg" placeholder="배송 메세지" name="deliver_msg">
					</div>
				</div>				
			</div>
		</div><!-- class=row -->
		
		<div class="row" style="text-align: center; margin: 80px 0;">
			<h1 class="page-header">결제수단 확인</h1>
			<div style="text-align: center;">
				<input type="radio" name="cal_info" value="transfer"><label style="margin-right: 50px;">&nbsp;계좌이체</label>
				<input type="radio" name="cal_info" value="no_bankingBook"><label style="margin-right: 50px;">&nbsp;무통장 입금</label>
				<input type="radio" name="cal_info" value="tel_billing"><label style="margin-right: 50px;">&nbsp;핸드폰 결제</label>
				<input type="radio" name="cal_info" value="card"><label>&nbsp;카드 결제</label>
			</div>
			<hr>
			<div class="row" style="text-align: center; margin: 50px 0;">
				<label>상품가격 :&nbsp; <span id="price"></span>&nbsp;원</label>
				<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
				<label>배송비 :&nbsp;<span id="del_fee"></span>&nbsp;원
				</label>
				<span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span>
				<label style="font-size: 1.5em;">총 결제금액 : <span id="totalprice"></span>&nbsp;원
				<input type="hidden" id="amount" name="totalAmount">
				</label>
			</div>
			<div>
				<button class="btn btn-default cal-btn" type="submit">결제하기</button>
				<button class="btn btn-default back_btn">돌아가기</button>
			</div>
		</div>
		</form>
	</div>
<script type="text/javascript">
	
	$(document).ready(function() {
		
		var userId = $("#member_userId").val();
		var productId = $("#productId").val();
		
		$(".confirm").click(function(event) {
		    event.preventDefault();

		    // 클릭한 확인 버튼에 가장 가까운 tr 요소를 선택
		    var $tr = $(this).closest('tr');

		    // tr 요소에서 해당 상품의 price 값을 가져오기
		    var price = parseFloat($tr.find('.productPrice').data('price')); // data-price 값을 읽어옵니다.

		    // 수량을 가져오기
		    var qty = parseInt($tr.find("select[name='order_Qty']").val());

		    // 상품별 총 가격 계산
		    var totalPrice = price * qty;

		    // 상품별로 가격 표시를 변경 (class를 이용하여 모든 totalPrice 클래스를 가진 요소 선택)
		    $tr.find(".totalPrice").html(totalPrice + '원');

		    // 여기에 총 가격과 포인트 계산 등을 추가할 수 있습니다.

		    // 총 상품 가격 다시 계산
		    updateTotalPrice();
		});

		// 총 상품 가격 계산 함수
		function updateTotalPrice() {
		    var totalAmount = 0;

		    // 모든 .totalPrice 요소를 선택하고 각각의 가격을 합산
		    $(".totalPrice").each(function() {
		        var priceStr = $(this).text().replace("원", ""); // '원' 문자열 제거
		        var price = parseFloat(priceStr);
		        totalAmount += price;
		    });

		    // 배송비 계산
		    var del_fee = parseFloat("<c:out value='${del_fee}'/>");

		    // 총 결제금액 계산
		    var amount = totalAmount;
		    
		    if (amount < 30000) {	
				totalPrice = Number(amount) + Number(del_fee);
				 $("#price").html(amount);
				 $("#del_fee").html(del_fee);
				 $("#totalprice").html(totalPrice);
				 $("#amount").val(amount);
			} else {
				totalPrice = amount;
				$("#price").html(amount);
			    $("#del_fee").html(0);
			    $("#totalprice").html(totalPrice);
			    $("#amount").val(amount);
			}
		}

		// 페이지 로드 시 초기 총 가격 계산
		updateTotalPrice();
		
		// 결제수단 선택 시 총 가격 업데이트
		$("input[name='cal_info']").click(function() {
		    updateTotalPrice();
		});
		
		$(".back_btn").click(function(event) {
			event.preventDefault();
			location.assign("/order/mycart/" + userId);
		});

		$("#mycart_btn").click(function(event) {
			event.preventDefault();
			location.assign("/order/mycart/" + userid);
			
		});
		
		$("#searchAdd").click(function(event) {
			event.preventDefault();
			postcode();

		});
		
		
	    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
	    function postcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var roadAddr = data.roadAddress; // 도로명 주소 변수
	                var extraRoadAddr = ''; // 참고 항목 변수

	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraRoadAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraRoadAddr !== ''){
	                    extraRoadAddr = ' (' + extraRoadAddr + ')';
	                }

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('postcode').value = data.zonecode;
	                document.getElementById("roadAddress").value = roadAddr;
	                
	            }

	        }).open();
	    }
	
	});
	
</script>

</body>
</html>