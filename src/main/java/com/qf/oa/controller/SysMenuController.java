package com.qf.oa.controller;

import com.github.pagehelper.PageInfo;
import com.google.gson.Gson;
import com.qf.oa.common.Page;
import com.qf.oa.common.SysResult;
import com.qf.oa.entity.SysMenu;
import com.qf.oa.service.ISysMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/sysMenu")
public class SysMenuController {
    @Autowired
    private ISysMenuService sysMenuService;
    @RequestMapping("/selectByCondition")
    public String selectByCondition(Page page, SysMenu sysMenu, Model model){
        PageInfo<SysMenu> pageInfo=sysMenuService.selectByCondition(page,sysMenu);
        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("url","sysMenu/selectByCondition");
        model.addAttribute("sysMenu",sysMenu);
        Map<String,Object> map=new HashMap<>();
        map.put("menuName",sysMenu.getMenuName());
        map.put("isPublish",sysMenu.getIsPublish());
        Gson gson=new Gson();
        model.addAttribute("params",gson.toJson(map));
        return "menu/menu_list";
    }
    @RequestMapping("/toAdd")
    public String toAdd(){
        return "menu/menu_add";
    }
    @RequestMapping("/menuList")
    @ResponseBody
    public List<SysMenu> getList(){
        List<SysMenu> list=sysMenuService.getMenuList();
        return list;
    }
    @RequestMapping("/menuAdd")
    @ResponseBody
    public SysResult add(SysMenu sysMenu){
        SysResult sysResult=new SysResult();
        int count=sysMenuService.insertSelective(sysMenu);
        if(count>0){
            sysResult.setResult(true);
        }else{
            sysResult.setResult(false);
        }
        return sysResult;
    }
    @RequestMapping("/delete")
    @ResponseBody
    public SysResult delete(Long id){
        SysResult sysResult=sysMenuService.updateByIsPublish(id);
        return sysResult;
    }

    @RequestMapping("/batchDel")
    @ResponseBody
    public SysResult batchDel(@RequestParam List<Long> idList){
        SysResult sysResult=sysMenuService.updateBatchDel(idList);
        return sysResult;
    }
    @RequestMapping("/toUpdate/{id}")
    public String toUpdate(@PathVariable Long id,Model model){
        SysMenu sysMenu=sysMenuService.selectByPrimaryKey(id);
        model.addAttribute("sysMenu",sysMenu);
        return "menu/menu_update";
    }

    @RequestMapping("/update")
    @ResponseBody
    public SysResult update(SysMenu sysMenu){
        SysResult sysResult=new SysResult();
        int count=sysMenuService.updateByPrimaryKeySelective(sysMenu);
        if(count>0){
            sysResult.setResult(true);
        }else{
            sysResult.setResult(false);
        }
        return sysResult;
    }

}
