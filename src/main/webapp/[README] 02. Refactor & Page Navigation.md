#1. 
검색조건 넣고 페이지 클릭시 검색조건 유지 (01에서 함)

#2. 
페이지 나누고 이전 다음만드는거 아직 제대로 구현안됨
Page.java 만들고 DAO에서 resultPage 따로 만들어 뭘 해야하는듯 JS처리도함

// beginUnitPage, endUnitPage, maxPage(totalPage)를 리턴하는 Page.java 를 만들어버림
   ProductAction 에서 Page 를 만들어 리턴

   ServletContext 에서 받아오던 pageSize 처럼, 
   ServletContext 에서 searchVO에서 받던 pageUnit도 페이지도 받아와서 Page에 넣음
   (ListProudctAction에서 web.xml 받아와 처리)
   
// (SearchVO)는 Page 만드는데만 이용함 (Search.java 로 변경)
	Search 에서는 PageSize, Currentpage, SearchCondition, SearchKeyword 가져옴
	
// null,Date 등을 str 처리하는 CommonUtil.java 추가

#3. 
ROWNUM 써서 currentPage 데이터만 받아오는것도 아직안됨
// DAO에서 makeCurrentPageSql, getTotalCount 따로 만들어놓고 getProductList 갈아엎어야됨
// DAO 에서 page를 위한 getTotalCount 도 만듦
UI, 장바구니-다중판매(?) 등등 디테일하게 리뉴얼