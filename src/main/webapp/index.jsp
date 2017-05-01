<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>优债债务统计</title>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/echarts/3.5.4/echarts.js"></script>
</head>
<body >
	<br>
	<br>
	<div align="center" id="main" style="width: 1200px; height:600px;"></div>
</body>

<script type="text/javascript">

var myChart ;
var option;
window.onload=function(){
	myChart = echarts.init(document.getElementById('main'));
}
var colors = ['#5793f3', '#d14a61', '#675bba'];

    var websocket = null;
    //判断当前浏览器是否支持WebSocket
    if ('WebSocket' in window) {
        websocket = new WebSocket("ws://localhost:8080/DaHandler");
    }
    else {
        alert('当前浏览器 Not support websocket')
    }

    //接收到消息的回调方法
    websocket.onmessage = function (event) {
    	var data = event.data.split("|");
    	var s0=data[0].split(",");//时间
    	var s1=data[1].split(",");//用户增长
    	var s2=data[2].split(",");//债务总额
    	var s3=data[3].split(",");//已处理总额
    	var s4=data[4].split(",");//未处理总额
    	var s5=data[5].split(",");//max

        // 指定图表的配置项和数据
       option = {
    color: colors,
    
    tooltip: {
        trigger: 'axis',
        axisPointer: {type: 'cross'}
    }, 
    grid: {
        right: '20%'
    },
    toolbox: {
        feature: {
            dataView: {show: true, readOnly: false},
            restore: {show: true},
            saveAsImage: {show: true}
        }
    },
    
    legend: {
        data:['未处置总额','已处置总额','债务总额']
    },
    xAxis: [
        {
            type: 'category',
            axisTick: {
                alignWithLabel: true
            },
            data: s0
        }
    ],
    yAxis: [
        {
            type: 'value',
            name: '未处置总额',
            min: 0,
            max: s5[0],
            position: 'right',
            axisLine: {
                lineStyle: {
                    color: colors[0]
                }
            },
            axisLabel: {
                formatter: '{value}千万'
            }
        },
        {
            type: 'value',
            name: '已处置总额',
            min: 0,
            max: s5[0],
            position: 'right',
            offset: 80,
            axisLine: {
                lineStyle: {
                    color: colors[1]
                }
            },
            axisLabel: {
                formatter: '{value}千万'
            }
        },
        {
            type: 'value',
            name: '债务总额',
            min: 0,
            max: s5[0], 
            position: 'left',
            axisLine: {
                lineStyle: {
                    color: colors[2]
                }
            },
            axisLabel: {
                formatter: '{value}千万 '
            }
        }
    ],
    title : {text: '2017年度优债债务统计'},
    series: [
        {
            name:'未处置总额',
            type:'bar',
            data:s4
        },
        {
            name:'已处置总额',
            type:'bar',
            yAxisIndex: 1,
            data:s3
        },
        {
            name:'债务总额',
            type:'line',
            yAxisIndex: 2,
            data:s2
        }
    ]
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