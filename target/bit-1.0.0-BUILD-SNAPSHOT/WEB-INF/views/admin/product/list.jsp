<%--
  Created by IntelliJ IDEA.
  User: seotaesu
  Date: 2022/05/28
  Time: 10:06 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../includes/adminheader.jsp"%>

<script type="text/javascript">
    $(document).ready(function () {
        const status = '<c:out value="${status}"/>';

        checkModal(status);

        function checkModal(status) {
            if (status === '') {
                return;
            }
            $('.modal-body').html(status);
            $('#myModal').modal('show');
        }

        $('#regBtn').on('click', function() {
            self.location = '/admin/product/register';
        }); // 버튼 클릭시 등록창으로 이동


    });
</script>




<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">Product List Page</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->



<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                상품 목록
                <button id='regBtn' type="button" class="btn btn-xs pull-right btn-success">상품등록</button>
            </div>

            <!-- /.panel-heading -->

            <div class="panel-body">
                <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
                    <thead>
                    <tr>
                        <th>상품 번호</th>
                        <th>이미지</th>
                        <th>카테고리</th>
                        <th>상품명</th>
                        <th>가격</th>
                        <th>재고량</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="item" items="${list}">
                        <tr class="odd gradeX">
                            <td><a href="/admin/product/detail?productId=${item.productId}">${item.productId}</a></td>
                            <td><img src='/admin/product/display?fileName=s_${item.productImg}'></td>
                            <td>${item.productType}</td>
                            <td>${item.productName}</td>
                            <td>${item.productPrice}</td>
                            <td>${item.productStock}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>


                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModallabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                <h4 class="modal-title" id="myModalLabel">알림</h4>
                            </div>
                            <div class="modal-body">처리가 완료되었습니다.</div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
<%--                                <button type="button" class="btn btn-default">Save Changes</button>--%>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.modal fade -->


            </div>
            <!-- /.panel-body -->

        </div>
        <!-- /.panel panel-default -->

    </div>
    <!-- /.col-lg-12 -->

</div>
<!-- /.row -->



<%@include file="../../includes/footer.jsp"%>