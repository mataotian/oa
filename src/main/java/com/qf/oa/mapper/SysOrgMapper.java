package com.qf.oa.mapper;

import com.qf.oa.dao.IBaseDao;
import com.qf.oa.entity.SysOrg;

import java.util.List;

public interface SysOrgMapper extends IBaseDao<SysOrg>{

    List<SysOrg> getList();

    int queryParentById(Long orgId);

    int queryParentByIdList(List<Long> idList);

    void updateBatchDelByIdList(List<Long> idList);

    List<SysOrg> selectByCondition(SysOrg sysOrg);
}