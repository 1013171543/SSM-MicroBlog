package jkworld.controller;

import jkworld.dao.UserMapper;
import jkworld.pojo.User;
import jkworld.service.TopicService;
import jkworld.service.UserService;
import jkworld.service.VerificationService;
import jkworld.serviceImp.BasicFunctionService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


/**
 * Demo UserController
 *
 * @author root
 * @date 2019/9/7
 */
@Controller
public class UserController {

    @Resource(name = "userServiceImp")
    private UserService userService;
    @Autowired
    private UserMapper userMapper;

    @Resource(name ="verificationServiceImp")
    private VerificationService verificationService;

    @Resource(name = "basicFunctionService")
    private BasicFunctionService basicFunctionService;

    @Resource(name = "topicServiceImp")
    private TopicService topicService;

    //用户登录
    @RequestMapping("/user/login")
    public void login(HttpServletRequest request, HttpServletResponse response) throws IOException {
        userService.Login(request,response);
    }
    @RequestMapping("/user/userInfoid/{user.id}")
    public ModelAndView userInfo(@PathVariable("user.id") Integer id) throws Exception{
        ModelAndView returnModel = userService.userInfo(id);
        return returnModel;
    }

    @RequestMapping("/user/updateUser")
    public ModelAndView updateUser(HttpServletRequest request) throws Exception {

        ModelAndView model = userService.updateUser(request);
        return model;
    }

    @RequestMapping("/user/createImgToken")
    public void createImgToken(HttpServletRequest request, HttpServletResponse response) throws Exception{
        verificationService.verificateImgToken(request, response);
    }
    @RequestMapping("/user/createPhoneToken")
    public void createPhoneToken(HttpServletRequest request, HttpServletResponse response) throws Exception{
        //先验证图片验证码是否正确，如果正确才让发送短信
        if(verificationService.checkImgToken(request, response)){
            verificationService.verificatePhoneToken(request);
        }
    }
    @RequestMapping("/user/cutImg")
    public void cutImg(HttpServletRequest req, HttpServletResponse response, MultipartFile file) throws IllegalStateException, IOException {

        basicFunctionService.getStringFromStream(req, response,file);
    }

    @RequestMapping("/user/regist")
    public ModelAndView regist(HttpServletRequest request, HttpServletResponse response, ModelAndView model, User user) throws Exception{
        System.out.println("用户注册*******************************");

        //如果手机验证码没有通过，注册失败，返回注册页面
        String serverToken = (String)request.getSession().getAttribute("phoneToken");
        String clientToken = request.getParameter("phoneToken");
        if(serverToken==null || !serverToken.equals(clientToken)){
            ModelAndView falseModel = new ModelAndView("regist");
            falseModel.addObject("registState",0);

            return falseModel;
        }else{
            //用户的提交的密码通过MD5加密，写入数据库
            ModelAndView returnModel = userService.addUser(request,response,model, user);
            return returnModel;
        }

    }

    @RequestMapping("/user/myTopic")
    public ModelAndView myTopic(HttpServletRequest request) throws Exception {


        ModelAndView model = topicService.UserTopics(request);

        return model;
    }

}
