package com.qf.oa.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.google.gson.Gson;
import com.qf.oa.common.Page;
import com.qf.oa.common.Page_info;

import com.qf.oa.entity.SysUser;
import org.activiti.engine.TaskService;

import org.activiti.engine.task.Task;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import java.util.List;


@Controller
@RequestMapping("/task")
public class TaskController {


    @Autowired
    private TaskService taskService;


    @RequestMapping("/taskList")
    public String getTask(Page page, Model model){
        //PageHelper.startPage(page.getCurrentPage(),page.getPageSize());
        Subject subject = SecurityUtils.getSubject();
        SysUser sysUser= (SysUser) subject.getPrincipal();
        Integer startIndex=(page.getCurrentPage()-1)*page.getPageSize();
        List<Task> taskList = taskService.createTaskQuery().taskAssignee(sysUser.getUserId().toString()).listPage(startIndex,page.getPageSize());
        List<Task> taskList1 = taskService.createTaskQuery().taskAssignee(sysUser.getUserId().toString()).list();
        //PageInfo<Task> pageInfo=new PageInfo<>(taskList);
        page.setList(taskList);
        Page_info pageInfo=new Page_info();
        pageInfo.setPageNum(page.getCurrentPage());
        pageInfo.setPageSize(page.getPageSize());
        pageInfo.setTotal(taskList1.size());
        pageInfo.setList(page.getList());

        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("url","task/taskList");
        return "task/task_list";
    }

}
