<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/7/21
  Time: 10:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>文章管理</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style>
        .center{
            width: 100%;
            height: 750px;
        }
        .center-left{
            width: 300px;
            height: 750px;
            display: inline-block;
        }
        .center-right{
            display: inline-block;
            width: 1200px;
            height: 770px;
        }
    </style>
    <script>
        $(function () {
            var userid=${user.userid};
            console.log(userid);
            $.ajax({
                //contentType:"application/json;charset=UTF-8",//发送数据以key=value的形式传递
                data: {userid:userid},//向后台controller发送的数据
                dataType:"json", //json格式解析返回数据
                type:"post",
                url:"/article/getuserarticle",
                error:function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log(XMLHttpRequest.status); //状态码
                    console.log(XMLHttpRequest.readyState); //状态
                    console.log(textStatus); //错误信息
                },
                success:function (data) {
                    if(data!=null){
                        console.log(data);
                        $("#totalarticle").text(data.length);
                    }
                }
            });
        });
        var articletitle;
        var articleid;
        var updatecontent;
        function updatearticle(val) {
            articletitle=$(val).parent().children().eq(0).children().eq(0).children().eq(0).text();
            articleid=$(val).parent().children().eq(0).children().eq(0).children().eq(1).text();
            console.log(articletitle+ "   "+articleid);
            $("#myModalLabel").text(articletitle);
        }
        function realupdatearticle(val) {
            updatecontent=$("#updatecontent").val();
            articleid=parseInt(articleid);
            $.ajax({
                //contentType:"application/json;charset=UTF-8",//发送数据以key=value的形式传递
                data: {articleid:articleid,articlecontent:updatecontent},//向后台controller发送的数据
                dataType:"json", //json格式解析返回数据
                type:"post",
                url:"/article/updatearticle",
                error:function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log(XMLHttpRequest.status); //状态码
                    console.log(XMLHttpRequest.readyState); //状态
                    console.log(textStatus); //错误信息
                },
                success:function (data) {
                    if(data==1){
                        alert("更改成功");
                    }
                }
            });
        }
    </script>
</head>
<body>
<nav class="navbar navbar-default" role="navigation" style="text-align: center">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="/index">CSDN</a>
        </div>
        <div>
            <form action="/articlemanagement" class="navbar-form navbar-left" role="search">
                <button type="submit" class="btn btn-default">
                    博客
                </button>
                <button type="submit" class="btn btn-default">
                    学院
                </button>
                <button type="submit" class="btn btn-default">
                    下载
                </button>
                <button type="submit" class="btn btn-default">
                    论坛
                </button>
                <button type="submit" class="btn btn-default">
                    问答
                </button>
                <button type="submit" class="btn btn-default">
                    直播
                </button>
                <button type="submit" class="btn btn-default">
                    招聘
                </button>
                <button type="submit" class="btn btn-default">
                    VIP会员
                </button>
                <input type="text" placeholder="搜索CSDN....." style="width: 300px;height: 35px">
                <button class="btn btn-default">
                    搜索
                </button>
            </form>
            <!--向右对齐-->
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a href="/personinformation" class="dropdown-toggle" data-toggle="dropdown">
                        个人中心 <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="/personinformation">个人信息</a></li>
                        <li><a href="/writearicle">写博客</a></li>
                        <li><a href="/comment">评论</a></li>
                        <li><a href="#">关注</a></li>
                        <li><a href="/mylovearticle">点赞</a></li>
                        <li class="divider"></li>
                        <li><a href="#">私信</a></li>
                    </ul>
                </li>
            </ul>
            <form class="navbar-form navbar-right" role="search">
                <button type="submit" class="btn btn-default">
                    <a href="/login">登录</a>
                </button>
                <button type="submit" class="btn btn-default">
                    <a href="/register">注册</a>
                </button>
            </form>
            <a><p class="navbar-text navbar-right"><button>${user.username}</button></p></a>
        </div>
    </div>
</nav>
    <div class="center">
        <div class="center-left" >
            <ul class="nav nav-pills nav-stacked" style="margin-left: 100px">
                <li class="active"><a href="#">博客管理</a></li>
                <li><a href="/mywallet">我的钱包</a></li>
                <li><a href="#">评论管理</a></li>
                <li><a href="#">分类专栏</a></li>
                <li><a href="/myreward">博客打赏</a></li>
                <li><a href="/mywallet">我的钱包</a></li>
                <li><a href="#">评论管理</a></li>
                <li><a href="#">分类专栏</a></li>
                <li><a href="/myreward">博客打赏</a></li>
                <li><a href="/mywallet">我的钱包</a></li>
                <li><a href="#">评论管理</a></li>
                <li><a href="#">分类专栏</a></li>
                <li><a href="/myreward">博客打赏</a></li>
            </ul>
            <ul class="nav nav-pills nav-stacked" style="margin-left: 100px">
                <li class="active"><a href="#">下载管理</a></li>
                <li><a href="#">上传资源</a></li>
                <li><a href="#">上传明细</a></li>
                <li><a href="#">积分明细</a></li>
                <li><a href="#">VIP下载服务</a></li>
            </ul>
            <ul class="nav nav-pills nav-stacked" style="margin-left: 100px">
                <li class="active"><a href="#">收益中心</a></li>
            </ul>
        </div>
        <div class="center-right">
            <nav class="navbar navbar-default" role="navigation">
                <div class="container-fluid">
                    <div class="navbar-header">
                        <a class="navbar-brand" href="#">全部</a><span>(</span><span id="totalarticle" class="total"></span><span>)</span>
                    </div>
                    <div class="navbar-header">
                        <a class="navbar-brand" href="#">公开</a></a><span>(</span><span class="total">0</span><span>)</span>
                    </div>
                    <div class="navbar-header">
                        <a class="navbar-brand" href="#">私密</a></a><span>(</span><span class="total">0</span><span>)</span>
                    </div>
                    <div class="navbar-header">
                        <a class="navbar-brand" href="#">审核</a></a><span>(</span><span class="total">0</span><span>)</span>
                    </div>
                    <div class="navbar-header">
                        <a class="navbar-brand" href="#">草稿箱</a></a><span>(</span><span class="total">0</span><span>)</span>
                    </div>
                    <div class="navbar-header">
                        <a class="navbar-brand" href="#">回收站</a></a><span>(</span><span class="total">0</span><span>)</span>
                    </div>
                </div>
            </nav>
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>标题</th>
                    <th>日期</th>
                    <th>点赞数</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${userarticle}" var="article" varStatus="vs">
                    <tr>
                        <td>
                            <span>
                                <a href="/article/getarticle?articletitle=${article.articletitle}">${article.articletitle}</a>
                                <span style="display: none">${article.articleid}
                                </span>
                            </span>
                        </td>
                        <td>${article.date}</td>
                        <td>${article.loveamount}</td>
                        <td class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal" onclick="updatearticle(this)">更改</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <!-- 模态框（Modal） -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel"></h4>
                    </div>
                    <div class="modal-body"><textarea id="updatecontent" placeholder="输入文章内容..." style="width: 570px ;height: 105px"></textarea></div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary" id="updatearticle" onclick="realupdatearticle(this)">提交更改</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal -->
        </div>
    </div>
</body>
</html>
