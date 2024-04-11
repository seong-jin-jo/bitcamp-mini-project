package com.model2.mvc.web.product;

import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
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
import com.model2.mvc.domain.ImagesVO;
import com.model2.mvc.domain.ProductVO;
import com.model2.mvc.domain.User;
import com.model2.mvc.service.image.ImageService;
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
	
	//AutoWired 추가로 해줘야함
	@Autowired
	@Qualifier("imageServiceImpl")
	private ImageService imageService;
	
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
		
		ImagesVO image = new ImagesVO();
		image.setImagesProd(product); // 조회를 위해 만든 도메인객체
		
		List<ImagesVO> images = imageService.getImagesList(image); // 리턴결과 image

		for(int i=0; i<images.size(); i++) {
			System.out.println(i+"번째"+" images 조회결과" +images.get(i).getImage());
		}
		
		//조회한 결과 'vo' 란 이름으로 얹어서 주기
		model.addAttribute("vo",product);
		model.addAttribute("images",images);
		
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
	
	//테스트용임 json form타입 등등
	@RequestMapping( value="addProductTest", method=RequestMethod.POST )
	public String addProductTest(
			@ModelAttribute ProductVO product, 
			//@RequestParam("singleFile") MultipartFile inputFileSingle,
			@RequestParam("multipleFile") MultipartFile[] inputFileMultiple) throws Exception{
		
		System.out.println(" <---------- 테스트중입니다 -------->");
		System.out.println(" product/addProductTest : POST" );
		System.out.println(product);
		//System.out.println(inputFileSingle);
		System.out.println(inputFileMultiple);
		
		return "forward:/product/addProductConfirm.jsp"; 
	}
			
	@RequestMapping( value="addProduct", method=RequestMethod.POST )
	public String addProduct(
			@ModelAttribute ProductVO product, 
			@RequestParam("singleFile") MultipartFile inputFileSingle,
			@RequestParam("multipleFile") MultipartFile[] inputFileMultiple) throws Exception {
		
		System.out.println("\n /product/addProduct : POST" );
		//Business Logic
		
		product.setProTranCode("판매중");
		//Date result = product.getManuDate();
		
		String rawManuDate = product.getManuDate().replaceAll("-", "");
		product.setManuDate(rawManuDate);
		
		//////////////////////////////
		// multipart 이미지 파일 등록시도중 (single, multiple)
		//////////////////////////////
		System.out.println("inputFileSingle => " + inputFileSingle);
		System.out.println("inputFileMultiple => " + inputFileMultiple);
		
		productService.addProduct(product); // query 수정해서 Product 삽입할때 prodNo 시퀀스넣은게 자바객체로 반환시키도록했음
		
		// 1. RequestParam 으로 input 의 name이 singleFile 이라는 애를 데려와서 MultipartFile[] 형식으로 받음
		// @RequestParam("singleFile") MultipartFile[] singleFile 
		// 파일들이 inputFile 매개변수(?)로 전달된다고함
		
		// MultipartFile 은 단일파일, MultipartFile 은 여러파일에 대한 데이터 타입
	
		
//다중파일로 왔을때 저장 (imageFile 테이블 하나 만들어서 join 시켜야되는듯)
		if(inputFileMultiple != null && inputFileMultiple.length > 0) {

			for(int i=0; i<inputFileMultiple.length; i++) {
				
				MultipartFile multipartMultiple = inputFileMultiple[i];
				System.out.println("multi 로 이만큼 옴 =>" + inputFileMultiple.length);
				System.out.println("\n" +i+ "번째 multi로 왔을때임 => " + multipartMultiple);
				
				//2. 바이너리 형태로(?)inputStream 을 읽고 file 로 변환해서 서버 로컬에 저장함
				String fileName2 = UUID.randomUUID().toString(); //랜덤한 파일 이름 생성 
				String filePath2 = "C:\\Users\\bitcamp\\Desktop\\Spring\\workspace\\mini-project-240404\\src\\main\\webapp\\images\\" + File.separatorChar + "fileInputStorage"; //파일경로 생성
						
				// 방법1
				multipartMultiple.transferTo(new File(filePath2, fileName2));
	
				// 방법2
				// 경도 : multipart.getBytes(); 이걸 IO 써서 파일로 저장했음
			
				// 방법3
				// FileUtils.copyInputStreamToFile(multipart.getInputStream(), new File(filePath, fileName));
				// Apache Commons IO 라이브러리의 FileUtils 클래스에 있는 메서드
				// InputStream에서 파일로의 복사를 단순화하고 간단하게 처리
				// spring commons-io 있었지만 2이상버젼에서 쓸수있는함수라해서 걔네 가져오다 우선순위 문제있어서 그냥 안씀
	
				System.out.println("multipartMultiple 받은 파일이름 =>"+multipartMultiple.getOriginalFilename());//파일이름 확인해보기
				System.out.println("multipart form 의 파라미터를 반환하는 getName 여기다가 마킹해주면 되지않을까 썸네일용 =>" + multipartMultiple.getName());
				System.out.println("multipart api 에 getResource 도 있어서 찍어봄 =>" + multipartMultiple.getResource());
				//3. product DB 저장, image DB 저장

				ImagesVO imagesMultiple = new ImagesVO();
				imagesMultiple.setImage(fileName2); // images 테이블 IMAGE 에 저장
				imagesMultiple.setImagesProd(product); // images 테이블 PROD_NO 에 저장
				imagesMultiple.setIsThumbnail(0); // images 테이블 IS_THUMBNAIL 에 저장
				
				System.out.println(imagesMultiple.toString());
				imageService.addImage(imagesMultiple);
			}
		
		}		
		
		
		//단일파일로 왔을때 image 테이블에 prodNo 엮어서저장
		if(inputFileSingle != null && !inputFileSingle.isEmpty()) {
			MultipartFile multipartSingle = inputFileSingle;
			System.out.println("\n single 로 왔을때" + multipartSingle);
			
			String fileName = UUID.randomUUID().toString(); //랜덤한 파일 이름 생성 
			String filePath = "C:\\Users\\bitcamp\\Desktop\\Spring\\workspace\\mini-project-240404\\src\\main\\webapp\\images\\" + File.separatorChar + "fileInputStorage"; //파일경로 생성
			multipartSingle.transferTo(new File(filePath, fileName));
			
			System.out.println("multipartSingle 받은 파일이름 =>"+multipartSingle.getOriginalFilename());//받은 파일이름 확인해보기	
			System.out.println("multipartSingle 저장된 파일 경로 및 파일 이름 " +  filePath + File.separatorChar + fileName);
			//product.addImageFile(multipartSingle.getOriginalFilename()); // 단일로 받은것저장
			
			ImagesVO images = new ImagesVO();
			images.setImage(fileName); // images 테이블 IMAGE 에 저장
			images.setImagesProd(product); // images 테이블 PROD_NO 에 저장
			images.setIsThumbnail(0); // images 테이블 IS_THUMBNAIL 에 저장
			System.out.println(images.toString());
			
			imageService.addImage(images);
			}
		//4. 조회시 파일이름에 맞는 애들을 불러와 띄움
		
		// 끝	
		
		return "forward:/product/addProductConfirm.jsp";
	}
	
	//수정 화면 들어가는
	@RequestMapping( value="updateProduct", method=RequestMethod.GET )
	public ModelAndView updateProduct(@RequestParam("prodNo") int prodNo) throws Exception {
		
		
		System.out.println("/product/updateProduct : GET");
		System.out.println(prodNo);
		
		ProductVO product = productService.findProduct(prodNo);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("ProductVO", product);
		
		ImagesVO image = new ImagesVO();
		image.setImagesProd(product); // 조회를 위해 만든 도메인객체
		
		List<ImagesVO> images = imageService.getImagesList(image); // 리턴결과 image

		for(int i=0; i<images.size(); i++) {
			System.out.println(i+"번째"+" images 조회결과" +images.get(i).getImage());
		}
	
		modelAndView.addObject("images", images);
		
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
