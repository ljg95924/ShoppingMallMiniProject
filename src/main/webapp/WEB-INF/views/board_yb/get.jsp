<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@include file="../includes/adminheader.jsp" %>
<link rel="stylesheet" href="/resources/dist/css/fileUploadImage.css">

<script type="text/javascript" src="/resources/js/reply.js" defer></script>
<script type="text/javascript">
    $(document).ready(function () {

        const bnoValue = '<c:out value="${board.bno}"/>';
        const bno = '<c:out value="${board.bno}"/>';

        // 게시글 상세정보 페이지로 들어오면 TBL_ATTACH 테이블에서 해당 bno 에 해당하는 첨부파일 갖고오는데,
        // 갖고 온 데이터를 보여줄 태그 설정
        const uploadResult = $(".uploadResult ul");

        // 게시글 상세정보 페이지로 들어오면 TBL_ATTACH 테이블에서 해당 bno 에 해당하는 첨부파일 갖고옴
        $.getJSON("/board/getAttachList", {bno: bno}, function (arr) {
            console.log(arr);

            // uploadResult 태그에 해당 데이터를 출력하기위한 함수
            showUploadedFile(arr);

        });	// end getJSON

        $(".bigPictureWrapper").on("click", function (e) {
            $(".bigPicture").animate({width: '0%', height: '0%'}, 1000);
            setTimeout(function () {
                $('.bigPictureWrapper').hide();
            }, 1000);
        }); // bigPictureWrapper END


        /* 		replyService.add({
                    reply : "JS TEST",
                    replyer : "js tester",
                    bno : bnoValue
                } // 댓글 데이터
                , function(result) {
                    alert("RESULT : " + result);
                }) */

        /* 		replyService.getList({
                    bno : bnoValue,
                    page : 1
                }, function(list) {
                    list.forEach(function(item) {
                        console.log(item);
                    });
                }) */

        /* 		replyService.remove(
         3
         , function (count) {
         console.log(count);
         if(count === "success"){
         alert("REMOVED");
         }
         }, function (err) {
         alert('error occurred...');
         }
         ) */

        /* 		replyService.update({
                    rno : 20,
                    bno : bnoValue,
                    reply : "modified reply..."
                }, function(result) {
                    alert("수정 완료");
                }) */

        replyService.get(9, function (data) {
            console.log(data);
        })

        //댓글 목록의 이벤트 처리
        const replyUL = $(".chat");
        showList(1);

        function showList(page) {
            replyService.getList(
                {bno: bnoValue, page: page || 1},
                function (list) {
                    let str = "";
                    if (list == null || list.length == 0) {
                        replyUL.html("");
                        return;
                    }
                    for (let i = 0, len = list.length || 0; i < len; i++) {
                        str += "<li class='left clearfix' data-rno='" + list[i].rno + "'>";
                        str += "<div><div class='header'><strong class='primary-font'>"
                            + list[i].replyer + "</strong>";
                        str += "<small class='pull-right text-muted'>" + replyService.displayTime(list[i].replyDate) + "</small><div>";
                        str += "<p>" + list[i].reply + "</p><div></li>";
                    }
                    replyUL.html(str);
                }//function call
            );
        }//showList


        const modal = $(".modal");
        const modalInputReply = modal.find("input[name='reply']");
        const modalInputReplyer = modal.find("input[name='replyer']");
        const modalInputReplyDate = modal.find("input[name='replyDate']");

        const modalModBtn = $("#modalModBtn");
        const modalRemoveBtn = $("#modalRemoveBtn");
        const modalRegisterBtn = $("#modalRegisterBtn");
        const modalCloseBtn = $("#modalCloseBtn");

        $("#addReplyBtn").on("click", function (e) {
            modal.find("input").val("");
            modalInputReplyDate.closest("div").hide();
            modal.find("button[id!='modalCloseBtn']").hide();
            modalRegisterBtn.show();
            $(".modal").modal("show");
        });

        modalRegisterBtn.on("click", function (e) {
            const reply = {
                reply: modalInputReply.val(),
                replyer: modalInputReplyer.val(),
                bno: bnoValue
            };

            replyService.add(reply, function (result) {
                alert(result); 				// 댓글 등록이 정상임을 팝업으로 알림
                modal.find("input").val("");// 댓글 등록이 정상적으로 이뤄지면, 내용을 지움
                modal.modal("hide");		// 모달창 닫음
                showList(1);
            });
        });


        $(".chat").on("click", "li", function (e) {
            const rno = $(this).data("rno");
            /* console.log(rno); */

            replyService.get(rno, function (reply) {
                modalInputReply.val(reply.reply);
                modalInputReplyer.val(reply.replyer);
                modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly", "readonly");
                modal.data("rno", reply.rno);

                modal.find("button[id!='modalCloseBtn']").hide();
                modalRemoveBtn.show();
                $(".modal").modal("show");
            });
        });

        modalModBtn.on("click", function (e) {
            const reply = {
                rno: modal.data("rno"),
                reply: modalInputReply.val()
            };
            replyService.update(reply, function (result) {
                modal.modal("hide");
                showList(1);
            });
        });

        modalRemoveBtn.on("click", function (e) {
            const rno = modal.data("rno");
            replyService.remove(rno, function (result) {
                modal.modal("hide");
                showList(1);
            });
        });

        modalCloseBtn.on("click", function (e) {
            modal.modal("hide");
        });

        // uploadResult 태그에 해당 데이터를 출력하기위한 함수
        // showUploadedFile START
        function showUploadedFile(uploadResultArr) {
            let str = "";

            $(uploadResultArr).each(function (i, obj) {
                if (!obj.fileType) {
                    var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
                    str += "<li data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.fileType + "'><div>";
                    str += "<span>" + obj.fileName + "</span>";
                    str += "<a href='/download?fileName=" + fileCallPath + "'><img src='/resources/images/attach.jpg'></a>"
                    str += "</div></li>";
                } else {
                    var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
                    let originPath = obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName;
                    originPath = originPath.replace(new RegExp(/\\/g), "/");  // 폴더 구분자인 경우 '/'로 통일
                    str += "<li data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.fileType + "'><div>";
                    str += "<span>" + obj.fileName + "</span>";
                    str += "<a href=\"javascript:showImage(\'" + originPath + "\')\"><img src='/display?fileName=" + fileCallPath + "'></a>";
                    str += "</div></li>";
                }
            });

            uploadResult.append(str);
        } // showUploadedFile END

    });

    // showImage START
    function showImage(fileCallPath) {
        $(".bigPictureWrapper").css("display", "flex").show();
        $(".bigPicture").html("<img src='/display?fileName=" + encodeURI(fileCallPath) + "'>")
            .animate({width: '100%', height: '100%'}, 1000);
    } // showImage END

</script>


<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">Board Read Page</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-info">
            <div class="panel-heading">게시글 읽기</div>
            <div class="panel-body">
                <div class="form-group">
                    <label>Bno</label>
                    <input class="form-control"
                           name="bno"
                           value='<c:out value="${board.bno}"/>'
                           readonly="readonly">
                    <label>Content</label>
                    <textarea class="form-control"
                              name="content"
                              readonly="readonly">${board.content}
                    </textarea>
                    <label>Writer</label>
                    <input class="form-control"
                           name="writer"
                           value='<c:out value="${board.writer}"/>'
                           readonly="readonly">
                </div>
                <button data-oper='modify' class="btn btn-info"
                        onclick="location.href='/board/modify?bno=<c:out value="${board.bno}"/>'">
                    Modify
                </button>
                <button data-oper='list' class="btn btn-success" onclick="location.href='/board/list'">
                    List
                </button>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-info">
            <div class="panel-heading">Attached File List</div>
            <div class="panel-body">
                <div class="form-group uploadResult">
                    <ul></ul>
                </div>
                <div class="bigPictureWrapper">
                    <div class="bigPicture"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="panel panel-default">
    <div class="panel-heading">
        <i class="fa fa-comments fa-fw"></i> Reply
        <button id='addReplyBtn' type="button" class="btn btn-xs pull-right btn-success">
            New Reply
        </button>
    </div>
    <div class="panel-body">
        <ul class="chat">
            <li class="left clearfix" data-rno="12">
                <div>
                    <div class="header">
                        <strong class="primary-font">user00</strong>
                        <small class="pull-right text-muted">2021-05-18 13:13</small>
                    </div>
                    <p>Good job</p>
                </div>
            </li>
        </ul>
    </div>
</div>
<!-- /.reply panel -->


<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModallabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabel">REPLY Modal</h4>
            </div>
            <div class="modal-body">
                <div class="modal-group">
                    <label>Reply</label>
                    <input class="form-control" name="reply" value="New Reply!!!">
                </div>
                <div class="modal-group">
                    <label>Replyer</label>
                    <input class="form-control" name="replyer" value="Replyer~~">
                </div>
                <div class="modal-group">
                    <label>Reply Date</label>
                    <input class="form-control" name="replyDate" value="2016-01-05">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-warning" id="modalModBtn">Modify</button>
                <button type="button" class="btn btn-danger" id="modalRemoveBtn">Remove</button>
                <button type="button" class="btn btn-primary" id="modalRegisterBtn">Register</button>
                <button type="button" class="btn btn-default" id="modalCloseBtn">Close</button>
            </div>
        </div>
    </div>
</div>


<!-- /.row -->
<%@include file="../includes/footer.jsp" %>
