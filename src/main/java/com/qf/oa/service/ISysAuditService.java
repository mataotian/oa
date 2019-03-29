package com.qf.oa.service;

import com.qf.oa.entity.SysAudit;

public interface ISysAuditService extends IBaseService<SysAudit> {
    void addSysAuditAndComplete(Long taskId, SysAudit sysAudit);
}
