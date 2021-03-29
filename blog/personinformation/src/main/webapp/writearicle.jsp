<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/7/21
  Time: 15:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>创客中心</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style>
        .title{
            width: 1200px;
            height: 600px;
            margin: auto;
            background: darkgray;
        }
        .write{
            width: 1200px;
            height: 550px;
            margin-top: 0px;
        }
    </style>
    <script>
        $(function () {
            $("#addarticle").click(function () {
                var articletitle=$("#articletitle").val();
                var articlecontent=$("#articlecontent").val();
                var userid=${user.userid};
                var myDate = new Date;
                var year = myDate.getFullYear(); //获取当前年
                var mon = myDate.getMonth() + 1; //获取当前月
                var date = myDate.getDate(); //获取当前日
                var nowdate=year+"."+mon+"."+date;
                $.ajax({
                    //contentType:"application/json;charset=UTF-8",//发送数据以key=value的形式传递
                    data: {articletitle:articletitle,articlecontent:articlecontent,userid:userid,date:nowdate,loveamount:0},//向后台controller发送的数据
                    dataType:"json", //json格式解析返回数据
                    type:"post",
                    url:"/article/create",
                    error:function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("文章太长或其他原因，请重新发布");
                        console.log(XMLHttpRequest.status); //状态码
                        console.log(XMLHttpRequest.readyState); //状态
                        console.log(textStatus); //错误信息
                    },
                    success:function (data) {
                            alert("发布成功");
                            window.location.href="/articlemanagement";
                            return false;
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
    <div class="title">
        <nav class="navbar navbar-default" role="navigation">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="#"> < 文章管理</a>
                </div>
                <form class="navbar-form navbar-left" role="search">
                    <div class="form-group">
                        <input id="articletitle" type="text" class="form-control" placeholder="输入文章标题" style="width: 700px">
                    </div>
                    <input id="addarticle" class="btn btn-default" value="发布文章">
                </form>
            </div>
        </nav>
        <textarea id="articlecontent" class="write" placeholder="输入正文">
        </textarea>
    </div>
</body>
</html>
