<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<body>
<%--<%@include file="../includes/memberheader.jsp"%>--%>
	<div>
		<h3 class="orderTitImg">
			<img src="https://cdn1.bio11.kr/data/skin/crex_new_1/images/order/orderCart_TitImg.jpg" alt="장바구니 단계 이미지">
		</h3>
			<%--<form name="cart_form" id="cart_form" method="post" target="actionFrame" action="order">--%>
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
							<col style="width:75px">
							<col style="width:410px">
							<col style="width:161px">
							<col style="width:131px">
							<col style="width:105px">
						</colgroup>
							<tbody>
							<tr>
								<th></th>
								<th>상품명/옵션선택</th>
								<th>수량</th>
								<th>판매가격</th>
								<th>구매선택</th>
							</tr>
	<!-- 상품이 있을 경우 ▽ -->
							<form action="/order/orderBasket" method="post">

								<c:forEach var="item" items="${basketInfo}" varStatus="status">
									<tr class="cart_info_tr">
										<input type="hidden" class="individual_productId_input" name="list[${status.index}].productId" value="${item.productId}">
										<%--<input type="hidden" class="individual_productId_input" name="list[${status.index}].cartId" value="${item.cartId}">--%>
										<td class="tdImg">
											<figure>
												<a href="/product/productDetail?productId=${item.productId}">
													<img src="/product/display?fileName=${item.productImg}" alt="이미지" style="width:100%; height:100%; " >
												</a>
											</figure>
										</td>
										<td class="tdPName">
											<p class="pName">
												<input type="hidden" class="individual_productName_input" name="list[${status.index}].productName" value="${item.productName}">
													${item.productName}
											</p>
										</td>
										<td class="tdPQuantity">
											<div class="pQuantity">
												<input type="hidden" class="individual_productQuantity_input" name="list[${status.index}].productQuantity" value="${item.productQuantity}">
													${item.productQuantity}
											</div>
										</td>
										<td>
											<p class="pPrice">
												<input type="hidden" class="individual_productPrice_input" name="list[${status.index}].productPrice" value="${item.productPrice}">
													${item.productPrice}
											</p>
										</td>
										<td>
											<button type="button" class="btn_one_buy">바로 구매</button>
											<button type="button" class="delete_btn" data-cartid="${item.cartId}">삭제</button>
										</td>
									</tr>
								</c:forEach>
								<input type="submit" value="주문">
							</form>
							<!-- 상품이 있을 경우 ▲ -->
						</tbody>
					</table>
					<!-- 총 상품금액 ▽ -->
					<div class="cartTotal">
						<ul>
							<li class="w345">
								<p class="titP">총 상품금액</p>
								<p class="priceP"><span class="total_price">
								<fmt:formatNumber value="${totalPrice}" pattern="###,###,###"/></span>
									원
								</p>
							</li>
						</ul>
					</div>
				</div>	<!-- 총 상품금액 ▲ -->\
				<!-- 상품 정보 및 가격 ▲ -->


			<%--	<div class="content_btn_section">
					<a class="order_btn">주문하기</a>
				</div>--%>
				<!-- 버튼 ▽ -->
	<%--		<form action="/orderBasket/${member.memberId}" method="get" class="order_form">
				<div class="cartBtn">
					<button type="button" class="btn_selOrder">선택 주문</button>
					<button type="button" class="btn_totalOrder">전체 주문</button>
				</div>
			</form>--%>
				<!-- 버튼 ▲ -->
			<%--</form>--%>

			<!-- 삭제 form -->
			<form action="/basket/delete" method="post" class="quantity_delete_form">
				<input type="hidden" name="cartId" class="delete_cartId">
			</form>

			<!-- 주문 form -->

			<form action="/order/orderPage/${userId}" method="get" class="order_form">
				<input type="hidden" name="basket" value="${basketInfo}">
			</form>


	</div>

	<script>
		$(document).ready(function(){

		});
		$(".btn_totalOrder").on("click", function(){
			let form_contents = '';
			let orderNumber = 0;
			$(".cart_info_tr").each(function(index, element){
				let total_price = $(element).find(".total_price").val();
			});
		});

		/* 장바구니 삭제 버튼 */
		$(".delete_btn").on("click", function(e){
			alert("삭제가 완료되었습니다.");
			e.preventDefault();
			const cartId = $(this).data("cartid");
			$(".delete_cartId").val(cartId);
			$(".quantity_delete_form").submit();
		});

		/* 바로구매 버튼 */
		$(".btn_buy").on("click", function(){
			let bookCount = $(".quantity_input").val();
			$(".order_form").find("input[name='orders[0].bookCount']").val(bookCount);
			$(".order_form").submit();
		});
		/* 주문 페이지 이동 */
		$(".order_btn").on("click", function(){

			/*let form_contents ='';
			let orderNumber = 0;

			$(".cart_info_td").each(function(index, element){
					let productId = $(element).find(".individual_productId_input").val();
					let productQuantity = $(element).find(".individual_productQuantity_input").val();

					let productId_input = "<input name='orders[" + orderNumber + "].productId' type='hidden' value='" + productId + "'>";
					form_contents += productId_input;

					let productQuantity_input = "<input name='orders[" + orderNumber + "].productQuantity' type='hidden' value='" + productQuantity + "'>";
					form_contents += productQuantity_input;

					orderNumber += 1;
			});*/



			$(".order_form").html(form_contents);
			$(".order_form").submit();

		});
	</script>
		<%@include file="../includes/memberfooter.jsp"%>
</body>
</html>