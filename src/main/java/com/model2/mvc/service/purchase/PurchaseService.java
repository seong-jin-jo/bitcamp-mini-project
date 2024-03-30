package com.model2.mvc.service.purchase;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.model2.mvc.domain.PurchaseVO;

public interface PurchaseService {

	public void purchaseProduct(PurchaseVO purchase) throws Exception;

	public List<PurchaseVO> getPurchaseList(String userId) throws Exception;
	
	public PurchaseVO findPurchase(PurchaseVO purchase) throws Exception;
	
	public void updatePurchase(PurchaseVO purchase) throws Exception;
	
}
