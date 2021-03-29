<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/7/21
  Time: 14:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>书籍</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://cdn.staticfile.org/vue/2.2.2/vue.min.js"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <style>
        body{
            background: mistyrose;
        }
        .booklist{
            width: 1400px;
            height: 1350px;
            background: white;
            margin: auto;
        }
        #mypage{
            width: 100%;
            height: 60px;
            margin: auto;
        }
        #mypage>button:first-child{
            margin-left: 640px;
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
            <a><p class="navbar-text navbar-right"><button id="userid" style="display: none">${user.userid}</button><button>${user.username}</button></p></a>
        </div>
    </div>
</nav>
    <div id="app" class="booklist">
        <nav class="navbar navbar-default" role="navigation">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="/personinformation"> < 个人中心</a>
                </div>
                <form class="navbar-form navbar-left" role="search">
                    <div class="form-group">
                        <input type="text" v-model="keyword"  class="form-control" placeholder="根据类型搜索" style="width: 700px">
                    </div>
                    <input @click="search();updatestatus()" type="button" value="搜索">
                    <input type="button" data-toggle="modal" data-target="#myModal" value="添加书籍信息" style="margin-left: 380px;width: 200px">
                </form>
            </div>
        </nav>
        <div class="row">
            <div v-for="result in results" class="col-sm-6 col-md-3" style="height: 390.5px;">
                <div class="thumbnail">
                    <div v-if="result.img.length>70"><img id="img1" :src="result.img" alt="通用的占位符缩略图"></div>
                    <div v-if="result.img.length<70"><img id="img2" src="/img/mental.jpg" alt="通用的占位符缩略图"></div>
                    <div class="caption">
                        <h3>{{result.price}}</h3>
                        <p style="height: 20px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;" v-html="result.title"></p>
                        <p>
                            <a href="#" @click="buybook($event)" class="btn btn-primary" role="button" data-toggle="modal" data-target="#buybook">
                                购买
                            </a>
                            <a href="#" @click="addbookcar($event)" class="btn btn-default" role="button" data-toggle="modal" data-target="#buycarbook">
                                加入购物车
                            </a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
        <div id="mypage"><button @click="prepage()">上一页</button><button @click="lastpage()">下一页</button></div>
        <!-- 模态框（Modal） -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="/addbook" method="post" enctype="multipart/form-data">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal"
                                    aria-hidden="true">×
                            </button>
                            <h4 class="modal-title" id="myModalLabel">
                                添加书籍
                            </h4>
                        </div>
                        <div class="modal-body">
                               书籍图片: <input name="multipart" type="file" style="display: inline-block">
                               <br>
                               价格:<input name="price" v-model="price" type="text" value="￥">
                               标题:<input name="title" v-model="title" type="text">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default"
                                    data-dismiss="modal">关闭
                            </button>
                            <button type="submit" class="btn btn-primary">
                                提交
                            </button>
                        </div>
                    </form>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->
        <!-- 模态框（Modal） -->
        <div class="modal fade" id="buybook" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"
                                aria-hidden="true">×
                        </button>
                        <h4 class="modal-title" id="mybuyinformation">
                            购买
                        </h4>
                    </div>
                    <div class="modal-body">
                       <div>
                           <span id="buytip" style="width: 100px; height: 40px; font-size: 22px ;height:43px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;" ></span>
                       </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default"
                                data-dismiss="modal">取消
                        </button>
                        <button  data-dismiss="modal" @click="truebuybook()" type="button" class="btn btn-primary">
                            确定购买
                        </button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->
        <!-- 模态框（Modal） -->
        <div class="modal fade" id="buycarbook" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"
                                aria-hidden="true">×
                        </button>
                        <h4 class="modal-title" id="mybuycarinformation">
                            购物车
                        </h4>
                    </div>
                    <div class="modal-body">
                        <span style="font-size: 22px">您确定加入购物车?</span>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default"
                                data-dismiss="modal">关闭
                        </button>
                        <button @click="trueaddbookcar()" data-dismiss="modal" type="button" class="btn btn-primary">
                            确定
                        </button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->
    </div>
    <script type="text/javascript">
        var myVue = new Vue({
            el:"#app",  // el选项可以是元素或css对象，指导dom来挂载vue实例
            data: {     // 声明需要双向绑定的数据
                dp1:"hello vue",
                dp2:120,
                keyword:"python",
                pageNo:1,
                pagesize:12,
                results:[],
                sizetotal:1,
                price:'',
                title:'',
                bookprice:'',
                booktitle:''
            },
            methods:{
                updatestatus:function(){
                    this.pageNo=1;
                    this.pagesize=12;
                    this.sizetotal=1;
                },
                search:function(){
                    var keyword=this.keyword;
                    var pagesize=this.pagesize.toString();
                    var pageNo=this.pageNo.toString();
                    axios.get('search/'+keyword+"/"+pageNo+"/"+pagesize).then(response=>{
                        console.log(response);
                        this.results=response.data;
                        if( this.results.length<12){
                            this.sizetotal=0;
                        }
                        console.log(this.sizetotal);
                    })
                },
                buybook:function (val) {
                    var button=val.currentTarget;
                    var mybook=button.parentElement.parentElement;
                    var price=mybook.firstElementChild;
                    this.bookprice=price.innerHTML;
                    this.booktitle=price.nextElementSibling.innerText;
                    console.log(price);
                    $("#buytip").text("您确定消费"+this.bookprice+"购买此书");
                },
                truebuybook:function (){
                    var userid=document.getElementById("userid").innerText;
                    console.log(userid+" "+this.booktitle+""+this.bookprice);
                    axios.get('buybook/'+userid+"/"+this.booktitle+"/"+this.bookprice).then(response=>{
                        if(response.data==1){
                            alert("购买成功");
                            window.location.href="/myreward";
                        }
                        else{
                            alert("购买失败,请查询余额是否不足！");
                        }
                    })
                },
                addbookcar:function (val) {
                    var button=val.currentTarget;
                    var mybook=button.parentElement.parentElement;
                    var price=mybook.firstElementChild;
                    this.bookprice=price.innerHTML;
                    this.booktitle=price.nextElementSibling.innerText;
                },
                trueaddbookcar:function (){
                    var userid=document.getElementById("userid").innerText;
                    console.log(userid+" "+this.booktitle+""+this.bookprice);
                    axios.get('addbookcar/'+userid+"/"+this.booktitle+"/"+this.bookprice).then(response=>{
                        if(response.data==1){
                            alert("已添加进入您的购物车,i请你在个人中心区查看");
                        }
                    })
                },
                prepage:function () {
                    if(this.pageNo-12>=0){
                        this.pageNo=this.pageNo-12;
                        this.search();
                        this.sizetotal=1;
                    }else {
                        alert("已经是第一页的");
                    }
                },
                lastpage:function () {
                    if(this.sizetotal==1){
                        this.pageNo=this.pageNo+12;
                        this.search();
                    }else {
                        alert("已经是第最后一页的");
                    }
                }
            },
            mounted:function () {
                this.search();
            }
        });
    </script>
</body>
</html>
