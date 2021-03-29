<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/7/20
  Time: 16:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录页面</title>
    <meta charset="utf-8">
<%--    <script type="text/javascript" src='<c:url value="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></c:url>'></script>--%>
<%--    <script type="text/javascript" src='<c:url value="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></c:url>'></script>--%>
<%--    <link rel="stylesheet" src='<c:url value="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css"></c:url>' type="text/css" >--%>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style>
        body{

        }
        nav{
            text-align: center;
        }
        .center{
            width: 100%;
            height: 750px;
        }
        .center-left{
            width: 300px;
            display: inline-block;
        }
        .center_middle{
            display: inline-block;
            vertical-align: center;
            margin-left: 160px;
        }
        img{
            width: 900px;
            height: 400px;
        }
        .center_right{
            display: inline-block;
            width: 500px;
            height: 500px;
            float: right;
            border-top: 160px;
        }
        h4{
            display: inline-block;
        }
        .new_content{
            width: 900px;
            margin: auto;
        }
    </style>
    <script>
        $(function () {
            $.ajax({
                //contentType:"application/json;charset=UTF-8",//发送数据以key=value的形式传递
                dataType:"json", //json格式解析返回数据
                type:"post",
                url:"/user/listuser",
                error:function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log(XMLHttpRequest.status); //状态码
                    console.log(XMLHttpRequest.readyState); //状态
                    console.log(textStatus); //错误信息
                },
                success:function (data) {
                    if(data==true){
                        console.log("查询专家成功")
                    }
                }
            });
            $.ajax({
                //contentType:"application/json;charset=UTF-8",//发送数据以key=value的形式传递
                dataType:"json", //json格式解析返回数据
                type:"post",
                url:"/article/listarticle",
                error:function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log(XMLHttpRequest.status); //状态码
                    console.log(XMLHttpRequest.readyState); //状态
                    console.log(textStatus); //错误信息
                },
                success:function (data) {
                    if(data!=null){
                        console.log("查询文章成功")
                    }
                }
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
                    <li class="active"><a href="#">推荐</a></li>
                    <li><a href="#">动态</a></li>
                    <li><a href="#">程序人生</a></li>
                    <li><a href="/python">Python</a></li>
                    <li><a href="/books">Java</a></li>
                    <li><a href="/books">书籍大全</a></li>
                    <li><a href="#">前段</a></li>
                    <li><a href="#">架构</a></li>
                    <li><a href="#">区块链</a></li>
                    <li><a href="#">6G</a></li>
                    <li><a href="#">游戏开发</a></li>
                    <li><a href="#">程序人生</a></li>
                    <li><a href="#">Python</a></li>
                    <li><a href="#">Java</a></li>
                    <li><a href="#">百万人学AI</a></li>
                </ul>
            </div>
            <div class="center_middle">
                <div id="myCarousel" class="carousel slide">
                    <!-- 轮播（Carousel）指标 -->
                    <ol class="carousel-indicators">
                        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                        <li data-target="#myCarousel" data-slide-to="1"></li>
                        <li data-target="#myCarousel" data-slide-to="2"></li>
                    </ol>
                    <!-- 轮播（Carousel）项目 -->
                    <div class="carousel-inner">
                        <div class="item active">
                            <img src="https://dss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3892794610,901028644&fm=26&gp=0.jpg" alt="First slide">
                            <div class="carousel-caption">IT人众人学习平台</div>
                        </div>
                        <div class="item">
                            <img src="https://dss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3697360071,1232155278&fm=26&gp=0.jpg" alt="Second slide">
                            <div class="carousel-caption">web前端_下载免费教程</div>
                        </div>
                        <div class="item">
                            <img src="https://dss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3720578784,2656298925&fm=26&gp=0.jpg" alt="Third slide">
                            <div class="carousel-caption">background 是用于在一个声明中设置所有背景属性的一个简写属性</div>
                        </div>
                    </div>
                    <!-- 轮播（Carousel）导航 -->
                    <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                    </a>
                </div>
            </div>
            <div class="center_right">
                <c:forEach items="${listuser}" var="user" varStatus="vs">
                    <div class="list-group">
                        <a href="#" class="list-group-item active">
                            <h4 class="list-group-item-heading">
                                博客专家
                            </h4>
                        </a>
                        <a href="#" class="list-group-item">
                            <button type="button" class="btn btn-primary btn-lg">
                                <span class="glyphicon glyphicon-user"></span> User
                            </button>
                            <h4 class="list-group-item-heading">
                                    ${user.username}
                            </h4>
                            <h2>数据库工程师</h2>
                            <p class="list-group-item-text">
                                董旭阳，硕士，2009年毕业于北京航空...
                            </p>
                        </a>
                    </div>
                </c:forEach>
            </div>
        </div>
        <div class="new_content">
            <c:forEach items="${listarticle}" var="article" varStatus="vs">
                <div class="page-header">
                    <h1><a href="/article/getarticle?articletitle=${article.articletitle}">${article.articleid}: ${article.articletitle}</a>
                        <small>${article.date}</small>
                    </h1>
                    <p>${article.articlecontent}</p>
                </div>
            </c:forEach>
        </div>
    </body>
</html>
