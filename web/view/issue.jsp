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
    <link href="/styles/issue.css" rel="stylesheet">
    <script src="/js/issuejs.js"></script>
    <title>議題</title>
</head>
<body style=" background-color: #343a40">
<style>
    .delcssi{
        position: absolute;
        top: 20%;
        left: 30%;
        height: 40%;
        width:40%;
        margin:0px auto;
        display: none;
        z-index: 999;
    }
</style>
<div style="overflow: hidden">
<div class="container-fluid" style="position: relative;overflow-y:auto">
    <%
        if(session.getAttribute("user_role").toString().equals("Project Manager")) {
    %>
    <div style="right: 30px;bottom: 30px;position: absolute;z-index: 999">
        <button class="btnnewdiv" onclick="newissuebtn()">+</button>
    </div>
    <%
        }
    %>
    <!-- 確定要刪除議題? -->
<%--    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">--%>
        <div class="delcssi" role="document" id="exampleModal">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">確定刪除此議題?</h5>
                </div>
                <div class="modal-body">
                    <form id="delissue" action="/del_issue" method="post" style="width:450px;">
                            <input type="hidden" name="pjid" id="issue9" value="">
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" onclick="cancel()">取消</button>
                    <button type="button" class="btn btn-primary" onclick="newmember('delissue')">確定</button>
                </div>
            </div>
        </div>
<%--    </div>--%>
    <%--    修改議題--%>
    <div id="issueall" class="issuecontent" style="overflow-y:auto;overflow-x:hidden;">
        <div style="right: 0px;top: 0px;position: absolute;">
            <button class="btncandiv" onclick="cancelbtn('issueall')">X</button>
        </div>

        <strong style="font-size: large"><p id="issue1" class="panel-heading"></p></strong>
        <p id="issue2"></p>
        <p id="issue3"></p>
        <p id="issue4"></p>
        <div id="onlydone">
            <p id="issuereply"></p>
            <textarea readonly id="doneresult" style="overflow:auto;width:450px;height:100px;resize:none;"></textarea>
        </div>
        <form id="replyissue" action="/reply" method="post" style="width:450px;">
        <%--            可使用參數名name--%>
        <%--            pjid：議題id、originstate：原始議題狀態、state：改變議題狀態、content：回復議題內容--%>
            <div id="subissue" style="display: none">
                <input type="hidden" name="pjid" id="issue0" value="">
                <input type="hidden" name="originstate" id="oristate" value="">
                &nbsp;&nbsp;選擇議題狀態
                <select class="custom-select mr-sm-2" style="font-size:20px;" id="inlineFormCustomSelect" name="state">
                </select>
                <br>
                <br>
                <div id="texta"></div>
                <input class="btnnewdiv" type="submit" value="送出">
            </div>
        </form>
    </div>
    <%--    新增議題--%>
    <div id="newissue" class="issuecontent" style="overflow-y:auto;overflow-x:hidden;display: none">
        <div style="right: 0px;top: 0px;position: absolute;">
            <button class="btncandiv" onclick="cancelbtn('newissue')">X</button>
        </div>
        <form id="newissueform" action="/newissue" method="post" style="width:450px;">
            <%
                Connection connection = null;
                PreparedStatement preparedStatement = null;
                ResultSet resultSet = null;
                String sql;

                connection = JdbcUtils.getconn();
                sql = "select * from its_db.project_manage where projectName = ?";
                preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
                preparedStatement.setString(1, session.getAttribute("projectname").toString());
                resultSet = preparedStatement.executeQuery();
                if(resultSet.next()) {
            %>
            <input type="hidden" name="pjid" id="newpjid" value=<%=resultSet.getInt(1)%>>
            <%
                }
            %>
            &nbsp;&nbsp;議題名稱
            <input type="text" name="newname" style="margin-top: 10px;"><br>
            &nbsp;&nbsp;議題內容
            <input type="text" name="newcontent" style="margin-top: 10px;"><br>
            &nbsp;&nbsp;議題負責人
            <select name="ownerid" class="selectcss">
                <%
                    try {
                        connection = JdbcUtils.getconn();
                        sql = "select * from its_db.project where name = ?";
                        preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
                        preparedStatement.setString(1,session.getAttribute("projectname").toString());
                        resultSet = preparedStatement.executeQuery();
                        while(resultSet.next()){
                            sql = "select * from its_db.user where id = ?";
                            ResultSet resultSet1 = null;
                            preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
                            preparedStatement.setInt(1, Integer.parseInt(resultSet.getString(3)));
                            resultSet1 = preparedStatement.executeQuery();
                            if(resultSet1.next()) {
                %>
                <option value=<%=resultSet.getString(3)%>><%=resultSet1.getString(2)%></option>
                <%          }
                        }
                    }
                    catch (SQLException e) {
                        e.printStackTrace();
                    }
                    finally{
                        JdbcUtils.close(preparedStatement,connection);
                    }
                %>
            </select>
            <br>
            <div style="right: 10px;bottom: 10px;position: absolute;">
                <input class="btnnewdiv" type="submit" value="送出">
            </div>
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
                    for(int i = 0; i < todo.size(); i++){
                %>
                <div class="panel panel-info" >
                    <div class="panel-heading">
                        <%
                            if(session.getAttribute("user_role").toString().equals("Project Manager")) {
                        %>
                        <button type="button" class="close pull-right" aria-label="Close" onclick="isbtn(this)">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <%
                            }
                        %>
                        <h3 class="panel-title"><%=todo.get(i).name%></h3>
                    </div>
                    <div class="panel-body" onclick="lookbtn(this,'<%=session.getAttribute("username").toString()%>', '<%=session.getAttribute("user_role").toString()%>')">
                        <%=todo.get(i).content%>
                    </div>
                    <div class="panel-footer" style="text-align: center;padding: 10px 15px 25px 15px;">
                        <%
//                            try {
                                connection = JdbcUtils.getconn();
                                sql = "select * from its_db.user where id = ?";
                                preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
                                preparedStatement.setInt(1,todo.get(i).ownerID);
                                resultSet = preparedStatement.executeQuery();
                                if(resultSet.next()){
                        %>
                        <p hidden><%=todo.get(i).id%></p>
                        <p hidden>TO DO</p>
                        <p hidden><%=todo.get(i).reply%></p>
                        <div style="position: absolute">議題負責人:<%=resultSet.getString(2)%></div>
                        <%
                                }
                        %>
                        <div class="pull-right">創建日期:<%=todo.get(i).creatDate%></div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </div>
        <div class="col-lg-4 bg-warning h-100 p-5">
            <div class="text-white text-center h1">DOING</div>
            <div class="col h-100 p-5">
                <%
                    ArrayList<Issue> doing = issue.doingIssue();
                    for(int i = 0; i < doing.size(); i++){
                %>
                <div class="panel panel-info" >
                    <div class="panel-heading">
                        <%
                            if(session.getAttribute("user_role").toString().equals("Project Manager")) {
                        %>
                        <button type="button" class="close pull-right" aria-label="Close" onclick="isbtn(this)">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <%
                            }
                        %>
                        <h3 class="panel-title"><%=doing.get(i).name%></h3>
                    </div>
                    <div class="panel-body"onclick="lookbtn(this,'<%=session.getAttribute("username").toString()%>','<%=session.getAttribute("user_role").toString()%>')">
                        <%=doing.get(i).content%>
                    </div>
                    <div class="panel-footer" style="text-align: center;padding: 10px 15px 25px 15px;">
                        <%
//                            try {
                                connection = JdbcUtils.getconn();
                                sql = "select * from its_db.user where id = ?";
                                preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
                                preparedStatement.setInt(1,doing.get(i).ownerID);
                                resultSet = preparedStatement.executeQuery();
                                if(resultSet.next()){
                        %>
                        <p hidden><%=doing.get(i).id%></p>
                        <p hidden>DOING</p>
                        <p hidden><%=doing.get(i).reply%></p>
                        <div style="position: absolute">議題負責人:<%=resultSet.getString(2)%></div>
                        <%
                                }
                        %>
                        <div class="pull-right">創建日期:<%=doing.get(i).creatDate%></div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </div>
        <div class="col-lg-4 bg-success h-100 p-5">
            <div class="text-white text-center h1">DONE</div>
            <div class="col h-100 p-5">
                <%
                    ArrayList<Issue> done = issue.doneIssue();
                    for(int i = 0; i < done.size(); i++){
                %>
                <div class="panel panel-info" >
                    <div class="panel-heading">
                        <%
                            if(session.getAttribute("user_role").toString().equals("Project Manager")) {
                        %>
                        <button type="button" class="close pull-right" aria-label="Close" onclick="isbtn(this)">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <%
                            }
                        %>
                        <h3 class="panel-title"><%=done.get(i).name%></h3>
                    </div>
                    <div class="panel-body"onclick="lookbtn(this,'<%=session.getAttribute("username").toString()%>','<%=session.getAttribute("user_role").toString()%>')">
                        <%=done.get(i).content%>
                    </div>
                    <div class="panel-footer" style="text-align: center;padding: 10px 15px 25px 15px;">
                        <%
//                            try {
                                connection = JdbcUtils.getconn();
                                sql = "select * from its_db.user where id = ?";
                                preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
                                preparedStatement.setInt(1,done.get(i).ownerID);
                                resultSet = preparedStatement.executeQuery();
                                if(resultSet.next()){
                        %>
                        <p hidden><%=done.get(i).id%></p>
                        <p hidden>DONE</p>
                        <p hidden><%=done.get(i).reply%></p>
                        <div style="position: absolute">議題負責人:<%=resultSet.getString(2)%></div>
                        <%
                                }
                                JdbcUtils.close(preparedStatement,connection);
                        %>
                        <div class="pull-right">創建日期:<%=done.get(i).creatDate%></div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </div>
</div>
    <script src="/js/issuejs.js"></script>
</div>
</body>
</html>
