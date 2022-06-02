<%--
  Created by IntelliJ IDEA.
  User: BIT
  Date: 2022-05-31
  Time: 오전 11:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
    <title>구매 완료 페이지</title>
    <style>
        p { font-size: 25px; color: black }
    </style>
</head>
<body>
<%@include file="../includes/memberheader.jsp"%>
    <div id="container">
        <h1>주문 완료!</h1>
    </div>
    <table width="100%" >
        <thead>
            <tr>
                <th class="center">주문 번호</th>
                <th>주문자명</th>
                <th>주문 일자</th>
            </tr>
        </thead>
            <tr>
                <td><p>${order.orderId}</p></td>
                <td><p>${order.orderName}</p></td>
                 <td>
                     <p><fmt:formatDate pattern="yyyy-MM-dd" value="${order.orderTime}" /></p>
                 </td>
             </tr>
    </table>
<br><br><br>
<table width="100%">
    <colgroup>
        <col style="width: 100px">
        <col style="width: 100px; ">
        <col style="width: 100px; ">
    </colgroup>
    <thead>
    <tr>
        <th> 주문 상품</th>
        <th> 주문 수량</th>
        <th> 주문 가격</th>
    </tr>
    <hr>
    </thead>
    <c:forEach var="item" items="${orderList}">
        <tr>
            <th>${item.orderProductName}</th>
            <th>${item.orderProductQuantity}</th>
            <th>${item.orderProductPrice}</th>
        </tr>
    </c:forEach>
</table>
<br><br><br><hr>
    <p class="titP">총 상품금액</p>
    <p class="priceP"><span class="total_price">
                                    <fmt:formatNumber value="${totalPrice}" pattern="###,###,###"/></span>
        원
    </p>
    <a href="/product/list?productType=all"> 메인으로 돌아가기 </a>
<%@include file="../includes/memberfooter.jsp"%>
</body>
</html>
