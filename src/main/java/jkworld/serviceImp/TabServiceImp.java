package jkworld.serviceImp;

import jkworld.dao.TabMapper;
import jkworld.dao.TopicMapper;
import jkworld.pojo.Tab;
import jkworld.pojo.Topic;
import jkworld.service.TabService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Demo ReplyService
 *
 * @author root
 * @date 2019/9/10
 */
@Service(value = "tabServiceImp")
public class TabServiceImp implements TabService {
    @Autowired
    private TabMapper tabMapper;
    @Autowired
    private TopicMapper topicMapper;

    @Override
    public ModelAndView getAllTabs() {
        // TODO Auto-generated method stub
        List<Tab> selectAllTabs = tabMapper.selectAllTabs();

        ModelAndView model = new ModelAndView("new");
        model.addObject("tabs", selectAllTabs);

        return model;
    }

    @Override
    public ModelAndView getByTabNameEn(String type) {
        // TODO Auto-generated method stub
        Tab tab = tabMapper.getByTabNameEn(type);


        System.out.println(tab);
        Integer tabId=tab.getId();
        ModelAndView model=new ModelAndView("category");

        //获取板块下的话题和用户
        List<Topic> listTopicsAndUsersOfTab = topicMapper.listTopicsAndUsersOfTab(tabId);

        model.addObject("topics", listTopicsAndUsersOfTab);
        model.addObject("tab", tab);

        return model;
    }

}
