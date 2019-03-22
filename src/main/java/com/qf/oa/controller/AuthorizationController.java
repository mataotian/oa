package com.qf.oa.controller;

import com.github.pagehelper.PageInfo;
import com.google.gson.Gson;
import com.qf.oa.common.Page;
import com.qf.oa.entity.SysMenu;
import com.qf.oa.entity.SysRole;
import com.qf.oa.entity.SysUser;
import com.qf.oa.service.ISysMenuService;
import com.qf.oa.service.ISysRoleService;
import com.qf.oa.service.ISysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/authorization")
public class AuthorizationController {
    @Autowired
    private ISysRoleService sysRoleService;
    @Autowired
    private ISysMenuService sysMenuService;
    @Autowired
    private ISysUserService sysUserService;
    @RequestMapping("/authPage")
    public String authorizationPage(Model model){
        List<SysRole> roleList=sysRoleService.queryAllRole();
        model.addAttribute("roleList",roleList);
        return "authorization/authorization_list";
    }

    @RequestMapping("/queryAuthUser")
    public String queryAuthUser(Long roleId, Page page, Model model){
        PageInfo<SysUser> pageInfo=sysUserService.queryAuthUser(roleId,page);
        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("url","authorization/queryAuthUser");
        Map<String,Object> map=new HashMap<>();
        map.put("roleId",roleId);
        Gson gson=new Gson();
        model.addAttribute("params",gson.toJson(map));
        return "authorization/authorization_user_list";
    }
    @RequestMapping("/queryAuthMenu")
    public String queryAuthMenu(Long roleId, Page page, Model model){
        PageInfo<SysMenu> pageInfo=sysMenuService.queryAuthMenu(roleId,page);
        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("url","authorization/queryAuthMenu");
        Map<String,Object> map=new HashMap<>();
        map.put("roleId",roleId);
        Gson gson=new Gson();
        model.addAttribute("params",gson.toJson(map));
        return "authorization/authorization_menu_list";
    }
}
