<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/7/25
  Time: 15:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的人脉</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style>
        body{
            background: gainsboro;
        }
        #mylist{
            background: white;
            width: 180px;
            height: 700px;
        }
        #mylist>li{
            margin-top: 30px;
            width: 175px;
            height: 50px;
            margin-left: 15px;
        }
        #mylist>li>button{

        }
        .col-xs-3{
            display: inline-block;
            width: 180px;
        }
        .content_right{
            width: 950px;
            height: 700px;
            background: white;
            display: inline-block;
            float: right;
            margin-right: 20px;
        }
        .one,.two,.three,.four{
            width: 900px;
            height: 650px;
        }
        #wallet_sort>li,#wallet_sort1>li{
            float: left;
            list-style: none;
            font-size: 20px;
            width: 150px;
            height: 50px;
            margin-left: 30px;
            text-align: center;
        }
        #wallet_sort>li:hover,#wallet_sort1>li:hover{
            background: silver;
        }
        .container{
            height: 200px;
        }
        .jum_left{
            display: inline-block;
            width: 180px;
            height: 160px;
            float: left;
            margin-left: -40px;
            border: 2px skyblue;
        }
        img{
            display: block;
            margin-right: 8px;
            width: 78px;
            height: 78px;
            border-radius: 50%;
            margin: auto;
        }
        .username{
            font-size: 25px;
            text-align: center;
        }
        .jum_right{
            display: inline-block;
            width: 850px;
            height: 140px;
            background: white;
            float: right;
            margin-top: -20px;
        }
        #tips{
            display: block;
            margin-right: 8px;
            width: 22px;
            height: 22px;
            border-radius: 50%;
            margin: auto;
            display: inline-block;
            float: left;
        }
        a{
            text-decoration: none;
            color: black;
        }
        a:hover{
            background: skyblue;
        }
        .jum_right_button>span>button{
            width: 150px;
            height: 60px;
            float: right;
        }
        .btn-group>button{
            width: 84px;
        }
        tr td{
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
            word-wrap: break-word;
        }
        tr td:hover{
            background: skyblue;
            cursor: pointer;
        }
        tr td>button{
            margin-left: 20px;
        }
    </style>
    <script>
        $(function () { $('.popover-show').popover('show');});
        $(function () { $('.popover-hide').popover('hide');});
        $(function () { $('.popover-destroy').popover('destroy');});
        $(function () { $('.popover-toggle').popover('toggle');});
        $(function () { $(".popover-options a").popover({html : true });});
    </script>
    <script>
        $(function () {
            $("#mylist li").click(function () {
                var index = $("#mylist li").index(this);
                var divindex = $(".content_right").children().eq(index);
                divindex.show();
                divindex.siblings().hide();
            });
            $("#wallet_sort li").click(function () {
                var index = $("#wallet_sort li").index(this);
                var divindex = $(".wallet_content").children().eq(index);
                divindex.show();
                divindex.siblings().hide();
            });
            var userid=${user.userid};
            $.ajax({
                //contentType:"application/json;charset=UTF-8",//发送数据以key=value的形式传递
                data:{userid:userid},//向后台controller发送的数据
                dataType:"json", //json格式解析返回数据
                type:"get",
                url:"/myaddfriendslist",
                error:function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log(XMLHttpRequest.status); //状态码
                    console.log(XMLHttpRequest.readyState); //状态
                    console.log(textStatus); //错误信息
                },
                success:function (data) {
                    var empty = $("#myaddfriendslist").empty();
                   for(var i=0;i<data.length;i++){
                       var addmoneyrecord=data[i].toString();
                       var arr=new Array();
                       arr=addmoneyrecord.split(':');
                       var list = $("#myaddfriendslist");
                       var tr=$("<tr></tr>");
                       var td1=$("<td></td>");
                       var td2=$("<td></td>");
                       var td3=$("<td></td>");
                       td1.text(arr[0]);
                       td2.text(arr[1]);
                       td3.text(arr[2]);
                       tr.append(td1);
                       tr.append(td2);
                       tr.append(td3);
                       list.append(tr);
                   }
                }
            });
            $.ajax({
                //contentType:"application/json;charset=UTF-8",//发送数据以key=value的形式传递
                data:{userid:userid},//向后台controller发送的数据
                dataType:"json", //json格式解析返回数据
                type:"get",
                url:"/queryfridens",
                error:function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log(XMLHttpRequest.status); //状态码
                    console.log(XMLHttpRequest.readyState); //状态
                    console.log(textStatus); //错误信息
                },
                success:function (data) {
                    $("#myfriendslist").empty();
                    for(var i=0;i<data.length;i++){
                        var date=data[i].toString();
                        var arr=date.split(":");
                        var tbody=$("#myfriendslist");
                        var tr=$("<tr></tr>");
                        var td1=$("<td></td>");
                        var td2=$("<td></td>");
                        var td3=$("<td></td>");
                        td1.text(arr[0]);
                        td2.text(arr[1]);
                        td3.text(arr[2]);
                        tr.append(td1);
                        tr.append(td2);
                        tr.append(td3);
                        tbody.append(tr);
                    }
                }
            });
            $.ajax({
                //contentType:"application/json;charset=UTF-8",//发送数据以key=value的形式传递
                data:{userid:userid},//向后台controller发送的数据
                dataType:"json", //json格式解析返回数据
                type:"get",
                url:"/mayknowperson",
                error:function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log(XMLHttpRequest.status); //状态码
                    console.log(XMLHttpRequest.readyState); //状态
                    console.log(textStatus); //错误信息
                },
                success:function (data) {
                    console.log(data);
                    $("#mymayknowfridens").empty();
                    for(var i=0;i<data.length;i++){
                        var date=data[i].toString();
                        var arr=date.split(":");
                        var tbody=$("#mymayknowfridens");
                        var tr=$("<tr></tr>");
                        var td1=$("<td></td>");
                        var td2=$("<td></td>");
                        var td3=$("<td></td>");
                        var td4=$("<td onclick=\"addfriends(this)\"></td>");
                        td1.text(arr[0]);
                        td2.text(arr[1]);
                        td3.text(arr[2]);
                        td4.text("添加");
                        tr.append(td1);
                        tr.append(td2);
                        tr.append(td3);
                        tr.append(td4);
                        tbody.append(tr);
                    }
                }
            });
            $.ajax({
                //contentType:"application/json;charset=UTF-8",//发送数据以key=value的形式传递
                data:{userid:userid},//向后台controller发送的数据
                dataType:"json", //json格式解析返回数据
                type:"get",
                url:"/addmelist",
                error:function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log(XMLHttpRequest.status); //状态码
                    console.log(XMLHttpRequest.readyState); //状态
                    console.log(textStatus); //错误信息
                },
                success:function (data) {
                    $("#addmelist").empty();
                    if(data.length>0){
                        $("#if_msg").text("有"+data.length+"条添加消息");
                    }
                    for(var i=0;i<data.length;i++){
                        var addmoneyrecord=data[i].toString();
                        var arr=new Array();
                        arr=addmoneyrecord.split(':');
                        var list=$("#addmelist");
                        var tr= $("<tr></tr>");
                        var td1=$("<td></td>");
                        var td2=$("<td></td>");
                        var td3=$("<td></td>");
                        td1.text(arr[0]);
                        td2.text(arr[1]);
                        var button1=$("<button onclick=\'trueaddfriends(this)\'></button>");
                        var button2=$("<button onclick=\'refuseaddfriends(this)\'></button>");
                        var button3=$("<button></button>");
                        button1.text("同意");
                        button2.text("拒绝");
                        td3.append(button1);
                        td3.append(button2);
                        tr.append(td1);
                        tr.append(td2);
                        tr.append(td3);
                        list.append(tr);
                    }
                }
            });
        })
        function trueaddfriends(val) {
            var tr=$(val).parent().parent();
            var agreeuserid=tr.children().eq(0).text();
            var userid=${user.userid};
            $.ajax({
                //contentType:"application/json;charset=UTF-8",//发送数据以key=value的形式传递
                data:{userid:userid,agreeuserid:agreeuserid},//向后台controller发送的数据
                dataType:"json", //json格式解析返回数据
                type:"get",
                url:"/agreeaddfriends",
                error:function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log(XMLHttpRequest.status); //状态码
                    console.log(XMLHttpRequest.readyState); //状态
                    console.log(textStatus); //错误信息
                },
                success:function (data) {
                    alert("已同意");
                }
            })
        }
        function refuseaddfriends(val) {
            var tr=$(val).parent().parent();
            var agreeuserid=tr.children().eq(0).text();
            var userid=${user.userid};
            $.ajax({
                //contentType:"application/json;charset=UTF-8",//发送数据以key=value的形式传递
                data:{userid:userid,agreeuserid:agreeuserid},//向后台controller发送的数据
                dataType:"json", //json格式解析返回数据
                type:"get",
                url:"/refuseaddfriends",
                error:function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log(XMLHttpRequest.status); //状态码
                    console.log(XMLHttpRequest.readyState); //状态
                    console.log(textStatus); //错误信息
                },
                success:function (data) {
                    alert("已拒绝");
                }
            })
        }
        function queryuser() {
            var adduserid=$("#adduserid").val();
            $("#addfrienduser").empty();
            $.ajax({
                //contentType:"application/json;charset=UTF-8",//发送数据以key=value的形式传递
                data:{userid:adduserid},//向后台controller发送的数据
                dataType:"json", //json格式解析返回数据
                type:"get",
                url:"/user/getuser",
                error:function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log(XMLHttpRequest.status); //状态码
                    console.log(XMLHttpRequest.readyState); //状态
                    console.log(textStatus); //错误信息
                },
                success:function (data) {
                    console.log(data);
                    var tr= $("#addfrienduser");
                    var td1=$("<td></td>");
                    var td2=$("<td></td>");
                    var td3=$("<td onclick=\"addfriends(this)\"></td>");
                    td1.text(data.userid);
                    td2.text(data.username);
                    td3.text("添加");
                    tr.append(td1);
                    tr.append(td2);
                    tr.append(td3);
                }
            });
        }
        function addfriends(val){
            var tr=$(val).parent();
            var userid=${user.userid};
            var addeduserid=tr.children().eq(0).text();
            $.ajax({
                //contentType:"application/json;charset=UTF-8",//发送数据以key=value的形式传递
                data:{userid:userid,addeduserid:addeduserid},//向后台controller发送的数据
                dataType:"json", //json格式解析返回数据
                type:"get",
                url:"/addfriends",
                error:function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log(XMLHttpRequest.status); //状态码
                    console.log(XMLHttpRequest.readyState); //状态
                    console.log(textStatus); //错误信息
                },
                success:function (data) {
                    alert("添加消息已发送，请耐心等待");
                }
            });
        }
    </script>
</head>
<body data-spy="scroll" data-target="#myScrollspy">
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
    <div class="container">
        <div class="jumbotron" style="height: 200px">
            <div class="jum_left">
                <div><img src="https://profile.csdnimg.cn/2/C/C/3_qq_41076792" username="qq_41076792" alt="qq_41076792" class="avatar"></div>
                <div class="username">${user.username}</div>
            </div>
            <div class="jum_right">
                <div class="container" style="" >
                    <div style="width: 104%;margin-left:-16px;height: 40px;background: skyblue">
                        <span style="margin-left:80px;font-size: 22px;color: white;cursor: pointer;margin-top: 40px" data-toggle="modal" data-target="#myModal">查找</span>
                    </div>
                </div>
                <div style="margin-top: -160px">
                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th>用户ID</th>
                            <th>用户名</th>
                            <th>是否添加</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr id="addfrienduser">

                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-3" id="myScrollspy">
                <ul id="mylist" class="nav nav-tabs nav-stacked" data-spy="affix" data-offset-top="125">
                    <li><button type="button"  class="btn btn-primary"
                                data-toggle="button" style="width: 150px;height: 50px">我的好友列表</button></li>
                    <li><button type="button" class="btn btn-primary"
                                data-toggle="button" style="width: 150px;height: 50px">我可能认识的人</button></li>
                    <li><button type="button" class="btn btn-primary"
                                data-toggle="button" style="width: 150px;height: 50px">C币</button></li>
                    <li><button type="button" class="btn btn-primary"
                                data-toggle="button" style="width: 150px;height: 50px">实名认证</button></li>
                </ul>
            </div>
            <div class="content_right">
                <div class="one" style="display: none">
                    <div class="top">
                        <ul id="wallet_sort">
                            <li>我的好友</li>
                            <li>我的申请列表</li>
                            <li id="if_msg">消息</li>
                        </ul>
                    </div>
                    <br>
                    <br>
                    <hr>
                    <div class="wallet_content">
                        <div class="wallet_one">
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>用户ID</th>
                                    <th>用户名</th>
                                    <th>状态</th>
                                </tr>
                                </thead>
                                <tbody id="myfriendslist">

                                </tbody>
                            </table>
                        </div>
                        <div class="wallet_two" style="display: none">
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>用户ID</th>
                                    <th>用户名</th>
                                    <th>状态</th>
                                </tr>
                                </thead>
                                <tbody id="myaddfriendslist">
                                </tbody>
                            </table>
                        </div>
                        <div class="wallet_three" style="display: none">
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>用户ID</th>
                                    <th>用户名</th>
                                    <th>状态</th>
                                </tr>
                                </thead>
                                <tbody id="addmelist">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="two">
                    <div class="top">
                        <ul id="wallet_sort1">
                            <li>我可能认识的人</li>
                        </ul>
                    </div>
                    <br>
                    <br>
                    <hr>
                    <div class="wallet_content">
                        <div class="wallet_one">
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>用户ID</th>
                                    <th>用户名</th>
                                    <th>共同好友数</th>
                                    <th>是否添加</th>
                                </tr>
                                </thead>
                                <tbody id="mymayknowfridens">

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="three" style="display: none">三</div>
                <div class="four" style="display: none">四</div>
            </div>
        </div>
    </div>
    <!-- 模态框（Modal） -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-hidden="true">×
                    </button>
                    <h4 class="modal-title" id="myModalLabel">
                        查找好友
                    </h4>
                </div>
                <div class="modal-body">
                    <span style="font-size: 22px;">输入用户ID:</span><input id="adduserid" type="text" style="width: 450px;height: 40px" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">取消
                    </button>
                    <button onclick="queryuser()" data-dismiss="modal" type="button" class="btn btn-primary">
                        查找
                    </button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
</body>
</html>
