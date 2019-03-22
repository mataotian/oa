<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/3/19
  Time: 11:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<body>
<div class="pd-20">
    <form action="" method="post" class="form form-horizontal" id="form-user-update">
        <input type="hidden" name="userId" value="${sysUser.userId}"/>
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>用户名称：</label>
            <div class="formControls col-5">
                <input type="text" class="input-text" value="${sysUser.userName}" placeholder="" id="userName" name="userName" datatype="*2-16" nullmsg="用户名称不能为空">
            </div>
            <div class="col-4"> </div>
        </div>
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>用户密码：</label>
            <div class="formControls col-5">
                <input type="text" class="input-text" value="${sysUser.userPassword}" placeholder="" id="userPassword" name="userPassword" datatype="*2-16" nullmsg="用户密码不能为空">
            </div>
            <div class="col-4"> </div>
        </div>
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>联系方式：</label>
            <div class="formControls col-5">
                <input type="text" class="input-text" value="${sysUser.phone}" placeholder="" id="phone" name="phone" datatype="*2-16" nullmsg="用户联系方式不能为空">
            </div>
            <div class="col-4"> </div>
        </div>
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>用户邮箱：</label>
            <div class="formControls col-5">
                <input type="text" class="input-text" value="${sysUser.email}" placeholder="" id="email" name="email" datatype="*2-16" nullmsg="用户邮箱不能为空">
            </div>
            <div class="col-4"> </div>
        </div>
        <div class="row cl">
            <label class="form-label col-3">是否有效：</label>
            <div class="formControls col-5"> <span class="select-box" style="width:150px;">
				<select class="select" name="flag" id="flag" size="1">
					<c:choose>
                        <c:when test="${sysUser.flag}">
                            <option value="0">否</option>
                            <option value="1" selected="selected">是</option>
                        </c:when>
                        <c:otherwise>
                            <option value="0" selected="selected">否</option>
                            <option value="1">是</option>
                        </c:otherwise>
                    </c:choose>
				</select>
				</span> </div>
        </div>

        <div class="row cl">
            <label class="form-label col-3">个人简介：</label>
            <div class="formControls col-5">
                <textarea name="introduce" value="" cols="" rows="" class="textarea"  placeholder="说点什么...100个字符以内" dragonfly="true" onKeyUp="textarealength(this,100)">
                    ${sysUser.introduce}
                </textarea>
                <p class="textarea-numberbar"><em class="textarea-length">0</em>/100</p>
            </div>
            <div class="col-4"> </div>
        </div>
        <div class="row cl">
            <div class="col-9 col-offset-3">
                <input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;修改&nbsp;&nbsp;">
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

        $("#form-user-update").Validform({
            tiptype:2,
            callback:function(form){

                $.ajax({
                    type:"POST",
                    url:"sysUser/userUpdate",
                    data:$("#form-user-update").serialize(),
                    success : function(data){
                        var icon;
                        if(data.result){
                            icon=6;
                        }else{
                            icon=5;
                        }
                        layer.alert(data.data ,{icon:icon},function () {
                            var index = parent.layer.getFrameIndex(window.name);
                            parent.$('.btn-refresh').click();
                            parent.layer.close(index);
                            parent.location.reload();
                        });
                    }
                })
               return false;
            }
        })
    })


</script>
</body>
</html>
