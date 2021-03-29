<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/8/2
  Time: 22:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Title</title>
    <script>
        var ws;
        function login() {
            if ("WebSocket" in window)
            {
                var sendUser=document.getElementById("sendUser").value;
                document.getElementById("sendUser").disabled=true;
                alert("您的浏览器支持 WebSocket!");

                // 打开一个 web socket
                ws = new WebSocket("ws://localhost:8001/chatDemo/"+sendUser);
                ws.onopen = function()
                {
                    document.getElementById("status").innerHTML="连接服务器成功";
                };
                ws.onmessage = function (event)
                {
                    if(event.data.indexOf("count")>-1){
                        var msg=event.data;
                        var data=msg.split(":");
                        document.getElementById('count').innerHTML=data[1];
                    }else {
                        setMessageInnerHTML(event.data);
                    }
                };

                ws.onclose = function()
                {
                   document.getElementById('status').innerHTML="连接被成功关闭";
                };
                window.onbeforeunload=function () {
                    ws.close();
                }
            }
            else
            {
                // 浏览器不支持 WebSocket
                alert("您的浏览器不支持 WebSocket!");
            }
        }
        //将消息显示在网页上
        function setMessageInnerHTML(innerHTML){
            document.getElementById('showMsg').innerHTML += innerHTML;
        }

        //关闭连接
        function closeWebSocket(){
            ws.close();
        }

        //发送消息
        function send(){
            var sendUser = document.getElementById("sendUser").value;
            var toUser = document.getElementById("toUser").value;
            var message = document.getElementById("message").value;

            var jsonMsg = {"sendUser":sendUser,"toUser":toUser,"message":message}
            ws.send(JSON.stringify(jsonMsg));

            console.log("发送的消息"+message);
        }
    </script>
</head>
    <body>
        账号:<input type="text" name="sendUser" id="sendUser"/>
        <input type="button" id="login" value="登录" onclick="login()"/>
        <input type="button" onclick="closeWebSocket()" value="退出">
        在线人数:<font id="count"></font> 连接状态:<font id="status"></font>
        <br/>
        接收人:<input type="text" name="toUser" id="toUser"><br/>
        消息框:<br/>
        <textarea rows="5" cols="5" id="showMsg" name="showMsg" disabled="disabled" style="width: 302px; height: 111px; "></textarea><br/>
        <textarea rows="5" cols="5" id="message" name="sendMsg" style="width: 302px; height: 111px; "></textarea><br/>
        <input type="button" value="发送" onclick="send()"/><input type="button" value="关闭" onclick="closeWebSocket()"/>
    </body>
</html>
