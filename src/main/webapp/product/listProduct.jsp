<!-- 좌측에서 상품 검색 (ListProductAction 실행) 눌렀을 때 쫙 띄우는 페이지 -->

<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--/////////////////////// EL / JSTL 적용으로 주석 처리 ////////////////////////

<%	
	System.out.println("/listProduct.jsp 에서 받아온 것"
	+ request.getAttribute("list") //실제 product List 만 줌 (total은 따로 page에서주니깐 map 안줌) 
	); // 검색 조건들
	
	
	Page resultPage = (Page)request.getAttribute("resultPage");

	List<ProductVO> list= (List<ProductVO>)request.getAttribute("list");
	//원래 HashMap<String,Object> map=(HashMap<String,Object>)request.getAttribute("map");
	//상품목록 (원랜 list 에다가 total, list 가져오던걸 list 만 가져옴)
	
	//페이지정보
	Search search=(Search)request.getAttribute("search");
	
	String searchKeyword = search.getSearchKeyword(); //검색어
    String searchCondition = search.getSearchCondition(); //검색조건

 	/* page 객체 만들며 사라진 코드
    int total=0; // 조회한 상품 개수
	ArrayList<ProductVO> list=null;
	if(map != null){
		total=((Integer)map.get("count")).intValue();
		list=(ArrayList<ProductVO>)map.get("list");
	}
	// map : 전체 개수 count 와 전체 목록 list 가 있음
	// total : 전체 데이터 개수를 
	// list : 실제 데이터 (DAO에서 pageUnit 만큼 담아놓음)

	int currentPage = search.getPage(); // page : 현재 위치한 페이지
	int totalPage=0;
	if(total > 0) { // 조회한 상품이 있으면
		totalPage= total / search.getPageUnit() ; // 전체 페이지 = 전체 데이터 / 몇개씩 보여줄지
		if(total%search.getPageUnit() >0) // pageUnit : 몇개씩 띄울지
			System.out.println("totalPage " +  totalPage);
			totalPage += 1;
	}
	*/
%>
--%>

<html>
<head>
<title>상품 목록조회</title>

<script type="text/javascript">
<!--
// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
function fncGetProductList(currentPage) {
	document.getElementById("currentPage").value = currentPage;
   	document.detailForm.submit();	
}
-->
</script>
<link rel="stylesheet" href="/css/my.css" type="text/css">
<link rel="stylesheet" href="/css/admin.css" type="text/css">
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm" action="/product/listProduct" method="post">

	<!-- 장난질 -->
	<div>
		<h3> listProductAction 에서 넘어옴 listProduct.jsp </h3>
		
	</div>
	
	<!--  상단배너 -->
	<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
		<tr>
			<td width="15" height="37">
				<img src="/images/ct_ttl_img01.gif" width="15" height="37">
			</td>
			<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="93%" class="ct_ttl01">상품 목록조회</td>
					</tr>
				</table>
			</td>
			<td width="12" height="37">
				<img src="/images/ct_ttl_img03.gif" width="12" height="37">
			</td>
		</tr>
	</table>
	
	<!--  회원검색 -->
	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	    <tr>
	        <%-- 검색한 컨디션에 맞게 option 을 띄움 --%>
	        <c:choose>
	            <%-- 검색한 것이 있으면 --%>
	            <c:when test="${not empty search.searchCondition}">
	                <td align="right">
	                    <select name="searchCondition" class="ct_input_g" style="width:80px">
	                        <%-- 상품번호로 조회했다면 --%>
	                        <c:choose>
	                            <c:when test="${search.searchCondition eq '0'}">
	                                <option value="0" selected>상품번호(no)</option>
	                                <option value="1">상품명</option>
	                            </c:when>
	                            <c:otherwise>
	                                <option value="1" selected>상품명</option>
	                                <option value="0">상품번호(no)</option>
	                            </c:otherwise>
	                        </c:choose>
	                    </select>
	                    <input type="text" name="searchKeyword" value="${search.searchKeyword}" class="ct_input_g" style="width:200px; height:19px" >
	                </td>
	            </c:when>
	            <%-- 검색하기 이전이라면 --%>
	            <c:otherwise>
	                <td align="right">
	                    <select name="searchCondition" class="ct_input_g" style="width:80px">
	                        <option value="1">1번 상품명</option>
	                        <option value="0">0번 상품번호</option>
	                    </select>
	                    <input type="text" name="searchKeyword" class="ct_input_g" style="width:200px; height:19px" >
	                </td>
	            </c:otherwise>
	        </c:choose>
	        
	        <!-- 검색 버튼임 -->    
	        <td align="right" width="70">
	            <table border="0" cellspacing="0" cellpadding="0">
	                <tr>
	                    <td width="17" height="23">
	                        <img src="/images/ct_btnbg01.gif" width="17" height="23">
	                    </td>
	                    <td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
	                        <a href="javascript:fncGetProductList(1);">검색</a>
	                    </td>
	                    <td width="14" height="23">
	                        <img src="/images/ct_btnbg03.gif" width="14" height="23">
	                    </td>
	                </tr>
	            </table>
	        </td>
	    </tr>
	</table>
	
	<!--  상품목록 띄우기 -->
	<!-- user && 판매중 이면 '상품이름' 링크클릭되게 -->
	<!-- admin && 배송중 이면 '상태코드' 링크클릭되게 -->
	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
		<tr>
			<td colspan="11" >전체  ${resultPage.getTotalCount()} 건수, 현재 ${resultPage.getCurrentPage()} 페이지</td>
		</tr>
		<tr>
			<td class="ct_list_b" width="100">No</td>
			<td class="ct_line02"></td>
			<td class="ct_list_b" width="150">상품명</td>
			<td class="ct_line02"></td>
			<td class="ct_list_b" width="150">가격</td>
			<td class="ct_line02"></td>
			<td class="ct_list_b">등록일</td>	
			<td class="ct_line02"></td>
			<td class="ct_list_b">현재상태</td>
		</tr>
		<tr>
			<td colspan="11" bgcolor="808285" height="1"></td>
		</tr>
		
		<!-- DB 조회한 list 에서 하나씩 vo 에 담아서 꺼내는중 -->
		<c:set var="i" value="0" />
		<c:forEach var="product" items="${list}">	
			<c:set var="i" value="${ i+1 }" />
			<tr class="ct_list_pop">
				<td align="center">${ i }</td>
				<td></td>
				<td align="left">

					
					<c:if test="${product.proTranCode == '판매중'}">
						<a href="/product/getProduct?prodNo=${product.prodNo}">${product.prodName}</a>
					</c:if>
					
					<c:if test="${product.proTranCode != '판매중'}">
					    ${product.prodName}
					</c:if>
					
				</td>
				<td></td>
				<td align="left">${product.price}</td>
				<td></td>
				<td align="left">${product.regDate}</td>
				<td></td>
				
				<td align="left">
					<c:if test="${product.proTranCode == '배송중'}">
						<a href="/purchase/process?prodNo=${product.prodNo}">${product.proTranCode}</a>
					</c:if>
					
					<c:if test="${product.proTranCode != '배송중'}">
						${product.proTranCode}(listProduct.jsp)
					</c:if>
				</td>		
			</tr>
			<tr>
				<td colspan="11" bgcolor="D6D7D6" height="1"></td>
			</tr>
		</c:forEach>
	</table>	
	
	<!--  페이지 넘버링 -->
	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
		<tr>
			<td align="center">
		   	<!-- 몰래 currentPage 의 값을 집어넣고 form post 요청 보냄.
		   	링크타면 request 끊어지고 param 에 담기는 좀 뭐하니까 post 요청하려고 이러는거임 -->
		   	<input type="hidden" id="currentPage" name="currentPage" value=""/>
			   	
			   	<%-- 
			   		PageUnit (한 화면에 띄우는 페이지 개수5) 보다 CurrentPage (현재 페이지6) 가 작으면 ◀ 이전 등장
			   		BeginUnitPage (가장 작은 페이지 번호수6) 보다 EndUnitPage (가장 큰 페이지수) 사이 다 띄움
			   		EndUnitPage (가장 마지막 페이지수) 보다 MaxPage (페이지 마지막 번호) 가 크면 이후 ▶ 등장
			   	--%> 
				
				<%-- /////////////////////// EL / JSTL 적용으로 주석 처리 //////////////////////// 		   
				<% if( resultPage.getCurrentPage() <= resultPage.getPageUnit() ){ %>
						◀ 이전
				<% }else{ %>
						<a href="javascript:fncGetUserList('<%=resultPage.getCurrentPage()-1%>')">◀ 이전</a>
				<% } %>
			
				<%	for(int i=resultPage.getBeginUnitPage();i<= resultPage.getEndUnitPage() ;i++){	%>
						<a href="javascript:fncGetUserList('<%=i %>');"><%=i %></a>
				<% 	}  %>
				
				<% if( resultPage.getEndUnitPage() >= resultPage.getMaxPage() ){ %>
						이후 ▶
				<% }else{ %>
						<a href="javascript:fncGetUserList('<%=resultPage.getEndUnitPage()+1%>')">이후 ▶</a>
				<% } %>
				 /////////////////////// EL / JSTL 적용으로 주석 처리 //////////////////////// --%>
		
				<jsp:include page="../common/pageNavigator.jsp"/>

				<br>
				<br>// 1. user 도 프로젝트 가져오면서 refactoring 1 완료
				<br>// 2. JSPL 참고해가면서 proudct, user refactoring 2 완료
				<br>// 3. 구매 배송까지완료
				<br>
				<br>// UI, 장바구니-다중판매(?) 등등 디테일하게 리뉴얼 준비
	    	</td>
		</tr>
	</table>
</form>


</body>
</html>