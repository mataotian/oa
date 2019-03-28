package com.qf.oa.controller;

import com.github.pagehelper.PageInfo;
import com.google.gson.Gson;
import com.qf.oa.common.Page;
import com.qf.oa.common.SysResult;
import com.qf.oa.entity.SysMenu;
import com.qf.oa.entity.SysUser;
import com.qf.oa.service.ISysUserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/sysUser")
public class SysUserController {
    @Autowired
    private ISysUserService sysUserService;

    @RequestMapping("/login")
    public String losgin(){
        return "login";
    }
    @RequestMapping("/checkLogin")
    public String checkLogin(SysUser sysUser,Model model){
        Subject currentUser = SecurityUtils.getSubject();
        if(!currentUser.isAuthenticated()){
            UsernamePasswordToken token=new UsernamePasswordToken(sysUser.getUserName(),sysUser.getUserPassword());
            try{
                currentUser.login(token);
            }catch (AuthenticationException e){
                System.out.println("认证失败");
                return "login";
            }

        }
        SysUser user= (SysUser) currentUser.getPrincipal();
        List<SysMenu> menuList=sysUserService.getMenuListByUserId(user.getUserId());
        model.addAttribute("menuList",menuList);
        return "index";
    }
//    @RequestMapping("/checkLogin")
//    public String checkLogin(SysUser sysUser,Model model){
//        SysUser currentUser=sysUserService.getUserById(sysUser);
//        if(currentUser==null){
//            return "login";
//        }
//        List<SysMenu> menuList=sysUserService.getMenuListByUserId(currentUser.getUserId());
//        model.addAttribute("menuList",menuList);
//        return "index";
//    }
    @RequestMapping("/selectByCondition")
    public String selectByCondition(Page page, SysUser sysUser, Model model){
        PageInfo<SysUser> pageInfo=sysUserService.selectByCondition(sysUser,page);
        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("sysUser",sysUser);
        model.addAttribute("url","sysUser/selectByCondition");
        Map<String,Object> map=new HashMap<>();
        map.put("userName",sysUser.getUserName());
        map.put("flag",sysUser.getFlag());
        Gson gson=new Gson();
        model.addAttribute("params",gson.toJson(map));
        return "user/user_list";
    }
    @RequestMapping("/toAdd")
    public String toAdd(){
        return "user/user_add";
    }
    @RequestMapping("/userAdd")
    @ResponseBody
    public SysResult userAdd(SysUser sysUser){
        SysResult sysResult=new SysResult();
        int count=sysUserService.insertSelective(sysUser);
        if(count>0){
            sysResult.setResult(true);
        }else{
            sysResult.setResult(false);
        }
        return sysResult;
    }

    @RequestMapping("/toUpdate/{id}")
    public String toUpdate(@PathVariable Long id,Model model){
        SysUser sysUser=sysUserService.selectByPrimaryKey(id);
        model.addAttribute("sysUser",sysUser);
        return "user/user_update";
    }
    @RequestMapping("/userUpdate")
    @ResponseBody
    public SysResult update(SysUser sysUser){
        SysResult sysResult=new SysResult();
        int count=sysUserService.updateByPrimaryKeySelective(sysUser);
        if(count>0){
            sysResult.setResult(true);
            sysResult.setData("修改成功!");
        }else{
            sysResult.setResult(false);
            sysResult.setData("修改失败...");
        }
        return sysResult;
    }
    @RequestMapping("/delete")
    @ResponseBody
    public SysResult delete(Long id){
        SysResult sysResult=new SysResult();
        int count=sysUserService.updateById(id);
        if(count>0){
            sysResult.setResult(true);
            sysResult.setData("删除成功!");
        }else{
            sysResult.setResult(false);
            sysResult.setData("删除失败...");
        }
        return sysResult;
    }
    @RequestMapping("/batchDel")
    @ResponseBody
    public SysResult userBatchDel(List<Long> idList){
        SysResult sysResult=new SysResult();
        int count=sysUserService.updateBatchDelIdList(idList);
        if(count>0){
            sysResult.setResult(true);
            sysResult.setData("删除成功!");
        }else{
            sysResult.setResult(false);
            sysResult.setData("删除失败..");
        }
        return sysResult;
    }
}
