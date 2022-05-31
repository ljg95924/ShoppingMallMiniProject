<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Bootstrap Admin Theme</title>

   
     <!-- Bootstrap Core CSS -->
    <link href="${path}/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

   <!--  MetisMenu CSS -->
    <link href="${path}/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- DataTables CSS -->
    <link href="${path}/resources/vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">

    <!-- DataTables Responsive CSS -->
    <link href="${path}/resources/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="${path}/resources/dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="${path}/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">




    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>

    <div class="container">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Please Sign In</h3>
                    </div>
                    <div class="panel-body">
                        <form role="form" action="<c:url value='/member/login' />" method="post">
                            <fieldset>
                                <div class="form-group">
                                    <input class="form-control" placeholder="Id" name="userId" type="text" autofocus>
                                </div>
                                <div class="form-group">
                                    <input class="form-control" placeholder="Password" name="userPwd" type="password">
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input name="rememberId" type="checkbox" value="rememberId">Remember ID
                                    </label>
                                </div>
                                <!-- Change this to a button or input when using this as a form -->
                                <input type="submit" value="Login" size="20" class="btn btn-lg btn-success btn-block">
                                <a href="findId" class="btn btn-lg btn-info btn-block">Find your ID</a>
                                <a href="findPw" class="btn btn-lg btn-warning btn-block">Find your PW</a>

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

    
    <!-- jQuery -->
    <script src="${path}/resources/vendor/jquery/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="${path}/resources/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="${path}/resources/vendor/metisMenu/metisMenu.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="${path}/resources/dist/js/sb-admin-2.js"></script>



</body>

</html>

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
