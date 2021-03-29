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
    <title>我的评论</title>
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
        #wallet_sort>li,#lovearticle>li{
            float: left;
            list-style: none;
            font-size: 20px;
            width: 150px;
            height: 50px;
            margin-left: 30px;
            text-align: center;
        }
        #wallet_sort>li:hover,#lovearticle>li:hover{
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
        td:hover{
            background: skyblue;
            cursor: pointer;
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
            $("#lovearticle li").click(function () {
                var index = $("#lovearticle li").index(this);
                var divindex = $("#wallet_content").children().eq(index);
                divindex.show();
                divindex.siblings().hide();
            });
            var userid=${user.userid};;
            $("#trueaddmoney").click(function () {
                var d=new Date();
                let year = d.getFullYear();//获取当前年
                var mon = d.getMonth() + 1; //获取当前月
                var date = d.getDate(); //获取当前日
                var hour =d.getHours();
                var minutes=d.getMinutes();
                var dateindex=year+"."+mon+"."+date+"."+hour+"."+minutes;
                var addmoney=$("#inputmoney").val();
                $.ajax({
                    //contentType:"application/json;charset=UTF-8",//发送数据以key=value的形式传递
                    data: {date:dateindex,userid:userid,money:addmoney},//向后台controller发送的数据
                    dataType:"json", //json格式解析返回数据
                    type:"post",
                    url:"/usermoney/addmoney",
                    error:function (XMLHttpRequest, textStatus, errorThrown) {
                        console.log(XMLHttpRequest.status); //状态码
                        console.log(XMLHttpRequest.readyState); //状态
                        console.log(textStatus); //错误信息
                    },
                    success:function (data) {
                        $("#addmoneylistbody").empty();

                       for(var i=0;i<data.length;i++){
                            var addmoneyrecord=data[i].toString();
                            var arr=new Array();
                            arr=addmoneyrecord.split(':');
                            console.log(addmoneyrecord+" "+arr);
                            let moneyrecord= $("#addmoneylistbody");
                            let tr= $("<tr></tr>");
                            let td1= $("<td></td>");
                            let td2= $("<td></td>");
                            let td3= $("<td></td>");
                            let td4= $("<td></td>");
                            td1.text(arr[0]);
                            td2.text(${user.userid});
                            td3.text(arr[1]);
                            td4.text("成功");
                            tr.append(td1);
                            tr.append(td2);
                            tr.append(td3);
                            tr.append(td4);
                            moneyrecord.append(tr);
                       }
                    }
                });
            });
            $.ajax({
                //contentType:"application/json;charset=UTF-8",//发送数据以key=value的形式传递
                data: {userid:userid},//向后台controller发送的数据
                dataType:"json", //json格式解析返回数据
                type:"post",
                url:"/reply/queryreplaybyuserid",
                error:function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log(XMLHttpRequest.status); //状态码
                    console.log(XMLHttpRequest.readyState); //状态
                    console.log(textStatus); //错误信息
                },
                success:function (data) {
                    $("#addcommentlistbody").empty();

                    for(var i=0;i<data.length;i++){
                        var commentrecord=data[i].toString();
                        var arr=new Array();
                        arr=commentrecord.split(':');
                        let comment= $("#addcommentlistbody");
                        console.log(arr[0]+" "+arr[1]);
                        var date =new Date();
                        let tr= $("<tr></tr>");
                        let td1= $("<td></td>");
                        let td2= $("<td onclick=\"go_toarticle(this)\"></td>");
                        let td3= $("<td></td>");
                        td1.text(date.getFullYear()+"."+date.getHours()+"."+date.getDate());
                        td2.text(arr[0]);
                        td3.text(arr[1]);
                        tr.append(td1);
                        tr.append(td2);
                        tr.append(td3);
                        comment.append(tr);
                    }
                }
            });
            $.ajax({
                //contentType:"application/json;charset=UTF-8",//发送数据以key=value的形式传递
                data: {userid:userid},//向后台controller发送的数据
                dataType:"json", //json格式解析返回数据
                type:"post",
                url:"/reply/queryreplayedbyuserid",
                error:function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log(XMLHttpRequest.status); //状态码
                    console.log(XMLHttpRequest.readyState); //状态
                    console.log(textStatus); //错误信息
                },
                success:function (data) {
                    $("#commentedlistbody").empty();

                    for(var i=0;i<data.length;i++){
                        var commentrecord=data[i].toString();
                        var arr=new Array();
                        arr=commentrecord.split(':');
                        let comment= $("#commentedlistbody");
                        console.log(arr[0]+" "+arr[1]);
                        var date =new Date();
                        let tr= $("<tr></tr>");
                        let td1= $("<td></td>");
                        let td2= $("<td onclick=\"go_toarticle(this)\"></td>");
                        let td3= $("<td></td>");
                        td1.text(date.getFullYear()+"."+date.getHours()+"."+date.getDate());
                        td2.text(arr[0]);
                        td3.text(arr[1]);
                        tr.append(td1);
                        tr.append(td2);
                        tr.append(td3);
                        comment.append(tr);
                    }
                }
            });
            $.ajax({
                //contentType:"application/json;charset=UTF-8",//发送数据以key=value的形式传递
                data: {userid:userid},//向后台controller发送的数据
                dataType:"json", //json格式解析返回数据
                type:"post",
                url:"/usermoney/querymoney",
                error:function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log(XMLHttpRequest.status); //状态码
                    console.log(XMLHttpRequest.readyState); //状态
                    console.log(textStatus); //错误信息
                },
                success:function (data) {
                    console.log(data.money);
                    if(data.money==null){
                        $("#wallet").text("0");
                    }
                    else {
                        $("#wallet").text(data.money);
                    }
                }
            });
            $.ajax({
                //contentType:"application/json;charset=UTF-8",//发送数据以key=value的形式传递
                data: {userid:userid},//向后台controller发送的数据
                dataType:"json", //json格式解析返回数据
                type:"post",
                url:"/article/useridlike",
                error:function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log(XMLHttpRequest.status); //状态码
                    console.log(XMLHttpRequest.readyState); //状态
                    console.log(textStatus); //错误信息
                },
                success:function (data) {

                    $("#lovelistbody").empty();
                    var loveword="棒棒哒!:好厉害呀!:你可牛上天了".toString();
                    var arr=new Array();
                    arr=loveword.split(':');
                    var x=0;
                    var y=2;
                    for(var i=0;i<data.length;i++){
                        var rand=parseInt(Math.random()*(y-x+1)+x);
                        let lovelist= $("#lovelistbody");
                        console.log(data[i]);
                        var date =new Date();
                        let tr= $("<tr></tr>");
                        let td1= $("<td></td>");
                        let td2= $("<td onclick=\"go_toarticle(this)\"></td>");
                        let td3= $("<td></td>");
                        td1.text(date.getFullYear()+"."+date.getHours()+"."+date.getDate());
                        td2.text(data[i]);
                        td3.text(arr[rand]);
                        tr.append(td1);
                        tr.append(td2);
                        tr.append(td3);
                        lovelist.append(tr);
                    }
                }
            });
            $.ajax({
                //contentType:"application/json;charset=UTF-8",//发送数据以key=value的形式传递
                data: {userid:userid},//向后台controller发送的数据
                dataType:"json", //json格式解析返回数据
                type:"post",
                url:"/article/useridedlike",
                error:function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log(XMLHttpRequest.status); //状态码
                    console.log(XMLHttpRequest.readyState); //状态
                    console.log(textStatus); //错误信息
                },
                success:function (data) {

                    $("#lovedlistbody").empty();
                    var loveword="棒棒哒!:好厉害呀!:你可牛上天了".toString();
                    var arr=new Array();
                    arr=loveword.split(':');
                    var x=0;
                    var y=2;
                    for(var i=0;i<data.length;i++){
                        var lovedword=data[i].toString();
                        var arr1=new Array();
                        arr1=lovedword.split('::');
                        var rand=parseInt(Math.random()*(y-x+1)+x);
                        let lovelist= $("#lovedlistbody");
                        var date =new Date();
                        let tr= $("<tr></tr>");
                        let td1= $("<td></td>");
                        let td2= $("<td onclick=\"go_toarticle(this)\"></td>");
                        let td3= $("<td></td>");
                        let td4= $("<td></td>");
                        td1.text(date.getFullYear()+"."+date.getHours()+"."+date.getDate());
                        td2.text(arr1[1]);
                        td3.text(arr1[0]);
                        td4.text(arr[rand]);
                        tr.append(td1);
                        tr.append(td2);
                        tr.append(td3);
                        tr.append(td4);
                        lovelist.append(tr);
                    }
                }
            });
        })
        function lazymoney(val) {
            var money =$(val).text();
            console.log(money);
            $("#inputmoney").val(money);
        }
        function go_toarticle(val) {
            var articleid=$(val).text();
            $.ajax({
                //contentType:"application/json;charset=UTF-8",//发送数据以key=value的形式传递
                data: {articleid:articleid},//向后台controller发送的数据
                dataType:"json", //json格式解析返回数据
                type:"post",
                url:"/article/getarticlebyarticleid",
                error:function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log(XMLHttpRequest.status); //状态码
                    console.log(XMLHttpRequest.readyState); //状态
                    console.log(textStatus); //错误信息
                },
                success:function (data) {
                    if(data!=null){
                        window.location.href="/article/getarticle?articletitle="+data.articletitle;
                        return false;
                    }else {
                        alert("该文章无效");
                    }
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
                <div class="">
                    <p class="popover-options" style="width: 230px; background: white">
                        <a style="width: 200px" href="#" class="" title="<h4>温馨提示：</h4>"
                           data-container="body" data-toggle="popover" data-content="1、余额可以在PC端购买VIP和学院课程，但不可直接用于下载资源；
2、余额可以用来购买C币套餐，但不可直接当C币使用；
3、充值成功后，余额可能存在延迟现象，一般1到5分钟内到账，如有问题，请咨询客服；">
                            <span>当前可用余额</span>
                            <img id="tips" data-v-32b0f0d5="" src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iMTJweCIgaGVpZ2h0PSIxMnB4IiB2aWV3Qm94PSIwIDAgMTIgMTIiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiAgICA8IS0tIEdlbmVyYXRvcjogU2tldGNoIDYzLjEgKDkyNDUyKSAtIGh0dHBzOi8vc2tldGNoLmNvbSAtLT4KICAgIDx0aXRsZT7luK7liqk8L3RpdGxlPgogICAgPGRlc2M+Q3JlYXRlZCB3aXRoIFNrZXRjaC48L2Rlc2M+CiAgICA8ZyBpZD0iUEPnq6/jgIHmiJHnmoTpkrHljIUiIHN0cm9rZT0ibm9uZSIgc3Ryb2tlLXdpZHRoPSIxIiBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPgogICAgICAgIDxnIGlkPSJlbGVtZW5057uE5Lu25YyW5o+Q5Y+WIiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMjk3LjAwMDAwMCwgLTEwMDkuMDAwMDAwKSIgZmlsbC1ydWxlPSJub256ZXJvIj4KICAgICAgICAgICAgPGcgaWQ9IuW4ruWKqSIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMjk2LjAwMDAwMCwgMTAwOC4wMDAwMDApIj4KICAgICAgICAgICAgICAgIDxyZWN0IGlkPSLnn6nlvaIiIGZpbGw9IiMwMDAwMDAiIG9wYWNpdHk9IjAiIHg9IjAiIHk9IjAiIHdpZHRoPSIxNCIgaGVpZ2h0PSIxNCI+PC9yZWN0PgogICAgICAgICAgICAgICAgPHBhdGggZD0iTTcuMDE2NjI1LDEyLjgzMDcwODMgQzMuNzk5MjUsMTIuODMwNzA4MyAxLjE5MDg3NSwxMC4yMjIzMzMzIDEuMTkwODc1LDcuMDA0OTU4MzQgQzEuMTkwODc1LDMuNzg3NTgzMzQgMy43OTkyNSwxLjE3OTIwODM0IDcuMDE2NjI1LDEuMTc5MjA4MzQgQzEwLjIzNCwxLjE3OTIwODM0IDEyLjg0MjA4MzMsMy43ODc1ODMzNCAxMi44NDIwODMzLDcuMDA0OTU4MzQgQzEyLjg0MjA4MzMsMTAuMjIyMzMzMyAxMC4yMzQsMTIuODMwNzA4MyA3LjAxNjYyNSwxMi44MzA3MDgzIFogTTcuMDE2NjI1LDExLjY2NTc5MTcgQzkuNTkwNTgzMzQsMTEuNjY1NzkxNyAxMS42NzcxNjY3LDkuNTc4OTE2NjYgMTEuNjc3MTY2Nyw3LjAwNDk1ODM0IEMxMS42NzcxNjY3LDQuNDMxMDAwMDEgOS41OTA1ODMzNCwyLjM0NDcwODM0IDcuMDE2NjI1LDIuMzQ0NzA4MzQgQzQuNDQyNjY2NjYsMi4zNDQ3MDgzNCAyLjM1NjM3NSw0LjQzMSAyLjM1NjM3NSw3LjAwNDk1ODM0IEMyLjM1NjM3NSw5LjU3ODkxNjY4IDQuNDQyNjY2NjYsMTEuNjY1NzkxNyA3LjAxNjYyNSwxMS42NjU3OTE3IFogTTcuNTk5Mzc1LDguMDk2OTU4MzQgTDcuNTk5Mzc1LDguNzUyOTE2NjYgQzcuNTk5Mzc1LDkuMDc0NzYwNiA3LjMzODQ2ODk0LDkuMzM1NjY2NjYgNy4wMTY2MjUsOS4zMzU2NjY2NiBDNi42OTQ3ODEwNiw5LjMzNTY2NjY2IDYuNDMzODc1LDkuMDc0NzYwNiA2LjQzMzg3NSw4Ljc1MjkxNjY2IEw2LjQzMzg3NSw3LjU4NzQxNjY2IEM2LjQzMzg3NSw3LjI2NiA2LjY5NDkxNjY2LDcuMDA0OTU4MzIgNy4wMTY2MjUsNy4wMDQ5NTgzNCBDNy42NjAwNzEyNSw3LjAwNDk1ODM0IDguMTgxNjg3NSw2LjQ4MzM0MjA5IDguMTgxNjg3NSw1LjgzOTg5NTg0IEM4LjE4MTY4NzUsNS4xOTY0NDk1OSA3LjY2MDA3MTI1LDQuNjc0ODMzMzQgNy4wMTY2MjUsNC42NzQ4MzMzNCBDNi4zNzMyMTIwOSw0LjY3NDgzMzMyIDUuODUxNTc3NzIsNS4xOTYzMzcxMSA1Ljg1MTQxNjY2LDUuODM5NzUgQzUuODUxNDE2NjYsNi4xNjE0MzI4NSA1LjU5MDY0MTE4LDYuNDIyMjA4MzMgNS4yNjg5NTgzMyw2LjQyMjIwODMzIEM0Ljk0NzI3NTQ4LDYuNDIyMjA4MzMgNC42ODY1LDYuMTYxNDMyODUgNC42ODY1LDUuODM5NzUgQzQuNjg2ODkyMDYsNC42Mjg3NzU1OCA1LjYxNDcxMDU1LDMuNjE5ODkyMSA2LjgyMTQxNjMxLDMuNTE4MzAyNjMgQzguMDI4MTIyMDYsMy40MTY3MTMxNiA5LjExMTU1NjM5LDQuMjU2Mjc0NDIgOS4zMTQ0MDU2NCw1LjQ1MDEzODQ3IEM5LjUxNzI1NDksNi42NDQwMDI1MiA4Ljc3MTkxNTU1LDcuNzk0MjkwNDMgNy41OTkzNzUsOC4wOTY5NTgzNCBMNy41OTkzNzUsOC4wOTY5NTgzNCBaIE03LjAxNjYyNSwxMC44NDk3MDg0IEM2LjgwODUzMjY3LDEwLjg0OTgxMjUgNi42MTYxOTE4NCwxMC43Mzg4OTI5IDYuNTEyMDU1NDQsMTAuNTU4NzMxOCBDNi40MDc5MTkwMywxMC4zNzg1NzA2IDYuNDA3ODA3ODUsMTAuMTU2NTM4OCA2LjUxMTc2Mzc3LDkuOTc2MjczNDIgQzYuNjE1NzE5NjksOS43OTYwMDgwOCA2LjgwNzk0OTM0LDkuNjg0ODk1ODYgNy4wMTYwNDE2Niw5LjY4NDc5MTU5IEM3LjMzNzcyNDUyLDkuNjg0NjMwNTggNy41OTg2MzA1OCw5Ljk0NTI3NTQ3IDcuNTk4NzkxNzQsMTAuMjY2OTU4MyBDNy41OTg5NTI3NSwxMC41ODg2NDEyIDcuMzM4MzA3ODYsMTAuODQ5NTQ3MyA3LjAxNjYyNSwxMC44NDk3MDg0IEw3LjAxNjYyNSwxMC44NDk3MDg0IFoiIGlkPSLlvaLnirYiIGZpbGw9IiM5OTlBQUEiPjwvcGF0aD4KICAgICAgICAgICAgPC9nPgogICAgICAgIDwvZz4KICAgIDwvZz4KPC9zdmc+" alt="" class="el-tooltip" aria-describedby="el-tooltip-7451" tabindex="0">
                        </a>
                    </p>
                </div>
                <div class="jum_right_button">
                    <span><h3 style="color: red ;float: left;margin-left: 22px">￥<span id="wallet"></span></h3></span>
                    <span><button><h3 style="color: red ;float: left;margin-left: 22px ;text-align: center">收益转入</h3></button></span>
                    <span><button><h3 style="color: red ;float: left;margin-left: 22px" data-toggle="modal" data-target="#myModal">充值</h3></button></span>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-3" id="myScrollspy">
                <ul id="mylist" class="nav nav-tabs nav-stacked" data-spy="affix" data-offset-top="125">
                    <li><button type="button"  class="btn btn-primary"
                                data-toggle="button" style="width: 150px;height: 50px">评论</button></li>
                    <li><button type="button" class="btn btn-primary"
                                data-toggle="button" style="width: 150px;height: 50px">点赞</button></li>
                    <li><button type="button" class="btn btn-primary"
                                data-toggle="button" style="width: 150px;height: 50px">私信</button></li>
                    <li><button type="button" class="btn btn-primary"
                                data-toggle="button" style="width: 150px;height: 50px">系统通知</button></li>
                </ul>
            </div>
            <div class="content_right">
                <div class="one">
                    <div class="top">
                        <ul id="wallet_sort">
                            <li>我评论的</li>
                            <li>评论我的</li>
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
                                    <th>日期</th>
                                    <th>文章号</th>
                                    <th>评论内容</th>
                                </tr>
                                </thead>
                                <tbody id="addcommentlistbody">
                                    <tr>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="wallet_two" style="display: none">
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>日期</th>
                                    <th>文章号</th>
                                    <th>评论内容</th>
                                </tr>
                                </thead>
                                <tbody id="commentedlistbody">
                                <tr>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="wallet_three" style="display: none">
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>日期</th>
                                    <th>文章号</th>
                                    <th>评论内容</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td>Tanmay</td>
                                    <td>Bangalore</td>
                                    <td>560001</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="two" style="display: none">
                    <div class="top">
                        <ul id="lovearticle">
                            <li>我点赞的</li>
                            <li>点赞我的</li>
                        </ul>
                    </div>
                    <br>
                    <br>
                    <hr>
                    <div class="wallet_content" id="wallet_content">
                        <div class="wallet_one">
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>日期</th>
                                    <th>文章号</th>
                                    <th>点赞详情</th>
                                </tr>
                                </thead>
                                <tbody id="lovelistbody">
                                <tr>
                                    <td>dasda</td>
                                    <td>dasda</td>
                                    <td>dasda</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="wallet_two" style="display: none">
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>日期</th>
                                    <th>我的文章号</th>
                                    <th>点赞用户</th>
                                    <th>点赞详情</th>
                                </tr>
                                </thead>
                                <tbody id="lovedlistbody">
                                <tr>
                                    <td>我</td>
                                    <td>我</td>
                                    <td>我</td>
                                    <td>我</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="wallet_three" style="display: none">
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>日期</th>
                                    <th>文章号</th>
                                    <th>评论内容</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td>Tanmay</td>
                                    <td>Bangalore</td>
                                    <td>560001</td>
                                </tr>
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
                        <span style="font-weight: bold">账户ID:${user.userid}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>当前可用余额:55</span>
                    </h4>
                </div>
                <div class="modal-body">
                    充值金额:<input id="inputmoney" type="text" style="width: 250px;height: 40px;" placeholder="单位/元">
                    <br>
                    <div class="btn-group">
                        <button type="button" class="btn btn-default" style="margin-left: 58px" onclick="lazymoney(this)">100</button>
                        <button type="button" class="btn btn-default" onclick="lazymoney(this)">200</button>
                        <button type="button" class="btn btn-default" onclick="lazymoney(this)">300</button>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">关闭
                    </button>
                    <button id="trueaddmoney" type="button" class="btn btn-primary">
                        充值
                    </button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
</body>
</html>
