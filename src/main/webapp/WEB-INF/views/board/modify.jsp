<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../includes/adminheader.jsp" %>

<link rel="stylesheet" href="/resources/dist/css/fileUploadImage.css">

<script type="text/javascript" defer>

    const bno = '<c:out value="${board.bno}"/>';

    $(document).ready(function () {

        const formObj = $('form');
        $('button').on('click', function (e) {

            // 기본 submit 기본 동작을 바로 실행하지 않기위해
            e.preventDefault();

            // button 태그에 있는 data-oper 값을 가져옴
            const operation = $(this).data('oper');

            // Remove 버튼 클릭 시
            if (operation === 'remove') {
                formObj.attr('action', '/board/remove');
            // List 버튼 클릭 시
            } else if (operation === 'list') {
                self.location = '/board/list';
                return;
            } else {
                let str = "";
                $(".uploadResult ul li").each(function (i, obj) {
                    let jobj = $(obj);
                    console.dir(jobj);
                    str += "<input type='hidden' name='attachList[" + i + "].fileName' value='" + jobj.data("filename") + "'>";
                    str += "<input type='hidden' name='attachList[" + i + "].uuid' value='" + jobj.data("uuid") + "'>";
                    str += "<input type='hidden' name='attachList[" + i + "].uploadPath' value='" + jobj.data("path") + "'>";
                    str += "<input type='hidden' name='attachList[" + i + "].fileType' value='" + jobj.data("type") + "'>";
                });
                formObj.append(str);
            }

            // 각 버튼 별 필요한 속성 정의 후 버튼 이벤트 진행
            formObj.submit();
        });

        // 게시글 수정 페이지로 들어오면 TBL_ATTACH 테이블에서 해당 bno 에 해당하는 첨부파일 갖고옴
        $.getJSON("/board/getAttachList", {bno: bno}, function (arr) {
            console.log(arr);

            // 갖고 온 정보를 화면에 뿌려주기 위한 함수
            // uploadResult 태그에 해당 데이터를 출력
            showUploadedFile(arr);

        });	// end getJSON


        // 첨부파일 이미지 클릭 시 bigPictureWrapper 클래스를 가진 태그에 해당 이미지를 크게 보여줌
        // showImage START
        function showImage(fileCallPath) {
            $(".bigPictureWrapper").css("display", "flex").show();
            $(".bigPicture").html("<img src='/display?fileName=" + encodeURI(fileCallPath) + "'>")
                .animate({width: '100%', height: '100%'}, 1000);
        } // showImage END


        // showImage 함수로 인해 커진 이미지를 없애기 위한 기능
        // bigPictureWrapper START
        $(".bigPictureWrapper").on("click", function (e) {
            $(".bigPicture").animate({width: '0%', height: '0%'}, 1000);
            setTimeout(function () {
                $('.bigPictureWrapper').hide();
            }, 1000);
        }); // bigPictureWrapper END

        // X 그림 누르면 해당 파일 삭제
        $(".uploadResult").on("click", "button", function (e) {
            let targetFile = $(this).data("file");
            let type = $(this).data("type");
            let targetLi = $(this).closest("li");
            // console.log(targetFile);

            // ajax file delete logic START
            $.ajax({
                url: '/deleteFile',
                data: {fileName: targetFile, type: type},
                dataType: 'text',
                type: 'post',
                success: function (result) {
                    alert(result);
                    targetLi.remove();
                },
            }); // ajax file delete logic END

        }); // uploadResult logic END


        // input type='file' 인 영역 내용변경이 감지되면 실행(서버에 해당 파일 업로드, DB 작업 X)
        // input type file change function START
        $("input[type='file']").change(function (e) {
            const formData = new FormData();
            const inputFile = $("input[name='uploadFile']");
            const files = inputFile[0].files;

            // 업로드 전에 <input type='file'> 객체가 포함된 <div> 복사
            const cloneObj = $(".uploadDiv").clone();

            // 업로드 파일 유효성 검사
            const regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
            const maxSize = 5242880;

            function checkExtension(fileName, fileSize) {
                if (fileSize >= maxSize) {
                    alert("파일 크기 초과");
                    return false;
                }
                if (regex.test(fileName)) {
                    alert("해당 종류의 파일은 업로드 할 수 없음");
                    return false;
                }
                return true;
            } // checkExtension END

            // 사용자가 입력한 업로드 파일 유효성 검사 및 파일 추가
            for (var i = 0; i < files.length; i++) {
                if (!checkExtension(files[i].name, files[i].size)) {
                    return false;
                }
                formData.append("uploadFile", files[i]);
            } // 사용자가 입력한 업로드 파일 유효성 검사 및 파일 추가 END

            console.log("files.length: " + files.length);

            // 파일 업로드
            // ajax file upload logic START
            $.ajax({
                url: "/uploadAjaxAction",
                processData: false, // 전달할 데이터 query string 을 만들지 말 것
                contentType: false,
                data: formData,     // 전달할 데이터
                type: "POST",
                dataType: 'json',   // 받을 데이터 형식
                success: function (result) {
                    console.log(result);
                    showUploadedFile(result);
                    $(".uploadDiv").html(cloneObj.html());
                },
            }); // $.ajax END

        }); // input type file change function END

        // ajax 로 서버에 해당 파일 업로드가 성공하게 되면,  uploadResult 클래스를 가진 태그에 아이콘, 업로드 파일명을 출력
        // showUploadedFile START
        function showUploadedFile(uploadResultArr) {
            let str = "";

            $(uploadResultArr).each(function (i, obj) {
                if (!obj.fileType) {
                    var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
                    str += "<li data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.fileType + "'><div>";
                    str += "<span>" + obj.fileName + "</span>";
                    str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='file'  class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
                    str += "<a href='/download?fileName=" + fileCallPath + "'><img src='/resources/images/attach.jpg'></a>"
                    str += "</div></li>";
                } else {
                    var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
                    let originPath = obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName;
                    originPath = originPath.replace(new RegExp(/\\/g), "/");  // 폴더 구분자인 경우 '/'로 통일
                    str += "<li data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.fileType + "'><div>";
                    str += "<span>" + obj.fileName + "</span>";
                    str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='image'  class='btn btn-warning btn-circle'> <i class='fa fa-times'></i></button><br>";
                    str += "<a href=\"javascript:showImage(\'" + originPath + "\')\"><img src='/display?fileName=" + fileCallPath + "'></a>";
                    str += "</div></li>";
                }
            });

            $(".uploadResult ul").append(str);
        } // showUploadedFile END

    });

</script>


<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">Board Modify Page</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">게시글 수정</div>
            <div class="panel-body">
                <form role="form" action="/board/modify" method="post">
                    <div class="form-group">
                        <label>Bno</label>
                        <input class="form-control"
                               name="bno"
                               value='${board.bno}'
                               readonly="readonly">
                    </div>
                    <div class="form-group">
                        <label>Title</label>
                        <input class="form-control"
                               name="title"
                               value='${board.title}'>
                    </div>
                    <div class="form-group">
                        <label>Content</label>
                        <input class="form-control"
                               name="content"
                               value='${board.content}'>
                    </div>
                    <div class="form-group">
                        <label>Writer</label>
                        <input class="form-control"
                               name="writer"
                               value='${board.writer}'
                               readonly="readonly">
                    </div>
                    <div class="form-group">
                        <label>RegDate</label>
                        <input class="form-control"
                               name="regDate"
                               value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.regDate}"/>'
                               readonly="readonly">
                    </div>
                    <div class="form-group">
                        <label>UpdateDate</label>
                        <input class="form-control"
                               name="updateDate"
                               value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.updateDate}"/>'
                               readonly="readonly">
                    </div>

                    <button type="submit" data-oper='modify' class="btn btn-info">Modify</button>
                    <button type="submit" data-oper='remove' class="btn btn-danger">Remove</button>
                    <button type="submit" data-oper='list' class="btn btn-success">List</button>
                </form>
            </div>

        </div>
    </div>
</div>


<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-info">
            <div class="panel-heading">Attached File List</div>
            <div class="panel-body">
                <div class="form-group uploadDiv">
                    <input type="file" name='uploadFile' multiple>
                </div>
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

<!-- /.row -->
<%@include file="../includes/footer.jsp" %>
