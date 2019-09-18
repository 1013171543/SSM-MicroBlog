package jkworld.serviceImp;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jkworld.dao.ReplyMapper;
import jkworld.dao.TopicMapper;
import jkworld.dao.UserMapper;
import jkworld.pojo.Reply;
import jkworld.pojo.Topic;
import jkworld.pojo.User;
import jkworld.service.TopicService;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

/**
 * Demo ReplyServiceImp
 *
 * @author root
 * @date 2019/9/10
 */
@Service(value = "topicServiceImp")
public class TopicServiceImp implements TopicService {

    @Autowired
    private TopicMapper topicMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private ReplyMapper replyMapper;


    @Override
    public ModelAndView processIndex() {

        //封装用于返回控制层渲染信息
        ModelAndView model = new ModelAndView("category");

        //使用shiro的session会话管理
        Session session = SecurityUtils.getSubject().getSession();

        //查询所有的帖子和用户信息
        List<Topic> topics = topicMapper.listTopicsAndUsers();

        //获取热帖
        List<Topic> listMostCommentsTopics = topicMapper.listMostCommentsTopics();

        //统计帖子总数
        int topicsNum = topicMapper.getTopicsNum();

        //查询用户总数
        int userCount = userMapper.getUserCount();

        JSONObject json = new JSONObject();
        json.put("topics", topics);

        System.out.println("topic size = "+topics.size());
        System.out.println("topicsNum ="+topicsNum);
        System.out.println("userCount="+userCount);

        User user=(User) session.getAttribute("user");

        session.setAttribute("usersNum", userCount);
        session.setAttribute("topicsNum", topicsNum);
        session.setAttribute("hostTopics", listMostCommentsTopics);

        model.addObject("topics",topics);
        model.addObject("topicsNum",topicsNum);
        model.addObject("userCount",userCount);
        model.addObject("user",user);
        model.addObject("hostTopics",listMostCommentsTopics);

        return model;
    }

    @Override
    public ModelAndView processDetails(HttpServletRequest request)
            throws Exception {

        Integer id =  Integer.parseInt(request.getParameter("topicId"));
        //增加话题点击量
        topicMapper.clickAddOne(id);

        //获取主题，对于有对象关系的映射，不要使用mybatis逆向工程生成的方法
        Topic topic = topicMapper.selectTopicById(id);

        //抓取全部评论
        List<Reply> replies = replyMapper.getRepliesOfTopic(id);

        //统计评论数
        int repliesNum = replyMapper.getRepliesNum(id);



        List<Topic> listMostCommentsTopics = topicMapper.listMostCommentsTopics();


        ModelAndView model = new ModelAndView("detail");
        model.addObject("topic",topic);
        model.addObject("replies",replies);
        model.addObject("repliesNum",repliesNum);

        model.addObject("hostTopics",listMostCommentsTopics);
        return model;
    }

    @Override
    public ModelAndView addTopic(HttpServletRequest request) throws Exception {
        // TODO Auto-generated method stub

        Topic topic = new Topic();
        System.err.println("before="+topic.getId());

        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String tabId = request.getParameter("tab");
        Integer userId = Integer.parseInt(request.getParameter("userId"));
        //初始化topic
        topic.setContent(content);
        topic.setTitle(title);
        topic.setUserId(userId);
        Byte byt = new Byte(tabId);
        topic.setTabId(byt);
        topic.setClick(1);
        topic.setCreateTime(new Date());
        topic.setUpdateTime(new Date());

        //创建帖子后，进入帖子，需要返回创建帖子后的帖子ID



        topicMapper.insertTopicReturnId(topic);
        System.err.println("after="+topic.getId());

        Integer id = topic.getId();
        ModelAndView model = new ModelAndView("redirect:/");
        return model;
    }

    @Override
    public ModelAndView UserTopics(HttpServletRequest request) throws Exception {
        // TODO Auto-generated method stub
        //返回的视图
        ModelAndView model = new ModelAndView("myTopic");
        Integer starPage = Integer.parseInt(request.getParameter("starPage"));
        int userId = Integer.parseInt(request.getParameter("id"));

        //设置起始页面和每页数据
        PageHelper.startPage(starPage,5);
        //查询要分页的数据
        List<Topic> userTopics = topicMapper.selectUserTopic(userId);

        //封装到pageInfo下
        PageInfo pageInfo = new PageInfo<>(userTopics);
        model.addObject("pageInfo",pageInfo);

        model.addObject("userTopics", userTopics);

        return model;
    }

}
