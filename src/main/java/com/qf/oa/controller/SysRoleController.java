package com.qf.oa.controller;

import com.github.pagehelper.PageInfo;
import com.google.gson.Gson;
import com.qf.oa.common.Page;
import com.qf.oa.common.SysResult;
import com.qf.oa.entity.SysRole;
import com.qf.oa.service.ISysRoleService;
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
@RequestMapping("/sysRole")
public class SysRoleController {

    @Autowired
    private ISysRoleService sysRoleService;
    @RequestMapping("/page")
    public String getPage(Page page, Model model){
        PageInfo<SysRole> pageRole= sysRoleService.getPage(page);
        model.addAttribute("pageInfo",pageRole);
        return "role/role_list";
    }
    @RequestMapping("/toAdd")
    public String toAdd(){
        return "role/role_add";
    }
    @RequestMapping("/roleAdd")
    public SysResult add(SysRole sysRole){
        SysResult sysResult=new SysResult();
        int count=sysRoleService.insertSelective(sysRole);
        if(count>0){
            sysResult.setResult(true);
            sysResult.setData("添加成功!");
        }else{
            sysResult.setResult(false);
            sysResult.setData("添加失败!");
        }
        System.out.println(sysResult.getData());
        return sysResult;
    }
    @RequestMapping("/toUpdate/{id}")
    public String toUpdate(@PathVariable Long id, Model model){
        SysRole sysRole=sysRoleService.selectByPrimaryKey(id);
        model.addAttribute("sysRole",sysRole);
        return "role/role_update";
    }
    @RequestMapping("/update")
    @ResponseBody
    public SysResult update(SysRole sysRole){
        SysResult sysResult=new SysResult();
        int count=sysRoleService.updateByPrimaryKeySelective(sysRole);
        if(count>0){
            sysResult.setResult(true);
            sysResult.setData("修改成功!");
        }else{
            sysResult.setResult(false);
            sysResult.setData("修改失败!");
        }
        return sysResult;
    }
    @RequestMapping("/delete")
    @ResponseBody
    public SysResult delete(Long id){
        SysResult sysResult=new SysResult();
        int count=sysRoleService.updateFlagById(id);
        if(count>0){
            sysResult.setResult(true);
            sysResult.setData("删除成功!");
        }else{
            sysResult.setResult(false);
            sysResult.setData("删除失败!");
        }
        return sysResult;
    }
    @RequestMapping("/batchDel")
    @ResponseBody
    public SysResult batchDel(@RequestParam List<Long> idList){
        SysResult sysResult=sysRoleService.updateBatchDelByIdList(idList);
        return sysResult;
    }
    @RequestMapping("/selectByCondition")
    public String selectByCondition(SysRole sysRole,Page page,Model model){
        PageInfo<SysRole> pageInfo=sysRoleService.selectByCondition(sysRole,page);
        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("sysRole",sysRole);
        model.addAttribute("url","sysRole/selectByCondition");
        Map<String,Object> map=new HashMap<>();
        map.put("roleName",sysRole.getRoleName());
        map.put("flag",sysRole.getFlag());
        Gson gson=new Gson();
        model.addAttribute("params",gson.toJson(map));
        return "role/role_list";
    }
}
