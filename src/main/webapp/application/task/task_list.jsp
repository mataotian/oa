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
<body id="taskBody">
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 组织管理 <span class="c-gray en">&gt;</span> 组织管理 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="pd-20">
    <table class="table table-border table-bordered table-hover table-bg">
        <thead>
        <tr>
            <th scope="col" colspan="6">任务审批管理</th>
        </tr>
        <tr class="text-c">
            <th width="25"><input type="checkbox"  value="" name=""></th>
            <th width="40">任务ID</th>
            <th width="200">任务名称</th>
            <th width="40">流程ID</th>
            <th width="250">任务创建时间</th>
            <th width="70">操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${pageInfo.list}" var="task">
        <tr class="text-c">
            <td><input type="checkbox" class="batchDel" value="${task.id}" name=""></td>
            <td>${task.id}</td>
            <td>${task.name}</td>
            <td>${task.processInstanceId}</td>
            <td><fmt:formatDate value="${task.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
            </td>
            <td class="f-14">
                <a title="编辑" href="javascript:;" onclick="admin_task_edit('任务审批','purchase/toShenPi?id=${task.id}','1')" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a>
            </td>
        </tr>
        </c:forEach>

        </tbody>
    </table>
    <jsp:include page="/application/common/page.jsp">
        <jsp:param name="bodyId" value="taskBody"></jsp:param>
    </jsp:include>

</div>
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="js/H-ui.js"></script>
<script type="text/javascript" src="js/H-ui.admin.js"></script>
<script type="text/javascript">

    /*管理员-组织-编辑*/
    function admin_task_edit(title,url,id,w,h){
        layer_show(title,url,w,h);
    }

    function selectByCondition() {
        var orgName=$("#orgName").val();
        var orgParentName=$("#orgParentName").val();
        var flag=$("#flag").val();
        $("#orgBody").load("sysOrg/selectByCondition",{"orgName":orgName,"orgParentName":orgParentName,"flag":flag})
    }
</script>
</body>
</html>
