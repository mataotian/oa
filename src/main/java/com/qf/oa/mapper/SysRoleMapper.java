package com.qf.oa.mapper;

import com.qf.oa.dao.IBaseDao;
import com.qf.oa.entity.SysRole;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SysRoleMapper extends IBaseDao{

    List<SysRole> getList();

    int updateBatchDelByIdList(List<Long> idList);

    List<SysRole> selectByCondition(SysRole sysRole);

    int batchAddUser(@Param("idList") List<Long> idList,@Param("roleId") Long roleId);

    int delUserFromRole(@Param("userId") Long userId,@Param("roleId") Long roleId);

    int batchAddMenu(@Param("idList") List<Long> idList,@Param("roleId") Long roleId);

    int delRoleMenu(@Param("menuId") Long menuId,@Param("roleId") Long roleId);
}