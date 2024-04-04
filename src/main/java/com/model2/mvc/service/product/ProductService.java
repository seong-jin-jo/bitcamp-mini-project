package com.model2.mvc.service.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.domain.ProductVO;

//DAO에게 내릴 명렬들을 모아 놓은 Service Logic 인터페이스
public interface ProductService {
	
	public ProductVO findProduct(int prodNo) throws Exception;
	
	//요기 HashMap 아니라 Map 으로 interface 기반으로 만들어도 됨
	public Map<String, Object> getProductList(Search search) throws Exception;
	
	
	public void addProduct(ProductVO productVO) throws Exception;
	
	public void updateProduct(ProductVO productVO) throws Exception;

	public boolean checkDuplication(String userId) throws Exception;

	public List<String> getProductAll(String value) throws Exception; // autocomplete위한
	
}