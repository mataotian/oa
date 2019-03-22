package com.qf.oa.mapper;

import com.qf.oa.dao.IBaseDao;
import com.qf.oa.entity.SysMenu;

import java.util.List;

public interface SysMenuMapper extends IBaseDao<SysMenu>{

    List<SysMenu> selectByCondition(SysMenu sysMenu);

    List<SysMenu> getMenuList();

    int updateBatchDel(List<Long> idList);

    int queryMenuParentId(Long id);

    int queryMenuByIdList(List<Long> idList);

    List<SysMenu> queryAuthMenu(Long roleId);
}