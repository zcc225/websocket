package com.zccpro.websocket;

import java.io.IOException;
import java.util.Date;
import java.util.LinkedList;
import java.util.Queue;
import java.util.Random;
import java.util.concurrent.CopyOnWriteArraySet;

import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;

import org.apache.commons.lang3.StringUtils;

import com.zccpro.util.DateStyle;
import com.zccpro.util.DateUtil;

/**
 * @ServerEndpoint ע����һ�����ε�ע�⣬���Ĺ�����Ҫ�ǽ�Ŀǰ���ඨ���һ��websocket��������,
 * ע���ֵ�������ڼ����û����ӵ��ն˷���URL��ַ,�ͻ��˿���ͨ�����URL�����ӵ�WebSocket��������
 */
@ServerEndpoint("/websocket")
public class WebSocketTest {
    //��̬������������¼��ǰ������������Ӧ�ð�����Ƴ��̰߳�ȫ�ġ�
    private static int onlineCount = 0;

    //concurrent�����̰߳�ȫSet���������ÿ���ͻ��˶�Ӧ��MyWebSocket������Ҫʵ�ַ�����뵥һ�ͻ���ͨ�ŵĻ�������ʹ��Map����ţ�����Key����Ϊ�û���ʶ
    private static CopyOnWriteArraySet<WebSocketTest> webSocketSet = new CopyOnWriteArraySet<WebSocketTest>();

    //��ĳ���ͻ��˵����ӻỰ����Ҫͨ���������ͻ��˷�������
    private Session session;
    
    private boolean flag = true;
    
    private int[] s={4,5,7,8,10,12};
   

//    /**
//     * ���ӽ����ɹ����õķ���
//     * @param session  ��ѡ�Ĳ�����sessionΪ��ĳ���ͻ��˵����ӻỰ����Ҫͨ���������ͻ��˷�������
//     */
//    @OnOpen
//    public void onOpen(Session session){
//        this.session = session;
//        webSocketSet.add(this);     //����set��
//        addOnlineCount();           //��������1
//        System.out.println("�������Ӽ��룡��ǰ��������Ϊ" + getOnlineCount());
//    }
    int randomNUm(){
    	Random random = new Random();
    	int nextInt = random.nextInt(s.length);
    	int i = s[nextInt];
    	return i;
    }
//    @OnOpen
//  public void onOpen(Session session){
//    	
//      this.session = session;
//      while(flag){
//    	  try {
//    		  StringBuffer sb =new StringBuffer();
//    		  sb.append("����:"+randomNUm()).append(",").append("ɽ��:"+randomNUm()).append(",").append("�人:"+randomNUm());
//			this.session.getBasicRemote().sendText(sb.toString());
//			System.out.println("�����С�����");
//			Thread.sleep(1000);
//		} catch (IOException e) {
//			flag = false;
//		} catch (InterruptedException e) {
//			System.out.println("�ر�");
//		}
//      }
//  }
    
  @OnOpen
  public void onOpen(Session session){
	  LinkedList<String> x = new LinkedList<String>();
	  LinkedList<Integer> y = new LinkedList<Integer>();
      this.session = session;
      while(flag){
    	  try {
    		  x.offer(DateUtil.DateToString(new Date(), DateStyle.HH_MM_SS_EN_YYYY_MM_DD));
    		  y.offer(randomNUm());
    		  if(x.size()>10){
    			x.remove(x.element());
    			y.remove(y.element());
    			}
    		  String xs = StringUtils.join(x.toArray(), ",");
    		  String ys = StringUtils.join(y.toArray(), ",");
			this.session.getBasicRemote().sendText(xs+"|"+ys);
			System.out.println("�����С�����"+xs+"|"+ys);
			Thread.sleep(1000);
		} catch (IOException e) {
			flag = false;
		} catch (InterruptedException e) {
			System.out.println("�ر�");
		}
      }
  }
    
    
    /**
   * ���ӹرյ��õķ���
   */
  @OnClose
  public void onClose(){
	  this.flag = false;
  }
//
//    /**
//     * ���ӹرյ��õķ���
//     */
//    @OnClose
//    public void onClose(){
//        webSocketSet.remove(this);  //��set��ɾ��
//        subOnlineCount();           //��������1
//        System.out.println("��һ���ӹرգ���ǰ��������Ϊ" + getOnlineCount());
//    }
//
//    /**
//     * �յ��ͻ�����Ϣ����õķ���
//     * @param message �ͻ��˷��͹�������Ϣ
//     * @param session ��ѡ�Ĳ���
//     */
//    @OnMessage
//    public void onMessage(String message, Session session) {
//        System.out.println("���Կͻ��˵���Ϣ:" + message);
//        //Ⱥ����Ϣ
//        for(WebSocketTest item: webSocketSet){
//            try {
//                item.sendMessage(message);
//            } catch (IOException e) {
//                e.printStackTrace();
//                continue;
//            }
//        }
//    }
//
//    /**
//     * ��������ʱ����
//     * @param session
//     * @param error
//     */
//    @OnError
//    public void onError(Session session, Throwable error){
//        System.out.println("��������");
//        error.printStackTrace();
//    }
//
//    /**
//     * ������������漸��������һ����û����ע�⣬�Ǹ����Լ���Ҫ��ӵķ�����
//     * @param message
//     * @throws IOException
//     */
//    public void sendMessage(String message) throws IOException{
//    	for (int i = 0; i < 1000000; i++) {
//			try {
//				Thread.sleep(1000);
//			} catch (InterruptedException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//			this.session.getBasicRemote().sendText("msg:"+i);
//		}
//        //this.session.getAsyncRemote().sendText(message);
//    }
//
//    public static synchronized int getOnlineCount() {
//        return onlineCount;
//    }
//
//    public static synchronized void addOnlineCount() {
//        WebSocketTest.onlineCount++;
//    }
//
//    public static synchronized void subOnlineCount() {
//        WebSocketTest.onlineCount--;
//    }
}