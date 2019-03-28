package com.qf.oa.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.qf.oa.common.Page;
import com.qf.oa.dao.IBaseDao;
import com.qf.oa.entity.SysMenu;
import com.qf.oa.entity.SysUser;
import com.qf.oa.mapper.SysUserMapper;
import com.qf.oa.service.ISysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SysUserServiceImpl extends BaseServiceImpl<SysUser> implements ISysUserService {

    @Autowired
    private SysUserMapper mapper;
    @Override
    public IBaseDao<SysUser> getDao() {
        return mapper;
    }

    @Override
    public PageInfo<SysUser> selectByCondition(SysUser sysUser, Page page) {
        PageHelper.startPage(page.getCurrentPage(),page.getPageSize());
        List<SysUser> list=mapper.selectByCondition(sysUser);
        PageInfo<SysUser> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public int updateById(Long id) {
        SysUser sysUser=mapper.selectByPrimaryKey(id);
        sysUser.setFlag(false);
        int count=mapper.updateByPrimaryKeySelective(sysUser);
        return count;
    }

    @Override
    public int updateBatchDelIdList(List<Long> idList) {
        int count=mapper.updateBatchDelIdList(idList);
        return count;
    }

    @Override
    public PageInfo<SysUser> queryAuthUser(Long roleId, Page page) {
        PageHelper.startPage(page.getCurrentPage(),page.getPageSize());
        List<SysUser> list=mapper.queryAuthUser(roleId);
        PageInfo<SysUser> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public PageInfo<SysUser> queryNoAuthUser(String userName,Long roleId,Page page) {
        PageHelper.startPage(page.getCurrentPage(),page.getPageSize());
        List<SysUser> list=mapper.queryNoAuthUser(roleId,userName);
        PageInfo<SysUser> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public SysUser getUserById(SysUser sysUser) {
        SysUser currentUser=mapper.getUserById(sysUser);
        if(sysUser.getUserPassword().equals(currentUser.getUserPassword())){
            return currentUser;
        }
        return null;
    }

    @Override
    public List<SysMenu> getMenuListByUserId(Long userId) {
        List<SysMenu> menuList=mapper.getMenuListByUserId(userId);
        return menuList;
    }

    @Override
    public SysUser getUserByUserName(String username) {
        return mapper.getUserByUserName(username);
    }
}
