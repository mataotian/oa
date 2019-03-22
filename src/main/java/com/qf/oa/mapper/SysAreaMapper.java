package com.qf.oa.mapper;

import com.qf.oa.entity.SysArea;

public interface SysAreaMapper {
    int deleteByPrimaryKey(Long areaId);

    int insert(SysArea record);

    int insertSelective(SysArea record);

    SysArea selectByPrimaryKey(Long areaId);

    int updateByPrimaryKeySelective(SysArea record);

    int updateByPrimaryKey(SysArea record);
}