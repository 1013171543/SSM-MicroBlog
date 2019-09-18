package jkworld.dao;

import jkworld.pojo.Reply;
import org.apache.ibatis.annotations.Param;


import java.util.List;

public interface ReplyMapper {


    List<Reply> getRepliesOfTopic(Integer topicId);

    //获取评论数
    int getRepliesNum(Integer topicId);


    int insert(Reply record);
}