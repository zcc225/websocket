<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Java后端WebSocket的Tomcat实现</title>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/echarts/3.5.4/echarts.js"></script>
	<script src="js/china.js" charset ="utf-8"></script>  
</head>
<body>
    <input id="text" type="text"/>
   <!--  <button onclick="send()">发送消息</button>
    <hr/>
    <button onclick="closeWebSocket()">关闭WebSocket连接</button>
    <hr/> -->
    <div id="message"></div>
     <div id="main" style="width: 600px;height:400px;"></div>
</body>

<script type="text/javascript">
var myChart ;
window.onload=function(){
	myChart = echarts.init(document.getElementById('main'));
	 alert("Hello world!");
}
function randomData() {
    return Math.round(Math.random()*1000);
}

    var websocket = null;
    //判断当前浏览器是否支持WebSocket
    if ('WebSocket' in window) {
        websocket = new WebSocket("ws://localhost:8080/websocket");
    }
    else {
        alert('当前浏览器 Not support websocket')
    }

    //连接发生错误的回调方法
    websocket.onerror = function () {
        setMessageInnerHTML("WebSocket连接发生错误");
    };

    //连接成功建立的回调方法
    websocket.onopen = function () {
        setMessageInnerHTML("WebSocket连接成功");
    }

    //接收到消息的回调方法
    websocket.onmessage = function (event) {
    	
    	var data = event.data.split(",");
    	var s0 = data[0].split(":");
    	var s1 = data[1].split(":");
    	var s2 = data[2].split(":");
    	//setMessageInnerHTML(s[0]);
    	//setMessageInnerHTML(s[1]);
    	   // 基于准备好的dom，初始化echarts实例
       // var myChart = echarts.init(document.getElementById('main'));

        // 指定图表的配置项和数据
        var option = {
        		 title: {
        		        text: 'iphone销量',
        		        subtext: '纯属虚构',
        		        left: 'center'
        		    },
        		    tooltip: {
        		        trigger: 'item'
        		    },
        		    legend: {
        		        orient: 'vertical',
        		        left: 'left',
        		        data:['iphone3','iphone4','iphone5']
        		    },
        		    visualMap: {
        		        min: 0,
        		        max: 2500,
        		        left: 'left',
        		        top: 'bottom',
        		        text: ['高','低'],           // 文本，默认为数值文本
        		        calculable: true
        		    },
        		    toolbox: {
        		        show: true,
        		        orient: 'vertical',
        		        left: 'right',
        		        top: 'center',
        		        feature: {
        		            dataView: {readOnly: false},
        		            restore: {},
        		            saveAsImage: {}
        		        }
        		    },
        		    series: [
        		        {
        		            name: 'iphone3',
        		            type: 'map',
        		            mapType: 'china',
        		            roam: false,
        		            label: {
        		                normal: {
        		                    show: true
        		                },
        		                emphasis: {
        		                    show: true
        		                }
        		            },
        		            data:[
        		                {name: '北京',value: randomData() },
        		                {name: '天津',value: randomData() },
        		                {name: '上海',value: randomData() },
        		                {name: '重庆',value: randomData() },
        		                {name: '河北',value: randomData() },
        		                {name: '河南',value: randomData() },
        		                {name: '云南',value: randomData() },
        		                {name: '辽宁',value: randomData() },
        		                {name: '黑龙江',value: randomData() },
        		                {name: '湖南',value: randomData() },
        		                {name: '安徽',value: randomData() },
        		                {name: '山东',value: randomData() },
        		                {name: '新疆',value: randomData() },
        		                {name: '江苏',value: randomData() },
        		                {name: '浙江',value: randomData() },
        		                {name: '江西',value: randomData() },
        		                {name: '湖北',value: randomData() },
        		                {name: '广西',value: randomData() },
        		                {name: '甘肃',value: randomData() },
        		                {name: '山西',value: randomData() },
        		                {name: '内蒙古',value: randomData() },
        		                {name: '陕西',value: randomData() },
        		                {name: '吉林',value: randomData() },
        		                {name: '福建',value: randomData() },
        		                {name: '贵州',value: randomData() },
        		                {name: '广东',value: randomData() },
        		                {name: '青海',value: randomData() },
        		                {name: '西藏',value: randomData() },
        		                {name: '四川',value: randomData() },
        		                {name: '宁夏',value: randomData() },
        		                {name: '海南',value: randomData() },
        		                {name: '台湾',value: randomData() },
        		                {name: '香港',value: randomData() },
        		                {name: '澳门',value: randomData() }
        		            ]
        		        }
        		    ]
        };

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option)
       setMessageInnerHTML(randomData());
    }

    //连接关闭的回调方法
    websocket.onclose = function () {
        setMessageInnerHTML("WebSocket连接关闭");
    }

    //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
    window.onbeforeunload = function () {
        closeWebSocket();
    }

    //将消息显示在网页上
    function setMessageInnerHTML(innerHTML) {
        document.getElementById('message').innerHTML += innerHTML + '<br/>';
    }

    //关闭WebSocket连接
    function closeWebSocket() {
        websocket.close();
    }

    //发送消息
    function send() {
        var message = document.getElementById('text').value;
        websocket.send(message);
    }
    
 ;
</script>
</html>