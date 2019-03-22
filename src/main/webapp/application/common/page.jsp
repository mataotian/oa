
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="lib/layui/css/layui.css" media="all">
    <script src="lib/layui/layui.js"></script>
    <script>
        layui.use('laypage', function(){
            var laypage = layui.laypage;

            //执行一个laypage实例
            laypage.render({
                elem: 'page' //注意，这里的 test1 是 ID，不用加 # 号
                ,count: ${pageInfo.total} //数据总数，从服务端得到
                ,curr:${pageInfo.pageNum} //当前页
                ,limit:${pageInfo.pageSize} //每页显示的条数
                ,limits:[1,2,3,4,5]
                ,groups:4  //连续的页码数
                ,layout:['count','prev', 'page', 'next','limit','refresh','skip']
                ,jump: function(obj, first){
                //obj包含了当前分页的所有参数，比如：
                console.log(obj.curr); //得到当前页，以便向服务端请求对应页的数据。
                console.log(obj.limit); //得到每页显示的条数

                //首次不执行
                if(!first){
                   //location.href="sysRole/page?currentPage="+obj.curr+"&pageSize="+obj.limit;
                   //$("#orgBody").load("sysOrg/selectByCondition?currentPage="+obj.curr+"&pageSize="+obj.limit,{"orgName":"${sysOrg.orgName}","orgParentName":"${sysOrg.orgParentName}","flag":"${sysOrg.flag}"});
                    $("#${param.bodyId}").load("${url}?currentPage="+obj.curr+"&pageSize="+obj.limit,${params});
                }
            }
            });
        });
    </script>
</head>
<body>
<div id="page"></div>
</body>
</html>
