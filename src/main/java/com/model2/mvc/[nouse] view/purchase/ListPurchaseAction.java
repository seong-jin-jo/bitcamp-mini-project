// 좌측 '상품관리' 누르면 상품 목록조회페이지

// listProduct.do 로 들어오면 ListProductAction 으로 매핑해서 실햄
// productService 를 불러서 ProductDAO의 getProductList DBMS 를 수행한다

package com.model2.mvc.view.purchase;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.framework.Action;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;

public class ListPurchaseAction extends Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("/ListPurchaseAction.java");
		System.out.println("상품관리를 눌렀을 때 이게 실행되어야함");

		Search search = new Search();
		
		int currentPage = 1;
		if(request.getParameter("currentPage") != null)
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
		search.setCurrentPage(currentPage);
		search.setSearchCondition(request.getParameter("searchCondition")); //상품번호0 or 상품이름1 검색조건선택
		search.setSearchKeyword(request.getParameter("searchKeyword")); //검색어
		
		
		int pageSize = Integer.parseInt( getServletContext().getInitParameter("pageSize"));
		int pageUnit  =  Integer.parseInt(getServletContext().getInitParameter("pageUnit"));
//		search.setPageSize(pageSize);
		//String pageSize = getServletContext().getInitParameter("pageSize"); //몇개씩 받아올지?
		//String pageUnit = search.setPageUnit(Integer.parseInt(pageUnit));
		
		// Business logic 수행
		// (pageSize 개수만큼의 상품데이터만 map 객체에 받아옴)
		search.setPageSize(pageSize);
		ProductService service = new ProductServiceImpl();
		HashMap<String,Object> map = service.getProductList(search);
		
		System.out.println(currentPage + " / "+ map.get("list") + " / " + pageUnit + " / " + pageSize);
		
		Page resultPage = new Page( currentPage, ((Integer)map.get("totalCount")).intValue(),pageUnit,pageSize);
		System.out.println("상품 목록 개수 (map.get(\"list\").size()) " + map.get("list"));
		System.out.println("페이지 정보 " + resultPage.toString());
		
		// Model 과 View 연결
		request.setAttribute("list", map.get("list")); //실제 product List 만 줌 (total은 따로 page에서주니깐 map 안줌) 
		request.setAttribute("resultPage", resultPage);
		request.setAttribute("search", search); // 검색 조건들
		
		return "forward:/purchase/listPurchase.jsp";
	}
	
	
}