package com.model2.mvc.web.purchase;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.domain.ProductVO;
import com.model2.mvc.domain.PurchaseVO;
import com.model2.mvc.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;


@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {
	///Field

	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	///Constructor
	public PurchaseController() {
		System.out.println(this.getClass()+"ㅎㅎ");
	}

	//상품에서 구매 클릭시
	@RequestMapping(value="addPurchaseView", method=RequestMethod.GET)
	public String addPurhcase() throws Exception {
		
		System.out.println("/purchase/addPurchase : GET");
		
		return "forward:/purchase/addPurchase.jsp";
	}
	
	// 구매이력 클릭시
	@RequestMapping(value ="listPurchase", method=RequestMethod.GET)
	public String listPurchase( HttpSession session, Model model) throws Exception {
		
		System.out.println("/purchase/listPurchase : GET");

		User user = (User)session.getAttribute("user");
		System.out.println(user.getUserId());
		
		List<PurchaseVO> result = purchaseService.getPurchaseList(user.getUserId());
		System.out.println("컨트롤러 DB조회결과 : " +result);
		
		model.addAttribute("result",result);
		
		return "forward:/purchase/listPurchase.jsp";
	}
	
	// 상품상세보기에서 구매버튼 클릭시
	@RequestMapping( value="execPurchase", method=RequestMethod.GET )
	public String purchaseProduct(@RequestParam("prodNo") int prodNo, Model model) throws Exception {
		
		System.out.println("/purchase/execPurchase : GET "+ prodNo);
		
		ProductVO product = productService.findProduct(prodNo);
		model.addAttribute("product", product);
		// 해당 product 를 입금대기중으로 수정
		// 해당 user에 product 엮어주기
		
		return "forward:/purchase/execPurchaseView.jsp";
	}
	
	// 구매페이지에서 최종구매버튼 클릭시
	@RequestMapping( value="execPurchase", method=RequestMethod.POST )
	public String purchaseProduct(@ModelAttribute("addPurchase") PurchaseVO purchase) throws Exception {
		
		System.out.println("/purchase/execPurchase : POST");
		System.out.println(purchase);

		//상품의 tranCode 업데이트
		int prodNo = purchase.getPurchaseProd().getProdNo();
		ProductVO product = productService.findProduct(prodNo);
		product.setProTranCode("배송중");
		productService.updateProduct(product);
	
		//구매의 tranCode 업데이트
		purchase.getPurchaseProd().setProTranCode("배송중");
		purchaseService.purchaseProduct(purchase);
		
		System.out.println("업데이트 완료!");
		
		return "forward:/purchase/purchaseConfirmView.jsp";
	}
	
	// 배송하기 클릭시
	@RequestMapping( value="updateTranCode", method=RequestMethod.GET )
	public String updateTranCode(@RequestParam int prodNo, Model model) throws Exception {
		
		System.out.println("/purchase/updateTranCode : GET");
		System.out.println(prodNo);
		
		//product 의 proTranCode 를 배송중에서 배송완료로 변경
		ProductVO product = productService.findProduct(prodNo);
		System.out.println(product);
		product.setProTranCode("배송완료");
		productService.updateProduct(product);
		model.addAttribute(product);
	
		//해당 product의 구매tranCode도 배송중에서 배송완료로 변경
		PurchaseVO purchase = new PurchaseVO();
		purchase.setPurchaseProd(product);
		System.out.println("업데이트할 대상 product : " + purchase.getPurchaseProd().getProdNo());
		purchase = purchaseService.findPurchase(purchase);
		purchaseService.updatePurchase(purchase);
		
		System.out.println("업데이트 purchase 성공");
		//얘네는 listProduct.jsp 가 아니라 얘네가 맞지?
		return "forward:/product/listProduct";
	}
	
	// 결제버튼 클릭시 View 보여줌
	@RequestMapping( value="payment", method=RequestMethod.GET )
	public String payment(@RequestParam String prodNo) {

		System.out.println("/purchase/payment : GET "+prodNo);
		
		return "forward:/purchase/paymentView.jsp";
	}

	// View에서 최종결제누르면 결제 처리함
	@RequestMapping( value="payment", method=RequestMethod.POST )
	public String payment(@ModelAttribute() PurchaseVO purchase) {
		
		System.out.println("/purchase/payment : POST");
		
		// 해당 product 를 배송중으로 수정
		
		return "forward:/purchase/paymentConfirmView.jsp";
	}
	
	// 배송중시 admin이 상품링크누르면 배송완료처리하도록
	@RequestMapping( value="process")
	public String process() {
		
		System.out.println("/purchase/process");
		
		return "forward:/purchase/process.jsp";
	}
}//CLASS
