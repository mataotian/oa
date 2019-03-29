package com.qf.oa.service.impl;

import com.qf.oa.dao.IBaseDao;
import com.qf.oa.entity.SysAudit;
import com.qf.oa.mapper.SysAuditMapper;
import com.qf.oa.service.ISysAuditService;
import org.activiti.engine.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class SysAuditServiceImpl extends BaseServiceImpl<SysAudit> implements ISysAuditService {
    @Autowired
    private SysAuditMapper sysAuditMapper;
    @Autowired
    private TaskService taskService;
    @Override
    public IBaseDao<SysAudit> getDao() {
        return sysAuditMapper;
    }

    @Override
    public void addSysAuditAndComplete(Long taskId, SysAudit sysAudit) {
        sysAuditMapper.insertSelective(sysAudit);
        Map<String,Object> map=new HashMap<>();
        map.put("flag",sysAudit.getState());
        taskService.complete(taskId.toString(),map);
    }
}
