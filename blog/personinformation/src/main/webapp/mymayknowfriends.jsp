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
    <title>ๆ็ไบบ่</title>
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
                //contentType:"application/json;charset=UTF-8",//ๅ้ๆฐๆฎไปฅkey=value็ๅฝขๅผไผ?้
                data:{userid:userid},//ๅๅๅฐcontrollerๅ้็ๆฐๆฎ
                dataType:"json", //jsonๆ?ผๅผ่งฃๆ่ฟๅๆฐๆฎ
                type:"get",
                url:"/myaddfriendslist",
                error:function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log(XMLHttpRequest.status); //็ถๆ็?
                    console.log(XMLHttpRequest.readyState); //็ถๆ
                    console.log(textStatus); //้่ฏฏไฟกๆฏ
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
                //contentType:"application/json;charset=UTF-8",//ๅ้ๆฐๆฎไปฅkey=value็ๅฝขๅผไผ?้
                data:{userid:userid},//ๅๅๅฐcontrollerๅ้็ๆฐๆฎ
                dataType:"json", //jsonๆ?ผๅผ่งฃๆ่ฟๅๆฐๆฎ
                type:"get",
                url:"/queryfridens",
                error:function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log(XMLHttpRequest.status); //็ถๆ็?
                    console.log(XMLHttpRequest.readyState); //็ถๆ
                    console.log(textStatus); //้่ฏฏไฟกๆฏ
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
                //contentType:"application/json;charset=UTF-8",//ๅ้ๆฐๆฎไปฅkey=value็ๅฝขๅผไผ?้
                data:{userid:userid},//ๅๅๅฐcontrollerๅ้็ๆฐๆฎ
                dataType:"json", //jsonๆ?ผๅผ่งฃๆ่ฟๅๆฐๆฎ
                type:"get",
                url:"/mayknowperson",
                error:function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log(XMLHttpRequest.status); //็ถๆ็?
                    console.log(XMLHttpRequest.readyState); //็ถๆ
                    console.log(textStatus); //้่ฏฏไฟกๆฏ
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
                        td4.text("ๆทปๅ?");
                        tr.append(td1);
                        tr.append(td2);
                        tr.append(td3);
                        tr.append(td4);
                        tbody.append(tr);
                    }
                }
            });
            $.ajax({
                //contentType:"application/json;charset=UTF-8",//ๅ้ๆฐๆฎไปฅkey=value็ๅฝขๅผไผ?้
                data:{userid:userid},//ๅๅๅฐcontrollerๅ้็ๆฐๆฎ
                dataType:"json", //jsonๆ?ผๅผ่งฃๆ่ฟๅๆฐๆฎ
                type:"get",
                url:"/addmelist",
                error:function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log(XMLHttpRequest.status); //็ถๆ็?
                    console.log(XMLHttpRequest.readyState); //็ถๆ
                    console.log(textStatus); //้่ฏฏไฟกๆฏ
                },
                success:function (data) {
                    $("#addmelist").empty();
                    if(data.length>0){
                        $("#if_msg").text("ๆ"+data.length+"ๆกๆทปๅ?ๆถๆฏ");
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
                        button1.text("ๅๆ");
                        button2.text("ๆ็ป");
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
                //contentType:"application/json;charset=UTF-8",//ๅ้ๆฐๆฎไปฅkey=value็ๅฝขๅผไผ?้
                data:{userid:userid,agreeuserid:agreeuserid},//ๅๅๅฐcontrollerๅ้็ๆฐๆฎ
                dataType:"json", //jsonๆ?ผๅผ่งฃๆ่ฟๅๆฐๆฎ
                type:"get",
                url:"/agreeaddfriends",
                error:function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log(XMLHttpRequest.status); //็ถๆ็?
                    console.log(XMLHttpRequest.readyState); //็ถๆ
                    console.log(textStatus); //้่ฏฏไฟกๆฏ
                },
                success:function (data) {
                    alert("ๅทฒๅๆ");
                }
            })
        }
        function refuseaddfriends(val) {
            var tr=$(val).parent().parent();
            var agreeuserid=tr.children().eq(0).text();
            var userid=${user.userid};
            $.ajax({
                //contentType:"application/json;charset=UTF-8",//ๅ้ๆฐๆฎไปฅkey=value็ๅฝขๅผไผ?้
                data:{userid:userid,agreeuserid:agreeuserid},//ๅๅๅฐcontrollerๅ้็ๆฐๆฎ
                dataType:"json", //jsonๆ?ผๅผ่งฃๆ่ฟๅๆฐๆฎ
                type:"get",
                url:"/refuseaddfriends",
                error:function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log(XMLHttpRequest.status); //็ถๆ็?
                    console.log(XMLHttpRequest.readyState); //็ถๆ
                    console.log(textStatus); //้่ฏฏไฟกๆฏ
                },
                success:function (data) {
                    alert("ๅทฒๆ็ป");
                }
            })
        }
        function queryuser() {
            var adduserid=$("#adduserid").val();
            $("#addfrienduser").empty();
            $.ajax({
                //contentType:"application/json;charset=UTF-8",//ๅ้ๆฐๆฎไปฅkey=value็ๅฝขๅผไผ?้
                data:{userid:adduserid},//ๅๅๅฐcontrollerๅ้็ๆฐๆฎ
                dataType:"json", //jsonๆ?ผๅผ่งฃๆ่ฟๅๆฐๆฎ
                type:"get",
                url:"/user/getuser",
                error:function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log(XMLHttpRequest.status); //็ถๆ็?
                    console.log(XMLHttpRequest.readyState); //็ถๆ
                    console.log(textStatus); //้่ฏฏไฟกๆฏ
                },
                success:function (data) {
                    console.log(data);
                    var tr= $("#addfrienduser");
                    var td1=$("<td></td>");
                    var td2=$("<td></td>");
                    var td3=$("<td onclick=\"addfriends(this)\"></td>");
                    td1.text(data.userid);
                    td2.text(data.username);
                    td3.text("ๆทปๅ?");
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
                //contentType:"application/json;charset=UTF-8",//ๅ้ๆฐๆฎไปฅkey=value็ๅฝขๅผไผ?้
                data:{userid:userid,addeduserid:addeduserid},//ๅๅๅฐcontrollerๅ้็ๆฐๆฎ
                dataType:"json", //jsonๆ?ผๅผ่งฃๆ่ฟๅๆฐๆฎ
                type:"get",
                url:"/addfriends",
                error:function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log(XMLHttpRequest.status); //็ถๆ็?
                    console.log(XMLHttpRequest.readyState); //็ถๆ
                    console.log(textStatus); //้่ฏฏไฟกๆฏ
                },
                success:function (data) {
                    alert("ๆทปๅ?ๆถๆฏๅทฒๅ้๏ผ่ฏท่ๅฟ็ญๅพ");
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
                    ๅๅฎข
                </button>
                <button type="submit" class="btn btn-default">
                    ๅญฆ้ข
                </button>
                <button type="submit" class="btn btn-default">
                    ไธ่ฝฝ
                </button>
                <button type="submit" class="btn btn-default">
                    ่ฎบๅ
                </button>
                <button type="submit" class="btn btn-default">
                    ้ฎ็ญ
                </button>
                <button type="submit" class="btn btn-default">
                    ็ดๆญ
                </button>
                <button type="submit" class="btn btn-default">
                    ๆ่
                </button>
                <button type="submit" class="btn btn-default">
                    VIPไผๅ
                </button>
                <input type="text" placeholder="ๆ็ดขCSDN....." style="width: 300px;height: 35px">
                <button class="btn btn-default">
                    ๆ็ดข
                </button>
            </form>
            <!--ๅๅณๅฏน้ฝ-->
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a href="/personinformation" class="dropdown-toggle" data-toggle="dropdown">
                        ไธชไบบไธญๅฟ <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="/personinformation">ไธชไบบไฟกๆฏ</a></li>
                        <li><a href="/writearicle">ๅๅๅฎข</a></li>
                        <li><a href="/comment">่ฏ่ฎบ</a></li>
                        <li><a href="#">ๅณๆณจ</a></li>
                        <li><a href="/mylovearticle">็น่ต</a></li>
                        <li class="divider"></li>
                        <li><a href="#">็งไฟก</a></li>
                    </ul>
                </li>
            </ul>
            <form class="navbar-form navbar-right" role="search">
                <button type="submit" class="btn btn-default">
                    <a href="/login">็ปๅฝ</a>
                </button>
                <button type="submit" class="btn btn-default">
                    <a href="/register">ๆณจๅ</a>
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
                        <span style="margin-left:80px;font-size: 22px;color: white;cursor: pointer;margin-top: 40px" data-toggle="modal" data-target="#myModal">ๆฅๆพ</span>
                    </div>
                </div>
                <div style="margin-top: -160px">
                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th>็จๆทID</th>
                            <th>็จๆทๅ</th>
                            <th>ๆฏๅฆๆทปๅ?</th>
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
                                data-toggle="button" style="width: 150px;height: 50px">ๆ็ๅฅฝๅๅ่กจ</button></li>
                    <li><button type="button" class="btn btn-primary"
                                data-toggle="button" style="width: 150px;height: 50px">ๆๅฏ่ฝ่ฎค่ฏ็ไบบ</button></li>
                    <li><button type="button" class="btn btn-primary"
                                data-toggle="button" style="width: 150px;height: 50px">Cๅธ</button></li>
                    <li><button type="button" class="btn btn-primary"
                                data-toggle="button" style="width: 150px;height: 50px">ๅฎๅ่ฎค่ฏ</button></li>
                </ul>
            </div>
            <div class="content_right">
                <div class="one" style="display: none">
                    <div class="top">
                        <ul id="wallet_sort">
                            <li>ๆ็ๅฅฝๅ</li>
                            <li>ๆ็็ณ่ฏทๅ่กจ</li>
                            <li id="if_msg">ๆถๆฏ</li>
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
                                    <th>็จๆทID</th>
                                    <th>็จๆทๅ</th>
                                    <th>็ถๆ</th>
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
                                    <th>็จๆทID</th>
                                    <th>็จๆทๅ</th>
                                    <th>็ถๆ</th>
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
                                    <th>็จๆทID</th>
                                    <th>็จๆทๅ</th>
                                    <th>็ถๆ</th>
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
                            <li>ๆๅฏ่ฝ่ฎค่ฏ็ไบบ</li>
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
                                    <th>็จๆทID</th>
                                    <th>็จๆทๅ</th>
                                    <th>ๅฑๅๅฅฝๅๆฐ</th>
                                    <th>ๆฏๅฆๆทปๅ?</th>
                                </tr>
                                </thead>
                                <tbody id="mymayknowfridens">

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="three" style="display: none">ไธ</div>
                <div class="four" style="display: none">ๅ</div>
            </div>
        </div>
    </div>
    <!-- ๆจกๆๆก๏ผModal๏ผ -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-hidden="true">ร
                    </button>
                    <h4 class="modal-title" id="myModalLabel">
                        ๆฅๆพๅฅฝๅ
                    </h4>
                </div>
                <div class="modal-body">
                    <span style="font-size: 22px;">่พๅฅ็จๆทID:</span><input id="adduserid" type="text" style="width: 450px;height: 40px" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">ๅๆถ
                    </button>
                    <button onclick="queryuser()" data-dismiss="modal" type="button" class="btn btn-primary">
                        ๆฅๆพ
                    </button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
</body>
</html>
