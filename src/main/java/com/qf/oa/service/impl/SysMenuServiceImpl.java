package com.qf.oa.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.qf.oa.common.Page;
import com.qf.oa.common.SysResult;
import com.qf.oa.dao.IBaseDao;
import com.qf.oa.entity.SysMenu;
import com.qf.oa.mapper.SysMenuMapper;
import com.qf.oa.service.ISysMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SysMenuServiceImpl extends BaseServiceImpl<SysMenu> implements ISysMenuService{
    @Autowired
    private SysMenuMapper mapper;
    @Override
    public IBaseDao<SysMenu> getDao() {
        return mapper;
    }

    @Override
    public PageInfo<SysMenu> selectByCondition(Page page, SysMenu sysMenu) {
        PageHelper.startPage(page.getCurrentPage(),page.getPageSize());
        List<SysMenu> list=mapper.selectByCondition(sysMenu);
        PageInfo<SysMenu> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public List<SysMenu> getMenuList() {
        List<SysMenu> list=mapper.getMenuList();
        return list;
    }

    @Override
    public SysResult updateByIsPublish(Long id) {
        SysResult sysResult=new SysResult();
        int count=mapper.queryMenuParentId(id);
        if(count>0){
            sysResult.setResult(false);
            sysResult.setData("删除失败");
        }else{
            SysMenu sysMenu=mapper.selectByPrimaryKey(id);
            sysMenu.setIsPublish(false);
            mapper.updateByPrimaryKeySelective(sysMenu);
            sysResult.setResult(true);
            sysResult.setData("删除成功!");
        }
        return sysResult;
    }

    @Override
    public SysResult updateBatchDel(List<Long> idList) {
        SysResult sysResult=new SysResult();
        int count=mapper.queryMenuByIdList(idList);
        if(count>0){
            sysResult.setResult(false);
        }else{
            mapper.updateBatchDel(idList);
            sysResult.setResult(true);
        }
        return sysResult;
    }

    @Override
    public PageInfo<SysMenu> queryAuthMenu(Long roleId, Page page) {
        PageHelper.startPage(page.getCurrentPage(),page.getPageSize());
        List<SysMenu> list=mapper.queryAuthMenu(roleId);
        PageInfo<SysMenu> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }
}
