<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/getBasketList.css" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<h3 class="orderTitImg">
			<img src="https://cdn1.bio11.kr/data/skin/crex_new_1/images/order/orderCart_TitImg.jpg" alt="장바구니 단계 이미지">
		</h3>
			<form name="cart_form" id="cart_form" method="post" target="actionFrame" action="order">
				<input type="hidden" name="cart_version" value="2">
				<!-- 전체선택 및 선택삭제 ▽ -->
				<div class="cartSelBtn">
					<ul>
						<li>
							<div class="cartCheckbox">
								<input type="checkbox" name="allSelect" id="allSelect" class="btn_select_all" checked="checked"><label for="allSelect">전체선택</label>
							</div>
						</li>
						<li>
							<button type="button" class="btn_select_del">선택삭제</button>
						</li>
					</ul>
				</div>
				<!-- 전체선택 및 선택삭제 ▲ -->
	
				<!-- 상품 정보 및 가격 ▽ -->
				<div class="cartInfo">
					<table>
						<colgroup>
							<col style="width:65px">
							<col style="width:75px">
							<col style="width:410px">
							<col style="width:161px">
							<col>
							<col style="width:105px">
						</colgroup>
						<tbody><tr>
							<th>선택</th>
							<th></th>
							<th>상품명/옵션선택</th>
							<th>수량</th>
							<th>판매가격</th>
							<th>구매선택</th>
						</tr>
	<!-- 상품이 있을 경우 ▽ -->
	<c:forEach var="item" items="${basketInfo}">
	<tr>
		<td>
			<input type="checkbox" name="cart_option_seq[]" value="1272796" goods_seq="237" price="158000" delivery_cost="0" class="cartChkBox" checked="checked">
		</td>
		<td class="tdImg">
			<figure>
				<a href="../goods/view?no=237">
					<img src="https://cdn1.bio11.kr/data/goods/202205/31172731list2.png" style="width:100%;height:100%">
				</a>
			</figure>
		</td>
		<td class="tdTit">
			<p class="pTit">
				${item.productName}
			</p>
		</td>
		<td class="tdAmount">
			<div class="tdNum" id="cart_option_ea_1272796">${item.productQuantity}</div>
			<div><button type="button" class="btn_ea_modify" id="1272796">변경</button></div>
		</td>
		<td>
			<p class="pPrice cart_option_price_1272796">${item.productPrice}</p>
		</td>
		<td>
			<button type="button" value="1272796" class="btn_dirpurchase btn_one_buy">바로 구매</button>
			<button type="button" value="1272796" goods_seq="237" class="btn_one_del btn_dirDelete">삭제</button>
		</td>
	</tr>
	</c:forEach>
	<!-- 상품이 있을 경우 ▲ -->
	</tbody></table>
					<!-- 총 상품금액, 할인금액, 배송비 ▽ -->
					<div class="cartTotal">
						<ul>
							<li class="w345">
								<p class="titP">총 상품금액</p>
								<p class="priceP"><span class="total_goods_price"></span><span> 
								<fmt:formatNumber value="${totalPrice}" pattern="###,###,###"/> 원
								</span></p>
							</li>
						</ul>
					</div>
					<!-- 총 상품금액, 할인금액, 배송비 ▲ -->
	
			</div>
				<!-- 상품 정보 및 가격 ▲ -->
	
				<!-- 버튼 ▽ -->
				<div class="cartBtn">
					<button type="button" class="btn_selOrder btn_selected_order" onclick="gtag('event', '버튼클릭', {'event_category' : '주문하기', 'event_label' : '장바구니'});">선택 주문</button>
					<button type="button" class="btn_totOrder btn_all_order" onclick="gtag('event', '버튼클릭', {'event_category' : '주문하기', 'event_label' : '장바구니'});">전체 주문</button>
				</div>
				<!-- 버튼 ▲ -->
			</form>
	</div>
	
	<script>
		$(document).ready(function(){
			
		});
		
		$(".btn_select_all").on("change",function(){
			set
		})
		$(".all_check_input").on("click", function(){

		/* 체크박스 체크/해제 */
		if($(".all_check_input").prop("checked")){
			$(".all_check_input").attr("checked", true);
		} else{
			$(".all_check_input").attr("checked", false);
		}
		
	});
	</script>
</body>
</html>