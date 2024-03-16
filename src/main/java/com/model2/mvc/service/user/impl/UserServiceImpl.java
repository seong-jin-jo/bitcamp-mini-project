package com.model2.mvc.service.user.impl;

import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.domain.User;
import com.model2.mvc.service.user.UserDao;
import com.model2.mvc.service.user.UserService;

@Service("userService닷!")
public class UserServiceImpl implements UserService{
	
	///Field
	@Autowired
	@Qualifier("userDao닷!")
	private UserDao userDAO;
	
	////***** spring 에서 setter 주입하럭다 해도 setter 메소드는 존재해야 userDao DI 할 수 있음
	public void setUserDao(UserDao userDAO) {
		this.userDAO = userDAO;
	}
	
	public UserServiceImpl() {
		 System.out.println(this.getClass());
		 System.out.println("[UserServiceImpl] userDAO =>" + userDAO);
		//DAO 주입으로 대쳬?
		//userDAO=new UserDao(); 
	}

	public void addUser(User userVO) throws Exception {
		userDAO.insertUser(userVO);
	}

	public User loginUser(User userVO) throws Exception {
			User dbUser=userDAO.findUser(userVO.getUserId());

			if(! dbUser.getPassword().equals(userVO.getPassword()))
				throw new Exception("로그인에 실패했습니다.");
			
			return dbUser;
	}

	public User getUser(String userId) throws Exception {
		return userDAO.findUser(userId);
	}

	public Map<String,Object> getUserList(Search search) throws Exception {
		List<User> list= userDAO.getUserList(search);
		int totalCount = userDAO.getTotalCount(search);
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

	public void updateUser(User userVO) throws Exception {
		System.out.println("updateUser 드간다");
		userDAO.updateUser(userVO);
	}

	public boolean checkDuplication(String userId) throws Exception {
		boolean result=true;
		User userVO=userDAO.findUser(userId);
		if(userVO != null) {
			result=false;
		}
		return result;
	}
}