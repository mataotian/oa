package com.qf.oa.service;

import com.github.pagehelper.PageInfo;
import com.qf.oa.common.Page;
import com.qf.oa.entity.SysMenu;
import com.qf.oa.entity.SysUser;

import java.util.List;

public interface ISysUserService extends IBaseService<SysUser> {
    PageInfo<SysUser> selectByCondition(SysUser sysUser, Page page);

    int updateById(Long id);

    int updateBatchDelIdList(List<Long> idList);

    PageInfo<SysUser> queryAuthUser(Long roleId, Page page);

    PageInfo<SysUser> queryNoAuthUser(String userName,Long roleId,Page page);

    SysUser getUserById(SysUser sysUser);

    List<SysMenu> getMenuListByUserId(Long userId);

    SysUser getUserByUserName(String username);
}
