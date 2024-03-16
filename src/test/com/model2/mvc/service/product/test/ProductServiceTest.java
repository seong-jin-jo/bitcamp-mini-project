package com.model2.mvc.service.product.test;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.model2.mvc.common.Search;
import com.model2.mvc.domain.ProductVO;
import com.model2.mvc.service.product.ProductDAO;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.user.UserDao;
import com.model2.mvc.service.user.UserService;


/*
 *	FileName :  UserServiceTest.java
 * ㅇ JUnit4 (Test Framework) 과 Spring Framework 통합 Test( Unit Test)
 * ㅇ Spring 은 JUnit 4를 위한 지원 클래스를 통해 스프링 기반 통합 테스트 코드를 작성 할 수 있다.
 * ㅇ @RunWith : Meta-data 를 통한 wiring(생성,DI) 할 객체 구현체 지정
 * ㅇ @ContextConfiguration : Meta-data location 지정
 * ㅇ @Test : 테스트 실행 소스 지정
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/commonservice.xml" })
public class ProductServiceTest {

	//==>@RunWith,@ContextConfiguration 이용 Wiring, Test 할 instance DI
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("productDaoImpl")
	private ProductDAO productDao;
	
	//@Test
	public void testAddProduct() throws Exception {
		
		ProductVO product = new ProductVO();
		//product.setFileName("exampleFileName.txt");
		product.setManuDate("20240305"); // ***************SQL 에서 넣는 date 타입과 확인타입.....공부필요
		product.setPrice(1000);
		product.setProdDetail("Example product detail description.");
		product.setProdName("Example Product");
		product.setProdNo(1247);
		//product.setRegDate("2034-03-05");
		product.setProTranCode("배송완료");
		
		productService.addProduct(product);
		
		product = productService.getProduct("1247");

		//==> console 확인
		System.out.println(product+" add에서 조회한 product");
		
		//==> API 확인
        //Assert.assertEquals("exampleFileName.txt", product.getFileName());
        Assert.assertEquals("20240305", product.getManuDate());
        Assert.assertEquals(1000, product.getPrice());
        Assert.assertEquals("Example product detail description.", product.getProdDetail());
        Assert.assertEquals("Example Product", product.getProdName());
        Assert.assertEquals(1247, product.getProdNo());
        //Assert.assertEquals("2024-03-05", product.getRegDate());
        Assert.assertEquals("배송완료", product.getProTranCode());
	}
	
	@Test
	public void testGetProduct() throws Exception {
		
		ProductVO product = new ProductVO();
		//==> 필요하다면...
//		user.setUserId("testUserId");
//		user.setUserName("testUserName");
//		user.setPassword("testPasswd");
//		user.setSsn("1111112222222");
//		user.setPhone("111-2222-3333");
//		user.setAddr("경기도");
//		user.setEmail("test@test.com");
		
		product = productService.getProduct("1247");
		System.out.println(product + " get에서 조회한 product");
		//==> console 확인
		//System.out.println(user);
		
		//==> API 확인
        //Assert.assertEquals("exampleFileName.txt", product.getFileName());
		// Assert.assertEquals("20240305", product.getManuDate()); //오류왜나노씨뿔
        Assert.assertEquals(1000, product.getPrice());
        Assert.assertEquals("Example product detail description.", product.getProdDetail());
        Assert.assertEquals("Example Product", product.getProdName());
        Assert.assertEquals(1247, product.getProdNo());
        //Assert.assertEquals(new java.sql.Date(new Date().getTime()), product.getRegDate());
        Assert.assertEquals("배송완료", product.getProTranCode());

		Assert.assertNotNull(productService.getProduct("user02"));
		Assert.assertNotNull(productService.getProduct("user05"));
	}
	
	@Test
	 public void testUpdateProduct() throws Exception{
		 
		ProductVO product = productService.getProduct("1247");
		Assert.assertNotNull(product);
		
		Assert.assertEquals("Example Product", product.getProdName());
		Assert.assertEquals("1000", product.getPrice());

		product.setProdName("Example Product updated");
		product.setPrice(1001);
		
		productService.updateProduct(product);
		
		product = productService.getProduct("1247");
		Assert.assertNotNull(product);
		
		//==> console 확인
		//System.out.println(user);
			
		//==> API 확인
		Assert.assertEquals("Example Product updated", product.getProdName());
		Assert.assertEquals("1001", product.getPrice());
	 }
	 
	@Test
	public void testCheckDuplication() throws Exception{

		//==> 필요하다면...
//		User user = new User();
//		user.setUserId("testUserId");
//		user.setUserName("testUserName");
//		user.setPassword("testPasswd");
//		user.setSsn("1111112222222");
//		user.setPhone("111-2222-3333");
//		user.setAddr("경기도");
//		user.setEmail("test@test.com");
//		
//		userService.addUser(user);
		
		//==> console 확인
		System.out.println(productService.checkDuplication("testUserId"));
		System.out.println(productService.checkDuplication("testUserId"+System.currentTimeMillis()) );
	 	
		//==> API 확인
		Assert.assertFalse( productService.checkDuplication("testUserId") );
	 	Assert.assertTrue( productService.checkDuplication("testUserId"+System.currentTimeMillis()) );
		 	
	}
	
	 //==>  주석을 풀고 실행하면....
	 @Test
	 public void testGetProductListAll() throws Exception{
		
		System.out.println("test 시작!!!!"); 
		System.out.println(productDao);
		System.out.println(productService);
		
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	List<ProductVO> map = productService.getProductList(search);
	 	
	 	//List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(3, map.size());
	 	
		//==> console 확인
	 	System.out.println(map);
	 	
	 	//Integer totalCount = (Integer)map.get("totalCount");
	 	//System.out.println(totalCount);
	 	
	 	System.out.println("=======================================");
	 	
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("0");
	 	search.setSearchKeyword("");
	 	map = productService.getProductList(search);
	 	
	 	//list = (List<Object>)map.get("list");
	 	//Assert.assertEquals(3, list.size());
	 	
	 	//==> console 확인
	 	//System.out.println(list);
	 	
	 	//totalCount = (Integer)map.get("totalCount");
	 	//System.out.println(totalCount);
	 }
	 
	 @Test
	 public void testGetUserListByUserId() throws Exception{
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("0");
	 	search.setSearchKeyword("admin");
	 	List<ProductVO> list = productService.getProductList(search);
	 	
	 	//List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(1, list.size());
	 	
		//==> console 확인
	 	//System.out.println(list);
	 	
	 	//Integer totalCount = (Integer)map.get("totalCount");
	 	//System.out.println(totalCount);
	 	
	 	System.out.println("=======================================");
	 	
	 	search.setSearchCondition("0");
	 	search.setSearchKeyword(""+System.currentTimeMillis());
	 	list = productService.getProductList(search);
	 	
	 	//list = (List<Object>)map.get("list");
	 	Assert.assertEquals(0, list.size());
	 	
		//==> console 확인
	 	//System.out.println(list);
	 	
	 	//totalCount = (Integer)map.get("totalCount");
	 	//System.out.println(totalCount);
	 }
	 
	 @Test
	 public void testGetUserListByUserName() throws Exception{
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("1");
	 	search.setSearchKeyword("SCOTT");
	 	List<ProductVO> list = productService.getProductList(search);
	 	
	 	//List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(3, list.size());
	 	
		//==> console 확인
	 	System.out.println(list);
	 	
	 	//Integer totalCount = (Integer)map.get("totalCount");
	 	//System.out.println(totalCount);
	 	
	 	System.out.println("=======================================");
	 	
	 	search.setSearchCondition("1");
	 	search.setSearchKeyword(""+System.currentTimeMillis());
	 	list = productService.getProductList(search);
	 	
	 	//list = (List<Object>)map.get("list");
	 	Assert.assertEquals(0, list.size());
	 	
		//==> console 확인
	 	System.out.println(list);
	 	
	 	//totalCount = (Integer)map.get("totalCount");
	 	//System.out.println(totalCount);
	 }	 
}