<%--
  Created by IntelliJ IDEA.
  User: snowchappie
  Date: 2019/12/20
  Time: 下午 09:07
  To change this template use File | Settings | File Templates.
--%>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="controller.IssueDisplay" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="controller.Issue" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="controller.JdbcUtils" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<html>
<head>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <title>議題</title>
    <style>
        .issuecontent{
            border: 10px solid aquamarine;
            position: absolute;
            top: 30%;
            height: auto;
            width: auto;
            display: none;
            z-index: 999;
            background: bisque;
            margin-left: 40%;
        }
        .btnnewdiv{
            box-shadow: 3px 4px 0px 0px #899599;
            background:linear-gradient(to bottom, #ededed 5%, #bab1ba 100%);
            background-color:#ededed;
            border-radius:15px;
            border:1px solid #d6bcd6;
            display:inline-block;
            cursor:pointer;
            color:#3a8a9e;
            font-family:Arial;
            font-size:16px;
            padding:12px 15px;
            text-decoration:none;
            text-shadow:0px 1px 0px #e1e2ed;
        }
        .btnnewdiv:hover {
            background:linear-gradient(to bottom, #bab1ba 5%, #ededed 100%);
            background-color:#bab1ba;
        }
        .selectcss{
            margin-top: 50px;
            color: #fff;
            background-color: #779126;
            -webkit-border-radius: 20px;
            -moz-border-radius: 20px;
            border-radius: 20px;
            padding: 8px 60px;
        }
    </style>
</head>
<body>
<div style="overflow: hidden">
    <div class="container-fluid" style="position: relative;overflow-y:auto">
        <div style="right: 30px;bottom: 30px;position: absolute;z-index: 999">
            <button class="btnnewdiv" onclick="newissuebtn()">+</button>
        </div>
        <!-- 確定要刪除議題? -->
        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">確定刪除此議題?</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        ...
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary">確定</button>
                    </div>
                </div>
            </div>
        </div>
        <%--    修改議題--%>
        <div id="issueall" class="issuecontent" style="overflow-y:auto;overflow-x:hidden">
            <div style="right: 0px;top: 0px;position: absolute;">
                <button onclick="cancelbtn('issueall')">X</button>
            </div>
            <p id="issue1"></p>
            <p id="issue2"></p>
            <p id="issue3"></p>
            <p id="issue4"></p>
            <div id="onlydone">
                <p id="issuereply"></p>
                <textarea readonly id="doneresult" style="overflow:auto;width:450px;height:80px"></textarea>
            </div>
            <form id="replyissue" action="/reply" method="post" style="width:450px;">
                <%--            可使用參數名name--%>
                <%--            pjid：議題id、originstate：原始議題狀態、state：改變議題狀態、content：回復議題內容--%>
                <div id="subissue" style="display: none">
                    <input type="hidden" name="pjid" id="issue0" value="">
                    <input type="hidden" name="originstate" id="oristate" value="">
                    <select class="custom-select mr-sm-2" style="font-size:20px;" id="inlineFormCustomSelect" name="state">
                    </select>
                    <br>
                    <br>
                    <div id="texta"></div>
                    <input type="submit" value="送出">
                </div>
            </form>
        </div>
        <%--    新增議題--%>
        <div id="newissue" class="issuecontent" style="overflow-y:auto;overflow-x:hidden;display: none">
            <div style="right: 0px;top: 0px;position: absolute;">
                <button onclick="cancelbtn('newissue')">X</button>
            </div>
            <form id="newissueform" action="" method="post" style="width:450px;">
                <input type="hidden" name="pjid" id="newpjid" value="hihi">  <%--session---projectid--%>
                議題名稱<br>
                <input type="text" name="newname"><br>
                議題內容<br>
                <input type="text" name="newcontent"><br>
                議題負責人
                <select name="ownerid" class="selectcss">

                    <%  Connection connection = null;
                        PreparedStatement preparedStatement = null;
                        ResultSet resultSet = null;
                        try {
                            connection = JdbcUtils.getconn();
//                        String role = "Project Manager";
                            String sql = "select * from its_db.project where name = ?";
                            preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
                            preparedStatement.setString(1,"hihi");
                            resultSet = preparedStatement.executeQuery();
                            while(resultSet.next()){
                    %>
                    <option value=<%=resultSet.getString(3)%>><%=resultSet.getString(3)%></option>
                    <%      }
                    }
                    catch (SQLException e) {
                        e.printStackTrace();
                    }
                    finally{
                        JdbcUtils.close(preparedStatement,connection);
                    }
                    %>
                </select>



                <%--java---date--%>
                <%--java---TO DO--%>
                <input type="submit" value="送出">
            </form>
        </div>
        <%--    議題主頁面--%>
        <div class="row h-100">
            <% IssueDisplay issue= new IssueDisplay();%>
            <div class="col-lg-4 bg-dark h-100 p-5">
                <div class="text-white text-center h1">TO DO</div>
                <div class="col h-100 p-5">
                    <%
                        ArrayList<Issue> todo = issue.toDoIssue();
                        for(int i = 0; i < todo.size(); i++){%>
                    <div class="panel panel-info" >
                        <div class="panel-heading">
                            <button type="button" class="close pull-right" aria-label="Close" data-toggle="modal" data-target="#exampleModal">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h3 class="panel-title"><%=todo.get(i).name%></h3>
                        </div>
                        <div class="panel-body" onclick="lookbtn(this)">
                            <%=todo.get(i).content%>
                        </div>
                        <div class="panel-footer" style="text-align: center;padding: 10px 15px 25px 15px;">
                            <p hidden><%=todo.get(i).id%></p>
                            <p hidden>TO DO</p>
                            <p hidden><%=todo.get(i).reply%></p>
                            <div style="position: absolute">議題負責人:<%=todo.get(i).ownerID%></div>
                            <div class="pull-right">創建日期:<%=todo.get(i).creatDate%></div>
                        </div>
                    </div>
                    <%}%>
                </div>
            </div>
            <div class="col-lg-4 bg-warning h-100 p-5">
                <div class="text-white text-center h1">DOING</div>
                <div class="col h-100 p-5">
                    <%
                        ArrayList<Issue> doing = issue.doingIssue();
                        for(int i = 0; i < doing.size(); i++){%>
                    <div class="panel panel-info" >
                        <div class="panel-heading">
                            <button type="button" class="close pull-right" aria-label="Close" data-toggle="modal" data-target="#exampleModal">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h3 class="panel-title"><%=doing.get(i).name%></h3>
                        </div>
                        <div class="panel-body"onclick="lookbtn(this)">
                            <%=doing.get(i).content%>
                        </div>
                        <div class="panel-footer" style="text-align: center;padding: 10px 15px 25px 15px;">
                            <p hidden><%=doing.get(i).id%></p>
                            <p hidden>DOING</p>
                            <p hidden><%=doing.get(i).reply%></p>
                            <div style="position: absolute">議題負責人:<%=doing.get(i).ownerID%></div>
                            <div class="pull-right">創建日期:<%=doing.get(i).creatDate%></div>
                        </div>
                    </div>
                    <%}%>
                </div>
            </div>
            <div class="col-lg-4 bg-success h-100 p-5">
                <div class="text-white text-center h1">DONE</div>
                <div class="col h-100 p-5">
                    <%
                        ArrayList<Issue> done = issue.doneIssue();
                        for(int i = 0; i < done.size(); i++){%>
                    <div class="panel panel-info" >
                        <div class="panel-heading">
                            <button type="button" class="close pull-right" aria-label="Close" data-toggle="modal" data-target="#exampleModal">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h3 class="panel-title"><%=done.get(i).name%></h3>
                        </div>
                        <div class="panel-body"onclick="lookbtn(this)">
                            <%=done.get(i).content%>
                        </div>
                        <div class="panel-footer" style="text-align: center;padding: 10px 15px 25px 15px;">
                            <p hidden><%=done.get(i).id%></p>
                            <p hidden>DONE</p>
                            <p hidden><%=done.get(i).reply%></p>
                            <div style="position: absolute">議題負責人:<%=done.get(i).ownerID%></div>
                            <div class="pull-right">創建日期:<%=done.get(i).creatDate%></div>
                        </div>
                    </div>
                    <%}%>
                </div>
            </div>
        </div>
    </div>
    <script>
        function cancelbtn(cancelid) {
            document.getElementById(cancelid).style.display="none";
        }
        function newissuebtn() {
            document.getElementById("newissue").style.display="block";
        }
        function lookbtn(objdiv) {
            //議題名稱
            document.getElementById("issue1").innerHTML = $(objdiv).parent().children('div:nth-child(1)').children('h3:nth-child(2)').text();
            //議題內容
            document.getElementById("issue2").innerHTML = $(objdiv).parent().children('div:nth-child(2)').text();
            //創建人
            document.getElementById("issue3").innerHTML = $(objdiv).parent().children('div:nth-child(3)').children('div:nth-child(4)').text();
            //創建時間
            document.getElementById("issue4").innerHTML = $(objdiv).parent().children('div:nth-child(3)').children('div:nth-child(5)').text();
            //議題id
            document.getElementById("issue0").value = $(objdiv).parent().children('div:nth-child(3)').children('p:nth-child(1)').text();
            //議題狀態
            document.getElementById("oristate").value = $(objdiv).parent().children('div:nth-child(3)').children('p:nth-child(2)').text();

            if($(objdiv).parent().children('div:nth-child(3)').children('p:nth-child(2)').text()=="TO DO"){
                //不要顯示textarea 顯示狀態選擇DOING DONE 沒有議題完成提示
                document.getElementById("onlydone").style.display="none";
                document.getElementById("inlineFormCustomSelect").innerHTML="<option value=\"DOING\">DOING</option><option value=\"DONE\">DONE</option>";
                document.getElementById("texta").innerHTML="";
                document.getElementById("subissue").style.display="block";
            }
            else if($(objdiv).parent().children('div:nth-child(3)').children('p:nth-child(2)').text()=="DOING"){
                //顯示議題回復textarea 顯示狀態選擇DONE 沒有議題完成提示
                document.getElementById("onlydone").style.display="none";
                document.getElementById("inlineFormCustomSelect").innerHTML="<option value=\"DOING\">DOING</option><option value=\"DONE\">DONE</option>";
                document.getElementById("texta").innerHTML="回覆議題內容<br><textarea id=\"replyid\"name=\"content\" style=\"resize:none;width:450px;height:100px;\"></textarea>";
                document.getElementById("replyid").value = $(objdiv).parent().children('div:nth-child(3)').children('p:nth-child(3)').text();
                document.getElementById("subissue").style.display="block";
            }
            else if($(objdiv).parent().children('div:nth-child(3)').children('p:nth-child(2)').text()=="DONE"){
                //不要顯示textarea 不顯示狀態選擇 提示已完成
                document.getElementById("inlineFormCustomSelect").innerHTML="";
                document.getElementById("onlydone").style.display="block";
                document.getElementById("issuereply").innerHTML="回覆內容";
                document.getElementById("doneresult").value= $(objdiv).parent().children('div:nth-child(3)').children('p:nth-child(3)').text();
                document.getElementById("subissue").style.display="none";
            }
            else{
            }
            document.getElementById("issueall").style.display="block";
        }
    </script>
</div>
</body>
</html>
