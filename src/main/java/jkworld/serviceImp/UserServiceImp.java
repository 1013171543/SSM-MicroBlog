package jkworld.serviceImp;

import com.alibaba.fastjson.JSONObject;
import eu.bitwalker.useragentutils.UserAgent;
import jkworld.dao.LoginLogMapper;
import jkworld.dao.UserMapper;
import jkworld.pojo.LoginLog;
import jkworld.pojo.User;
import jkworld.service.UserService;
import jkworld.util.IpUtils;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
import java.util.Random;

/**
 * Demo ReplyServiceImp
 *
 * @author root
 * @date 2019/9/10
 */
@Service(value = "userServiceImp")
public class UserServiceImp implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private LoginLogMapper loginLogMapper;

    @Override
    public boolean Login(HttpServletRequest request, HttpServletResponse response) throws IOException {

        //获取用户名密码和记住我状态
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String remenber = request.getParameter("remenber");

        System.out.println(username);
        System.out.println(password);
        System.out.println(remenber);


        //shiro获取当前用户
        Subject currentUser = SecurityUtils.getSubject();
        Session session = SecurityUtils.getSubject().getSession();

        if(!currentUser.isAuthenticated()){

            UsernamePasswordToken token = new UsernamePasswordToken(username,password);
            //判断用户是否是记住我状态
            if(remenber.equals("true")){
                token.setRememberMe(true);
            }else {
                token.setRememberMe(false);
            }
            try {
                currentUser.login(token);
            }catch (AuthenticationException ae){
                System.out.println(ae.getMessage());

                //登录失败,返回客户端失败码
                JSONObject json = new JSONObject();
                json.put("serverState",0);
                response.getWriter().print(json);
                return false;
            }
        }
        //查询用户之后放入session域中
        User user = userMapper.selectUserByName(username);
        session.setAttribute("user", user);

        userMapper.addUserCredit(user.getId());

        //获取真实ip地址
        String ip= IpUtils.getRemortIP(request);
        UserAgent userAgent = UserAgent.parseUserAgentString(request.getHeader("User-Agent"));
        //获取用户的浏览器名
        String userbrowser = userAgent.getBrowser().toString();

        LoginLog log=new LoginLog();
        log.setDevice(userbrowser);
        log.setIp(ip);
        log.setUserId(user.getId());
        log.setLoginTime(new Date());
        //写入数据库
        int insert = loginLogMapper.insert(log);


        //登录成功
        JSONObject json = new JSONObject();
        json.put("serverState",1);
        response.getWriter().print(json);
        return true;
    }

    @Override
    public ModelAndView quit(HttpServletRequest request, ModelAndView model) throws Exception {
        // TODO Auto-generated method stub

        HttpSession session = request.getSession();
        session.removeAttribute("user");
        //返回首页
        model.setViewName("redirect:/");
        return model;
    }

    @Override
    public ModelAndView userInfo(@PathVariable("user.id") Integer id)
            throws Exception {

        ModelAndView model = new ModelAndView();
        model.setViewName("user_info");

        Session session = SecurityUtils.getSubject().getSession();

        //要查看的用户，可能是用户本人，也可能是其他人
        User user = userMapper.selectByPrimaryKey(id);

        //登陆的用户
        User mainUser = (User)session.getAttribute("user");
        //对比ID,如果与登陆的id不相同，则不能修改信息
        if(mainUser == null){
            model.addObject("flag",false);
            model.addObject("userInfo",user);
            return model;
        }
        if(id.compareTo(mainUser.getId()) !=0 ){
            model.addObject("flag",false);
        }


        model.addObject("userInfo",user);

        return model;
    }

    @Override
    public ModelAndView updateUser(HttpServletRequest request) throws Exception {
        // TODO Auto-generated method stub
        Integer id = Integer.parseInt(request.getParameter("id"));
        String avatar = "   resources/images/"+request.getParameter("photo");
        String phone_num = request.getParameter("tel");
        String email = request.getParameter("email");

        //this photo maybe is null，because use mybatis's dynamic sql
        int resultState = userMapper.updateUserById(id, phone_num, avatar, email);

        ModelAndView model = new ModelAndView("user_info");
        User selectByPrimaryKey = userMapper.selectByPrimaryKey(id);
        model.addObject("userInfo",selectByPrimaryKey);

        return model;
    }


    @Override
    public ModelAndView addUser(HttpServletRequest request, HttpServletResponse response, ModelAndView model, User user) throws Exception {
        //用户注册
        User selectUserByName = userMapper.selectUserByName(user.getUsername());
        if(selectUserByName!=null){

            ModelAndView returnModel = new ModelAndView("regist");
            returnModel.addObject("registState",1);
            return returnModel;
        }

        //随机给用户生成一张头像
        Random rand=new Random();
        int randomNum=rand.nextInt(10)+1;
        String avatarUrl="resources/images/avatar-default-"+randomNum+".png";
        //用户类型
        Byte userType = new Byte("0");


        //将获取到的用户密码MD5一把，保证数据安全性
        user.setPassword(DigestUtils.md5Hex(user.getPassword()));
        //添加用户的注册时间,mybatis会自动更正时间格式
        user.setCreateTime(new Date());
        user.setUpdateTime(new Date());
        user.setAvatar(avatarUrl);
        user.setType(userType);
        //初始化用户积分
        user.setCredit(0);

        //如果注册成功跳转到首页地址
        int insert = userMapper.insert(user);
        if(insert==1){
            model.setViewName("redirect:/forword/toLogin");
        }else{

        }
        return model;

    }
}
