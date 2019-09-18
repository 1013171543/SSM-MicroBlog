package jkworld.dao;

import jkworld.pojo.User;
import org.apache.ibatis.annotations.Param;

public interface UserMapper {

    User selectByPrimaryKey(Integer id);

    // 查找用户名是否存在
    User selectUserByName(String username);
    //查找用户权限
    int selectUserPermissionByName(String username);

    int getUserCount();

    //增加用户积分
    void addUserCredit(Integer id);

    //修改用户信息
    int updateUserById(@Param("id") Integer id, @Param("phone_num") String phone_num, @Param("avatar") String avatar, @Param("email") String email);

    //add
    int insert(User record);
}