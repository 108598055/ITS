<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="controller.JdbcUtils" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.*"%>
<%--

  Created by IntelliJ IDEA.
  User: leo
  Date: 2019/11/22
  Time: 下午 05:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%--    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">--%>
    <%--bootstrap及jquery套件--%>
    <link href="https://jonmiles.github.io/bootstrap-treeview/bower_components/bootstrap/dist/css/bootstrap.css" rel="stylesheet">
    <script src="https://jonmiles.github.io/bootstrap-treeview/bower_components/jquery/dist/jquery.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <%--自寫--%>

    <script src="/js/bootstrap-treeview.js"></script>
    <link rel="stylesheet" href="/styles/usemain.css"/>

    <style type="text/css" id="treeview7-style">
        .treeview .list-group-item{cursor:pointer}
        .treeview span.indent{margin-left:10px;margin-right:10px}
        .treeview span.icon{width:12px;margin-right:5px}
        .treeview
        .node-disabled{color:silver;cursor:not-allowed}
        .node-treeview7{color:#428bca;border:none;}
        .node-treeview7:not(.node-disabled):hover{background-color:#F5F5F5;}
    </style>
</head>

<body >
<div class="container">
    <div class="row">
        <div class="col-sm-4">
            <div id="treeview7" class="treeview">
                <ul class="list-group">
                </ul>
            </div>
        </div>
        <div id="dg" style="z-index: 9999; position: fixed ! important; right: 10px; bottom: 10px; border-radius: 50%;">
            <% if(session.getAttribute("user_role").toString().equals("Admin")){%>
            <button onclick="show('popId')" class="new_project_botton">+</button>
            <%}%>
        </div>
        <div id="dg1" style="z-index: 9999; position: fixed ! important; right: 10px; bottom: 80px; border-radius: 50%;">
            <% if(session.getAttribute("user_role").toString().equals("Admin")){%>
            <button onclick="show('del_pj')" class="new_project_botton">-</button>
            <%}%>
        </div>
    </div>
</div>

<%--    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">--%>
<%--        <div class="modal-dialog" role="document">--%>
<%--            <div class="modal-content">--%>
<%--                <div class="modal-header">--%>
<%--                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">--%>
<%--                        <span aria-hidden="true">×</span>--%>
<%--                    </button>--%>
<%--                    <h4 class="modal-title" id="myModalLabel">Modal title</h4>--%>
<%--                </div>--%>
<%--                <div class="modal-body">--%>
<%--                    <p>One fine body…</p>--%>
<%--                </div>--%>
<%--                <div class="modal-footer">--%>
<%--                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>--%>
<%--                    <button type="button" class="btn btn-primary">Save</button>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<script src="/js/usemain.js"></script>
<script type="text/javascript">
    $(function() {
        var defaultData = [
            {}
        ];
        <%
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            connection = JdbcUtils.getconn();
            String sql;
            if(session.getAttribute("user_role").equals("Admin")) {
                sql = "select * from its_db.project_manage where isDeleted IS NULL";
                preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
            }
            else if(session.getAttribute("user_role").equals("Project Manager")) {
                String username = (String)session.getAttribute("username");
//                System.out.print(session.getAttribute("username"));
//                sql = "select * from its_db.project_manage where ownerID = " + session.getAttribute("username");
                sql = "select * from its_db.project_manage where ownerID = ? AND isDeleted IS NULL";
                preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
                preparedStatement.setString(1,username);
//                preparedStatement.setString(2, "doing");
//                resultSet = preparedStatement.executeQuery();
            }
            else if(session.getAttribute("user_role").equals("Member")) {
                sql = "select * from its_db.project where memberID = " + (int)session.getAttribute("userid");
                preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
            }
            resultSet = preparedStatement.executeQuery();

            while(resultSet.next()){
                if(session.getAttribute("user_role").equals("Member")) {
                    ResultSet resultSet1 = null;
                    String sql1 = "select * from its_db.project_manage where projectID = ? AND projectName = ?";
                    preparedStatement = (PreparedStatement)connection.prepareStatement(sql1);
                    preparedStatement.setInt(1, resultSet.getInt(1));
                    preparedStatement.setString(2, resultSet.getString(2));
                    resultSet1 = preparedStatement.executeQuery();
                    while(resultSet1.next()) {
                        if(resultSet1.getString(4) == null) {
        %>
        defaultData.push(
            {
                text:'<%=resultSet.getString(2)%>',
                href: 'tree.jsp', tags: ['3'],
                nodes: [
                    {
                        text: '主畫面',
                        href:"main.jsp",
                        tags: ['0']
                    },
                    {
                        text: '議題',
                        href: "issue.jsp",
                        tags: ['0']
                    },
                    {
                        text: '報表',
                        href: "report.jsp",
                        tags: ['0']
                    }]
            });
        <%              }
                   }
                }
                else {
        %>
        defaultData.push({
            text:'<%=resultSet.getString(2)%>',
            href: 'tree.jsp', tags: ['3'],
            nodes: [
                {
                    text: '主畫面',
                    href: "main.jsp",
                    tags: ['0']
                },
                {
                    text: '議題',
                    href: "issue.jsp",
                    tags: ['0']
                },
                {
                    text: '報表',
                    href: "report.jsp",
                    tags: ['0']
                }]
        });
        <%}
            }
        }
        catch (SQLException e) {
            e.printStackTrace();
        } finally{
            JdbcUtils.close(preparedStatement,connection);
        }
        %>
        $('#treeview7').treeview({
            levels: 1,
            color: "#428bca",
            showBorder: false,
            enableLinks: true,
            data: defaultData
        });
    });
</script>
</body>
</html>