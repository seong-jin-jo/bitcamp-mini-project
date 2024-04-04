<!-- 좌측에서 구매이력조회 눌렀을 때 쫙 띄우는 페이지 -->

<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>구매 목록조회</title>

<!-- CDN(Content Delivery Network) 호스트 사용 -->
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">
	function fncGetUserList() {
		document.detailForm.submit();
	}
</script>

<style>
	/* 판매중인 상품 */
	.delivering {
	    
	    background-color: white;
	    animation: blink 2s infinite;
	}
   	
    .delivering:hover {
		animation: none;
    }
    
   	@keyframes blink {
		0% { opacity: 1; }
		50% { opacity: 0.1; }
		100% { opacity: 1; }
	}
</style>

</head>

<body bgcolor="#ffffff" text="#000000">

<jsp:include page="/layout/background.jsp" />
<jsp:include page="/layout/toolbar.jsp" />

<div style="width: 70%; margin: 100px auto;">

<form name="detailForm" action="/listUser.do" method="post">

<tr>
	<td colspan="11">전체 ${result.size()} 건수, 현재 1 페이지</td>
</tr>
<table class="table ">

       <thead>
         <tr>
           <th align="center">No</th>
           <th align="left" >회원ID</th>
           <th align="left">상품명</th>
           <th align="left">주문자명</th>
           <th align="left">주문자전화번호</th>
           <th align="left">배송현황</th>
           <th align="left">정보수정</th>
         </tr>
       </thead>
     
	   <tbody>
     	<c:set var="i" value="0"/>
		<c:forEach var="item" items="${result}">
		<c:set var="i" value="${ i+1 }"/>
		<tr class="ct_list_pop ${item.purchaseProd.proTranCode eq '배송중' ? 'delivering' : ''}">
			<td align="left">${ i }</td>
			<td align="left">${user.userId}</td>
			<td align="left">${item.purchaseProd.prodName}</td>
			<td align="left">${item.receiverName}</td>
			<td align="left">${item.receiverPhone}</td>
			<td align="left">${item.purchaseProd.proTranCode}</td>
			<td align="left">정보수정(구현중)</td>	
		</tr>			
		</c:forEach>	
	   </tbody>	  
</table>


</form>

</div>
