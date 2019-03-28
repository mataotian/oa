package com.qf.oa.realm;

import com.qf.oa.entity.SysUser;
import com.qf.oa.service.ISysUserService;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

public class MyRealm extends AuthorizingRealm{
    @Autowired
    private ISysUserService sysUserService;
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        return null;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        UsernamePasswordToken token= (UsernamePasswordToken) authenticationToken;
        String username = token.getUsername();
        SysUser sysUser=sysUserService.getUserByUserName(username);
        if(sysUser!=null){
            ByteSource byteSource=ByteSource.Util.bytes(username);
            return new SimpleAuthenticationInfo(sysUser,sysUser.getUserPassword(),byteSource,this.getName());
        }
        return null;
    }
}
