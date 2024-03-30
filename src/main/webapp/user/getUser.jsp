<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
	<meta charset="EUC-KR">
	<title>회원정보조회</title>

	<!-- jQuery CDN(Content Delivery Network) 호스트 사용 -->
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>	
	<link rel="stylesheet" href="/css/admin.css" type="text/css">

	<script type="text/javascript">
		
		//==> 추가된부분 : "수정" "확인"  Event 연결 및 처리
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.	
			 $( ".button-container button:contains('확인')" ).on("click" , function() {
				//Debug..
				//alert(  $( "td.ct_btn01:contains('확인')" ).html() );
				history.go(-1);
			});
		 	 
			 $(".button-container button:contains('회원정보수정')").on("click" , function() {
					//Debug..
					//alert(  $( "td.ct_btn01:contains('수정')" ).html() );
					self.location = "/user/updateUser?userId=${user.userId}"
				});
		});
		
		function ajaxTest(){
			console.log("테스트시작");

			var userId = "${user.userId}"
			console.log(userId,'이거');
			
			$.ajax({
				url : "/user/json/getUser/"+userId,
				method : "GET" ,
				dataType : "json" ,
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success : function(JSONData , status) {

					//Debug...
					//alert(status);
					//Debug...
					//alert("JSONData : \n"+JSONData);
					console.log("성공은하나");
					console.log(JSONData,status)
					var displayValue = "<h3>"
												+"아이디 : "+JSONData.userId+"<br/>"
												+"이  름 : "+JSONData.userName+"<br/>"
												+"이메일 : "+JSONData.email+"<br/>"
												+"ROLE : "+JSONData.role+"<br/>"
												+"등록일 : "+JSONData.regDateString+"<br/>"
												+"</h3>";
					//Debug...									
					console.log(displayValue);
					//$("button").remove();
					//$("body").html(displayValue);
				}//success
			})//ajax
		};//ajaxTest

		
	</script>

</head>

<body bgcolor="#ffffff" text="#000000">

<jsp:include page="/layout/background.jsp" />
<jsp:include page="/layout/toolbar.jsp" />

<div style="width: 70%; margin: 100px auto;">

	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">회원정보조회</h3>
	       <h5 class="text-muted">내 정보를 <strong class="text-danger">최신정보로 관리</strong>해 주세요.</h5>
	    </div>
	
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>아 이 디</strong></div>
			<div class="col-xs-8 col-md-4">${user.userId}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>이 름</strong></div>
			<div class="col-xs-8 col-md-4">${user.userName}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>주소</strong></div>
			<div class="col-xs-8 col-md-4">${user.addr}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>휴대전화번호</strong></div>
			<div class="col-xs-8 col-md-4">${ !empty user.phone ? user.phone : ''}	</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>이 메 일</strong></div>
			<div class="col-xs-8 col-md-4">${user.email}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>가입일자</strong></div>
			<div class="col-xs-8 col-md-4">${user.regDate}</div>
		</div>
		
		<hr/>
		
		<div class="button-container container text-right " >

	  			<button type="button" class="btn btn-primary">회원정보수정</button>

	  			<button type="button" class="btn btn-primary">확인</button>

		</div>
		
		<br/>
		
 	</div>
</div>

</body>

</html>