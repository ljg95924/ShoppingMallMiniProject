<%--
  Created by IntelliJ IDEA.
  User: BIT
  Date: 2022-05-31
  Time: 오전 11:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
    <title>구매 완료 페이지</title>
    <style>
        p { font-size: 25px; color: black }
        div, th, tr { text-align: center; font-size: 20px; }
        a {
            position: absolute;
            right: 200px;
            font-size: 30px;
        }
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
    <a href="/product/list"> 메인으로 돌아가기 </a>
<%@include file="../includes/memberfooter.jsp"%>
</body>
</html>
