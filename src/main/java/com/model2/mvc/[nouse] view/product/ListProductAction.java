// 좌측 '상품검색' 누르면 상품 목록조회페이지
// + 상품검색했을 때 해당 정보가지고 또 다시 상품 목록조회페이지 ListProduct.jsp 리프레쉬

// listProduct.do 로 들어오면 ListProductAction 으로 매핑해서 실햄
// productService 를 불러서 ProductDAO의 getProductList DBMS 를 수행한다

package com.model2.mvc.view.product;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.framework.Action;
import com.model2.mvc.service.domain.ProductVO;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;

public class ListProductAction extends Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("/ListProudctAction.java");
		System.out.println("상품 검색을 눌렀을 때 이게 실행되어야함");
		//menu 는 좌측 눌렀을 때 넘어오고 
		System.out.println("menu가 넘어오는데? " + request.getParameter("menu"));
		//currentpage는 페이지 클릭했을 때 넘어옴
		System.out.println("currentpage도 넘어와? " + request.getParameter("currentPage"));
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
		System.out.println("pageSize,pageUnit"+pageSize+","+pageUnit);
		// Business logic 수행
		// (pageSize 개수만큼의 상품데이터만 map 객체에 받아옴)
		search.setPageSize(pageSize);
		System.out.println("search : " + search); 
		ProductService service = new ProductServiceImpl();

		//HashMap<String,Object> map 
		List<ProductVO> map = service.getProductList(search);
		
		System.out.println("map받아온거" + map);
//		System.out.println(currentPage + " / "+ map.get("list") + " / " + pageUnit + " / " + pageSize);
//		
//		Page resultPage = new Page( currentPage, ((Integer)map.get("totalCount")).intValue(),pageUnit,pageSize);
//		System.out.println("상품 목록 개수 (map.get(\"list\").size()) " + map.get("list"));
//		System.out.println("페이지 정보 " + resultPage.toString());
//		
//		// Model 과 View 연결
//		request.setAttribute("list", map.get("list")); //실제 product List 만 줌 (total은 따로 page에서주니깐 map 안줌) 
//		request.setAttribute("resultPage", resultPage);
		request.setAttribute("search", search); // 검색 조건들
		
		return "forward:/product/listProduct.jsp";
	}
	
	
}