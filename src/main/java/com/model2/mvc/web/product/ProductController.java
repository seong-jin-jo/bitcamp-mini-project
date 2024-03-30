package com.model2.mvc.web.product;

import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.domain.ProductVO;
import com.model2.mvc.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.user.UserService;


@Controller
@RequestMapping("/product/*")
public class ProductController {
	////////////Business logic UserService DI/////////////////////
	///Field

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	///Constructor
	public ProductController() {
		System.out.println(this.getClass()+"ㅅㅅ");
	}
	
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	//페이지 넘어갈때 리스트가 왜 줄어듦?
	@RequestMapping( value="listProduct" )
	public String listProduct(@ModelAttribute("search") Search search, @RequestParam String menu, Model model) throws Exception {

		System.out.println("/product/listProduct");
		
		System.out.println("param : "+menu);
		
		if(search == null) {
			search = new Search();
		}
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		System.out.println(search);
		
		Map<String , Object> map = productService.getProductList(search);
		System.out.println("listProduct 조회결과 : "+map);
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("param", menu);
		
		return "forward:/product/listProduct.jsp";
	}
	
	@RequestMapping( value="getProduct", method=RequestMethod.GET )
	public String getProduct(@RequestParam("prodNo") int prodNo, Model model) throws Exception {
		
		System.out.println("/product/getProduct");
		
		//Product No으로 DB조회
		ProductVO product= productService.findProduct(prodNo);
		//조회한 결과 'vo' 란 이름으로 얹어서 주기
		model.addAttribute("vo",product);
		
		return "forward:/product/readProduct.jsp";
	}

	// @RequestBody 써봤는데 바로 도메인객체 바인딩 안됨
	// @ModelAttribute 는 query 를 받아오는 애들.. 도메인객체 바인딩 가능함?
	// pjt 보니 가능한거같은데 왜 product 는 null 이 뜰까?
	// ModelAttribute("<-요기->") 데이터타입 요기 // 이렇게 두개맞춰줘야하나? 무슨 의미를 갖는거지 
	// -> enctype 아무거나써도 requestbody는 됨. 형식의차이 (text/plain 읽기쉽게 기본은 param)으로
	// 근데 modelAttribute 쓸때는 기본타입써야
	
	@RequestMapping( value="addProduct", method=RequestMethod.GET )
	public String addProductView() {
		
		return "forward:/product/addProductView.jsp";
	}
	
	@RequestMapping( value="addProduct", method=RequestMethod.POST )
	public String addProduct(@ModelAttribute("product") ProductVO product) throws Exception {
		
		System.out.println("/product/addProduct : POST" );
		//Business Logic
		
		product.setProTranCode("판매중");
		//Date result = product.getManuDate();
		
		System.out.println(product.toString());
		String rawManuDate = product.getManuDate().replaceAll("-", "");
		product.setManuDate(rawManuDate);
		
		productService.addProduct(product);
		
		
		return "forward:/product/addProductConfirm.jsp";
	}
	
	//수정 화면 들어가는
	@RequestMapping( value="updateProduct", method=RequestMethod.GET )
	public ModelAndView updateProduct(@RequestParam("prodNo") int prodNo) throws Exception {
		
		
		System.out.println("/product/updateProduct : GET");
		System.out.println(prodNo);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("ProductVO", productService.findProduct(prodNo));
	
		//modelAndView.addObject("userId", user.getUserId()); //모델정보
		modelAndView.setViewName("forward:/product/updateProduct.jsp");
		
		return modelAndView;
	}
	
	//수정 화면에서 컨펌하는
	@RequestMapping( value="updateProduct", method=RequestMethod.POST )
	public ModelAndView updateProduct(@ModelAttribute("product") ProductVO productVO) throws Exception {
		
		System.out.println("/product/updateProduct : POST");
		System.out.println(productVO);

		// 수정 버튼을 눌렀을때 DB에 컨펌하고 최신 user정보 띄우는
		productService.updateProduct(productVO);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("productVO", productVO); //모델정보
		modelAndView.setViewName("redirect:/product/getProduct?prodNo="+productVO.getProdNo()); //VIEW정보
		return modelAndView;
	}
	
}//CLASS
