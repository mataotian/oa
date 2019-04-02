<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/3/19
  Time: 11:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <form action="" method="post" class="form form-horizontal" id="form-user-add">
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>用户名称：</label>
            <div class="formControls col-5">
                <input type="text" class="input-text" value="" placeholder="" id="userName" name="userName" datatype="*2-16" nullmsg="用户名称不能为空">
            </div>
            <div class="col-4"> </div>
        </div>
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>密码：</label>
            <div class="formControls col-5">
                <input type="text" class="input-text" value="" placeholder="" id="userPassword" name="userPassword" datatype="*2-16" nullmsg="用户密码不能为空">
            </div>
            <div class="col-4"> </div>
        </div>
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>组织名称：</label>
            <div class="formControls col-5">
                <input type="text" id="orgParentName" name="" value="" readonly="readonly" class="input-text" datatype="*2-16" nullmsg="组织名不能为空">
                <input type="hidden" id="orgParentId" name="orgId" value="1"/>
                <input class="btn btn-primary radius" type="button" value="选择组织" onclick="selectOrgParent()"/>
            </div>
            <div class="col-4"> </div>
        </div>
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>联系方式：</label>
            <div class="formControls col-5">
                <input type="text" class="input-text" value="" placeholder="" id="phone" name="phone" datatype="m" errormsg="手机号错误" nullmsg="用户联系方式不能为空">
            </div>
            <div class="col-4"> </div>
        </div>
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>用户邮箱：</label>
            <div class="formControls col-5">
                <input type="text" class="input-text" value="" placeholder="" id="email" name="email" datatype="*2-16" nullmsg="用户邮箱不能为空">
            </div>
            <div class="col-4"> </div>
        </div>
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red"></span>生日：</label>
            <div class="formControls col-5">
                <input type="text" class="input-text Wdate" value="" placeholder="" id="birthday" name="birthday" onclick="WdatePicker({skin:'whyGreen',maxDate:'%y-%M-%d'})"/>
            </div>
            <div class="col-4"> </div>
        </div>
        <div class="row cl">
            <label class="form-label col-3">是否有效：</label>
            <div class="formControls col-5"> <span class="select-box" style="width:150px;">
				<select class="select" name="flag" id="flag" size="1">
					<option value="0">否</option>
					<option value="1">是</option>
				</select>
				</span> </div>
        </div>
        <%--<div class="row cl">--%>
            <%--<label class="form-label col-3">所在城市：</label>--%>
            <%--<div class="formControls col-5" id="distpicker">--%>
                <%--<span  class="select-box" style="width:95px;"><select  name="provinceName" class="select" size="1" id="province"></select></span>--%>
                <%--<!-- province -->--%>
                <%--<span class="select-box" style="width:95px;"><select name="cityName" class="select" size="1"  id="city"></select></span><!-- city -->--%>
                <%--<span class="select-box" style="width:95px;"><select name="contryName" class="select" size="1"   id="district"></select></span>--%>
            <%--</div>--%>
        <%--</div>--%>
        <div class="row cl">
            <label class="form-label col-3">个人简介：</label>
            <div class="formControls col-5">
                <textarea name="introduce" value="" cols="" rows="" class="textarea"  placeholder="说点什么...100个字符以内" dragonfly="true" onKeyUp="textarealength(this,100)"></textarea>
                <p class="textarea-numberbar"><em class="textarea-length">0</em>/100</p>
            </div>
            <div class="col-4"> </div>
        </div>
        <div class="row cl">
            <div class="col-9 col-offset-3">
                <input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;添加&nbsp;&nbsp;">
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
<script type="text/javascript" src="/lib/distpicker/distpicker.data.js"></script>
<script type="text/javascript" src="/lib/distpicker/distpicker.js"></script>
<script type="text/javascript" src="/lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="lib/zTree/v3/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript">

    $(function(){
        $('.skin-minimal input').iCheck({
            checkboxClass: 'icheckbox-blue',
            radioClass: 'iradio-blue',
            increaseArea: '20%'
        });

        // $("#distpicker").distpicker({
        //     province: "--所在省--",
        //     city: "--所在市--",
        //     district: "--所在区--",
        // });

        $("#form-user-add").Validform({
            tiptype:2,
            callback:function(form){

                $.ajax({
                    type:"POST",
                    url:"sysUser/userAdd",
                    data:$("#form-user-add").serialize(),
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
    function selectOrgParent() {
        var index = layer.open({
            title: "选择组织",
            type: 1,
            content: $("#orgParentTree"),
            area: ['500px', '300px'],
            btn: "确定"
        });
        $.ajax({
            type:"POST",
            url:"sysOrg/orgList",
            success:function(data){
                console.log(data)
                var zTreeObj;
                // zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
                var setting = {
                    data: {
                        simpleData: {
                            enable: true,
                            idKey: "orgId",
                            pIdKey: "orgParentId"
                        },
                        key: {
                            name: "orgName"
                        }
                    },
                    callback: {
                        onClick: function(event, treeId, treeNode) {
                            $("#orgParentName").val(treeNode.orgName);
                            $("#orgParentId").val(treeNode.orgId);
                        }
                    }
                };
                var zNodes = data;
                $(document).ready(function(){
                    zTreeObj = $.fn.zTree.init($("#zTree"), setting, zNodes);
                });
            }
        })
    }

</script>
</body>
</html>
