package com.example.personinformation.controller;

import java.io.IOException;
import java.util.concurrent.ConcurrentHashMap;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import com.example.personinformation.bean.usermsg;
import com.example.personinformation.service.usermsgservice;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

//该注解用来指定一个URI，客户端可以通过这个URI来连接到WebSocket。类似Servlet的注解mapping。无需在web.xml中配置。
//chatDemo：表示访问的具体url。{sendUser}：表示在url上的参数
@ServerEndpoint("/chatDemo/{sendUser}")
@Component
public class Chat{
    private static usermsgservice umsgservice;
    @Autowired
    public void setusermsgservice(usermsgservice umsgservice){
        Chat.umsgservice=umsgservice;
    }
    // 用户在线数
    private static int onLineCount = 0;
    // 当前的websocket对象
    private static ConcurrentHashMap<Integer, Chat> webSocketMap = new ConcurrentHashMap<Integer, Chat>();
    // 当前会话,属于websocket的session
    private Session session;
    // 聊天信息
    private Integer sendUser;// 当前用户
    private Integer toUser;// 接收人
    private String message;// 聊天信息
    private Object usermsg1;

    /**
     * 连接建立成功调用的方法
     * @param session 可选的参数。session为与某个客户端的连接会话，需要通过它来给客户端发送数据
     * @PathParam("sendUser") 表示可以在访问的时候带上参数，参数：sendUser为  @ServerEndpoint("/chatDemo/{sendUser}")
     * @throws IOException
     */
    @OnOpen
    public void onOpen(@PathParam("sendUser") Integer sendUser,Session session) throws IOException {
        this.sendUser = sendUser;
        this.session = session;
        addOnlineCount();
        System.out.println("有新连接加入！当前在线人数为" + getOnlineCount() + " 当前session是" + session.hashCode());

        webSocketMap.put(sendUser, this);//当前用户的websocket
        // 刷新在线人数
        for (Chat chat : webSocketMap.values()) {
            //使用if判断是要统计人数还是发送消息
            chat.sendMessage("count",getOnlineCount() + "");
        }
    }

    /**
     * 连接关闭所调用的方法
     *
     * @return
     * @throws IOException
     */
    @OnClose
    public void onClose() throws IOException {
        // 在线数减1
        subOnlineCount();

        for (Chat chat : webSocketMap.values()) {
            //说明当前的session已经被关闭
            if(chat.session != this.session){
                chat.sendMessage("count", getOnlineCount() + "");
            }
        }
        webSocketMap.remove(sendUser);
        System.out.println("有一连接关闭！当前在线人数为" + getOnlineCount());
    }

    /**
     * 收到客户端的消息后所调用的方法
     *
     * @param message  客户端发送过来的消息
     * @param session  可选的参数，同上
     * @throws IOException
     */
    @OnMessage
    public void onMessage(String jsonMsg, Session session) throws IOException {
        JSONObject jsonOject = JSONObject.fromObject(jsonMsg);
        sendUser = Integer.parseInt(jsonOject.getString("sendUser"));
        toUser = Integer.parseInt(jsonOject.getString("toUser"));
        message = jsonOject.getString("message");
        message = "来自:" + sendUser + "用户发给" + toUser + "用户的信息:" + message + " \r\n";
        // 得到接收人
        Chat user = webSocketMap.get(toUser);
        if (user == null) {//如果接收人不存在则保持到数据库
            message = "来自:" + sendUser + ":用户发给:" + toUser + ":用户的信息:" + message + " \r\n";
            System.out.println("信息已保存到数据库");
            usermsg u=new usermsg();
            u.setToUser(toUser);
            u.setSendUser(sendUser);
            u.setMessage(message);
            umsgservice.addusermsg(u);
            return;
        }
        user.sendMessage("send",message);
    }
    /**
     * 发成错误所调用的方法
     * @param session
     * @param error
     */
    @OnError
    public void onError(Session session, Throwable error) {
        System.out.println("发生错误");
        error.printStackTrace();
    }

    /**
     * 这个方法与上面几个方法不一样。没有用注解，是根据自己需要添加的方法。
     * @param type 根据类型判断是要进行在线人数统计还是发送消息  count：人数统计  send：发送消息
     * @param message
     * @param receive
     * @throws IOException
     */
    public void sendMessage(String type,String message) throws IOException {
        if(type.equals("count")){
            this.session.getBasicRemote().sendText("count:" + message);//在jsp判断是否包含count
        }else{
            this.session.getBasicRemote().sendText(message);//提供阻塞式的消息发送方式
            // this.session.getAsyncRemote().sendText(message);//提供非阻塞式的消息传输方式。
        }
    }

    // 获得当前在线人数
    public static synchronized int getOnlineCount() {
        return onLineCount;
    }

    // 新用户
    public static synchronized void addOnlineCount() {
        Chat.onLineCount++;
    }

    // 移除退出用户
    public static synchronized void subOnlineCount() {
        Chat.onLineCount--;
    }
}