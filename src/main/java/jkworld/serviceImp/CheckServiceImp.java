package jkworld.serviceImp;

import com.alibaba.fastjson.JSONObject;

import jkworld.dao.UserMapper;
import jkworld.pojo.User;
import jkworld.service.CheckService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Service(value="checkServiceImp")
public class CheckServiceImp implements CheckService {

	@Autowired
	private UserMapper userMapper;
	
	@Override
	public boolean checkUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub

		
		String username =request.getParameter("username");
		
		//查找用户名是否已经被注册
		User selectUserByName = userMapper.selectUserByName(username);
		
		//返回json数据
		JSONObject json = new JSONObject();

		if(selectUserByName != null){
			json.put("serverState","0");
			response.getWriter().print(json);
		}else{
			json.put("serverState","1");
			response.getWriter().print(json);
		}
		
		return false;
	}

}
