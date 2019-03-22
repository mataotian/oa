package com.qf.oa.dao;


import com.qf.oa.entity.SysRole;

import java.util.List;

public interface IBaseDao<T>{
    int deleteByPrimaryKey(Long orgId);

    int insert(T t);

    int insertSelective(T t);

    T selectByPrimaryKey(Long orgId);

    int updateByPrimaryKeySelective(T t);

    int updateByPrimaryKey(T t);

}
