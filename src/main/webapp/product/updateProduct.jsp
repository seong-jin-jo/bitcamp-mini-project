<!-- 상품정보 수정 클릭하면 시작하는 페이지 -->
<!--  updateProductViewAction 에서 넝ㅁ어옴 -->

<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>
<title>상품정보수정</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<link rel="stylesheet" href="/css/my.css" type="text/css">

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	
	$(function(){

	    console.log($("#button-group"));
	    $("#button-group").find("button").on("click" , function() {
	        console.log("수정하러감");
	        fncUpdateProduct();
	    });
	    
	    function fncUpdateProduct() {
	        var name = $('form input[name="prodName"]').val();
	        
	        if(name == null || name.length < 1){
	            alert("null 처리 구현 아직 안됨!");
	            return;
	        }
	        
	        $('form[name="detailForm"]').attr("method" , "POST").attr("action" , "/product/updateProduct").submit();
	    }
	    
	    function check_email(frm) {
	        alert; // 이 부분은 어떤 의도로 작성되었는지 확인이 필요합니다.
	        
	        var email = $('form input[name="email"]').val();
	        
	        if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1)){
	            alert("이메일 형식이 아닙니다.");
	            return false;
	        }
	        return true;
	    }
	    
	    function resetData() {
	        $('form[name="detailForm"]')[0].reset();
	    }
	});

</script>
</head>

<body bgcolor="#ffffff" text="#000000">	

<jsp:include page="/layout/toolbar.jsp" />
<jsp:include page="/layout/background.jsp" />

<div style="width: 70%; margin: 100px auto;">

<form name="detailForm" method="post">

<input type="hidden" name="prodNo" value="${ProductVO.getProdNo()}">

<!-- 상단 배너 -->

	<div class="container">
	
		<!-- 상단 배너 -->
		<div class="page-header">
	       <h3 class=" text-info">상품정보조회</h3>
	       <h5 class="text-muted">상품 정보를 <strong class="text-danger">업데이트</strong>해 주세요.</h5>
	    </div>
		
		<!-- 상품번호 -->
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>상품번호</strong></div>
			<div class="col-xs-8 col-md-4"><input type="text" name="prodNo" value="${ProductVO.getProdNo()}" readonly></div>
		</div>				
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>상품명</strong></div>
			<div class="col-xs-8 col-md-4"><input type="text" name="prodName" value="${ProductVO.getProdName()}"></div>
		</div>

		<hr/>
				
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>상품이미지</strong></div>
	  		<br/>
	  		&nbsp;
			<c:forEach var="imagehana" items="${images}" varStatus="loop">
				<!-- el 쓰면 getImage 안하고 바로 image 가능 -->
		       	<img width="30%" height="30%" src="/images/fileInputStorage/${imagehana.image}"/>
		    </c:forEach>
		</div>							  

		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>상품상세정보</strong></div> 
			<div class="col-xs-8 col-md-4"><input type="text" name="prodDetail" value="${ProductVO.getProdDetail()}"></div>
		</div>

		<hr/>
				
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>제조일자</strong></div>
			<div class="col-xs-8 col-md-4"><input type="text" name="manuDate" value="${ProductVO.getRegDate()}"></div>
		</div>

		<hr/>
			
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>가격</strong></div>
			<div class="col-xs-8 col-md-4"><input type="text" name="price" value="${ProductVO.getPrice()}"></div>
		</div>	

		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>등록일자</strong></div>
			<div class="col-xs-8 col-md-4"><input type="text" name="regDate" value="${ProductVO.getRegDate()}"></div>
		</div>	

		<hr/>
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>상품상태</strong></div>
			<div class="col-xs-8 col-md-4"><input type="text" name="proTranCode" value="${ProductVO.getProTranCode()}"></div>
		</div>	

	</div>

	<div class="container text-right" id="button-group">
        <button type="button" class="btn btn-primary">
            수정
        </button>
        <button type="button" class="btn btn-secondary" onclick="javascript:history.go(-1)">
            이전
        </button>
	</div>

</form>

</div>

</body>
</html>
