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


    });
</script>




<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">User List Page</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->



<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                회원 목록
            </div>
            <!-- /.panel-heading -->

            <div class="panel-body">
                <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
                    <thead>
                    <tr>
                        <th>회원 아이디</th>
                        <th>이름</th>
                        <th>성별</th>
                        <th>이메일</th>
                        <th>전화번호</th>
                        <th>가입일자</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="item" items="${list}">
                        <tr class="odd gradeX">
                            <td><a href="/admin/member/modify?userId=${item.userId}">${item.userId}</a></td>
                            <td>${item.userName}</td>
                            <td>${item.userGender}</td>
                            <td>${item.userEmail}</td>
                            <td>${item.userPhone}</td>
                            <td class="center">
                                <fmt:formatDate pattern="yyyy/MM/dd" value="${item.userRegdate}" />
                            </td>
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