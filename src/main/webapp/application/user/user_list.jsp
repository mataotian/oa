<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<base href="<%=request.getContextPath()+"/"%>">
<link href="css/H-ui.min.css" rel="stylesheet" type="text/css" />
<link href="css/H-ui.admin.css" rel="stylesheet" type="text/css" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
<head>
    <title>Title</title>
</head>
<body id="userBody">
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 用户管理 <span class="c-gray en">&gt;</span> 用户管理 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="pd-20">
    <div class="text-c">
        <div class="row cl ">
            <div class="formControls col-4">
                用户名称: <input type="text" class="input-text" style="width: 250px" id="userName" value="${sysUser.userName}">
            </div>
            是否有效:
            <span class="select-box" style="width:150px">
              <select name="brandclass" class="select" size="1" id="flag">
                    <option value="1" selected="selected">是</option>
                    <option value="0">否</option>
                </select>
			</span>
        </div>
        <div class="row cl">
            <div class="cl pd-5">
                <button type="button"
                        class="btn btn-success radius" id="" name="" onclick="selectByCondition()">
                    <i class="Hui-iconfont">&#xe665;</i> 搜索
                </button>
            </div>
        </div>
    </div>
    <div class="cl pd-5 bg-1 bk-gray"> <span class="l"> <a href="javascript:;" onclick="batchDel()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a> <a class="btn btn-primary radius" href="javascript:;" onclick="admin_user_add('添加用户','sysUser/toAdd','800')"><i class="Hui-iconfont">&#xe600;</i> 添加用户</a> </span> <span class="r">共有数据：<strong>${pageInfo.total}</strong> 条</span> </div>
    <table class="table table-border table-bordered table-hover table-bg">
        <thead>
        <tr>
            <th scope="col" colspan="7">用户管理</th>
        </tr>
        <tr class="text-c">
            <th width="25"><input type="checkbox"  value="" name=""></th>
            <th width="40">用户ID</th>
            <th width="200">用户名</th>
            <th width="40">联系电话</th>
            <th width="40">邮箱</th>
            <th width="200">生日</th>
            <th width="80">是否有效</th>
            <th width="300">个人简介</th>
            <th width="70">操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${pageInfo.list}" var="sysUser">
        <tr class="text-c">

            <td><input type="checkbox" class="batchDel" value="${sysUser.userId}" name=""></td>
            <td>${sysUser.userId}</td>
            <td>${sysUser.userName}</td>
            <td>${sysUser.phone}</td>
            <td>${sysUser.email}</td>
            <td><fmt:formatDate value="${sysUser.birthday}" pattern="yyyy-MM-dd"/>
                    </td>
            <td>
                <c:if test="${sysUser.flag}">
                    是
                </c:if><c:if test="${!sysUser.flag}">
                    否
                </c:if>
            </td>
            <td>${sysUser.introduce}</td>
            <td class="f-14"><a title="编辑" href="javascript:;" onclick="admin_user_edit('用户编辑','sysUser/toUpdate/${sysUser.userId}','1')" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a> <a title="删除" href="javascript:;" onclick="user_del(this,${sysUser.userId})" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a></td>
        </tr>
        </c:forEach>

        </tbody>
    </table>
    <jsp:include page="/application/common/page.jsp">
        <jsp:param name="bodyId" value="userBody"></jsp:param>
    </jsp:include>

</div>
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="js/H-ui.js"></script>
<script type="text/javascript" src="js/H-ui.admin.js"></script>
<script type="text/javascript">
    var id1;
    /*管理员-用户-添加*/
    function admin_user_add(title,url,w,h){
        layer_show(title,url,w,h);
    }
    /*管理员-用户-编辑*/
    function admin_user_edit(title,url,id,w,h){
        layer_show(title,url,w,h);
    }
    /*管理员-用户-删除*/
    function user_del(obj,id){

        layer.confirm('用户删除须谨慎，确认要删除吗？',function() {
            //此处请求后台程序，下方是成功后的前台处理……
            $.ajax({
                type: "POST",
                url: "sysUser/delete?id="+id,
                success: function (data) {
                    if(data.result){
                        $(obj).parents("tr").remove();
                        layer.msg('已删除!', {icon: 1, time: 1000},function () {
                            location.reload();
                        });

                    }else{
                        layer.msg('删除失败!', {icon: 1, time: 1000});
                    }
                }
            })

        });
    }
    function batchDel() {
        var batch=$(".batchDel:checked");
        layer.confirm('用户删除须谨慎，确认要删除吗？',function() {
            //此处请求后台程序，下方是成功后的前台处理……
            if(batch.length==0){
                layer.msg('请选择你要删除的选项!', {icon: 2, time: 1000});
            }else{
                var ids=[];
                for (var i=0;i<batch.length;i++){
                    ids.push(batch[i].value);
                }
                $.ajax({
                    type: "POST",
                    url: "sysUser/batchDel?idList="+ids,
                    success: function (data) {
                        if(data.result){
                            layer.msg('已删除!', {icon: 1, time: 1000});
                            location.reload();
                        }else{
                            layer.msg('删除失败!', {icon: 1, time: 1000});
                        }
                    }
                })
            }
        });
    }
    function selectByCondition() {
        var userName=$("#userName").val();
        var flag=$("#flag").val();
        $("#userBody").load("sysUser/selectByCondition",{"userName":userName,"flag":flag})
    }
</script>
</body>
</html>
