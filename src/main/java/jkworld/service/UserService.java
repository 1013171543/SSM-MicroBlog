package jkworld.service;

import jkworld.pojo.User;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Demo ReplyService
 *
 * @author root
 * @date 2019/9/10
 */
public interface UserService {
    //使用json方式登录,所以使用request,response
    public boolean Login(HttpServletRequest request, HttpServletResponse response) throws IOException;
    //退出登陆
    ModelAndView quit(HttpServletRequest request, ModelAndView model) throws Exception;
    //用户详情
    ModelAndView userInfo(@PathVariable("user.id") Integer id) throws Exception;
    //用户更新
    ModelAndView updateUser(HttpServletRequest request) throws Exception;


    //用户注册
    ModelAndView addUser(HttpServletRequest request, HttpServletResponse response, ModelAndView model, User user) throws Exception;


}
