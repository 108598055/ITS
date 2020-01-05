<%--
  Created by IntelliJ IDEA.
  User: snowchappie
  Date: 2019/12/20
  Time: 上午 10:29
  To change this template use File | Settings | File Templates.
--%>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<link rel=stylesheet type="text/css" href="/styles/mainStyle.css">
<%@ page contentType="text/html;charset=UTF-8" language="Java" import="java.util.*" %>
<%@ page import="controller.MainDisplay" %>
<%@ page import="sun.awt.windows.WPrinterJob" %>
<%--<%@ page import="static sun.misc.MessageUtils.out" %>--%>
<%@ page import="java.util.ArrayList" %>
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
    <title>概覽</title>
</head>
<body>
<div class="content h-100 w-100">

    <!-- 新增成員 -->
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="display: none">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">新增成員</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div style="height: auto">
                    <form id="newmember1" action="/newmember" method="post" style="width:450px;">
                        <div>
                            <%  Connection connection = null;
                                PreparedStatement preparedStatement = null;
                                ResultSet resultSet = null;
                                connection = JdbcUtils.getconn();
                                String sql3 = "select * from its_db.project_manage where projectName = ?";
                                preparedStatement = (PreparedStatement)connection.prepareStatement(sql3);
                                preparedStatement.setString(1,session.getAttribute("projectname").toString());
                                resultSet = preparedStatement.executeQuery();
                                if(resultSet.next()) {
                                    session.setAttribute("pjid", resultSet.getInt(1));
                            %>
                            <input type="hidden" name="pjid"  value=<%=resultSet.getInt(1)%>>
                            <input type="hidden" name="pjname" value=<%=session.getAttribute("projectname")%>>
                            <%}%>
                            <select class="custom-select mr-sm-2" style="font-size:20px;" id="memberID" name="member">

                                <%
                                    resultSet = null;
                                        String sql = "select * from its_db.user where role = ?";
                                        preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
                                        preparedStatement.setString(1,"Member");
                                        resultSet = preparedStatement.executeQuery();
                                        while(resultSet.next()){
                                            String sql2 = "select * from its_db.project where memberID = ? and name = ?";
                                            preparedStatement = (PreparedStatement)connection.prepareStatement(sql2);
                                            preparedStatement.setInt(1, resultSet.getInt(1));
                                            preparedStatement.setString(2, session.getAttribute("projectname").toString());
                                            ResultSet resultSet1 = preparedStatement.executeQuery();

                                            if(!resultSet1.next()) {
                                %>
                                <option value=<%=resultSet.getInt(1)%>><%=resultSet.getString(2)%></option>>
                                <%}}%>
                            </select>
                            <br>
                            <br>
                            <div id="texta"></div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" onclick="newmember('newmember1')">確定</button>
                </div>
            </div>
        </div>
    </div>
        <!-- 刪除成員 -->
    <div class="modal fade" id="delete1" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="display: none">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">刪除成員</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div style="height: auto">
                    <form id="deletemember" action="/delmember" method="post" style="width:450px;">
                        <div >
                            <%
                                connection = JdbcUtils.getconn();
                                sql3 = "select * from its_db.project_manage where projectName = ?";
                                preparedStatement = (PreparedStatement)connection.prepareStatement(sql3);
                                preparedStatement.setString(1,session.getAttribute("projectname").toString());
                                resultSet = preparedStatement.executeQuery();
                                if(resultSet.next()) {
                                    session.setAttribute("pjid", resultSet.getInt(1));
                            %>
                            <input type="hidden" name="pjid"  value=<%=resultSet.getInt(1)%>>
                            <input type="hidden" name="pjname" value=<%=session.getAttribute("projectname")%>>
                            <%}%>
                            <select class="custom-select mr-sm-2" style="font-size:20px;" id="memberID" name="member">
                                <%
                                    resultSet = null;
                                        sql = "select * from its_db.user where role = ?";
                                        preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
                                        preparedStatement.setString(1,"Member");
                                        resultSet = preparedStatement.executeQuery();
                                        while(resultSet.next()){
                                            String sql2 = "select * from its_db.project where memberID = ? and name = ?";
                                            preparedStatement = (PreparedStatement)connection.prepareStatement(sql2);
                                            preparedStatement.setInt(1, resultSet.getInt(1));
                                            preparedStatement.setString(2, session.getAttribute("projectname").toString());
                                            ResultSet resultSet1 = preparedStatement.executeQuery();

                                            if(resultSet1.next()) {
                                %>
                                <option value=<%=resultSet.getInt(1)%>><%=resultSet.getString(2)%></option>>
                                <%}}%>
                            </select>
                            <br>
                            <br>
                            <div id="texta"></div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" onclick="newmember('deletemember')">確定</button>
                </div>
            </div>
        </div>
    </div>
    <div class="row h-100 w-100">
        <div class="col-lg-6 bg-dark h-100 p-5">
            <div class="panel panel-primary h-100">
                <%--讀取issue資料表--%>
                <%MainDisplay main = new MainDisplay();%>
                <div class="panel-heading">
                    <h3 class="panel-title">
                        議題
                    </h3>
                </div>
                <div class="panel-body">
                    ALL:<%=main.allIssue()%>
                </div>
                <div class="panel-body">
                    TO DO:<%=main.toDo()%>
                </div>
                <div class="panel-body">
                    DOING:<%=main.doing()%>
                </div>
                <div class="panel-body">
                    DONE:<%=main.done()%>
                </div>
            </div>
        </div>
        <div class="col-lg-6 bg-dark h-100 p-5">
            <div class="panel panel-primary h-100">
                <div class="panel-heading align-center" style="height: 60px">
                    <h3 class="panel-title" >
                        成員
                        <%  if(session.getAttribute("user_role").toString().equals("Project Manager")) {%>
                        <button type="button" class="btn btn-success pull-right" data-toggle="modal" data-target="#exampleModal">
                            新增成員
                        </button>
                        <button type="button" class="btn btn-success pull-right" data-toggle="modal" data-target="#delete1">
                            刪除成員
                        </button>
                        <%}%>
                    </h3>
                </div>
                <%
                    ArrayList<String> member = main.member();
                    for(int i = 0; i < member.size(); i++){
                        out.print("<div class=\"panel-body\">");
                        out.print(member.get(i));
                        out.print("</div>");
                    }
                %>
            </div>
        </div>
    </div>
</div>
</body>
<script>
function newmember(ID){
    document.getElementById(ID).submit();
}
</script>
</html>
