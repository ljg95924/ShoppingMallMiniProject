<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product Detail</title>
    <!-- <link rel="stylesheet" href="css/productDetail.css"> -->
<%@include file="../includes/memberheader.jsp"%>
    <style>
        html, button, body, div, span, applet, object, iframe, h1, h2, h3, h4, h5, h6, p, blockquote, pre, a, abbr, acronym, address, big, cite, code, del, dfn, em, ins, kbd, q, s, samp, small, strike, strong, sub, sup, tt, var, b, u, i, center, dl, dt, dd, ol, ul, li, fieldset, form, label, legend, table, caption, tbody, tfoot, thead, tr, th, td, article, aside, canvas, details, embed, figure, figcaption, footer, header, hgroup, menu, nav, output, ruby, section, summary, time, mark, audio, video {
            margin: 0;
            padding: 0;
            border: 0;
            font-size: 100%;
            /* font: inherit; */
            vertical-align: baseline;
            letter-spacing: -0.5px;
        }


        .pageNew_rightArea {
            position: absolute;
            left: 700px;
            top: 120px;
            float: left;
            font-size: 30px;
        }

        .pageNew_goodsBtn03 {
            border-radius: 3px 0 0 3px;
            cursor: pointer;
            float: left;
            margin-bottom: 15px;
            text-align: center;
            height: 65px;
            line-height: 65px;
            box-sizing: border-box;
            background: #fff;
            border: 1px solid #0086a8;
            color: #0091b6;
            font-size: 20px;
            font-weight: bold;
            display: inline-block;
        }

        .pageNew_goodsBtn02 {
            border-radius: 0 3px 3px 0;
            cursor: pointer;
            float: left;
            margin-bottom: 15px;
            text-align: center;
            height: 65px;
            line-height: 65px;
            box-sizing: border-box;
            background: #00a0c9;
            border: 1px solid #00a0c9;
            color: #fff;
            font-size: 20px;
            font-weight: bold;
            display: inline-block;
        }

        .w180 {
            width: 180px;
        }

        div {
            display: block;
        }

        /* 수량 버튼  */
        .button {
            padding: 2% 0 2% 3%;
        }

        .button_quantity {
            margin-bottom: 2%;

        }

        .button_quantity input {
            height: 26px;
            width: 40px;
            text-align: center;
            font-weight: bold;
        }

        .button_quantity button {
            border: 1px solid #aaa;
            color: #3a60df;
            width: 20px;
            height: 20px;
            padding: 3px;
            background-color: #fff;
            font-weight: bold;
            font-size: 15px;
            line-height: 15px;
        }

    </style>
</head>
<body>
<div class="pageNew_detail">
    <div class="pageNew_leftArea">
        <div class="pageNew_thum">
            <div class="mainImage">
                <img src="/product/display?fileName=${product.productImg}" alt="이미지"/>
            </div>
        </div>
    </div>

    <div class="pageNew_rightArea">
        <%--			<form name="goodsForm" method="post" action="">--%>
        <h3 class="pageNew_goodsTit">${product.productName}</h3>
        <hr>
        <div class="pageNew_goodsPrice">
            <div class="goodsPrice_div">
                <%-- 						<ul class="pay_info">
                                            <li class="pay_tit">판매금액: </li>
                                            <li class="pay_sum">
                                                <fmt:formatNumber value="${product.product_price}" pattern="###,###,###"/>
                                                <span class="pay_sumSpan">원</span>
                                            </li>
                                        </ul> --%>
                <div class="price">
                    판매 금액:
                    <fmt:formatNumber value="${product.productPrice}" pattern="###,###,###"/>
                    원
                    <hr>
                </div>
            </div>
        </div>
        <div class="button">
            <div class="button_quantity">
                주문수량
                <input type="text" class="quantity_input" value="1">
                <span>
							<button type="button" class="plus_btn">+</button>
							<button type="button" class="minus_btn">-</button>
						</span>
            </div>
        </div>
        <div class="pageNew_btn">
            <div class="pageNew_goodsBtn03 w180" id="addCart">
                <a class="btn_cart">
                    장바구니
                </a>
            </div>
            <div class="pageNew_goodsBtn02 w180" id="buy">
                <a class="btn_buy">
                    바로구매
                </a>
            </div>
        </div>
        <%--			</form>--%>

    </div>
</div>

<div class="goods_description" style="margin-top:300px">
    <div class="goods_detail">
        <div class="imgPR" align="center">
            <img src="https://bio11.speedgabia.com/desimone/product/emall/official/detail/DE_top_p.jpg" border="0" style="position:absolute">
            <img src="https://bio11.speedgabia.com/desimone/product/emall/official/detail/DR_P.jpg" border="0">
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        let quantity = $(".quantity_input").val();
        $(".plus_btn").on("click", function () {
            $(".quantity_input").val(++quantity);
        });
        $(".minus_btn").on("click", function () {
            if (quantity > 1) {
                $(".quantity_input").val(--quantity);
            }
        });
        // 서버로 보낼 데이터
        const form = {
            userId: '${memberDto.userId}',
            productId: '${product.productId}',
            productQuantity: ''
        }

        // 장바구니 추가 버튼
        $(".btn_cart").on("click", function (e) {
            e.preventDefault();
            form.productQuantity = $(".quantity_input").val();
            form.productId = ${product.productId};
            $.ajax({
                url: '../basket/addBasket',
                type: 'POST',
                data: form,
                success: function (result) {
                    cartAlert(result);

                }
            });
        });

        function cartAlert(result) {
            if (result === '0') {
                alert("장바구니에 추가를 하지 못하였습니다.");
            } else if (result === '1') {
                alert("장바구니에 추가되었습니다.");
            } else if (result === '2') {
                alert("장바구니에 이미 추가되어져 있습니다.");
            } else if (result === '5') {
                alert("로그인이 필요합니다.");
            }
        }

        // 결제버튼 클릭시
        $(".btn_buy").on("click", function () {
            let quantity = $(".quantity_input").val();
            if("${memberDto.userId}" === "") {
                alert("로그인 후에 이용해주세요.");
            } else if ('${product.productStock}' < quantity) {
                alert("주문수량에 비해 해당 상품 재고가 부족합니다.");
            } else {
                form.productQuantity = quantity
                form.productId = ${product.productId};

				console.log(typeof form);

                $.ajax({
                    url: '/order/orderOne',
                    type: 'POST',
                    data: form,
                    dataType: 'text',
                    success: function (orderId) {
                        console.log(orderId);
                        alert(orderId);
                        location.href = '/order/orderResult?orderId=' + orderId;
                    }
                });
            }
        });


        // // 파일 업로드
        // // ajax file upload logic START
        // $.ajax({
        // 	url: "/uploadAjaxAction",
        // 	processData: false, // 전달할 데이터 query string 을 만들지 말 것
        // 	contentType: false,
        // 	data: formData,     // 전달할 데이터
        // 	type: "POST",
        // 	dataType: 'json',   // 받을 데이터 형식
        // 	success: function (result) {
        // 		console.log(result);
        // 		showUploadedFile(result);
        // 		$(".uploadDiv").html(cloneObj.html());
        // 	},
        // }); // $.ajax END


    });
</script>
    <%@include file="../includes/memberfooter.jsp"%>
</body>
</html>