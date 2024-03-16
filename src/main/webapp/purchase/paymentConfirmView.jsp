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

/paymentConfirmView.jsp

결제완료되면 이동하는 페이지.
(결제완료) 변경하고 판매자가 배송해야됨

<br></br>${productVO.getProdName()}
	</br>${productVO.getProTranCode()}
</body>
</html>