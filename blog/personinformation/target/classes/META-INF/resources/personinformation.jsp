<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/7/21
  Time: 15:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>个人信息</title>
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
            margin-top: 0px;
            display: inline-block;
            width: 1200px;
            height: 730px;
            background: navajowhite;
        }
        .information{
            width: 400px;
            height: 600px;
            background: skyblue;
            margin: auto;
        }
        textarea{
            width: 325px;
            height: 160px;

        }
    </style>
    <script>
        $(function () {
            $("#netname").val('${user.netname}');
            $("#username").val('${user.username}');
            $("#password").val('${user.password}');
            $("#position").val('${user.position}');
            $("#corporation").val('${user.corporation}');
            $("#introduction").val('${user.introduction}');
            $("#update").click(function () {
                console.log($("#form-horizontal").serialize());
                $.ajax({
                    //contentType:"application/json;charset=UTF-8",//发送数据以key=value的形式传递
                    data:$("#form-horizontal").serialize(),//向后台controller发送的数据
                    dataType:"json", //json格式解析返回数据
                    type:"post",
                    url:"/user/update",
                    error:function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("更改失败,请重新操作");
                        console.log(XMLHttpRequest.status); //状态码
                        console.log(XMLHttpRequest.readyState); //状态
                        console.log(textStatus); //错误信息
                    },
                    success:function (data) {
                        if(data==true){
                            alert("更改成功");
                            // window.location.href="/login";
                        }
                    }
                });
            });
        })
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
                <li class="active"><a href="#">个人资料</a></li>
                <li><a href="#">我的收藏</a></li>
                <li><a href="/myreward">我的书籍</a></li>
                <li><a href="/myfriend">我的人脉</a></li>
                <li><a href="/mymayknowfriends">我可能认识的人</a></li>
                <li><a href="#">我的粉丝</a></li>
                <li><a href="/comment">我的评论</a></li>
                <li><a href="/mywallet">我的钱包</a></li>
                <li><a href="/articlemanagement">我的博客</a></li>
                <li><a href="/mylovearticle">我的点赞</a></li>
                <li><a href="#">我的下载</a></li>
                <li><a href="#">我的论坛</a></li>
                <li><a href="#">我的问答</a></li>
            </ul>
            <ul class="nav nav-pills nav-stacked" style="margin-left: 100px">
                <li class="active"><a href="#">个人资料</a></li>
                <li><a href="#">我的收藏</a></li>
                <li><a href="#">我的勋章</a></li>
                <li><a href="#">我的人脉</a></li>
                <li><a href="#">我关注的人</a></li>
            </ul>
        </div>
        <div class="center-right">
            <nav class="navbar navbar-default" role="navigation" style="text-align: center">
                <div class="container-fluid">
                    <div class="navbar-header">
                        <a class="navbar-brand" href="#">个人资料</a>
                    </div>
                </div>
            </nav>
            <div class="information">
                <form id="form-horizontal" class="form-horizontal" role="form">
                    <div class="form-group">
                        <label for="lastname" class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <input readonly name="username" type="text" class="form-control" id="username" placeholder="请输入姓名">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="lastname" class="col-sm-2 control-label">密码</label>
                        <div class="col-sm-10">
                            <input name="password" type="text" class="form-control" id="password" placeholder="请输入密码">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="firstname" class="col-sm-2 control-label">昵称</label>
                        <div class="col-sm-10">
                            <input name="netname" type="text" class="form-control" id="netname" placeholder="请输入昵称">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="lastname" class="col-sm-2 control-label">职位</label>
                        <div class="col-sm-10">
                            <input name="position" type="text" class="form-control" id="position" placeholder="请输入职位">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="lastname" class="col-sm-2 control-label">公司</label>
                        <div class="col-sm-10">
                            <input name="corporation" type="text" class="form-control" id="corporation" placeholder="请输入公司">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="lastname" class="col-sm-2 control-label">简介</label>
                        <div class="col-sm-10">
                           <textarea name="introduction" id="introduction" placeholder="说点什么..."></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <input id="update" type="button" value="更改">
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
