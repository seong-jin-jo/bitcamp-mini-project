package com.model2.mvc.web.user;

import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.domain.User;
import com.model2.mvc.service.user.UserService;


// 일단 두달전 자바시작해서 
// 오늘 여기까지 해해가지고 
// 스프링 군기는 한번 잡은거같애 
// 근데 삭삭 잘할라면 하반기는돼야될듯

@Controller
@RequestMapping("/user/*")
public class UserController {
	////////////Business logic UserService DI/////////////////////
	///Field

	@Autowired
	@Qualifier("userService닷!")
	private UserService userService;
	///Constructor
	public UserController() {
		System.out.println(this.getClass()+"ㅋ");
	}
	
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	@RequestMapping( value="addUser", method=RequestMethod.GET )
	public String addUser( @ModelAttribute("user") User user ) throws Exception {

		System.out.println("/user/addUserView : GET");
		
		//Business Logic
		//userService.addUser(user);
		
		return "redirect:/user/addUserView.jsp";
	}
	
	@RequestMapping( value="checkDuplication", method=RequestMethod.POST )
	public String checkDuplication( @RequestParam("userId") String userId , Model model ) throws Exception{
		
		System.out.println("/user/checkDuplication : POST");
		//Business Logic
		boolean result=userService.checkDuplication(userId);
		// Model 과 View 연결
		model.addAttribute("result", new Boolean(result));
		model.addAttribute("userId", userId);

		return "forward:/user/checkDuplication.jsp";
	}
	
	//@RequestMapping("/getUser.do")
	@RequestMapping( value="getUser", method=RequestMethod.GET )
	public String getUser( @RequestParam("userId") String userId , Model model ) throws Exception {
		
		System.out.println("/user/getUser : GET");
		System.out.println(userId);
		//Business Logic
		User user = userService.getUser(userId);
		// Model 과 View 연결
		model.addAttribute("user", user);
		
		return "forward:/user/getUser.jsp";
	}
	
	@RequestMapping( value="listUser" )
	public String listUser( @ModelAttribute("search") Search search, Model model , HttpServletRequest request) throws Exception {

		System.out.println("/user/listUser");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}	
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map = userService.getUserList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("listUser 조회결과 : "+map);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/user/listUser.jsp";
		
	}
	
	@RequestMapping( value="loginView", method=RequestMethod.GET)
	public String loginView() throws Exception{
		
		return "redirect:/user/loginView.jsp";
	}
	
	@RequestMapping( value="login", method=RequestMethod.POST )
	public String login(@ModelAttribute("user") User user , HttpSession session ) throws Exception{
		
		System.out.println("/user/login");
		//Business Logic
		User dbUser=userService.getUser(user.getUserId());
			
		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
		}
		
		System.out.println("로그인 완료. 세션상태 => "+session.getAttribute("user"));
		
		return "redirect:/index.jsp";
	}
	
	@RequestMapping( value="logout", method=RequestMethod.GET )
	public ModelAndView logout(HttpSession session) {
		System.out.println("/user/logout");

		//로그인 정보 삭제
		session.removeAttribute("user");

		//클라에 전달할 메세지 생성
		//String message = "아이디 패스워드 3자 이상 입력하세요";

		//모델/뷰 정보를 갖는 모델앤뷰 생성
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/index.jsp");
		//modelAndView.addObject("message", message);

		System.out.println("logout할 때 index.jsp 가라고 포워딩했는데 왜안가노");
		return modelAndView;
	}//logout method
	
	//user 를 model 에 안태웠는데 어떻게 전달이 돼지??
	//회원정보에서 수정 누르면 들어오는 곳. 수정화면으로넘어감
	@RequestMapping( value="updateUser", method=RequestMethod.GET )
	public ModelAndView updateuserView(@RequestParam("userId") String userId, Model model) throws Exception{
		
		// 수정 버튼을 눌렀을때 수정가능하게 하는 JSP 띄우는
		System.out.println("/user/updateUserView");
		
		// System.out.println("updateUserView.do"+userId); //user21,user21
		
		
		User user = userService.getUser(userId);
		
		ModelAndView modelAndView = new ModelAndView();
		//modelAndView.addObject("user",user);
		modelAndView.setViewName("forward:/user/updateUser.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping( value="updateUser", method=RequestMethod.POST )
	public ModelAndView updateUser(@ModelAttribute("user") User user) throws Exception {
		System.out.println("/user/updateUser");
		System.out.println(user);

		// 수정 버튼을 눌렀을때 DB에 컨펌하고 최신 user정보 띄우는
		userService.updateUser(user);
		
		ModelAndView modelAndView = new ModelAndView();
		//modelAndView.addObject("userId", user.getUserId()); //모델정보
		modelAndView.setViewName("redirect:/user/getUser?userId="+user.getUserId()); //VIEW정보
		
		return modelAndView;
	}
	
	/////////////////////////////
	/////////////////////////////
	/////////////////////////////
	
	//네비게이션
	@RequestMapping( value = "logon")
	public ModelAndView logon(){
		
		System.out.println("/user/logon : 시작");

		//클라에 전달할 메세지 생성
		String message = "아이디 패스워드 3자이상 입력하세요";

		//모델/뷰 정보를 갖는 모델앤뷰 생성
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/user/logon.jsp");
		modelAndView.addObject("message", message);

		System.out.println("logon.do : 종료");

		return modelAndView;
	}//logon method

	//네비게이션
	@RequestMapping( value = "home")
	public ModelAndView home(HttpSession session) {
		System.out.println("/user/home : 시작");

		//클라에 전달할 메세지 생성
		String message = "WELCOME";

		//모델/뷰 정보를 갖는 모델앤뷰 생성
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/user/home.jsp");
		modelAndView.addObject("message", message);

		System.out.println("home.do : 종료");

		return modelAndView;
	}//home method

	//네비게이션
	@RequestMapping(value="/logonAction.do",method= RequestMethod.GET)
	public ModelAndView logonAction(){

		System.out.println("/user/logonAction : 시작");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:/logon.do");
		System.out.println("logonAction.do GET: 종료");

		return modelAndView;
	}//logonAction GET method

	//비지니스로직수행과 네비게이션@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@RequestMapping(value="/logonAction.do",method=RequestMethod.POST)
	public ModelAndView logonAction(@ModelAttribute("user") User user,
									HttpSession session) throws Exception {
		
		System.out.println("/user/logonAction : 시작");

		//컨트롤러 : 네비게이션
		String viewName = "forward:/user/logon.jsp";

		//컨트롤러: 비지니스 로직 처리
		//비지니스레이어의 DAO 생성 및 Method 호출
//		UserDao userDAO = new UserDAO();
//		userDAO.getUser(user);
		User returnUser = userService.getUser(user.getUserId());
		if(   returnUser.getPassword().equals(user.getPassword())) {
			returnUser.setActive(true);
			user = returnUser;
			
		}
		////////////////////////////////////////////////////////////////////
		
		if (user.isActive()) {
			viewName = "forward:/user/home.jsp";
			session.setAttribute("sessionUser", user);
		}
		System.out.println("action : " + viewName);//디버깅용

		//클라에 전달할 메세지 생성
		String message = null;
		if (viewName.equals("forward:/user/logon.jsp")) {
			message = "WELCOME입니다.";
		} else {
			message = "아이디 패스워드 3자이상 입력하세요";
		}//ELSE

		//모델/뷰 정보를 갖는 모델앤뷰 생성
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(viewName);
		modelAndView.addObject("message", message);

		System.out.println("logonAction.do POST : 종료");
		return modelAndView;
	}//logonAction POST method
	
}//CLASS
