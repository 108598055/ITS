<%--
  Created by IntelliJ IDEA.
  User: leo
  Date: 2019/12/22
  Time: 下午 07:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.13.0/moment.min.js"></script>
    <style>
    </style>

</head>
<body class="body" bgcolor="#87cefa">
<div style="width:1100px;height:400px;border-style:solid;border-width:1px;margin:5% auto;border-color:black;padding:20px 20px;">
    <div style="float:left;width:63%;height:90%;border-style:solid;border-width:1px;border-color:#669999;padding:5px">
        <div style="float:left;width:44%;height:90%;border-style:solid;border-width:1px;border-color:#669999;margin:7px;padding:5px">
            <div style="width:93%;height:30%;border-style:solid;border-width:1px;border-color:#669999;margin:3px auto;text-align:center;font-size:28px;font-family:monospace;">
                事件總數<br>
                <font color="#ff0000">23</font>
            </div>
            <div style="width:93%;height:30%;border-style:solid;border-width:1px;border-color:#669999;margin:3px auto;text-align:center;font-size:28px;font-family:monospace;">
                已指派<br>
                <font color="#ff0000">11</font>
            </div>
            <div style="width:93%;height:30%;border-style:solid;border-width:1px;border-color:#669999;margin:3px auto;text-align:center;font-size:28px;font-family:monospace;">
                未指派<br>
                <font color="#ff0000">12</font>
            </div>
        </div>
        <div style="float:right;width:48%;height:90%;border-style:solid;border-width:1px;border-color:#669999;margin:7px;padding:7px 5px">
            <div style="width:93%;height:55%;border-style:solid;border-width:1px;border-color:#669999;margin:10px auto;text-align:center;font-size:28px;font-family:monospace;text-align:center;line-height:170px;">
                已經完成&nbsp;<font color="#ff0000">11</font>
            </div>
            <div style="width:93%;height:30%;border-style:solid;border-width:1px;border-color:#669999;margin:10px auto;text-align:center;font-size:28px;font-family:monospace;text-align:center;line-height:80px;">
                待完成&nbsp;<font color="#ff0000">15</font>
            </div>
        </div>
    </div>
    <div style="float:right;width:33%;height:95%;border-style:solid;border-width:1px;border-color:#669999;">
        <canvas id="canvasPie"></canvas>
    </div>
</div>
</body>
<script>
    //資料標題
    var labels= ['已經完成','待完成'];

    var ctx = document.getElementById('canvasPie').getContext('2d');
    var pieChart = new Chart(ctx, {
        type: 'pie',
        data : {
            labels:labels,
            datasets: [{
                //預設資料
                data:[11,15],//data[0]=>已經完成,data[1]=>未完成
                backgroundColor: ["#8cd98c","#ffc34d"],
            }],
        }
    });
</script>
</html>
