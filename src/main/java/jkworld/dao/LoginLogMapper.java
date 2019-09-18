package jkworld.dao;

import jkworld.pojo.LoginLog;
import org.apache.ibatis.annotations.Param;


import java.util.List;

public interface LoginLogMapper {

    int insert(LoginLog record);

}