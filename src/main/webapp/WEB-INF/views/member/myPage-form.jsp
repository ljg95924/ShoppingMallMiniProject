<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@include file="../includes/memberheader.jsp"%>


    <div class="container">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">My page</h3>
                    </div>
                    <div class="panel-body">

                            <fieldset>
                                <div class="form-group">
                                    ${memberDto.userName} 님 안녕하세요.
                                </div>
                                <!-- Change this to a button or input when using this as a form -->
                                <a href="${path}/member/update" class="btn btn-lg btn-info btn-block">Update Member</a>
                                <a href="${path}/member/delete" class="btn btn-lg btn-warning btn-block">Leave Member</a>
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
 

	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModallabel" aria-hidden="true">
		<div class="modal-dialog">
		    <div class="modal-content">
		        <div class="modal-header">
		             <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		             <h4 class="modal-title" id="myModalLabel">Modal title</h4>
		        </div>
		        <div class="modal-body">처리가 완료되었습니다.</div>
		        <div class="modal-footer">
		             <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		             <button type="button" class="btn btn-default" >Save Changes</button>
				</div>
	      	</div><!-- /.moadl-content -->
 			</div><!-- /.modal-dialog -->
	</div> <!-- /.modal fade    -->


<script>
	$(document).ready(() => {
		let result = '<c:out value="${result}"/>';
		//모달 보여주기 추가
		const checkModal = (result) => {
			if(result===""){
				return;
			}else {
				$(".modal-body").html(result);
			}
			$("#myModal").modal("show");
		}
		checkModal(result);
	});
</script>


<%@include file="../includes/memberfooter.jsp"%>