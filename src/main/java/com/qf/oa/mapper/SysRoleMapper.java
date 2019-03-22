package com.qf.oa.mapper;

import com.qf.oa.dao.IBaseDao;
import com.qf.oa.entity.SysRole;

import java.util.List;

public interface SysRoleMapper extends IBaseDao{

    List<SysRole> getList();

    int updateBatchDelByIdList(List<Long> idList);

    List<SysRole> selectByCondition(SysRole sysRole);

}