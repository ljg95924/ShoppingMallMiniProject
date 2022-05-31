<%--
  Created by IntelliJ IDEA.
  User: seotaesu
  Date: 2022/05/29
  Time: 4:36 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../../includes/adminheader.jsp" %>

<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">Product Detail Page</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->


<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-info">
            <div class="panel-heading">
                등록상품 상세정보
            </div>
            <!-- /.panel-heading -->

            <div class="panel-body">
                <form action="/admin/product/modify" name="newProduct" method="post">
                    <div class="form-group">
                        <label for="productId">상품 번호</label>
                        <input class="form-control"
                               id="productId"
                               name="productId"
                               value='${product.productId}'
                               readonly="readonly">
                        <label for="productName">상품명</label>
                        <input class="form-control"
                               id="productName"
                               name="productName"
                               value='${product.productName}'>
                        <label for="productType">카테고리</label>
                        <input class="form-control"
                               id="productType"
                               name="productType"
                               value='${product.productType}'>
                        <label for="productPrice">상품 가격</label>
                        <input class="form-control"
                               id="productPrice"
                               name="productPrice"
                               value='${product.productPrice}'>
                        <label for="productStock">상품 수량</label>
                        <input class="form-control"
                               id="productStock"
                               name="productStock"
                               value='${product.productStock}'>
                        <lable for="productImg">이미지</lable>
                        <img src='/admin/product/display?fileName=${product.productImg}'>
                    </div>
                    <!-- /.form-group -->
                    <input type="submit" class="btn btn-primary" value="수정">

                </form>
                <!-- /form -->

            </div>
            <!-- /.panel-body -->

        </div>
        <!-- /.panel panel-info -->

    </div>
    <!-- /.col-lg-12 -->

</div>
<!-- /.row -->


<%@include file="../../includes/footer.jsp" %>