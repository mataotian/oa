package com.qf.oa.service;

import com.github.pagehelper.PageInfo;
import com.qf.oa.common.Page;
import com.qf.oa.common.SysResult;
import com.qf.oa.entity.SysMenu;

import java.util.List;

public interface ISysMenuService extends IBaseService<SysMenu>{
    PageInfo<SysMenu> selectByCondition(Page page, SysMenu sysMenu);

    List<SysMenu> getMenuList();

    SysResult updateByIsPublish(Long id);

    SysResult updateBatchDel(List<Long> idList);

    PageInfo<SysMenu> queryAuthMenu(Long roleId, Page page);

    PageInfo<SysMenu> queryNoAuthMenu(String menuName, Long roleId, Page page);
}
