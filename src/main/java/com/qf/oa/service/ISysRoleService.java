package com.qf.oa.service;

import com.github.pagehelper.PageInfo;
import com.qf.oa.common.Page;
import com.qf.oa.common.SysResult;
import com.qf.oa.entity.SysRole;

import java.util.List;

public interface ISysRoleService extends IBaseService<SysRole>{
    PageInfo<SysRole> getPage(Page page);

    int updateFlagById(Long id);

    SysResult updateBatchDelByIdList(List<Long> idList);

    PageInfo<SysRole> selectByCondition(SysRole sysRole, Page page);

    List<SysRole> queryAllRole();
}
