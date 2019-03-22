package com.qf.oa.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.qf.oa.common.Page;
import com.qf.oa.common.SysResult;
import com.qf.oa.entity.SysOrg;
import com.qf.oa.mapper.SysOrgMapper;
import com.qf.oa.service.ISysOrgService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SysOrgServiceImpl extends BaseServiceImpl<SysOrg> implements ISysOrgService{
    @Autowired
    private SysOrgMapper mapper;

    public SysOrgMapper getDao(){
        return mapper;
    }

    @Override
    public PageInfo<SysOrg> getList(Page page) {

        PageHelper.startPage(page.getCurrentPage(),page.getPageSize());
        List<SysOrg> list= mapper.getList();
        PageInfo<SysOrg> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public List<SysOrg> getOrgList() {
        List<SysOrg> list= mapper.getList();
        return list;
    }

    @Override
    public SysResult updateById(Long id) {
        SysResult sysResult=new SysResult();
        int count=mapper.queryParentById(id);
        if(count>0){
            sysResult.setResult(false);
        }else{
            SysOrg sysOrg=new SysOrg();
            sysOrg.setOrgId(id);
            sysOrg.setFlag(false);
            mapper.updateByPrimaryKeySelective(sysOrg);
            sysResult.setResult(true);
        }
        return sysResult;
    }

    @Override
    public SysResult updateBatchDelByIdList(List<Long> idList) {
        SysResult sysResult=new SysResult();
        int count=mapper.queryParentByIdList(idList);
        if(count>0){
            sysResult.setResult(false);
        }else{
            mapper.updateBatchDelByIdList(idList);
            sysResult.setResult(true);
        }
        return sysResult;
    }

    @Override
    public PageInfo<SysOrg> selectByCondition(SysOrg sysOrg, Page page) {
        PageHelper.startPage(page.getCurrentPage(),page.getPageSize());
        List<SysOrg> list=mapper.selectByCondition(sysOrg);
        PageInfo<SysOrg> pageInfo=new PageInfo<>(list);
        return pageInfo;
    }
}
