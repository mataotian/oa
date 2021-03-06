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
            <th width="70">操作</th>
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
                <td class="f-14">
                    <a title="删除" href="javascript:;" onclick="del_role_menu(this,${sysMenu.menuId})" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a>
                </td>
            </tr>
        </c:forEach>

        </tbody>
    </table>
    <jsp:include page="/application/common/page.jsp">
        <jsp:param name="bodyId" value="authorization"></jsp:param>
    </jsp:include>

</div>
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="js/H-ui.js"></script>
<script type="text/javascript" src="js/H-ui.admin.js"></script>
<script type="text/javascript">


    /*管理员-菜单-删除*/
    function del_role_menu(obj,id){

        layer.confirm('菜单删除须谨慎，确认要删除吗？',function() {
            var roleId1=${params}.roleId;
            //此处请求后台程序，下方是成功后的前台处理……
            $.ajax({
                type: "POST",
                url: "authorization/delRoleMenu?menuId="+id+"&roleId="+roleId1,
                success: function (data) {
                    if(data.result){
                        $(obj).parents("tr").remove();
                        layer.msg('已解除授权!', {icon: 1, time: 1000});
                    }else{
                        layer.msg('解除授权失败!', {icon: 2, time: 1000});
                    }
                }
            })

        });
    }


</script>
</body>
</html>







