<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%-- EL/jSTl 전환
<%@ page import="com.model2.mvc.service.product.vo.*" %>
    
<% 
	ProductVO vo = (ProductVO)request.getAttribute("productVO");
%>
--%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="/layout/background.jsp" />
/purchaseConfirmView.jsp

구매 등록 완료!

<a href="/purchase/payment?">결제하러가기뷰(어떤데이터넣어야하지)</a>

<br></br>${productVO.getProdName()}
	</br>${productVO.getProTranCode()}

<form name="updatePurchase" action="/updatePurchaseView.do?tranNo=0" method="post">

다음과 같이 구매가 되었습니다.

<table border=1>
	<tr>
		<td>물품번호</td>
		<td>10094</td>
		<td></td>
	</tr>
	<tr>
		<td>구매자아이디</td>
		<td>user21</td>
		<td></td>
	</tr>
	<tr>
		<td>구매방법</td>
		<td>
		
			현금구매
		
		</td>
		<td></td>
	</tr>
	<tr>
		<td>구매자이름</td>
		<td>SCOTT</td>
		<td></td>
	</tr>
	<tr>
		<td>구매자연락처</td>
		<td>0104324244</td>
		<td></td>
	</tr>
	<tr>
		<td>구매자주소</td>
		<td>01051512222</td>
		<td></td>
	</tr>
		<tr>
		<td>구매요청사항</td>
		<td>gggg</td>
		<td></td>
	</tr>
	<tr>
		<td>배송희망일자</td>
		<td></td>
		<td></td>
	</tr>
</table>
</form>
	
</body>
</html>