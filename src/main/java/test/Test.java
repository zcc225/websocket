package test;

import java.awt.image.DataBufferUShort;
import java.util.Date;
import java.util.LinkedList;
import java.util.Queue;

import org.apache.commons.lang3.StringUtils;

import com.zccpro.util.DateStyle;
import com.zccpro.util.DateUtil;

public class Test {
public static void main(String[] args) {
	
	 LinkedList<String> linkedList = new LinkedList<String>();
	
	for (int i = 0; i < 20; i++) {
		linkedList.offer(i+"");
		if(linkedList.size()>10){
			linkedList.remove(linkedList.element());
		}
	}
	
	String join = StringUtils.join(linkedList.toArray(), ",");
	System.out.println(join);
	String[] split = join.split(",");
//	Object[] array =  linkedList.toArray();
//	
//	for (Object string : array) {
//		System.out.println(String.valueOf(string));
//	}
	System.out.println(split.toString());
	
//	String dateToString = DateUtil.DateToString(new Date(), DateStyle.HH_MM_SS_EN_YYYY_MM_DD);
//	System.out.println(dateToString);
	
	
	
}
}
