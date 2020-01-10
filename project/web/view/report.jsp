<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="controller.JdbcUtils" %>
<%@ page import="controller.GetParameter" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
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
<body class="body" bgcolor="#a8d8b9">
<div style="width:1100px;height:400px;border-style:solid;border-width:1px;margin:5% auto;border-color:black;padding:20px 20px;">
    <div style="float:left;width:63%;height:100%;border-style:solid;border-width:1px;border-color:#669999;padding:5px">
        <div style="float:left;width:44%;height:100%;margin:7px;padding:5px">
            <%
                Connection connection = null;
                PreparedStatement preparedStatement = null;
                ResultSet resultSet = null;
                String sql;
                GetParameter getParameter = new GetParameter();
                int count = 0;

                connection = JdbcUtils.getconn();
                sql = "select * from its_db.issue where projectID = ?";
                preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
//                System.out.println(session.getAttribute("projectname"));
                preparedStatement.setInt(1, Integer.parseInt(session.getAttribute("pjid").toString()));
                resultSet = preparedStatement.executeQuery();
                while(resultSet.next()) {
                    count++;
                }
            %>
            <div style="width: 100%;margin: 10px auto;text-align: center;font-size: 28px;font-family: monospace;text-align: center;line-height: 35px;">
                議題總數
                <font color="#ff0000"><%=count%></font>
            </div>
            <div style="width: 100%;margin: 10px auto;text-align: left;font-size: 25px;font-family: monospace;text-align: center;line-height: 20px;">
                <p id="start"></p>
                <p id="today"></p>
            </div>
            <br>
            <div id="flotcontainer"></div>
            <%
//                Connection connection = null;
//                PreparedStatement preparedStatement = null;
//                ResultSet resultSet = null;
//                String sql;
//                GetParameter getParameter = new GetParameter();
                int countTodo = 0;

                connection = JdbcUtils.getconn();
                sql = "select * from its_db.issue where state = ? and projectID = ?";
                preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
//                System.out.println(session.getAttribute("projectname"));
                preparedStatement.setString(1, "TO DO");
                preparedStatement.setInt(2, Integer.parseInt(session.getAttribute("pjid").toString()));
                resultSet = preparedStatement.executeQuery();
                while(resultSet.next()) {
                    countTodo++;
                }
            %>


        </div>
        <div style="float:right;width:48%;height:90%;margin:7px;padding:7px 5px">
            <div style="width: 100%;margin: 10px auto;text-align: left;font-size: 25px;font-family: monospace;text-align: center;line-height: 45px;">
                To Do：<font color="#ff0000"><%=countTodo%></font><br>
<%--            </div>--%>
            <%
//                Connection connection = null;
//                PreparedStatement preparedStatement = null;
//                ResultSet resultSet = null;
//                String sql;
//                GetParameter getParameter = new GetParameter();
                int countDoing = 0;

                connection = JdbcUtils.getconn();
                sql = "select * from its_db.issue where state = ? and projectID = ?";
                preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
//                System.out.println(session.getAttribute("projectname"));
                preparedStatement.setString(1, "DOING");
                preparedStatement.setInt(2, Integer.parseInt(session.getAttribute("pjid").toString()));
                resultSet = preparedStatement.executeQuery();
                while(resultSet.next()) {
                    countDoing++;
                }
            %>
<%--            <div style="width: 100%;margin: 10px auto;text-align: center;font-size: 28px;font-family: monospace;text-align: center;line-height: 80px;">--%>
                Doing：<font color="#ff0000"><%=countDoing%></font><br>
<%--            </div>--%>
            <%
//                Connection connection = null;
//                PreparedStatement preparedStatement = null;
//                ResultSet resultSet = null;
//                String sql;
//                GetParameter getParameter = new GetParameter();
                int countDone = 0;

                connection = JdbcUtils.getconn();
                sql = "select * from its_db.issue where state = ? and projectID = ?";
                preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
//                System.out.println(session.getAttribute("projectname"));
                preparedStatement.setString(1, "DONE");
                preparedStatement.setInt(2, Integer.parseInt(session.getAttribute("pjid").toString()));
                resultSet = preparedStatement.executeQuery();
                while(resultSet.next()) {
                    countDone++;
                }
            %>
<%--            <div style="width: 100%;margin: 10px auto;text-align: center;font-size: 28px;font-family: monospace;text-align: center;line-height: 80px;">--%>
                Done ：<font color="#ff0000"><%=countDone%></font>
            </div>
        </div>
    </div>
    <div style="float:right;width:33%;height:100%;border-style:solid;border-width:1px;border-color:#669999;">
        <canvas id="canvasPie"></canvas>
    </div>
</div>
</body>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script src="http://static.pureexample.com/js/flot/excanvas.min.js"></script>
<script src="http://static.pureexample.com/js/flot/jquery.flot.min.js"></script>

<!-- CSS -->
<style type="text/css">
#flotcontainer {
    width: 600px;
    height: 200px;
    text-align: center;
    margin: 0 auto;
}
</style>
<script>
    //資料標題
    var labels= ['Todo','Doing','Done'];

    var ctx = document.getElementById('canvasPie').getContext('2d');
    var pieChart = new Chart(ctx, {
        type: 'pie',
        data : {
            labels:labels,
            datasets: [{
                //預設資料
                data:[<%=countTodo%>,<%=countDoing%>,<%=countDone%>],//data[0]=>已經完成,data[1]=>未完成
                backgroundColor: ["#404040","#ffcd00","#00cc00"],
            }],
        }
    });

    function generateSeries(added){
        <%
            java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd");
//            Date date1 = new Date();
//            String strDate = format.format(date1);
//            java.util.Date beginDate= format.parse("2007-12-24");
//            java.util.Date endDate= format.parse("2007-12-25");

            Date date = null;
            connection = JdbcUtils.getconn();
            sql = "select * from its_db.issue where projectID = ? order by `date` asc";
            preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
            preparedStatement.setInt(1, Integer.parseInt(session.getAttribute("pjid").toString()));
            resultSet = preparedStatement.executeQuery();
            if(resultSet.next()) {
                date = resultSet.getDate(6);
            }
            else {
                date = Date.valueOf(LocalDate.now());
            }
            SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy/MM/dd");
            %>

        document.getElementById("start").innerHTML = "起始日期：<%=sdFormat.format(date)%>";
        document.getElementById("today").innerHTML = "今日日期：<%= sdFormat.format(Date.valueOf(LocalDate.now()))%>";
        <%
            long day=(Date.valueOf(LocalDate.now().plusDays(1)).getTime()-date.getTime())/(24*60*60*1000);
            long day_array[] = new long[(int)(day+1)];
            for(int i = 0; i < day_array.length; i++) {
                day_array[i] = 0;
            }
            connection = JdbcUtils.getconn();
            sql = "select * from its_db.issue where projectID = ?";
            preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
            preparedStatement.setInt(1, Integer.parseInt(session.getAttribute("pjid").toString()));
            resultSet = preparedStatement.executeQuery();
            while(resultSet.next()) {
                long beginday=(resultSet.getDate(6).getTime()-date.getTime())/(24*60*60*1000);
                long endday = 0;
                if(resultSet.getDate(9) != null) {
                    endday=(resultSet.getDate(9).getTime()-date.getTime())/(24*60*60*1000);
                }
                else {
                    endday = (Date.valueOf(LocalDate.now().plusDays(1)).getTime()-date.getTime())/(24*60*60*1000);
                }
                if(resultSet.getDate(9) != null) {
                    for(int i = (int)beginday; i < (int)endday; i++) {
                        day_array[i]++;
                    }
                }
                else {
                    for(int i = (int)beginday; i <= (int)endday; i++) {
                        day_array[i]++;
                    }
                }
            }
//            for(int i = 0; i < day_array.length; i++) {
//                System.out.print(day_array[i]+" ");
//            }
        %>
        var data = [];
        <% for(int i = 0; i < day_array.length; i++) {%>
            <%long d = day_array[i];
            int j = i + 1;%>
            data.push([<%=j%>, <%=d%>]);
        <%}%>
        return data;
    }

    $(document).ready(function(){
        var dataLarge1 = generateSeries(0);
        $.plot($("#flotcontainer"),
            [
                {label: "議題數量變化", data: dataLarge1}
            ],
            {
                grid: {
                    backgroundColor: { colors: ["#D1D1D1", "#7A7A7A"] }
                },
                xaxis: {
                    min: 1,
                    tickDecimals: 0
                },
                yaxis: {
                    min: 0,
                    tickDecimals: 0
                }
            }
        );
    });
</script>
</html>
