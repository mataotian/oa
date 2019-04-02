package com.qf.oa.controller;

import com.github.pagehelper.PageInfo;
import com.google.gson.Gson;
import com.qf.oa.common.Page;
import com.qf.oa.common.SysResult;
import com.qf.oa.entity.SysOrg;
import com.qf.oa.service.ISysOrgService;
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
@RequestMapping("/sysOrg")
public class SysOrgController {
    @Autowired
    private ISysOrgService sysOrgService;
    @RequestMapping("/page")
    public String getPage(Page page, Model model){
        PageInfo<SysOrg> pageInfo=sysOrgService.getList(page);

        model.addAttribute("pageInfo",pageInfo);
        return "org/org_list";
    }
    @RequestMapping("/delete")
    @ResponseBody
    public SysResult delete(Long id){
        SysResult sysResult=sysOrgService.updateById(id);
        return sysResult;
    }
    @RequestMapping("/toAdd")
    public String toAdd(){
        return "org/org_add";
    }
    @RequestMapping("/orgAdd")
    @ResponseBody
    public SysResult orgAdd(SysOrg sysOrg){
        SysResult sysResult=new SysResult();
        int count=sysOrgService.insertSelective(sysOrg);
        if(count>0){
            sysResult.setResult(true);
            sysResult.setData("添加成功！");
        }else{
            sysResult.setResult(false);
            sysResult.setData("添加失败！");
        }
        System.out.println(sysResult.getData());
        return sysResult;
    }
    @RequestMapping("/orgList")
    @ResponseBody
    public List<SysOrg> getList(){
        List<SysOrg> orgList= sysOrgService.getOrgList();
        return orgList;
    }

    @RequestMapping("/toUpdate/{id}")
    public String toUpdate(@PathVariable Long id,Model model){
        SysOrg sysOrg= sysOrgService.selectByPrimaryKey(id);
        model.addAttribute("sysOrg",sysOrg);
        return "org/org_update";
    }

    @RequestMapping("/update")
    @ResponseBody
    public SysResult update(SysOrg sysOrg){
        SysResult sysResult=new SysResult();
        int count=sysOrgService.updateByPrimaryKeySelective(sysOrg);
        if(count>0){
            sysResult.setResult(true);
            sysResult.setData("修改成功！");
        }else{
            sysResult.setResult(false);
            sysResult.setData("修改失败！");
        }
        return sysResult;
    }
    @RequestMapping("/batchDel")
    @ResponseBody
    public SysResult batchDel(@RequestParam List<Long> idList){
        SysResult sysResult=sysOrgService.updateBatchDelByIdList(idList);
        System.out.println(sysResult.getData());
        return sysResult;
    }
    @RequestMapping("/selectByCondition")
    public String selectByCondition(SysOrg sysOrg,Page page,Model model){
        PageInfo<SysOrg> pageInfo=sysOrgService.selectByCondition(sysOrg,page);
        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("sysOrg",sysOrg);
        model.addAttribute("url","sysOrg/selectByCondition");
        Map<String,Object> map=new HashMap<>();
        map.put("orgName",sysOrg.getOrgName());
        map.put("orgParentName",sysOrg.getOrgParentName());
        map.put("flag",sysOrg.getFlag());
        Gson gson=new Gson();
        model.addAttribute("params",gson.toJson(map));
        return "org/org_list";
    }


}
