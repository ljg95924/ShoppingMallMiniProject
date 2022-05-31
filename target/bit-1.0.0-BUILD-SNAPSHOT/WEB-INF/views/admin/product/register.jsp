<%--
  Created by IntelliJ IDEA.
  User: seotaesu
  Date: 2022/05/29
  Time: 12:54 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../../includes/adminheader.jsp" %>


<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">Product Register Page</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->


<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-info">
            <div class="panel-heading">
                등록상품 정보
            </div>
            <!-- /.panel-heading -->

            <div class="panel-body">
                <form action="/admin/product/register" name="newProduct" method="post" enctype="multipart/form-data">
                    <div class="form-group">

                        <label for="productName">상품명</label>
                        <input class="form-control"
                               id="productName"
                               name="productName">
                        <label for="productType">카테고리</label>
                        <input class="form-control"
                               id="productType"
                               name="productType">
                        <label for="productPrice">상품 가격</label>
                        <input class="form-control"
                               id="productPrice"
                               name="productPrice">
                        <label for="productStock">상품 수량</label>
                        <input class="form-control"
                               id="productStock"
                               name="productStock">
                        <lable for="productImg">이미지</lable>
                        <input class="form-control"
                               id="productImg"
                               name="file"
                               type="file">
                    </div>
                    <!-- /.form-group -->
                    <input type="submit" class="btn btn-primary" value="등록">

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