package com.qf.oa.mapper;

import com.qf.oa.dao.IBaseDao;
import com.qf.oa.entity.SysUser;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SysUserMapper extends IBaseDao<SysUser>{

    List<SysUser> selectByCondition(SysUser sysUser);

    int updateBatchDelIdList(List<Long> idList);

    List<SysUser> queryAuthUser(Long roleId);

    List<SysUser> queryNoAuthUser(@Param("roleId") Long roleId,@Param("userName") String userName);
}