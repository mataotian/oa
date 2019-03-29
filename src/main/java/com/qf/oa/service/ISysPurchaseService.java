package com.qf.oa.service;

import com.github.pagehelper.PageInfo;
import com.qf.oa.common.Page;
import com.qf.oa.entity.SysPurchase;

public interface ISysPurchaseService extends IBaseService<SysPurchase> {
    void addPurchaseAndStartProcess(SysPurchase sysPurchase);

    PageInfo<SysPurchase> selectAll(Page page);

    SysPurchase addPurchaseAndComplete(Long id);

    void updateSysPurchaseAndComplete(Long taskId, SysPurchase sysPurchase);
}
