package com.qf.oa.controller;

import com.github.pagehelper.PageInfo;
import com.google.gson.Gson;
import com.qf.oa.common.Page;
import com.qf.oa.common.SysResult;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
    @RequestMapping("/queryNoAuthUser")
    public String queryNoAuthUser(String userName,Long roleId,Page page,Model model){
        PageInfo<SysUser> pageInfo=sysUserService.queryNoAuthUser(userName,roleId,page);
        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("url","authorization/queryNoAuthUser");
        model.addAttribute("roleId",roleId);
        model.addAttribute("userName",userName);
        Gson gson=new Gson();
        Map<String,Object> map=new HashMap<>();
        map.put("roleId",roleId);
        map.put("userName",userName);
        model.addAttribute("params",gson.toJson(map));
        return "authorization/authorization_addUser";
    }

    @RequestMapping("/batchAddUser")
    @ResponseBody
    public SysResult batchAddUser(@RequestParam List<Long> idList, Long roleId){
        return sysRoleService.batchAddUser(idList,roleId);
    }
    @RequestMapping("/delete")
    @ResponseBody
    public SysResult delete(Long userId,Long roleId){
        return sysRoleService.delUserFromRole(userId,roleId);
    }

    @RequestMapping("/queryNoAuthMenu")
    public String queryNoAuthMenu(String menuName,Long roleId,Page page,Model model){
        PageInfo<SysMenu> pageInfo=sysMenuService.queryNoAuthMenu(menuName,roleId,page);
        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("url","authorization/queryNoAuthMenu");
        model.addAttribute("menuName",menuName);
        model.addAttribute("roleId",roleId);
        Map<String,Object> map=new HashMap<>();
        map.put("menuName",menuName);
        map.put("roleId",roleId);
        Gson gson=new Gson();
        model.addAttribute("params",gson.toJson(map));
        return "authorization/authorization_addMenu";
    }
    @RequestMapping("/batchAddMenu")
    @ResponseBody
    public SysResult batchAddMenu(@RequestParam List<Long> idList,Long roleId){
        return sysRoleService.batchAddMenu(idList,roleId);
    }
    @RequestMapping("delRoleMenu")
    @ResponseBody
    public SysResult delRoleMenu(Long menuId,Long roleId){
        return sysRoleService.delRoleMenu(menuId,roleId);
    }
}
