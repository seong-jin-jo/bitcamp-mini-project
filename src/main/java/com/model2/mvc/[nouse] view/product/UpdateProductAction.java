package com.model2.mvc.view.product;
// 상품 정보수정
// updateProduct.do 로 들어오면 UpdateProductAction 으로 매핑해서 실햄
// productService 를 불러서 ProductDAO의 updateProduct DBMS 를 수행한다

import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.model2.mvc.framework.Action;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.*;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.domain.ProductVO;

public class UpdateProductAction extends Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 상품 상세보기 readProduct.jsp 에서 수정 누르면 prodNo와 함께 넘어옴
		
		System.out.println("/updateProductAction.do");
		
		// 수정버튼 클릭전에 request에 갖고있던 prodNo
		String prodNo=(String)request.getParameter("prodNo"); 
		System.out.println(request.getParameter("prodName"));
		
		System.out.println("prodNO "+prodNo+" 수정들어감");
		
		// 수정하면서 form 에서 받은 refreshed 정보 새롭게 집어넣음
		ProductVO productVO=new ProductVO();
		productVO.setProdNo(Integer.parseInt(prodNo));
		productVO.setProdName(request.getParameter("prodName"));
		productVO.setProdDetail(request.getParameter("prodDetail"));
		productVO.setManuDate(request.getParameter("manuDate"));
		productVO.setPrice(Integer.parseInt(request.getParameter("price")));
		productVO.setRegDate(Date.valueOf(request.getParameter("regDate")));
		
		System.out.println("productVO 내용은 "+productVO);
		System.out.println("RegDate는 " + productVO.getRegDate());
		

		
		HttpSession session=request.getSession();
		
		if(session.getAttribute("user")!= null) {
			String sessionId=((User)session.getAttribute("user")).getUserId();
			System.out.println("sessionId는 " + sessionId);
		}
		/*
		if(sessionId.equals(userId)){
			session.setAttribute("user", userVO);
		}
		////////////////////*/

		ProductService service=new ProductServiceImpl();
		service.updateProduct(productVO);
		
		return "redirect:/getProduct.do?prodNo="+prodNo;
	}
	
	
}