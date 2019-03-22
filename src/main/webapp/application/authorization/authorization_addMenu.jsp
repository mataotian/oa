<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/3/18
  Time: 20:38
  To change this template use File | Settings | File Templates.
--%>
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
<body id="menuBody">
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 菜单管理 <span class="c-gray en">&gt;</span> 菜单管理 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="pd-20">
    <div class="text-c">
        <div class="row cl ">
            <div class="formControls col-4">
                菜单名称: <input type="text" class="input-text" style="width: 250px" id="menuName" value="${sysMenu.menuName}">
            </div>
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
    <div class="cl pd-5 bg-1 bk-gray">
        <a href="javascript:;" onclick="batchAdd()" class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i> 批量授权</a>
    </div>
    <table class="table table-border table-bordered table-hover table-bg">
        <thead>
        <tr>
            <th scope="col" colspan="7">菜单管理</th>
        </tr>
        <tr class="text-c">
            <th width="25"><input type="checkbox"  value="" name=""></th>
            <th width="40">菜单ID</th>
            <th width="200">菜单名</th>
            <th>菜单创建时间</th>
            <th width="80">是否有效</th>
            <th width="300">描述</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${pageInfo.list}" var="sysMenu">
            <tr class="text-c">

                <td><input type="checkbox" class="batchDel" value="${sysMenu.menuId}" name=""></td>
                <td>${sysMenu.menuId}</td>
                <td>${sysMenu.menuName}</td>
                <td><fmt:formatDate value="${sysMenu.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </td>
                <td>
                    <c:if test="${sysMenu.isPublish}">
                        是
                    </c:if><c:if test="${!sysMenu.isPublish}">
                    否
                </c:if>
                </td>
                <td>${sysMenu.menuDesc}</td>
            </tr>
        </c:forEach>

        </tbody>
    </table>
    <jsp:include page="/application/common/page.jsp">
        <jsp:param name="bodyId" value="menuBody"></jsp:param>
    </jsp:include>

</div>
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="js/H-ui.js"></script>
<script type="text/javascript" src="js/H-ui.admin.js"></script>
<script type="text/javascript">


    function batchAdd() {
        var batch=$(".batchDel:checked");
        layer.confirm('菜单授权须谨慎，确认要授权吗？',function() {
            //此处请求后台程序，下方是成功后的前台处理……
            if(batch.length==0){
                layer.msg('请选择你要授权的菜单选项!', {icon: 2, time: 1000});
            }else{
                var ids=[];
                for (var i=0;i<batch.length;i++){
                    ids.push(batch[i].value);
                }
                $.ajax({
                    type: "POST",
                    url: "authorization/batchAddMenu?idList="+ids+"&roleId="+${roleId},
                    success: function (data) {
                        if(data.result){
                            layer.msg('已授权!', {icon: 1, time: 1000})
                            location.reload();
                        }else{
                            layer.msg('授权失败!', {icon: 1, time: 1000});
                        }
                    }
                })
            }
        });
    }
    function selectByCondition() {
        var menuName=$("#menuName").val();
        $("#menuBody").load("authorization/queryNoAuthMenu",{"menuName":menuName,"roleId":${roleId}})
    }
</script>
</body>
</html>







