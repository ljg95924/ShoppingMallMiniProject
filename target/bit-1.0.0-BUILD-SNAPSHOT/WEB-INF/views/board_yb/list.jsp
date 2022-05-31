<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/adminheader.jsp"%>

<script type="text/javascript">
	$(document).ready(
			function() {
				var result = '<c:out value="${result}"/>';
				checkModal(result);
				function checkModal(result) {
					if (result === '') {
						return;
					}
					if (parseInt(result) > 0) {
						$('.modal-body').html(
								'게시글' + parseInt(result) + '번이 등록되었습니다.');
					}
					$('#myModal').modal('show');
				}

				$('#regBtn').on('click', function() {
					self.location = '/board/register';
				}); // 버튼 클릭시 등록창으로 이동
				
				
				var searchForm = $("#searchForm");
				$("#searchForm button").on("click", function (e) {
					if (!searchForm.find("option:selected").val()) {
						alert("검색종류를 선택하세요");
						return false;
					}
					
					if (!searchForm.find("input[name='keyword']").val()) {
						alert("키워드를 입력하세요");
						return false;
					}
					e.preventDefault();
					searchForm.submit();
				});
			}
			
			


	);
</script>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">List Page</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				게시글 목록
				<button id='regBtn' type="button" class="btn btn-xs pull-right btn-success">글쓰기</button>
			</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
					<thead>
						<tr>
							<th>#번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>수정</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="item" items="${list}">
							<tr class="odd gradeX">
								<td>${item.bno}</td>
								<td>
									<a href="/board/get?bno=${item.bno}">${item.title}</a>
								</td>
								<td>${item.writer}</td>
								<td class="center">
									<fmt:formatDate pattern="yyyy/MM/dd" value="${item.regDate}" />
								</td>
								<td class="center">
									<fmt:formatDate pattern="yyyy/MM/dd" value="${item.updateDate}" />
								</td>

							</tr>
						</c:forEach>

					</tbody>
				</table>

				<c:set var="searchCount" value="${searchCount}" />
				<c:if test="${searchCount > 0 and criteria.keyword ne null}">
					<c:out value="${searchCount}" /> 개의 결과가 검색됨
				</c:if>
				<!-- 검색창 추가 -->
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm" action="/board/list" method="get">
							<select class="form-group" name="type">
								<option value="" <c:out value="${criteria.type==null?'selected':''}"/>>--</option>
								<option value="T" <c:out value="${criteria.type=='T'?'selected':''}"/>>제목</option>
								<option value="C" <c:out value="${criteria.type=='C'?'selected':''}"/>>내용</option>
								<option value="W" <c:out value="${criteria.type=='W'?'selected':''}"/>>작성자</option>
								<option value="TC" <c:out value="${criteria.type=='TC'?'selected':''}"/>>제목 or 내용</option>
								<option value="TW" <c:out value="${criteria.type=='TW'?'selected':''}"/>>제목 or 작성자</option>
								<option value="TCW" <c:out value="${criteria.type=='TCW'?'selected':''}"/>>제목 or 내용 or 작성자</option>
							</select>
							<input type="text" class="form-control" name="keyword" value='<c:out value="${criteria.keyword}"/>'><span class="input-group-btn"><button class="btn btn-info" type="button">Search</button></span>
						</form>
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
								<button type="button" class="btn btn-default">Save Changes</button>
							</div>
						</div>
					</div>
				</div>
				<!-- /.modal fade -->


				<!-- /.table-responsive -->

			</div>
			<!-- /.table-responsive -->
		</div>
		<!-- /.panel-body -->
	</div>
	<!-- /.panel -->
</div>
<!-- /.col-lg-6 -->
</div>
<!-- /.row -->
<%@include file="../includes/footer.jsp"%>
