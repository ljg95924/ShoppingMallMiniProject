<%--
  Created by IntelliJ IDEA.
  User: seotaesu
  Date: 2022/05/28
  Time: 3:04 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../../includes/adminheader.jsp" %>


<script type="text/javascript" defer>

    $(document).ready(function () {

        const formObj = $('form');
        $('button').on('click', function (e) {

            e.preventDefault();

            const operation = $(this).data('oper');

            // Remove 버튼 클릭 시
            if (operation === 'remove') {
                formObj.attr('action', '/admin/member/remove');
                // List 버튼 클릭 시
            } else if (operation === 'list') {
                self.location = '/admin/member/list';
                return;
            } else if (operation === 'modify') {
                formObj.attr('action', '/admin/member/modify');
            }

            formObj.submit();

        });

    });

</script>


<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">User Detail Page</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->


<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-info">
            <div class="panel-heading">
                회원 상세정보
            </div>
            <!-- /.panel-heading -->

            <div class="panel-body">
                <form role="form" action="#" method="post">
                    <div class="form-group">
                        <label for="userId">아이디</label>
                        <input class="form-control"
                               id="userId"
                               name="userId"
                               value='${member.userId}'
                               readonly="readonly">
                        <label for="userName">이름</label>
                        <input class="form-control"
                               id="userName"
                               name="userName"
                               value='${member.userName}'>
                        <label for="userGender">성별</label>
                        <input class="form-control"
                               id="userGender"
                               name="userGender"
                               value='${member.userGender}'
                               readonly="readonly">
                        <label for="userAddress">주소</label>
                        <input class="form-control"
                               id="userAddress"
                               name="userAddress"
                               value='${member.userAddress}'>
                        <label for="userBirth">생일</label>
                        <input class="form-control"
                               id="userBirth"
                               name="userBirth"
                               value='${member.userBirth}'
                               readonly="readonly">
                        <label for="userEmail">E-Mail</label>
                        <input class="form-control"
                               id="userEmail"
                               name="userEmail"
                               value='${member.userEmail}'>
                        <label for="userPhone">핸드폰 번호</label>
                        <input class="form-control"
                               id="userPhone"
                               name="userPhone"
                               value='${member.userPhone}'>
                        <label for="userRegdate">가입일</label>
                        <input class="form-control"
                               id="userRegdate"
                               name="userRegdate"
                               value='<fmt:formatDate pattern="yyyy/MM/dd" value="${member.userRegdate}"/>'
                               readonly="readonly">
                    </div>
                    <!-- /.form-group -->

                    <button type="submit" data-oper='modify' class="btn btn-info">Modify</button>
                    <button type="submit" data-oper='remove' class="btn btn-danger">Remove</button>
                    <button type="submit" data-oper='list' class="btn btn-success">List</button>

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