package com.qf.oa.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.qf.oa.common.Page;
import com.qf.oa.common.SysResult;
import com.qf.oa.entity.SysRole;
import com.qf.oa.mapper.SysRoleMapper;
import com.qf.oa.service.ISysRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class SysRoleServiceImpl extends BaseServiceImpl<SysRole> implements ISysRoleService{
    @Autowired
    private SysRoleMapper roleMapper;
    @Override
    public SysRoleMapper getDao() {
        return roleMapper;
    }

    @Override
    public PageInfo<SysRole> getPage(Page page) {

        PageHelper.startPage(page.getCurrentPage(),page.getPageSize());
        List<SysRole> list=roleMapper.getList();
        PageInfo<SysRole> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public int updateFlagById(Long id) {
        SysRole sysRole=new SysRole();
        sysRole.setRoleId(id);
        sysRole.setFlag(false);
        int count=roleMapper.updateByPrimaryKeySelective(sysRole);
        return count;
    }

    @Override
    public SysResult updateBatchDelByIdList(List<Long> idList) {
        SysResult sysResult=new SysResult();
        int count=roleMapper.updateBatchDelByIdList(idList);
        if(count>0){
            sysResult.setResult(false);
        }else{
            sysResult.setResult(true);
        }
        return sysResult;
    }

    @Override
    public PageInfo<SysRole> selectByCondition(SysRole sysRole, Page page) {
        PageHelper.startPage(page.getCurrentPage(),page.getPageSize());
        List<SysRole> list=roleMapper.selectByCondition(sysRole);
        PageInfo<SysRole> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public List<SysRole> queryAllRole() {
        List<SysRole> roleList=roleMapper.getList();
        return roleList;
    }

    @Override
    public SysResult batchAddUser(List<Long> idList, Long roleId) {
        SysResult sysResult=new SysResult();
        int count=roleMapper.batchAddUser(idList,roleId);
        if(count>0){
            sysResult.setResult(true);
        }else{
            sysResult.setResult(false);
        }
        return sysResult;
    }

    @Override
    public SysResult delUserFromRole(Long userId, Long roleId) {
        SysResult sysResult=new SysResult();
        int count=roleMapper.delUserFromRole(userId,roleId);
        if(count>0){
            sysResult.setResult(true);
        }else{
            sysResult.setResult(false);
        }
        return sysResult;
    }

    @Override
    public SysResult batchAddMenu(List<Long> idList, Long roleId) {
        SysResult sysResult=new SysResult();
        int count=roleMapper.batchAddMenu(idList,roleId);
        if(count>0){
            sysResult.setResult(true);
        }else{
            sysResult.setResult(false);
        }
        return sysResult;
    }

    @Override
    public SysResult delRoleMenu(Long menuId, Long roleId) {
        SysResult sysResult=new SysResult();
        int count=roleMapper.delRoleMenu(menuId,roleId);
        if(count>0){
            sysResult.setResult(true);
        }else{
            sysResult.setResult(false);
        }
        return sysResult;
    }
}
