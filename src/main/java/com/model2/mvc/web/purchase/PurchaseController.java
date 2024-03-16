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
	////////////Business logic UserService DI/////////////////////
	///Field

	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	///Constructor
	public PurchaseController() {
		System.out.println(this.getClass());
	}

	// 구매이력 클릭시
	@RequestMapping(value ="listPurchase")
	public String listPurchase(@RequestParam("test") String test) throws Exception {

		System.out.println(test);
		System.out.println("/purchase/listPurchase 떠야됨");
		
		return "forward:/purchase/listPurchase.jsp";
	}
	
	// 상품상세보기에서 구매버튼 클릭시
	@RequestMapping( value="execPurchase", method=RequestMethod.GET )
	public String purchaseProduct(@RequestParam("prodNo") String prodNo ) {
		
		System.out.println("/purchase/execPurchase : "+ prodNo);
		
		// 해당 product 를 입금대기중으로 수정
		// 해당 user에 product 엮어주기
		
		return "forward:/purchase/purchaseConfirmView.jsp";
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
