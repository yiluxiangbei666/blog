<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/7/21
  Time: 19:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>文章</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style>
        body{
            background: gainsboro;
        }
        .article{
            width: 1200px;
            height: 1800px;
            margin: auto;
            background: white;
        }
        .article_title{
            width: 100%;
            height: 90px;

        }
        .article_title>h1{
            text-align: center;
        }
        .article_mark{
            width: 90%;
            height: 70px;
            background: mistyrose;
            margin: auto;
            display: flex;
        }
        ul{
            margin-top: 10px;
            align-items: center;
        }
        ul>li{
            float: left;
            margin-left: 20px;
            width: 300px;
            height: 60px;
            vertical-align: middle;
            list-style: none;
            font-size: 20px;
        }
        .content{
            width: 90%;
            height: 600px;
            margin: auto;
        }
        .content_main{
            width: 100%;
            height: 600px;
        }
        .article_pinglun
        {
            width: 100%;
            height: 60px;
            background: mistyrose;
        }
        .pinglunframe{
            width: 90%;
            height: 400px;
            margin: auto;
            border: 1px gainsboro;
        }
        img{
            display: block;
            margin-right: 8px;
            width: 24px;
            height: 24px;
            border-radius: 50%;
        }
        .operater{
            margin-top: 20px;
        }
        .operaterdiv{
            margin-left: -100px;
        }
    </style>
    <script>
        $(function () {
            var id=${article.articleid};
            var userid=${user.userid};
            var content;
            $("#pinglun").click(function () {
                content=$('#pingluncontent').val();
                console.log("articleid"+id+"userid"+userid+"content:"+content);
                $.ajax({
                    //contentType:"application/json;charset=UTF-8",//发送数据以key=value的形式传递
                    data: {articleid:id,userid:userid,content:content},//向后台controller发送的数据
                    dataType:"json", //json格式解析返回数据
                    type:"post",
                    url:"/reply/create",
                    error:function (XMLHttpRequest, textStatus, errorThrown) {
                        console.log(XMLHttpRequest.status); //状态码
                        console.log(XMLHttpRequest.readyState); //状态
                        console.log(textStatus); //错误信息
                    },
                    success:function (data) {
                        alert("评论成功");
                    }
                });
            });
            $.ajax({
                //contentType:"application/json;charset=UTF-8",//发送数据以key=value的形式传递
                data: {articleid:id,userid:userid},//向后台controller发送的数据
                dataType:"json", //json格式解析返回数据
                type:"post",
                url:"/article/ifuserreward",
                error:function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log(XMLHttpRequest.status); //状态码
                    console.log(XMLHttpRequest.readyState); //状态
                    console.log(textStatus); //错误信息
                },
                success:function (data) {
                    if(data==1){
                        $("#is_rewardbutton").text("已打赏");
                    }
                }
            });
            $.ajax({
                //contentType:"application/json;charset=UTF-8",//发送数据以key=value的形式传递
                data: {articleid:id},//向后台controller发送的数据
                dataType:"json", //json格式解析返回数据
                type:"post",
                url:"/reply/listreplybyid",
                error:function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log(XMLHttpRequest.status); //状态码
                    console.log(XMLHttpRequest.readyState); //状态
                    console.log(textStatus); //错误信息
                },
                success:function (data) {

                }
            });
            var userid=${user.userid};
            var articleid=${article.articleid};
            console.log(userid+"  "+articleid);
            $.ajax({
                //contentType:"application/json;charset=UTF-8",//发送数据以key=value的形式传递
                data: {userid:userid,articleid:articleid},//向后台controller发送的数据
                dataType:"json", //json格式解析返回数据
                type:"post",
                url:"/article/useriflove",
                error:function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log(XMLHttpRequest.status); //状态码
                    console.log(XMLHttpRequest.readyState); //状态
                    console.log(textStatus); //错误信息
                },
                success:function (data) {
                    if(data.article_love_amount==null){
                        $("#loveamount").text("点赞数:"+0);
                    }
                    else {
                        $("#loveamount").text("点赞数:"+data.article_love_amount);
                    }
                    if(data.user_if_love==1){
                        $("#user_if_like").text("以点赞");
                    }
                }
            });
        })
        function deletereply(val) {
            console.log(val);
            var replyid=$(val).children("span").eq(0).text();
            var userid=$("#replyuserid").text();
            var newuserid=${user.userid};
            if(userid==newuserid){
                $.ajax({
                    //contentType:"application/json;charset=UTF-8",//发送数据以key=value的形式传递
                    data: {replyid:replyid},//向后台controller发送的数据
                    dataType:"json", //json格式解析返回数据
                    type:"post",
                    url:"/reply/delete",
                    error:function (XMLHttpRequest, textStatus, errorThrown) {
                        console.log(XMLHttpRequest.status); //状态码
                        console.log(XMLHttpRequest.readyState); //状态
                        console.log(textStatus); //错误信息
                    },
                    success:function (data) {
                        if(data==1){
                            alert("删除成功");
                        }
                    }
                });
            }else {
                alert("您无权删除");
            }
        }
        var replyid;
        function replyperson(val) {
            replyid=$(val).parent().children().eq(1).children().eq(0).text();
            console.log(replyid);
            var aftertr=$(val).parent().parent().parent();
            let tr= $("<tr style=\"width: 600px;margin-left: 50px\"></tr>");
            let td1 = $("<td></td>");
            let td2 = $("<td></td>");
            let img =$("<img src=\"https://profile.csdnimg.cn/2/C/C/3_qq_41076792\" username=\"qq_41076792\" alt=\"qq_41076792\" class=\"avatar\">");
            let input=$("<input type=\"text\" placeholder=\"输入答复内容.....\" style=\"width: 600px;margin-left: 100px;height: 35px\">");
            td2.text("");
            let div=$("<div class=\"operaterdiv\"></div>");
            let reply=$("<button class=\"operater\" onclick=\"addreplyperson(this)\"></button>");
            let deletereplyperson=$("<button class=\"operater\" onclick=\"deletereplyperson(this)\"></button>");
            reply.html("确认");
            deletereplyperson.html("删除");
            div.append(reply);
            div.append(deletereplyperson);
            td2.append(div);
            td1.append(img);
            td1.append(input);
            tr.append(td1);
            tr.append(td2);
            aftertr.after(tr);
        }
        function addreplyperson(val) {
            var userid=${user.userid};
            var username="${user.username}";
            var content=$(val).parent().parent().parent().children().eq(0).children().eq(1).val();
            console.log("replyid:"+replyid,"userid"+userid+"content"+content);
            $.ajax({
                //contentType:"application/json;charset=UTF-8",//发送数据以key=value的形式传递
                data: {replyid:replyid,userid:userid,username:username,replycontent:content},//向后台controller发送的数据
                dataType:"json", //json格式解析返回数据
                type:"post",
                url:"/replyperson/create",
                error:function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log(XMLHttpRequest.status); //状态码
                    console.log(XMLHttpRequest.readyState); //状态
                    console.log(textStatus); //错误信息
                },
                success:function (data) {
                    if(data==1){
                       alert("回复成功");
                    }
                }
            });
        }
        function deletereplyperson(val) {
            var attr = $(val).parent().parent().parent().attr('id');
            var reg = /\d+/g;
            var rusult=attr.match(reg);
            var userid=rusult[0];
            var replypersonid=rusult[1];
            console.log(userid+" "+replypersonid);
            if(userid==${user.userid}){
                $.ajax({
                    //contentType:"application/json;charset=UTF-8",//发送数据以key=value的形式传递
                    data: {replypersonid:replypersonid},//向后台controller发送的数据
                    dataType:"json", //json格式解析返回数据
                    type:"post",
                    url:"/replyperson/deletereplyperson",
                    error:function (XMLHttpRequest, textStatus, errorThrown) {
                        console.log(XMLHttpRequest.status); //状态码
                        console.log(XMLHttpRequest.readyState); //状态
                        console.log(textStatus); //错误信息
                    },
                    success:function (data) {
                        if(data==1){
                            alert("删除成功");
                        }
                    }
                });
            }
            else {
                alert("此评论你无权删除");
            }
        }
        function useridaddlike(val) {
            var userid=${user.userid};
            var articleid=${article.articleid};
            console.log(userid+"  "+articleid);
            if($(val).text()=="点赞"){
                $.ajax({
                    //contentType:"application/json;charset=UTF-8",//发送数据以key=value的形式传递
                    data: {userid:userid,articleid:articleid},//向后台controller发送的数据
                    dataType:"json", //json格式解析返回数据
                    type:"post",
                    url:"/article/addlike",
                    error:function (XMLHttpRequest, textStatus, errorThrown) {
                        console.log(XMLHttpRequest.status); //状态码
                        console.log(XMLHttpRequest.readyState); //状态
                        console.log(textStatus); //错误信息
                    },
                    success:function (data) {
                        $("#loveamount").text("点赞数:"+data.article_love_amount);
                        if(data.user_if_love==1){
                            $("#user_if_like").text("以点赞");
                        }
                    }
                });
            }else {
                $.ajax({
                    //contentType:"application/json;charset=UTF-8",//发送数据以key=value的形式传递
                    data: {userid:userid,articleid:articleid},//向后台controller发送的数据
                    dataType:"json", //json格式解析返回数据
                    type:"post",
                    url:"/article/deletelike",
                    error:function (XMLHttpRequest, textStatus, errorThrown) {
                        console.log(XMLHttpRequest.status); //状态码
                        console.log(XMLHttpRequest.readyState); //状态
                        console.log(textStatus); //错误信息
                    },
                    success:function (data) {
                        $("#loveamount").text("点赞数:"+data.article_love_amount);
                        if(data.user_if_love==0){
                            $("#user_if_like").text("点赞");
                        }
                    }
                });
            }
        }
        function getrewardmoney(val) {
            var rewardm = $(val).text();
            $("#rewardmoney").text(rewardm);
        }
        function truereward() {
            var rewarddescribe=$("#rewardinductor").val();
            var rewardmoney= $("#rewardmoney").text();
            console.log(rewarddescribe+" "+rewardmoney);
            var userid=${user.userid};
            var articleid=${article.articleid};
            var if_reward = $("#is_rewardbutton").text();
            if(if_reward=="已打赏"){
                alert("不可重复打赏");
            }
            else {
                $.ajax({
                    //contentType:"application/json;charset=UTF-8",//发送数据以key=value的形式传递
                    data: {articleid:articleid,userid:userid,rewardmoney:rewardmoney,rewarddescribe:rewarddescribe},//向后台controller发送的数据
                    dataType:"json", //json格式解析返回数据
                    type:"post",
                    url:"/article/rewardarticlemoney",
                    error:function (XMLHttpRequest, textStatus, errorThrown) {
                        console.log(XMLHttpRequest.status); //状态码
                        console.log(XMLHttpRequest.readyState); //状态
                        console.log(textStatus); //错误信息
                    },
                    success:function (data) {
                        if(data==1){
                            alert("打赏成功");
                        }else {
                            alert("余额不足");
                        }
                    }
                });
            }
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
    <div class="article">
        <div class="article_title">
            <h1>${article.articletitle}</h1>
        </div>
        <div class="article_mark">
            <ul>
                <li>作者:${user_article_name}</li>
                <li>时间:${article.date}</li>
                <li id="loveamount">点赞数:${article.loveamount}</li>
            </ul>
        </div>
        <div class="content">
            <textarea readonly class="content_main">${article.articlecontent}</textarea>
        </div>
        <div class="article_pinglun">
            <div class="btn-group" style="margin-left: 420px">
                <button type="button" class="btn btn-primary btn-lg" onclick="useridaddlike(this)" id="user_if_like">点赞</button>
                <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">评论</button>
                <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#rewardModal" id="is_rewardbutton">打赏</button>
                <button type="button" class="btn btn-primary btn-lg">收藏</button>
                <button type="button" class="btn btn-primary btn-lg">...</button>
            </div>
        </div>
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">评论界面</h4>
                    </div>
                    <div class="modal-body"><textarea id="pingluncontent" placeholder="输入需要评论的文字" style="width: 100%"></textarea></div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button id="pinglun" type="button" data-dismiss="modal" class="btn btn-primary">评论</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal -->
        </div>
        <div class="modal fade" id="rewardModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" style="text-align: center">打赏:<span id="rewardmoney"></span></h4>
                        <div class="btn-group" >
                            <button type="button" class="btn btn-default" style="margin-left: 200px" onclick="getrewardmoney(this)">100</button>
                            <button type="button" class="btn btn-default" onclick="getrewardmoney(this)">200</button>
                            <button type="button" class="btn btn-default" onclick="getrewardmoney(this)">300</button>
                        </div>
                    </div>
                    <div class="modal-body"><textarea  id="rewardinductor" placeholder="打赏描述" style="width: 100%"></textarea></div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button  type="button" data-dismiss="modal" class="btn btn-primary" onclick="truereward()">确认打赏</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal -->
        </div>
        <div class="pinglunframe">
            <table class="table table-striped">
                <thead>
                </thead>
                <tbody id="tbody">
                <c:forEach items="${listreplybyid}" var="reply" varStatus="vs">
                    <script>
                        $(function () {
                            $.ajax({
                                //contentType:"application/json;charset=UTF-8",//发送数据以key=value的形式传递
                                data: {replyid:${reply.replyid}},//向后台controller发送的数据
                                dataType:"json", //json格式解析返回数据
                                type:"post",
                                url:"/replyperson/listreplypersonbyreplyid",
                                error:function (XMLHttpRequest, textStatus, errorThrown) {
                                    console.log(XMLHttpRequest.status); //状态码
                                    console.log(XMLHttpRequest.readyState); //状态
                                    console.log(textStatus); //错误信息
                                },
                                success:function (data) {
                                    if(data!=null){
                                        for(var i = 0; i < data.length; i++) {
                                            console.log(data[i].replypersonid+" "+data[i].replyid," "+data[i].userid+" "+data[i].replycontent);
                                            let aftertr=$("#replyid${reply.replyid}");
                                            let tr= $("<tr style=\"width: 600px;margin-left: 50px\"></tr>");
                                            let td1 = $("<td></td>");
                                            let td2 = $("<td></td>");
                                            let img =$("<img src=\"https://profile.csdnimg.cn/2/C/C/3_qq_41076792\" username=\"qq_41076792\" alt=\"qq_41076792\" class=\"avatar\">");
                                            let input=$("<input type=\"text\" readonly placeholder=\"输入答复内容.....\" style=\"width: 600px;margin-left: 100px;height: 35px\">");
                                            input.val(data[i].username+"  回复:  "+data[i].replycontent);
                                            td2.text("");
                                            let div=$("<div class=\"operaterdiv\"></div>");
                                            let deletereplyperson=$("<button class=\"operater\" onclick=\"deletereplyperson(this)\"></button>");
                                            deletereplyperson.html("删除");
                                            div.append(deletereplyperson);
                                            td2.append(div);
                                            td1.append(img);
                                            td1.append(input);
                                            tr.append(td1);
                                            tr.append(td2);
                                            aftertr.after(tr);
                                            tr.attr('id',data[i].userid+'tr'+data[i].replypersonid);
                                        }
                                    }
                                }
                            });
                        })
                    </script>
                    <tr id="replyid${reply.replyid}">
                        <td><img src="https://profile.csdnimg.cn/2/C/C/3_qq_41076792" username="qq_41076792" alt="qq_41076792" class="avatar">${reply.username}&nbsp;评论: &nbsp;&nbsp;${reply.content}</td>
                        <td>
                            <div class="operaterdiv">
                                <button class="operater" onclick="replyperson(this)">回复</button>
                                <button class="operater" onclick="deletereply(this)">删除
                                    <span class="replyid" style="display: none">${reply.replyid}</span>
                                    <span id="replyuserid" style="display: none">${reply.userid}</span>
                                </button>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
