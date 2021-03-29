<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/7/21
  Time: 17:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>个人主页</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style>
        body{
            background: aliceblue;
        }
        .all{
            width: 1400px;
            height: 1000px;
            margin: auto;
            background: skyblue;
        }
        .rank{
            width: 1400px;
            height: 40px;
            background: deepskyblue;
            margin-top: -20px;
        }
        .rank>span{
            margin-left: 50px;
            text-align: center;
            font-size: 20px;
        }
    </style>

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
    <div class="all">
        <nav class="navbar navbar-default" role="navigation" style="text-align: center">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="#">CSDN</a>
                </div>
                <div>
                    <form class="navbar-form navbar-left" role="search">
                        <button type="submit" class="btn btn-default">
                            博客<span>3</span>
                        </button>
                        <button type="submit" class="btn btn-default">
                            资源
                        </button>
                        <button type="submit" class="btn btn-default">
                            论坛
                        </button>
                        <button type="submit" class="btn btn-default">
                            Blink
                        </button>
                        <button type="submit" class="btn btn-default">
                            问答
                        </button>
                        <button type="submit" class="btn btn-default">
                            收藏
                        </button>
                        <button type="submit" class="btn btn-default">
                            专栏
                        </button>
                    </form>
                </div>
            </div>
        </nav>
        <div class="rank">
            <span>等级</span>
            <span>TA的博文</span>
            <span>TA的排名</span>
        </div>
        <table class="table table-striped">
            <thead>
            <tr>
                <th>标题</th>
                <th>日期</th>
                <th>点赞数</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>Tanmay</td>
                <td>Bangalore</td>
                <td>560001</td>
                <td><button>删除</button><button>删除</button></td>
            </tr>
            <tr>
                <td>Sachin</td>
                <td>Mumbai</td>
                <td>400003</td>
                <td><button>删除</button><button>删除</button></td>
            </tr>
            <tr>
                <td>Uma</td>
                <td>Pune</td>
                <td>411027</td>
                <td><button>删除</button><button>删除</button></td>
            </tr>
            </tbody>
        </table>
    </div>

</body>
</html>
