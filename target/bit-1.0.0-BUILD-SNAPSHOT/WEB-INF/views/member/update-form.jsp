<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../includes/adminheader.jsp"%>



<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header"> Member Info Update Page</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">회원정보 수정</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<form  role="form" action="<c:url value='/member/update'/>" method="post">
					<div id="wrap">
						<div id="content">
							<h1>BIO 11</h1>
							
							<div class="row">
								<label>아이디</label><br>
								<input maxlength="15" type="text" id="id" name="userId" value="${memberDto.userId}" readonly="readonly" >
								<span id="id_email">@bio11.com</span>
								<br><span id="id_msg" ></span><br>
									
								<label>비밀번호</label><br>
								<input type="password" id="pw" name="userPwd" onblur="pwCheck()"><br>
								<span id="pw_msg1" ></span>
								<span id="pw_msg2" ></span><br>
								
								<label>비밀번호 재확인</label><br>
								<input type="password" id="confirmPwd" onblur="coCheck()"><br>
								<span id="co_msg"></span><br>
								
				
								<label>이름</label><br>
								<input type="text" id="name" name="userName" value="${memberDto.userName}"readonly="readonly"><br>
								<span id="name_msg"></span><br>
								
								<label>주소</label><br>
								<input maxlength="15" type="text" id="address" value="${memberDto.userAddress}" name="userAddress" onblur="addressCheck()">
								<br><span id="address_msg" ></span><br>
								
								<label>생년월일</label><br>
								<input type="text" id="year" name="year" value="${year}" onblur="birth()">
								
								<select  id="month" name="month" size="1" onblur="birth()"> 
									<c:forEach var="m" begin="1" end="12" step="1">
										<c:choose>
											<c:when test="${month eq m}">
												<option value="${m}" selected>${m}월</option>
											</c:when>
											<c:otherwise>
												<option value="${m}">${m}월</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</select>
				
								<input type="text" id="day" name="day" value="${day}" onblur="birth()">
								<br>
								<span id="year_msg"></span>
				
								<c:if test="${memberDto.userGender eq 'm'}">
									<br><label>성별</label>
									<label for="man">남자</label> 
									<input type="radio" name="userGender" value="m" id="man" checked> 
									<label for="woman">여자</label>
									<input type="radio" name="userGender" value="wm" id="woman"><br>
								</c:if>
								<c:if test="${memberDto.userGender eq 'wm'}">
									<br><label>성별</label>
									<label for="man">남자</label> 
									<input type="radio" name="userGender" value="m" id="man"> 
									<label for="woman">여자</label>
									<input type="radio" name="userGender" value="wm" id="woman" checked><br>
								</c:if>
								

								
								<br><label>본인 확인 이메일</label><br>
								<input type="email" id="userEmail" name="userEmail" value="${memberDto.userEmail}" onblur="emailCheck()" placeholder="email@gmail.com" size="24" ><br>
								<span id="email_msg"></span><br>
				
								<label>휴대전화</label><br>
								<input type="text" id="userPhone" name="userPhone" value="${memberDto.userPhone}" onblur="phoneCheck()" placeholder="010-****-****" size="24"><br>
								<span id="phone_msg"></span><br>
														
								<input type="button" value="수정하기" size="24" onclick="submitCheck()">
							</div>
						</div>
					</div>
				</form>				
			
				
				<!-- 모달 -->
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
				      	</div><!--/.moadl-content -->
		  			</div><!--/.modal-dialog -->
				</div> <!-- /.modal fade -->   
	
			</div><!-- /.panel-body -->
		</div><!-- /.panel -->
	</div><!-- /.col-lg-6 -->
</div><!-- /.row -->

<script>	//유효성 체크

/* 유효성 검사 통과유무 변수 */
var idBool = false;           // 아이디
var pwBool = false;           // 비번
var pwckcorBool = false;      // 비번 확인 일치 확인
var addressBool = false;        // 전화번호
var nameBool = false;         // 이름
var birthBool = false;        // 생년월일
var emailBool = false;        // 이메일
var phoneBool = false;        // 전화번호

	$(document).ready(() => {
		
		//모달 보여주기 추가
		let result = '<c:out value="${result}"/>';
		
		const checkModal = (result) => {
			if(result===""){
				return;
			}else {
				$(".modal-body").html(result);
			}
			$("#myModal").modal("show");
		}
		checkModal(result);
	});//document.ready	
		

		
	function idCheck(){
		idBool = false;
		var id = document.getElementById("id").value;
	    var msg = document.getElementById('id_msg');
	    
		if (id == "") {
			msg.style.color="red";
			msg.innerHTML = "필수 정보입니다.";
			return;
	    }

	    var isPW = /^[a-z0-9][a-z0-9_\-]{4,19}$/;
	    if (!isPW.test(id)) {
	    	msg.innerHTML = "5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.";
	    	return;
	    }
	    idBool = true;
		msg.innerHTML = "";
	}
	
	function pwCheck(){
		 pwBool = false;
		var pw = document.getElementById("pw").value;
	    var msg1 = document.getElementById('pw_msg1');
	    var msg2 = document.getElementById('pw_msg2');
	
		if (pw == "") {
			msg1.style.color="red";
			msg1.style.left="285px";
			msg1.innerHTML = "사용불가";
			msg2.innerHTML = "필수 정보입니다.";
			return;
	    }

	    var isPW = /^[A-Za-z0-9`\-=\\\[\];',\./~!@#\$%\^&\*\(\)_\+|\{\}:"<>\?]{8,16}$/;
	    if (!isPW.test(pw)) {
	    	msg1.style.color="red";
	    	msg1.style.left="285px";
	    	msg1.innerHTML = "사용불가";
	    	msg2.innerHTML = "8~16자 / 영문 대 소문자, 숫자, 특수문자를 사용하세요.";
	    	return;
	    }
	    msg1.style.color="green";
	    msg1.style.left="320px";
	    msg1.innerHTML = "안전";
	    msg2.innerHTML = "";
	    pwBool = true;
	}
	
	function coCheck(){
		pwckcorBool = false;
		var pw = document.getElementById("pw").value;
		var confirmPwd = document.getElementById("confirmPwd").value;
	    var msg = document.getElementById('co_msg');
	    
		if (confirmPwd == "") {
			msg.style.color="red";
			msg.innerHTML = "필수 정보입니다.";
			return;
	    }

	    if (pw != confirmPwd) {
	    	msg.innerHTML = "비밀번호 재확인 불일치, 다시 입력 해주세요.";
	    	return;
	    }
	    msg.style.color="green";
	    msg.style.left="320px";
	    msg.innerHTML = "확인";
	    pwckcorBool = true;
	}
	
	function nameCheck(){
		nameBool = false;
		var name = document.getElementById("name").value;
	    var msg = document.getElementById('name_msg');
	    
		if (name == "") {
			msg.style.color="red";
			msg.innerHTML = "필수 정보입니다.";
			return;
	    }

		var nonchar = /[^가-힣a-zA-Z0-9]/gi;
        if (nonchar.test(name)) {
        	msg.innerHTML = "한글 또는 영문 대 소문자를 사용하세요. (특수기호, 공백 사용 불가)";
    		return;
   		}
    	msg.innerHTML = "";
    	nameBool = true;
	}
	
	function birth(){
		birthBool = false;
		var year = document.getElementById("year").value;
		var month = document.getElementById("month").value;
		var day = document.getElementById("day").value;
		
	    var year_msg = document.getElementById('year_msg');
	    year_msg.innerHTML = "";
	  
        if (year == "" && day == "") {
        	year_msg.style.color="red";
        	year_msg.innerHTML = "필수 정보입니다.";
            return;
        }

        if(year == "") {
        	year_msg.innerHTML = "태어난 년도 4자리를 정확하게 입력하세요.";
            return ;
        }
        
        if(year.length != 4) {
           	year_msg.innerHTML = "태어난 년도 4자리를 정확하게 입력하세요.";
            return ;
        }
        if (day.length == 1) {
            day = "0" + day;
        }
        if (month.length == 1) {
        	month = "0" + month;
        }
        
	    if(month == "") {
	        year_msg.innerHTML = "태어난 월을 선택하세요.";
            return ;
        }
        if(day == "") {
        	year_msg.innerHTML = "태어난 일(날짜) 2자리를 정확하게 입력하세요.";
            return ;
        }
        
        if(day.length != 2 ) {
        	year_msg.innerHTML = "태어난 일(날짜) 2자리를 정확하게 입력하세요.";
	         return ;
        } 

        birthday = year + month + day;
        if (birthday.length != 8) {
        	year_msg.innerHTML = "생년월일을 다시 확인해주세요.";
            return;
        }

        if (month < 1 || month > 12) {
        	year_msg.innerHTML = "생년월일을 다시 확인해주세요.";
            return;
        }
        
        var maxDaysInMonth = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];
        var maxDay = maxDaysInMonth[month - 1];
        
        //윤년 처리
		if (month == 2 && (year % 4 == 0 && year % 100 != 0 || year % 400 == 0)) {
            maxDay = 29;
        }

       if (day <= 0 || day > maxDay) {
    	   year_msg.innerHTML = "생년월일을 다시 확인해주세요.";
           return;
       }
        year_msg.innerHTML = "";

        var age = calcAge(birthday);
        if (age < 0) {
        	year_msg.innerHTML = "아직 안태어났습니다.";
            return ;
        } else if (age >= 120) {
            year_msg.innerHTML = "120살이 넘으셨다고요?";
            return ;
        } else if (age < 14) {
            year_msg.innerHTML = "만 14세 미만의 어린이는 가입할수 없습니다.";
            return ;
        } 
        birthBool = true;
	}
	
	function addressCheck(){
		addressBool = false;
		var address = document.getElementById("address").value;
	    var address_msg = document.getElementById('address_msg');
	    
		if (address == "") {
			address_msg.style.color="red";
			address_msg.innerHTML = "필수 정보입니다.";
			return;
	    }
		address_msg.innerHTML = "";
    	addressBool = true;
	}
	
	
	function emailCheck(){
		emailBool = false;
		var email = document.getElementById("userEmail").value;
	    var msg = document.getElementById('email_msg');
	    
		if (email == "") {
			msg.style.color="red";
			msg.innerHTML = "필수 정보입니다.";
			return;
	    }
		var isEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;	
	   /*  var isEmail = ^([\w\.\_\-])*[a-zA-Z0-9]+([\w\.\_\-])*([a-zA-Z0-9])+([\w\.\_\-])+@([a-zA-Z0-9]+\.)+[a-zA-Z0-9]{2,8}$; */
	    if (!isEmail.test(email)) {
	    	msg.style.color="red";
	    	msg.innerHTML = "email 형식을 확인해주세요.";
	    	return;
	    }
		
    	msg.innerHTML = "";
    	emailBool = true;
	}
	
	function phoneCheck(){
		phoneBool = false;
		var phone = document.getElementById("userPhone").value;
	    var msg = document.getElementById('phone_msg');
	    
		if (phone == "") {
			msg.style.color="red";
			msg.innerHTML = "필수 정보입니다.";
			return;
	    }
		var isPhone = /^\d{3}-\d{3,4}-\d{4}$/;
	    if (!isPhone.test(phone)) {
	    	msg.style.color="red";
	    	msg.innerHTML = "전화번호 형식을 확인해주세요.";
	    	return;
	    }
    	msg.innerHTML = "";
    	phoneBool = true;
	}
	
	
	
	var formObj = $("form");
	
	function submitCheck(e) {
		
		idCheck();
		pwCheck();
		coCheck();
		birth();
		nameCheck();
		emailCheck();
		phoneCheck();

		if(idBool && pwBool && pwckcorBool && nameBool && addressBool && birthBool && emailBool && phoneBool){
			// alert("true")
			formObj.submit();
		}else{
			alert("필수데이터를 정확하게 입력하세요.")
			return false;
		}

	}
	

	
	
    function calcAge(birth) {
        var date = new Date();
        var year = date.getFullYear(); //현재 년도
        var month = (date.getMonth() + 1); //현재 달
        var day = date.getDate(); //현재 일
        if (month < 10)
            month = '0' + month;
        if (day < 10)
            day = '0' + day;
        var monthDay = month + '' + day; //ex) 11 day

        birth = birth.replace('-', '').replace('-', '');
        var birthdayy = birth.substr(0, 4);
        var birthdaymd = birth.substr(4, 4);

        var age = monthDay < birthdaymd ? year - birthdayy - 1 : year - birthdayy;
        return age;
    }
    

    

</script>



<%@include file="../includes/footer.jsp"%>
