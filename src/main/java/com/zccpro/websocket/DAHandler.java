package com.zccpro.websocket;

import java.io.IOException;
import java.util.Date;
import java.util.LinkedList;
import java.util.Random;

import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.apache.commons.lang3.StringUtils;

import com.zccpro.util.DateStyle;
import com.zccpro.util.DateUtil;

@ServerEndpoint("/DaHandler")
public class DAHandler {

	 private Session session;
	 private boolean flag = true;
	 private int[] user={4,5,7,8,10,12};
	 private double[] money={40000000,50000000,70000000,80000000,120000,1200000};
	 private double[] disposal={40000000,5000000,7000000,8000000,10000000,12000000};
	 double total=0;
	 double totaldis=0;
	 int max=0;
	 int randomuser(){
	    	Random random = new Random();
	    	int nextInt = random.nextInt(user.length);
	    	int i = user[nextInt];
	    	return i;
	    }
	 int randommoney(){
	    	Random random = new Random();
	    	int nextInt = random.nextInt(money.length);
	    	double i = money[nextInt];
	    	total+=i;
	    	return (int) (total/10000000);
	    }
	 int randomDisposal(){
	    	Random random = new Random();
	    	int nextInt = random.nextInt(disposal.length);
	    	double i = disposal[nextInt];
	    	totaldis+=i;
	    	return (int) (totaldis/10000000);
	    }
	 int calNotDis(){
		 return (int) ((total-totaldis)/10000000);
	 }
	 int calmax(){
		 if(total/10000000>max){
			 max= (int) (total/10000000+100);
		 }
		 return max;
	 }
	
	 @OnOpen
	  public void onOpen(Session session){
		  LinkedList<String> nowdate = new LinkedList<String>();//当前时间
		  LinkedList<Integer> usergrowth = new LinkedList<Integer>();//用户增长
		  LinkedList<Integer> moneytotal = new LinkedList<Integer>();//债务总额
		  LinkedList<Integer> TotalDisposal = new LinkedList<Integer>();//已处置总额
		  LinkedList<Integer> TotalNotDisposal = new LinkedList<Integer>();//未处置总额
		  try {
	      this.session = session;
	      while(nowdate.size()<10){
    		  nowdate.offer(DateUtil.DateToString(new Date(), DateStyle.HH_MM_SS_EN_YYYY_MM_DD));//增加一条横坐标
	    	  usergrowth.offer(randomuser());//增加一个用户增长曲线
	    	  moneytotal.offer(randommoney());
	    	  TotalDisposal.offer(randomDisposal());
	    	  TotalNotDisposal.offer(calNotDis());
    	  }
	      while(flag){
	    	  nowdate.offer(DateUtil.DateToString(new Date(), DateStyle.HH_MM_SS_EN_YYYY_MM_DD));//增加一条横坐标
	    	  usergrowth.offer(randomuser());//增加一个用户增长曲线
	    	  moneytotal.offer(randommoney());
	    	  TotalDisposal.offer(randomDisposal());
	    	  TotalNotDisposal.offer(calNotDis());
    		  if(nowdate.size()>10){
    			  nowdate.remove(nowdate.element());
    			  usergrowth.remove(usergrowth.element());
    			  moneytotal.remove(moneytotal.element());
    			  TotalDisposal.remove(TotalDisposal.element());
    			  TotalNotDisposal.remove(TotalNotDisposal.element());
    			}
	    		  String nowdates = StringUtils.join(nowdate.toArray(), ",");
	    		  String usergrowths = StringUtils.join(usergrowth.toArray(), ",");
	    		  String moneytotals = StringUtils.join(moneytotal.toArray(), ",");
	    		  String TotalDisposals = StringUtils.join(TotalDisposal.toArray(), ",");
	    		  String TotalNotDisposals = StringUtils.join(TotalNotDisposal.toArray(), ",");
				this.session.getBasicRemote().sendText(nowdates+"|"+usergrowths+"|"+moneytotals+"|"+TotalDisposals+"|"+TotalNotDisposals+"|"+calmax());
				System.out.println("结果推送。。。"+nowdates+"|"+usergrowths+"|"+moneytotals+"|"+TotalDisposals+"|"+TotalNotDisposals+"|"+calmax());
				Thread.sleep(1000);
	      }
		  } catch (IOException e) {
			  flag = false;
		  } catch (InterruptedException e) {
			  System.out.println("关闭");
		  }
	  }
	    
}
