package com.qf.oa.service.impl;

import com.qf.oa.dao.IBaseDao;
import com.qf.oa.service.IBaseService;

public abstract class BaseServiceImpl<T> implements IBaseService<T>{

    public abstract IBaseDao<T> getDao();
    @Override
    public int deleteByPrimaryKey(Long orgId) {
        return getDao().deleteByPrimaryKey(orgId);
    }

    @Override
    public int insert(T t) {
        return getDao().insert(t);
    }

    @Override
    public int insertSelective(T t) {
        return getDao().insertSelective(t);
    }

    @Override
    public T selectByPrimaryKey(Long orgId) {
        return getDao().selectByPrimaryKey(orgId);
    }

    @Override
    public int updateByPrimaryKeySelective(T t) {
        return getDao().updateByPrimaryKeySelective(t);
    }

    @Override
    public int updateByPrimaryKey(T t) {
        return getDao().updateByPrimaryKey(t);
    }
}
