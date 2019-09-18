package jkworld.service;

import jkworld.pojo.Reply;
import org.springframework.web.servlet.ModelAndView;

/**
 * Demo ReplyService
 *
 * @author root
 * @date 2019/9/10
 */
public interface ReplyService {
    //增加评论
    ModelAndView addReply(Reply reply) throws Exception;
}
