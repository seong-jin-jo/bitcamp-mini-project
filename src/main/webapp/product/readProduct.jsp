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

<h3> getProductAction 에서 링크타고 readProduct jsp로 넘어왔다</h3>

<html>
<head>
	<title>회원정보조회</title>

	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	<link rel="stylesheet" href="/css/my.css" type="text/css">
	
	<html>
	

<head>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<title>Insert title here</title>
</head>

<body bgcolor="#ffffff" text="#000000">

<form name="detailForm" method="post">

<!-- 상단 배너 -->
	<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
		<tr>
			<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"	width="15" height="37"></td>
			<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="93%" class="ct_ttl01">상품상세조회</td>
						<td width="20%" align="right">&nbsp;</td>
					</tr>
				</table>
			</td>
			<td width="12" height="37">
				<img src="/images/ct_ttl_img03.gif"  width="12" height="37"/>
			</td>
		</tr>
	</table>
		
	<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 13px;">
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		<!-- 상품번호 -->
		<tr>
			<!-- 첫번째 칼럼 -->
			<td width="104" class="ct_write">
				상품번호 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
			</td>
			<!-- 구분선 -->
			<td bgcolor="D6D6D6" width="1"></td>
			<!-- 두번째 칼럼 -->
			<td class="ct_write01">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="105">${vo.getProdNo()}</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		<!-- 상품명 -->
		<tr>
			<td width="104" class="ct_write">
				상품명 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
			</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">${vo.getProdName()}</td>
		</tr>
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		<!-- 상품이미지 -->
		<tr>
			<td width="104" class="ct_write">
				상품이미지 <img 	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
			</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">
				<img width="30%" height="30%" src="https://mblogthumb-phinf.pstatic.net/20160817_259/retspe_14714118890125sC2j_PNG/%C7%C7%C4%AB%C3%F2_%281%29.png?type=w800"/>
			</td>
		</tr>
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		<!-- 상품상세정보 -->
		<tr>
			<td width="104" class="ct_write">
				상품상세정보 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
			</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">${vo.getProdDetail()}</td>
		</tr>
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		<!-- 제조일자 -->
		<tr>
			<td width="104" class="ct_write">제조일자</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">${vo.getRegDate()}</td>
		</tr>
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		<!-- 가격 -->
		<tr>
			<td width="104" class="ct_write">가격</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">${vo.getPrice()}</td>
		</tr>
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		<!-- 등록일자 -->
		<tr>
			<td width="104" class="ct_write">등록일자</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">${vo.getRegDate()}</td>
		</tr>
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		<!-- 상품상태 -->
		<tr>
			<td width="104" class="ct_write">상품상태</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">${vo.getProTranCode()}</td>
		</tr>
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
	</table>
		
	<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
		<tr>
			<td width="53%"></td>
			<td align="right">
	
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
			
				<!-- 관리자만이 수정버튼을 볼 수 있다  -->								
				<c:if test="${sessionScope != null && sessionScope.user.userId.equals('admin')}">								
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01"	style="padding-top: 3px;">
						<a href="/product/updateProduct?prodNo=${vo.getProdNo()}">수정</a>
						<!-- update 페이지.. -->
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
				</c:if>
				
				<c:if test="${sessionScope != null && sessionScope.user.userId.contains('user')}"> 
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01"	style="padding-top: 3px;">
						<a href="/purchase/execPurchase?prodNo=${vo.getProdNo()}">구매</a>
						<!-- update 페이지.. -->
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>			
				</c:if>
				
				<%-- 
					<% JSTL/EL 로 변경
						if(currentSession != null){
							if(currentSession.getUserId().equals("admin")){ 
					%>
					
				<% 
					}}
				%>
				--%>
				<c:if test="${sessionScope == null || !sessionScope.User.userId().equals('admin')}">
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
						<a href="javascript:history.go(-1)">이전</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</c:if>
				</tr>
			</table>
	
			</td>
		</tr>
	</table>

</form>

</body>
</html>