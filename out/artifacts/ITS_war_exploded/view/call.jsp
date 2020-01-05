<%--
  Created by IntelliJ IDEA.
  User: HongDeLiu
  Date: 2019/12/20
  Time: 下午 02:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="controller.JdbcUtils" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>

<html>
<head>
    <%--    <title>Title</title>--%>
    <link href="/styles/usemain.css" rel="stylesheet">
    <script src="/js/usemain.js"></script>
    <script src="https://jonmiles.github.io/bootstrap-treeview/bower_components/jquery/dist/jquery.js"></script>
    <script src="/js/bootstrap-treeview.js"></script>

</head>
<body>
<%--彈跳視窗新增專案--%>
<div id="popId" class="project_new_div">
    <form action="/call" method="post" id="form1" style="font-size:x-large; text-align:center;">
        <div >
            <label>project name</label>
            <input type="text" name="project_name" class="inputcss" required> <br>
            <label>person in charge</label>
            <select name="person" class="selectcss">

                <%  Connection connection = null;
                    PreparedStatement preparedStatement = null;
                    ResultSet resultSet = null;
                    try {
                        connection = JdbcUtils.getconn();
                        String role = "Project Manager";
                        String sql = "select * from its_db.user where role = ?";
                        preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
                        preparedStatement.setString(1,role);
                        resultSet = preparedStatement.executeQuery();
                        while(resultSet.next()){
                %>
                <option value=<%=resultSet.getString(2)%>><%=resultSet.getString(2)%></option>
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
        </div>
        <div class="btndiv">
            <input type="button" value="確定" onclick="new_pj_confirm()" class="end_project_div" >&nbsp;&nbsp;
            <input type="button" value="取消" onclick="hide('popId')" class="end_project_div" >&nbsp;&nbsp;&nbsp;
            <br>
            <br>
        </div>
    </form>
</div>
<%--彈跳視窗刪除專案--%>
<div id="del_pj" class="project_new_div">
    <form action="/del_pj" method="post" id="form3" style="font-size:x-large; text-align:center;">
        <div >
            <label>delete project name</label>
            <select name="project_name" class="selectcss">

                <%  connection = null;
                    preparedStatement = null;
                    resultSet = null;
                    try {
                        connection = JdbcUtils.getconn();
                        String sql = "select * from its_db.project_manage where isDeleted IS NULL";
                        preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
                        resultSet = preparedStatement.executeQuery();
                        while(resultSet.next()){
                %>
                <option value=<%=resultSet.getString(2)%>><%=resultSet.getString(2)%></option>
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
        </div>
        <div class="btndiv">
            <input type="submit" value="確定" class="end_project_div" >
            <input type="button" value="取消" onclick="hide('del_pj')" class="end_project_div">
            <br>
            <br>
        </div>
    </form>
</div>
<%--彈跳視窗修改密碼--%>
<div id="pass" class="password_div">
    <form action="/password" method="post" id="form2" style="font-size:small; text-align:center;">
        <div >
            <label>輸入舊密碼</label>
            <input type="text" name="old_pass" class="pwdinputcss" required> <br>
            <label>輸入新密碼</label>
            <input type="text" name="new_pass" class="pwdinputcss" required> <br>
            <label>再次輸入新密碼</label>
            <input type="text" name="new_pass2" class="pwdinputcss" required> <br>
        </div>
        <div class="btndiv">
            <input type="button" value="確定" class="end_project_div" >
            <input type="button" value="取消" onclick="hide('pass')" class="end_project_div" >
            <br>
            <br>
        </div>
    </form>
</div>
<%--主要版面--%>
<div style="width: 100%; height: 100%; position: absolute; top: 0px; left: 0px; z-index: 9; overflow: hidden">
    <iframe src="/view/ITSframe.jsp" width="100%" height="100%" marginwidth="0" id="call"></iframe>
</div>
</body>
</html>
