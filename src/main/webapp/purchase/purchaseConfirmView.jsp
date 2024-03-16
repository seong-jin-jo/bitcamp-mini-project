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

/purchaseConfirmView.jsp

구매 등록 완료!

<a href="/purchase/payment?">결제하러가기뷰(어떤데이터넣어야하지)</a>

<br></br>${productVO.getProdName()}
	</br>${productVO.getProTranCode()}
	
</body>
</html>