<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/3/19
  Time: 11:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <base href="<%=request.getContextPath()+"/"%>">
    <link href="css/H-ui.min.css" rel="stylesheet" type="text/css" />
    <link href="css/H-ui.admin.css" rel="stylesheet" type="text/css" />
    <link href="lib/icheck/icheck.css" rel="stylesheet" type="text/css" />
    <link href="lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="lib/zTree/v3/css/zTreeStyle/zTreeStyle.css" type="text/css">
    <title>Title</title>
</head>
<body id="purchaseBody">
<div class="pd-20">
    <form action="purchase/add" method="post" class="form form-horizontal" id="form-purchase-add">
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>采购主题：</label>
            <div class="formControls col-5">
                <input type="text" class="input-text" id="title" name="title" datatype="*2-50" nullmsg="采购主题不能为空">
            </div>
            <div class="col-4"> </div>
        </div>
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>采购金额：</label>
            <div class="formControls col-5">
                <input type="text" class="input-text" id="money" name="money" datatype="*2-50" nullmsg="金额不能为空">
            </div>
            <div class="col-4"> </div>
        </div>
        <div class="row cl">
            <label class="form-label col-3">描述：</label>
            <div class="formControls col-5">
                <textarea name="content" class="textarea"  placeholder="说点什么...100个字符以内" dragonfly="true" onKeyUp="textarealength(this,100)"></textarea>
                <p class="textarea-numberbar"><em class="textarea-length">0</em>/100</p>
            </div>
            <div class="col-4"> </div>
        </div>
        <div class="row cl">
            <div class="col-9 col-offset-3">
                <input class="btn btn-primary radius"  type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
            </div>
        </div>
    </form>
    <table class="table table-border table-bordered table-hover table-bg">
        <thead>
        <tr>
            <th scope="col" colspan="7">采购管理</th>
        </tr>
        <tr class="text-c">
            <th width="25"><input type="checkbox"  value="" name=""></th>
            <th width="40">采购ID</th>
            <th width="80">采购主题</th>
            <th width="80">采购金额</th>
            <th>采购创建时间</th>
            <th width="200">描述</th>
            <th width="70">操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${pageInfo.list}" var="purchase">
            <tr class="text-c">

                <td><input type="checkbox" class="batchDel" value="${purchase.id}" name=""></td>
                <td>${purchase.id}</td>
                <td>${purchase.title}</td>
                <td>${purchase.money}</td>
                <td><fmt:formatDate value="${purchase.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </td>
                <td>${purchase.content}</td>
                <td class="f-14">
                    <a title="编辑" href="javascript:;" onclick="admin_purchase_edit('采购编辑','sysOrg/toUpdate/${purchase.id}','1')" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a>
                    <a title="删除" href="javascript:;" onclick="purchase_del(this,${purchase.id})" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <jsp:include page="/application/common/page.jsp">
        <jsp:param name="bodyId" value="purchaseBody"></jsp:param>
    </jsp:include>
</div>
<div id="orgParentTree" style="display: none">
    <ul id="zTree" class="ztree"></ul>
</div>
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="lib/icheck/jquery.icheck.min.js"></script>
<script type="text/javascript" src="lib/Validform/5.3.2/Validform.min.js"></script>
<script type="text/javascript" src="lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="js/H-ui.js"></script>
<script type="text/javascript" src="js/H-ui.admin.js"></script>
<script type="text/javascript" src="lib/zTree/v3/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript">

    $(function(){
        $('.skin-minimal input').iCheck({
            checkboxClass: 'icheckbox-blue',
            radioClass: 'iradio-blue',
            increaseArea: '20%'
        });

        $("#form-purchase-add").Validform({
            tiptype:2,
            callback:function(form){
                layer.alert(data.data ,{icon:icon},function () {
                    var index = parent.layer.getFrameIndex(window.name);
                    parent.$('.btn-refresh').click();
                    parent.layer.close(index);
                    parent.location.reload();
                });
            }
        })
    })

</script>
</body>
</html>
