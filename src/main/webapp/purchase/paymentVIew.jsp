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

/paymentView.jsp

각종 결제정보 쭉 뜨고 ...
form 에서post 요청으로 결제들어감

--> /purchase/payment 으로 가면됨

<br></br>${productVO.getProdName()}
	</br>${productVO.getProTranCode()}
</body>
</html>