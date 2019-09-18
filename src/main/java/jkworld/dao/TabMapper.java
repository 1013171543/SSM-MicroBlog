package jkworld.dao;

import jkworld.pojo.Tab;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TabMapper {

    //查找所有模块
    List<Tab> selectAllTabs();


    //分类模块
    Tab getByTabNameEn(String tabName);
}