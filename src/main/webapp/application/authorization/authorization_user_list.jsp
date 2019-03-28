<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2019/3/18
  Time: 17:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <base href="<%=request.getContextPath()+"/"%>">
    <link href="css/H-ui.min.css" rel="stylesheet" type="text/css"/>
    <link href="css/H-ui.admin.css" rel="stylesheet" type="text/css"/>
    <link href="css/style.css" rel="stylesheet" type="text/css"/>
    <link href="lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css"/>

</head>
<body id="userBody">
<div class="pd-20">

    <div class="cl pd-5 bg-1 bk-gray"></div>
    <table class="table table-border table-bordered table-hover table-bg">
        <thead>
        <tr>
            <th scope="col" colspan="8">用户管理</th>
        </tr>
        <tr class="text-c">
            <th width="40">用户ID</th>
            <th width="100">用户名称</th>
            <th width="100">电话</th>
            <th width="100">邮箱</th>
            <th width="100">生日</th>
            <th width="100">是否有效</th>
            <th width="200">个人简介</th>
            <th width="70">操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${pageInfo.list}" var="sysUser">
            <tr class="text-c">
                <td>${sysUser.userId}</td>
                <td>${sysUser.userName}</td>
                <td>${sysUser.phone}</td>
                <td>${sysUser.email}</td>
                <td>
                    <fmt:formatDate value="${sysUser.birthday}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
                </td>
                <td>
                    <c:if test="${sysUser.flag}">
                        是
                    </c:if>
                    <c:if test="${!sysUser.flag}">
                        否
                    </c:if>
                </td>
                <td>${sysUser.introduce}</td>
                <td class="f-14">
                    <a title="删除" href="javascript:;" onclick="del_role_user(this,${sysUser.userId})" class="ml-5"
                       style="text-decoration:none">
                        <i class="Hui-iconfont">&#xe6e2;</i></a></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <%--装展示分页导航的容器--%>
    <jsp:include page="/application/common/page.jsp">
        <jsp:param name="bodyId" value="authorization"></jsp:param>
    </jsp:include>

</div>
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="js/H-ui.js"></script>
<script type="text/javascript" src="js/H-ui.admin.js"></script>

<script type="text/javascript">

    /*解除角色和用户的关系*/
    function del_role_user(obj, id) {
        layer.confirm('确定要解除与该用户的关系？', function (index) {
            var roleId1=${params}.roleId;
            //发送ajax请求去删除该条数据
            $.ajax({
                url: "authorization/delete",
                type: "POST",
                data: "userId=" + id+"&roleId="+roleId1,
                success: function(data){
                    if (data.result) {
                        $(obj).parents("tr").remove();
                        layer.msg('解决授权成功!', {icon: 1, time: 2000});
                    } else {
                        layer.msg('解决授权失败!', {icon: 2, time: 2000});
                    }
                }
            })

        });
    }
</script>
</body>
</html>
