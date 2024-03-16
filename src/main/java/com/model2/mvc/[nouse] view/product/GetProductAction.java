// 상품 상세보기
// getProduct.do 로 들어오면 getProductAction 으로 매핑해서 실햄
// productService 를 불러서 ProductDAO의 findProduct DBMS 를 수행한다

package com.model2.mvc.view.product;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model2.mvc.framework.Action;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.domain.ProductVO;

// P/L인 Action 의 명령을 받아 DB 조회를 DAO에게 요청함

public class GetProductAction extends Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		String ProdNo = request.getParameter("prodNo");
		
		ProductService service = new ProductServiceImpl();
		ProductVO vo = service.getProduct(ProdNo);
		
		System.out.println("/getProductAction.java");
		System.out.println("ProductVO는 " + vo);
		
		request.setAttribute("vo", vo);
		
		return "forward:/product/readProduct.jsp";
	}
	
	
	
}