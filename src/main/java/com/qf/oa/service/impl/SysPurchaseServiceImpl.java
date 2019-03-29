package com.qf.oa.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.qf.oa.common.Page;
import com.qf.oa.dao.IBaseDao;
import com.qf.oa.entity.SysPurchase;
import com.qf.oa.mapper.SysPurchaseMapper;
import com.qf.oa.service.ISysPurchaseService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.form.TaskFormData;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class SysPurchaseServiceImpl extends BaseServiceImpl<SysPurchase> implements ISysPurchaseService {
    @Autowired
    private SysPurchaseMapper sysPurchaseMapper;
    @Autowired
    private RuntimeService runtimeService;
    @Autowired
    private TaskService taskService;
    @Override
    public IBaseDao<SysPurchase> getDao() {
        return sysPurchaseMapper;
    }

    @Override
    public void addPurchaseAndStartProcess(SysPurchase sysPurchase) {
        sysPurchaseMapper.insertSelective(sysPurchase);
        Map<String,Object> map=new HashMap<>();
        map.put("money",sysPurchase.getMoney());
        map.put("administrationId",2);
        map.put("managerId",3);
        map.put("financialId",4);
        map.put("currentId",sysPurchase.getUserId());
        String businessKey=sysPurchase.getId().toString();
        runtimeService.startProcessInstanceByKey("purchase",businessKey,map);
        System.out.println("启动任务成功!");
    }

    @Override
    public PageInfo<SysPurchase> selectAll(Page page) {
        PageHelper.startPage(page.getCurrentPage(),page.getPageSize());
        List<SysPurchase> list=sysPurchaseMapper.selectAll();
        PageInfo<SysPurchase> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public SysPurchase addPurchaseAndComplete(Long id) {
        Task task = taskService.createTaskQuery().taskId(id.toString()).singleResult();
        String processInstanceId=task.getProcessInstanceId();
        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId.toString()).singleResult();
        String businessKey=processInstance.getBusinessKey();
        Long purchaseId=Long.parseLong(businessKey);
        SysPurchase sysPurchase=sysPurchaseMapper.selectByPrimaryKey(purchaseId);
        return sysPurchase;
    }

    @Override
    public void updateSysPurchaseAndComplete(Long taskId, SysPurchase sysPurchase) {
        sysPurchaseMapper.updateByPrimaryKeySelective(sysPurchase);
        Map<String,Object> map=new HashMap<>();
        map.put("flag",true);
        map.put("money",sysPurchase.getMoney());
        taskService.complete(taskId.toString(),map);
    }


}
