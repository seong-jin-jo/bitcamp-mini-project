// 상품을 등록
// addProduct.do 로 들어오면 AddProductAction 으로 매핑해서 실햄
// productService 를 불러서 ProductDAO의 insertProduct DBMS 를 수행한다

package com.model2.mvc.view.product;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model2.mvc.framework.Action;
import com.model2.mvc.service.domain.ProductVO;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;


public class AddProductAction extends Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// DBMS에 상품 등록하도록 하는 코드
		System.out.println("/addProduct.do");
		
		ProductVO productVO=new ProductVO();
		
		productVO.setProdName(request.getParameter("prodName"));
		productVO.setProdDetail(request.getParameter("prodDetail"));
		productVO.setManuDate(request.getParameter("manuDate"));
		productVO.setPrice(Integer.parseInt(request.getParameter("price")));
		
		System.out.println(productVO);
		
		ProductService service=new ProductServiceImpl();
		service.addProduct(productVO);
		
		request.setAttribute("productVO", productVO); //구매확정페이지 띄우려고
		
		return "forward:/product/addProductConfirm.jsp"; //미정
	}
	
	
}