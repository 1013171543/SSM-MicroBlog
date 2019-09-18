package jkworld.dao;

import jkworld.pojo.Topic;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TopicMapper {

    //返回话题与用户的多个实体类
    public List<Topic> listTopicsAndUsers();

    //获取主题总数
    public int getTopicsNum();

    //获取最热话题
    List<Topic>  listMostCommentsTopics();

    //点击量+1
    int clickAddOne(Integer id);
    //id查询
    Topic selectTopicById(Integer id);

    void insertTopicReturnId(Topic topic);

    List<Topic> listTopicsAndUsersOfTab(Integer tabId);

    List<Topic> selectUserTopic(Integer userId);

}