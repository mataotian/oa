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
    <form action="purchase/reply" method="post" class="form form-horizontal" id="form-purchase-add">
        <h3>采购申请详情</h3>
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>采购主题：</label>
            <div class="formControls col-5">
                <input type="text" class="input-text" id="title" name="title" value="${purchase.title}">
            </div>
            <div class="col-4"> </div>
        </div>
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>采购金额：</label>
            <div class="formControls col-5">
                <input type="text" class="input-text" id="money" name="money" value="${purchase.money}">
            </div>
            <div class="col-4"> </div>
        </div>
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>描述：</label>
            <div class="formControls col-5">
                <input type="text" class="input-text" name="content" value="${purchase.content}">
            </div>
            <div class="col-4"> </div>
        </div>
        <%--<h3>采购审批</h3>--%>
        <%--<div class="row cl">--%>
            <%--<label class="form-label col-3"><span class="c-red">*</span>意见：</label>--%>
            <%--<div class="formControls col-5">--%>
                <%--<input type="text" class="input-text" id="content" name="content" >--%>
            <%--</div>--%>
            <%--<div class="col-4"> </div>--%>
        <%--</div>--%>
        <div class="row cl">
            <div class="col-9 col-offset-3">
                <input type="hidden" name="id" value="${purchase.id}"/>
                <input type="hidden" name="taskId" value="${taskId}"/>
                <input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;重新申请&nbsp;&nbsp;">
            </div>
        </div>
    </form>

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
               return true;
            }
        })
    })
    function pass(result) {
        $("#state").val(result);
    }
</script>
</body>
</html>
