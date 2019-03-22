package com.qf.oa.entity;

import java.util.Date;

public class SysOrg {
    private Long orgId;

    private Long orgParentId;

    private String orgParentName;

    private String orgName;

    private String orgDesc;

    private Boolean flag;

    private Date createTime;

    private Date updateTime;

    public Long getOrgId() {
        return orgId;
    }

    public void setOrgId(Long orgId) {
        this.orgId = orgId;
    }

    public Long getOrgParentId() {
        return orgParentId;
    }

    public void setOrgParentId(Long orgParentId) {
        this.orgParentId = orgParentId;
    }

    public String getOrgParentName() {
        return orgParentName;
    }

    public void setOrgParentName(String orgParentName) {
        this.orgParentName = orgParentName == null ? null : orgParentName.trim();
    }

    public String getOrgName() {
        return orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName == null ? null : orgName.trim();
    }

    public String getOrgDesc() {
        return orgDesc;
    }

    public void setOrgDesc(String orgDesc) {
        this.orgDesc = orgDesc == null ? null : orgDesc.trim();
    }

    public Boolean getFlag() {
        return flag;
    }

    public void setFlag(Boolean flag) {
        this.flag = flag;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    @Override
    public String toString() {
        return "SysOrg{" +
                "orgId=" + orgId +
                ", orgParentId=" + orgParentId +
                ", orgParentName='" + orgParentName + '\'' +
                ", orgName='" + orgName + '\'' +
                ", orgDesc='" + orgDesc + '\'' +
                ", flag=" + flag +
                ", createTime=" + createTime +
                ", updateTime=" + updateTime +
                '}';
    }
}