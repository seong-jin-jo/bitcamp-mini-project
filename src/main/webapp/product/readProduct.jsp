<!--  listProduct 에서 /getProduct.do?userId 했을때 getProductAction.java 거쳐 옴-->
<!-- 상품 클릭했을 때 상세정보 보는 페이지 -->

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- EL / JSTL 적용으로 주석 처리 

	<%@ page import="com.model2.mvc.service.product.vo.*" %>
	<%@ page import="com.model2.mvc.service.domain.*" %>
	<%
		ProductVO vo=(ProductVO)request.getAttribute("vo"); //조회시
		System.out.println("/readProduct.jsp");
	
		// 세션 
		User currentSession = (User)session.getAttribute("user");
		if(currentSession != null){
			System.out.println("session -> "+currentSession.toString());
		}
	%>

--%>

<html>
<head>
	<title>상세정보조회</title>

	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	<link rel="stylesheet" href="/css/my.css" type="text/css">
	
	<html>
	

<head>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<title>Insert title here</title>
</head>

<body bgcolor="#ffffff" text="#000000">

<jsp:include page="/layout/toolbar.jsp" />
<jsp:include page="/layout/background.jsp" />

<div style="width: 70%; margin: 100px auto;">

<form name="detailForm" method="post">
	
	<div class="container">
	
		<!-- 상단 배너 -->
		<div class="page-header">
	       <h3 class=" text-info">상품정보조회</h3>
	       <h5 class="text-muted">상품 정보를 <strong class="text-danger">업데이트</strong>해 주세요.</h5>
	    </div>
		
		<!-- 상품번호 -->
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>상품번호</strong></div>
			<div class="col-xs-8 col-md-4">${vo.getProdNo()}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>상품명</strong></div>
			<div class="col-xs-8 col-md-4">${vo.getProdName()}</div>
		</div>

		<hr/>
				
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>상품이미지</strong></div>
			<!-- 
				<img width="30%" height="30%" src="/images/fileInputStorage/${images[0].getImage()}"/>
				<img width="30%" height="30%" src="/images/fileInputStorage/${images[1].getImage()}"/>
				<img width="30%" height="30%" src="/images/fileInputStorage/${images[2].getImage()}"/>
				<img width="30%" height="30%" src="/images/fileInputStorage/${images[3].getImage()}"/>
			-->
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
			<div class="col-xs-8 col-md-4">${vo.getProdDetail()}</div>
		</div>

		<hr/>
				
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>제조일자</strong></div>
			<div class="col-xs-8 col-md-4">${vo.getRegDate()}</div>
		</div>

		<hr/>
			
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>가격</strong></div>
			<div class="col-xs-8 col-md-4">${vo.getPrice()}</div>
		</div>	

		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>등록일자</strong></div>
			<div class="col-xs-8 col-md-4">${vo.getRegDate()}</div>
		</div>	

		<hr/>
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>상품상태</strong></div>
			<div class="col-xs-8 col-md-4">${vo.getProTranCode()}</div>
		</div>	

	</div>
		
	<div class="container text-right">
	    <div class="row">
				<!-- 구매 버튼 -->
	            <c:if test="${sessionScope != null && sessionScope.user.userId.contains('user')}">								
	                <button type="button" class="btn btn-primary" style="margin-right: 10px;" onclick="location.href='/purchase/execPurchase?prodNo=${vo.getProdNo()}'">구매</button>
	            </c:if>
	            
	            <!-- 수정 버튼 -->
	            <c:if test="${sessionScope != null && sessionScope.user.userId.equals('admin')}">								
	                <button type="button" class="btn btn-primary" style="margin-right: 10px;" onclick="location.href='/product/updateProduct?prodNo=${vo.getProdNo()}'">수정</button>
	            </c:if>

	            <!-- 이전 버튼 -->
	            <c:if test="${sessionScope == null || !sessionScope.User.userId().equals('admin')}">
	                <button type="button" class="btn btn-secondary" onclick="javascript:history.go(-1)">이전</button>
	            </c:if>

	    </div>
	</div>

</form>

</div>

</body>
</html>