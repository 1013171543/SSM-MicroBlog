package jkworld.shiro;

import jkworld.dao.UserMapper;
import jkworld.pojo.User;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthenticatingRealm;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import java.rmi.activation.UnknownObjectException;
import java.util.HashSet;
import java.util.Set;

/**
 * Demo ShiroRealm
 *
 * @author root
 * @date 2019/9/8
 */
public class ShiroRealm extends AuthorizingRealm {

    @Autowired
    private UserMapper userMapper;

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {

        //强转为UsernamePasswordToken
        UsernamePasswordToken token = (UsernamePasswordToken) authenticationToken;

        //获取从控制层封装的用户名
        String username = token.getUsername();

        //查询数据库
        User user = userMapper.selectUserByName(username);

        //如果用户不存在,抛出无法识别用户异常
        if(user == null){
            throw new UnknownAccountException();
        }


        //封装从数据库获取的用户账户信息
        //username
        Object principal = user.getUsername();
        //password
        Object credentials = user.getPassword();
        //realm名称
        String realmName  = getName();
        SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(principal,credentials,realmName);

        return info;
    }


    //认证授权
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {

        //获取用户名称
        Object principal = principalCollection.getPrimaryPrincipal();
        //获取用户权限等级
        int i = userMapper.selectUserPermissionByName((String) principal);

        Set<String> roles = new HashSet();
        if(i == 0){

            //普通用户
            roles.add("user");
           }else{

            roles.add("user");
            roles.add("admin");
        }


        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo(roles);

        return info;
    }
}
