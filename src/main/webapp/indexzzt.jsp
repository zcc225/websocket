<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Java后端WebSocket的Tomcat实现</title>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/echarts/3.5.4/echarts.js"></script>
</head>
<body>
    Welcome<br/><input id="text" type="text"/>
   <!--  <button onclick="send()">发送消息</button>
    <hr/>
    <button onclick="closeWebSocket()">关闭WebSocket连接</button>
    <hr/> -->
    <div id="message"></div>
     <div id="main" style="width: 600px;height:400px;"></div>
</body>

<script type="text/javascript">
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
        var myChart = echarts.init(document.getElementById('main'));

        // 指定图表的配置项和数据
        var option = {
            title: {
                text: '报表展示'
            },
            tooltip: {},
            legend: {
                data:['地区']
            },
            xAxis: {
                data: [s0[0],s1[0],s2[0]]
            },
            yAxis: {},
            series: [{
                name: '人数',
                type: 'bar',
                data: [s0[1],s1[1],s2[1]]
            }]
        };

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option)
       // setMessageInnerHTML(event.data);
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