<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/3/22
  Time: 10:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <base href="<%=request.getContextPath()+"/"%>">
    <link href="css/H-ui.min.css" rel="stylesheet" type="text/css" />
    <link href="css/H-ui.admin.css" rel="stylesheet" type="text/css" />
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <link href="lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 管理员管理 <span class="c-gray en">&gt;</span> 管理员列表 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="pd-20">
    <div class="text-c">
        <div class="row cl ">
            <div class="formControls col-6">
                角色:
                <select id="role">
                    <option value="-1">请选择</option>
                    <c:forEach items="${roleList}" var="role">
                        <option value="${role.roleId}">${role.roleName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="formControls col-6">
                类型：
                <select id="type">
                    <option value="-1">请选择</option>
                    <option value="1">用户</option>
                    <option value="2">菜单</option>
                </select>
            </div>
        </div>
        <div class="row cl">
            <div class="cl pd-5">
                <button type="button"
                        class="btn btn-success radius" id="query" name="">
                    <i class="Hui-iconfont">&#xe665;</i> 搜索
                </button>
            </div>
        </div>
    </div>
    <div class="cl pd-5 bg-1 bk-gray mt-20"> <span class="l"><a href="javascript:;" onclick="datadel()" class="btn btn-primary radius"><i class="Hui-iconfont">&#xe6e2;</i> 授权新角色</a>
        <a href="javascript:;" onclick="admin_add('添加管理员','admin-add.html','800','500')" class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i> 授权新菜单</a></span>
    </div>
    <table class="table table-border table-bordered table-bg" id="authorization">

    </table>
</div>
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript" src="lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="js/H-ui.js"></script>
<script type="text/javascript" src="js/H-ui.admin.js"></script>
<script type="text/javascript">

    $(function() {
        $("#query").click(function () {
            var role=$("#role").val();
            var type=$("#type").val();
            if(role==-1){
                layer.msg("请选择角色",{icon: 2, time: 2000});
                return;
            }else if(type==-1){
                layer.msg("请选择类型",{icon: 2, time: 2000});
                return;
            }

            if(type==1){
                $("#authorization").load("authorization/queryAuthUser",{"roleId":role});
            }else{
                $("#authorization").load("authorization/queryAuthMenu",{"roleId":role});
            }
        })
    })
    /*管理员-增加*/
    function admin_add(title,url,w,h){
        layer_show(title,url,w,h);
    }
    /*管理员-删除*/
    function admin_del(obj,id){
        layer.confirm('确认要删除吗？',function(index){
            //此处请求后台程序，下方是成功后的前台处理……

            $(obj).parents("tr").remove();
            layer.msg('已删除!',{icon:1,time:1000});
        });
    }
    /*管理员-编辑*/
    function admin_edit(title,url,id,w,h){
        layer_show(title,url,w,h);
    }

</script>
</body>
</html>
