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
	<title>상품 목록조회T</title>
	
	<!-- CDN(Content Delivery Network) 호스트 사용 -->
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

	<link rel="stylesheet" href="/css/my.css" type="text/css">
	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	
	<!-- ajax 및 페이지이동 -->
	<script type="text/javascript">
		
		// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
		function fncGetProductList(currentPage) {
			console.log("요청됨")
			$('#menu').val(`${param.menu}`);
			$('#currentPage').val(currentPage);
			$('form[name="detailForm"]').submit();
			
		//	document.getElementById("currentPage").value = currentPage;
		// 	document.detailForm.submit();	
		}
		
		$(function() {
			//var prodNo = $(".ct_list_pop td")[0].innerText;
			//console.log(prodNo);
			
		 	$( "#searchButton" ).on("click" , function() {
				//Debug..
				//alert(  $( "td.ct_btn01:contains('검색')" ).html() );
				console.log("검색 요청됨")
				fncGetProductList(1);
			});
						 
			$(".ct_list_pop").on("click", function(){
				
				var clickedTr = $(this);
				console.log("clicked",clickedTr);
				var prodNo = clickedTr.find("td:first").text();
				console.log("prodNo",prodNo);
				
				$.ajax( 
						{
							url : "/product/json/getProduct?prodNo="+prodNo ,
							method : "GET" ,
							dataType : "json" , //서버에서 받아올 데이터 타입
							headers : {
								"Accept" : "application/json", //서버에게 원하는 데이터 타입
								"Content-Type" : "application/json" //req,res 바디의 데이터 타입?
							},
							//data:JSON.stringify({"userId":userId}) <- 만약 POST 요청이면 data 명
							success : function(JSONData , status) {
								console.log(JSONData,status)
								//Debug...
								//alert(status);
								//Debug...
								//alert("JSONData : \n"+JSONData);
								
								var displayValue = "<p class='ajax'>"
															//+"파일이름 : "+JSONData.fileName+"<br/>"
															//+"이미지 : "+JSONData.imageFile+"<br/>"
															//+"제조일자 : "+JSONData.manuDate+"<br/>"
															//+"가격 : "+JSONData.price+"<br/>"
															//+"상품명  : "+JSONData.prodName+"<br/>"
															//+"배송상태 : "+JSONData.proTranCode+"<br/>"
															+"상세정보 : "+JSONData.prodDetail+"<br/>"
															//+"상품번호 : "+JSONData.prodNo+"<br/>"
															//+"등록일  : "+JSONData.regDate+"<br/>"
												+"</p>";
								//Debug...									
								console.log(displayValue); 
								
								//clickedTr.find("h3").empty();
								console.log("clickedTr",clickedTr);
								if (clickedTr.next().is("p.ajax")) {
									console.log("제거")
								    // 이미 등록된 요소가 있으면 해당 요소를 제거
								    clickedTr.next("p.ajax").remove();
								} else {
									console.log("등록")
								    // 등록된 요소가 없으면 "gg"를 추가
								    clickedTr.after(displayValue).addClass("selected");
								}
								
							}
						})
			})
		})
		
		</script>
	
	<!-- 호버관련 -->		
	<style>
	 label {
	   display: inline-block;
	   width: 5em;
	 }
	
		/* 판매중인 상품 */
	.selling {
	    background-color: transparent; /* 초기 상태를 투명하게 설정 */
	    background-color: white;
	    animation: blink 2s infinite;
	}
   	
    .selling:hover {
		animation: none;
    }
    
	.ct_list_pop {
		transition: background-color 0.3s ease;
	}
	
	.ct_list_pop:hover { /* tr 호버했을때 */
	    /* 마우스를 올렸을 때의 스타일 */
	    background-color: lightyellow;
	    box-shadow: 0 0 5px rgba(0, 0, 0, 0.3); /* 그림자 효과 추가 */
     	animation: none;
	}

	.selected {
		animation: blink 1s infinite; /* 선택된 요소를 은은하게 반짝이도록 애니메이션 적용 */	
	}
	
	/* ajax에서 가져온 p태그 */
	.ajax { 
		border: 1px solid #ccc;
		padding: 10px;
		margin-top: 10px;
		width: 100%;
		/* display: none; 초기에는 숨겨둠 */
	}
	
	/* ajax에서 가져온 p태그 호버시 */
	.ajax:hover { 
		background-color: #f0f0f0; /* 호버 시 배경색 변경 */
		transform: scale(1.05); /* 호버 시 확대 효과 */
		cursor: pointer; /* 클릭 가능한 요소로 커서 변경 */
	}

	@keyframes blink {
		0% { opacity: 1; }
		50% { opacity: 0.1; }
		100% { opacity: 1; }
	}
	</style>
	<script>
		$(document).ready(function() {
		    // ct_list_pop 요소에 호버 이벤트 추가
		    $('.ct_list_pop').hover(function() {
		        // 다른 ct_list_pop 요소의 animation 중단
		        $('.ct_list_pop').css('animation', 'none');
		    }, function() {
		        // 호버가 끝날 때 다시 animation 적용
		        $('.ct_list_pop selling').css('animation', 'blink 2s infinite');
		    });
	
		    // selected 요소에 호버 이벤트 추가
		    $('.selected').hover(function() {
		        // 다른 ct_list_pop 요소의 animation 중단
		        $('.ct_list_pop').css('animation', 'none');
		    }, function() {
		        // 호버가 끝날 때 다시 animation 적용
		        $('.ct_list_pop').css('animation', 'blink 2s infinite');
		    });
		});
	</script>
	 
	<!-- 툴팁 -->
	<script type="text/javascript">
		$(document).ready(function(){
		    $('.ct_list_pop').tooltip();     
		});
	</script>
	
</head>

<body bgcolor="#ffffff" text="#000000">

<jsp:include page="/layout/background.jsp" />
<jsp:include page="/layout/toolbar.jsp" />


<div style="width: 70%; margin: 100px auto;">


		
	<div class="container">
		
		<!--  상단제목 -->
		<div class="page-header text-info">
	       <h3>상품목록조회</h3>
	    </div>
		
		<!--  상품검색 -->
		<div class="row"> 
		    
			    <div class="col-md-6 text-left">
			    	<p class="text-primary">
			    		전체  ${resultPage.getTotalCount() } 건수, 현재 ${resultPage.getCurrentPage()}  페이지
			    	</p>
			    </div>
			    
			    <div class="col-md-6 text-right">
				    <form class="form-inline" name="detailForm" action="/product/listProduct" method="post">
				      
				      <!-- 회원ID -->
					  <div class="form-group">
					  
					    <select class="form-control" name="searchCondition" >
							<!-- 판매중 상품보기로 
								<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>회원ID</option>
							 -->
							<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>

						</select>
					  </div>
					  
					  <!-- 검색어 -->
					  <div class="form-group">
					    <label class="sr-only" for="searchKeyword">검색어</label>
					    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
					    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
					  </div>
					  
					  <!-- 검색 -->
					  <button type="button" id="searchButton" class="btn btn-default">검색</button>
					  
					  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
					  <input type="hidden" id="currentPage" name="currentPage" value=""/>
					  <input type="hidden" id="menu" name="menu" value=""/>
					 
				  
					</form>
		    	</div>
		    	
			</div>
		
		<!--  상품목록 띄우기 -->
		<table class="table ">
		
	        <thead>
	          <tr>
	            <th align="center">No</th>
	            <th align="left" >상품명</th>
	            <th align="left">가격</th>
	            <th align="left">등록일</th>
	            <th align="left">현재상태</th>
	          </tr>
	        </thead>
	        
			<tbody>
			
				<!-- DB 조회한 list 에서 하나씩 vo 에 담아서 꺼내는중 -->
				<c:set var="i" value="0" />
				<c:forEach var="x" items="${list}">	
					<c:set var="i" value="${ i+1 }" />
					<tr class="ct_list_pop ${x.proTranCode eq '판매중' ? 'selling' : ''}" title="구매하려면 링크를 클릭하세요" data-placement="left">
						<td style="display:none;">${x.prodNo}</td>
						<td align="center">${ i }</td>
						<td align="left">
					
							<c:if test="${x.proTranCode == '판매중'}">
								<a href="/product/getProduct?prodNo=${x.prodNo}">${x.prodName}</a>
							</c:if>
							
							<c:if test="${x.proTranCode != '판매중'}">
							    ${x.prodName}
							</c:if>
							
						</td>
						<td align="left">${x.price}</td>
						<td align="left">${x.regDate}</td>		
						<td align="left">
							
							<%-- ${list} -> ProductVO 담김 --%>
							<%-- ${resultPage} -> Page [currentPage=1, totalCount=8, pageUnit=5, pageSize=3, maxPage=3, beginUnitPage=1, endUnitPage=3] --%> 
							<%-- ${search} -> Search [curruntPage=1, searchCondition=null, searchKeyword=null, pageSize=3] --%>
							<%-- ${param} -> {menu=search} --%>
							<%-- ${product} -> ProductVO--%>
							
							<c:if test="${param.menu eq 'search'}">
							    ${x.proTranCode}
							</c:if>
							<c:if test="${param.menu eq 'manage'}">
							    <c:choose>
							        <c:when test="${x.proTranCode eq '배송중'}">
							            ${x.proTranCode} 
							            <a href="/purchase/updateTranCode?prodNo=${x.prodNo}&menu=${param.menu}&currentPage=${resultPage.currentPage}">배송하기</a>
					
							        </c:when>
							        <c:otherwise>
							            ${x.proTranCode}	
							        </c:otherwise>
							    </c:choose>
							</c:if>
						
							<!-- 
							<c:if test="${param.menu == 'manage'}">
							
								<c:if test="${product.proTranCode == '판매중'}">
									<a href="/product/getProduct?prodNo=${product.prodNo}">${product.prodName}</a>
								</c:if>
								
								<c:if test="${product.proTranCode != '판매중'}">
								    ${product.prodName}
								</c:if>
								
							</c:if>
							
							
							<c:if test="${param.menu == 'search'}">
							${param.menu} !!
								${product.proTranCode == '판매중'}
								
							</c:if>
							 -->
						</td>		
					</tr>
				</c:forEach>
			
			</tbody>	
		 </table>
		
 	</div>	
 	
	<jsp:include page="../common/pageNavigator_new_product.jsp"/>

</form>

</div>

</body>
</html>