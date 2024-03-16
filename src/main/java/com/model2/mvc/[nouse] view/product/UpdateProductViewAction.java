// 상품 정보수정
// updateProductView.do 로 들어오면 UpdateProductViewAction 으로 매핑해서 실햄
// productService 를 불러서 ProductDAO의 updateProduct DBMS 를 수행한다

package com.model2.mvc.view.product;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model2.mvc.framework.Action;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.domain.ProductVO;

public class UpdateProductViewAction extends Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("/updateProductView.do");
		
		String prodNo = request.getParameter("prodNo");
		
		ProductService service=new ProductServiceImpl();
		ProductVO productVO=service.getProduct(prodNo);
		
		request.setAttribute("ProductVO", productVO);
		
		System.out.println("조회한 prodNo " + prodNo);

		
		return "forward:/product/updateProduct.jsp";
	}
	
}