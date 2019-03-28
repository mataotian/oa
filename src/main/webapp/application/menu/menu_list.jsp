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
            是否发布:
            <span class="select-box" style="width:150px">
              <select name="brandclass" class="select" size="1" id="isPublish">
                    <c:choose>
                        <c:when test="${sysMenu.isPublish}">
                            <option value="1" selected="selected">是</option>
                            <option value="0">否</option>
                        </c:when>
                        <c:otherwise>
                            <option value="1">是</option>
                            <option value="0" selected="selected">否</option>
                        </c:otherwise>
                    </c:choose>
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
    <div class="cl pd-5 bg-1 bk-gray"> <span class="l"> <a href="javascript:;" onclick="batchDel()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a> <a class="btn btn-primary radius" href="javascript:;" onclick="admin_menu_add('添加菜单','sysMenu/toAdd','800')"><i class="Hui-iconfont">&#xe600;</i> 添加菜单</a> </span> <span class="r">共有数据：<strong>${pageInfo.total}</strong> 条</span> </div>
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
                <td class="f-14"><a title="编辑" href="javascript:;" onclick="admin_menu_edit('菜单编辑','sysMenu/toUpdate/${sysMenu.menuId}','1')" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a> <a title="删除" href="javascript:;" onclick="menu_del(this,${sysMenu.menuId})" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a></td>
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
    var id1;
    /*管理员-菜单-添加*/
    function admin_menu_add(title,url,w,h){
        layer_show(title,url,w,h);
    }
    /*管理员-菜单-编辑*/
    function admin_menu_edit(title,url,id,w,h){
        layer_show(title,url,w,h);
    }
    /*管理员-菜单-删除*/
    function menu_del(obj,id){

        layer.confirm('菜单删除须谨慎，确认要删除吗？',function() {

            //此处请求后台程序，下方是成功后的前台处理……
            $.ajax({
                type: "POST",
                url: "sysMenu/delete?id="+id,
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
        layer.confirm('菜单删除须谨慎，确认要删除吗？',function() {
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
                    url: "sysMenu/batchDel?idList="+ids,
                    success: function (data) {
                        if(data.result){
                            layer.msg('已删除!', {icon: 1, time: 1000},function () {
                                location.reload();
                            })
                        }else{
                            layer.msg('删除失败!', {icon: 1, time: 1000});
                        }
                    }
                })
            }
        });
    }
    function selectByCondition() {
        var menuName=$("#menuName").val();
        var isPublish=$("#isPublish").val();
        $("#menuBody").load("sysMenu/selectByCondition",{"menuName":menuName,"isPublish":isPublish})
    }
</script>
</body>
</html>







