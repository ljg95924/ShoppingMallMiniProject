<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style>
	ul li 
	{
		list-style-type: none;
		float: left;
	}
</style>
<%@include file="../includes/memberheader.jsp"%>
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
	                <%-- <a href="/basket/getBasketList/${member.user_id}"> --%>
	                <%-- 로그인 부분 합치면 수정!! --%>
						<a href="../basket/getBasketList/${memberDto.userId}" onclick="return moveBasket();">
							나의 장바구니
						</a>
	            </div>
	            <!-- /.panel-heading --> 
	            <div class="panel-body">

	                    <div class="desimone_cont3">
	                    	<ul class="desimone_cont3_ul">
		                    	<c:forEach var="item" items="${list}">
		                    		<li>
		                    			<div class="back_share">
				                            <a href="productDetail?productId=${item.productId}">
<%--				                            	<img src="${item.productImg}" width=230 height=230 alt="이미지"/>--%>
												<img src="/admin/product/display?fileName=${item.productImg}" width=230 height=230 alt="이미지"/>
				                            </a>
				                           
		                    			</div>
		                    			<div>
		                    				<p class="desimone_tit">${item.productName}</p>
		                    			</div>
		                    			<div class="product_won">
		                    				${item.productPrice}
		                    			</div>
		                    		</li>
			                   </c:forEach>
	                    	</ul>
	                    </div>
	                   
	                       
	                    </tbody>
	                <!-- /.table-responsive -->
	              
	                </div>
	                <!-- /.table-responsive -->
	                
	                
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
					      </div>
					   </div>
				</div> <%-- /.modal fade--%>
	                
	            </div>
	            <!-- /.panel-body -->
	        </div>
	        <!-- /.panel -->
	    </div>
	    <!-- /.col-lg-6 -->
	</div>
	<!-- /.row -->

	<script type="text/javascript">
		function moveBasket(){
			if("${memberDto.userId}" === ""){
				alert("로그인 후 이용해주세요.");
				return false;
			}

		}
		$(document).ready(function(){
			var result= '<c:out value="${result}"/>';

			function checkModal(result){
				if(result === ''){
					return;
				} else{
					$(".modal-body").html(result);
				}
				$("#myModal").modal("show");
			}
			checkModal(result);
		});
		
		// $("#regBtn").on("click", function(){
		// 	self.location = "/board/register";
		// });
	</script>
 <%-- <%@include file="../includes/footer.jsp" %>   --%>
<%@include file="../includes/memberfooter.jsp"%>