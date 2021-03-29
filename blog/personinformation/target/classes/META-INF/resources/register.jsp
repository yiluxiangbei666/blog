<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/7/21
  Time: 10:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册界面</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style>
        body{

        }
        .center{
            width: 100%;
            height: 800px;
            background-repeat: no-repeat;
            background-image: url("https://dss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3526649462,1739201268&fm=26&gp=0.jpg");
            background-size: 2200px 1100px;
        }
        .center_middle{
            height: 700px;
            width: 800px;
            margin: auto;
        }
        .middle_left{
            margin-top: 100px;
            width: 370px;
            height: 500px;
            display: inline-block;
            float: left;
            background-color:#4d4d4d;
            opacity: 0.5;
        }
        .middle_right{
            margin-top: 100px;
            width: 420px;
            height: 500px;
            display: inline-block;
            float: right;
            background-color: white;
            opacity: 0.8;
        }
        .mark{
            width: 300px;
            height: 430px;
            margin-top: 40px;
            margin-left: 30px;
        }
        .loginform{
            width: 300px;
            height: 430px;
            margin-top: 40px;
            margin-left: 30px;
        }
        .btn-group{
            float: left;
        }
    </style>
    <script>
        $(function () {
            $("#registbtn").click(function () {
                $.ajax({
                    //contentType:"application/json;charset=UTF-8",//发送数据以key=value的形式传递
                    data:$("#registerform").serialize(),//向后台controller发送的数据
                    dataType:"json", //json格式解析返回数据
                    type:"post",
                    url:"/user/create",
                    error:function (XMLHttpRequest, textStatus, errorThrown) {
                        console.log(XMLHttpRequest.status); //状态码
                        console.log(XMLHttpRequest.readyState); //状态
                        console.log(textStatus); //错误信息
                    },
                    success:function (data) {
                        alert("注册成功，即将跳转到登录界面");
                        window.location.href="/login";
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
        <div class="center_middle">
            <div class="middle_left">
                <div class="mark">
                    <h2>SQL</h2>
                    <p><h3>SQL结构化查询语言，1970年代起源于IBM，是对Edgar Codd关系模型的第一个商业化语言实现。它是最广泛使用的数据库语言，在不同的数据库系统中往往有不同的实现，用于管理关系数据库管理系统（RDBMS)，或在关系流数据管理系统（RDSMS）中进行流处理。</h3></p>
                    <div class="btn-group">
                        <button type="button" class="btn btn-default">点赞</button>
                    </div>
                </div>
            </div>
            <div class="middle_right">
                <div class="loginform">
                    <form id="registerform" class="form-horizontal" role="form">
                        <div class="form-group">
                            <label for="firstname" class="col-sm-2 control-label">账号</label>
                            <div class="col-sm-10">
                                <input name="username" type="text" class="form-control" id="firstname"
                                       placeholder="请输入名字">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="lastname" class="col-sm-2 control-label">密码</label>
                            <div class="col-sm-10">
                                <input name="password" type="text" class="form-control" id="lastname"
                                       placeholder="请输入密码">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="lastname" class="col-sm-2 control-label">手机号</label>
                            <div class="col-sm-10">
                                <input name="phone" type="text" class="form-control" id="phone"
                                       placeholder="请输入手机号">
                            </div>
                        </div>
                        <input style="margin-left: 57px" id="registbtn" type="button" value="注册">
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

