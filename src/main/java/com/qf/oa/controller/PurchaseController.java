package com.qf.oa.controller;

import com.github.pagehelper.PageInfo;
import com.qf.oa.common.Page;
import com.qf.oa.common.Page_info;
import com.qf.oa.entity.SysAudit;
import com.qf.oa.entity.SysPurchase;
import com.qf.oa.entity.SysUser;
import com.qf.oa.service.ISysAuditService;
import com.qf.oa.service.ISysPurchaseService;
import org.activiti.engine.FormService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.form.TaskFormData;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Map;

@Controller
@RequestMapping("/purchase")
public class PurchaseController {

    @Autowired
    private ISysPurchaseService sysPurchaseService;
    @Autowired
    private ISysAuditService sysAuditService;
    @Autowired
    private FormService formService;
    @Autowired
    private TaskService taskService;
    @Autowired
    private RuntimeService runtimeService;
    @RequestMapping("/toAdd")
    public String toAdd(Page page,Model model){
        PageInfo<SysPurchase> pageInfo=sysPurchaseService.selectAll(page);
        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("url","purchase/toAdd");
        return "purchase/purchase_add";
    }

    @RequestMapping("/add")
    public String add(Page page, SysPurchase sysPurchase, Model model){
        Subject subject = SecurityUtils.getSubject();
        SysUser sysUser = (SysUser)subject.getPrincipal();
        sysPurchase.setUserId(sysUser.getUserId());
        sysPurchase.setUserName(sysUser.getUserName());
        sysPurchaseService.addPurchaseAndStartProcess(sysPurchase);

        PageInfo<SysPurchase> pageInfo=sysPurchaseService.selectAll(page);
        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("url","purchase/add");
        return "purchase/purchase_add";
    }
    @RequestMapping("/toShenPi")
    public String toShenPi(Long id,Model model){
        TaskFormData taskFormData=formService.getTaskFormData(id.toString());
        String formKey = taskFormData.getFormKey();
        System.out.println(formKey);
        String jp=null;
        SysPurchase sysPurchase=sysPurchaseService.addPurchaseAndComplete(id);

        if("process/shenpi".equals(formKey)){
               model.addAttribute("purchase",sysPurchase);
               model.addAttribute("taskId",id);
             jp="task/task_shenpi";
        }else if("process/reply".equals(formKey)){
            model.addAttribute("purchase",sysPurchase);
            model.addAttribute("taskId",id);
             jp="task/task_reply";
        }
        return jp;
    }
    @RequestMapping("/shenpi")
    public String shenpi(Long taskId, Long purchaseId,SysAudit sysAudit){
        Subject subject = SecurityUtils.getSubject();
        SysUser sysUser= (SysUser) subject.getPrincipal();
        sysAudit.setUserId(sysUser.getUserId());
        sysAudit.setUserName(sysUser.getUserName());
        sysAudit.setPurchaseId(purchaseId);
        sysAuditService.addSysAuditAndComplete(taskId,sysAudit);
        return "task/task_list";
    }
    @RequestMapping("/reply")
    public String reply(Long taskId,SysPurchase sysPurchase){
        sysPurchaseService.updateSysPurchaseAndComplete(taskId,sysPurchase);
        System.out.println(sysPurchase.getId());
        System.out.println(sysPurchase.getTitle());
        System.out.println(sysPurchase.getMoney());
        System.out.println(sysPurchase.getContent());
        return "task/task_reply";
    }
}
