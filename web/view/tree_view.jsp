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
    <%--&lt;%&ndash;    <title>登錄成功頁面</title>&ndash;%&gt;--%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link href="https://jonmiles.github.io/bootstrap-treeview/bower_components/bootstrap/dist/css/bootstrap.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <style type="text/css" id="treeview7-style"> .treeview .list-group-item{cursor:pointer}.treeview span.indent{margin-left:10px;margin-right:10px}.treeview span.icon{width:12px;margin-right:5px}.treeview .node-disabled{color:silver;cursor:not-allowed}.node-treeview7{color:#428bca;border:none;}.node-treeview7:not(.node-disabled):hover{background-color:#F5F5F5;} </style>
    <script src="/js/usemain.js"></script>
    <link rel="stylesheet" href="/styles/usemain.css"/>
</head>
<%--<body style="background-color:#a94442;">--%>
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

            <%--                    <input type="button" value="按钮" style="width: 50px; height: 50px; border-radius: 50%;border: none">--%>
            <% if(session.getAttribute("user_role").toString().equals("Admin")){%>
            <button onclick="show('popId')" class="new_project_botton">+</button>
            <%}%>


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

            <%--    <script src="http://cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>--%>
            <%--    <script src="http://cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>--%>

        </div>
        <div id="dg1" style="z-index: 9999; position: fixed ! important; right: 10px; bottom: 80px; border-radius: 50%;">

            <%--                    <input type="button" value="按钮" style="width: 50px; height: 50px; border-radius: 50%;border: none">--%>
            <% if(session.getAttribute("user_role").toString().equals("Admin")){%>
            <button onclick="show('popId')" class="new_project_botton">-</button>
            <%}%>
        </div>
    </div>
</div>
<script src="https://jonmiles.github.io/bootstrap-treeview/bower_components/jquery/dist/jquery.js"></script>
<script src="../js/bootstrap-treeview.js"></script>
<script type="text/javascript">

    $(function() {
        var defaultData = [
            {}
        ];
        <% Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            connection = JdbcUtils.getconn();
            String sql;
            if(session.getAttribute("user_role").equals("Admin")) {
                sql = "select * from its_db.project_manage;";
                preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
//                resultSet = preparedStatement.executeQuery();
            }
            else if(session.getAttribute("user_role").equals("Project Manager")) {
                String username = (String)session.getAttribute("username");
//                System.out.print(session.getAttribute("username"));
//                sql = "select * from its_db.project_manage where ownerID = " + session.getAttribute("username");
                sql = "select * from its_db.project_manage where ownerID = ?";
                preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
                            preparedStatement.setString(1,username);
//                resultSet = preparedStatement.executeQuery();
            }
            else if(session.getAttribute("user_role").equals("Member")) {
                sql = "select * from its_db.project where memberID = " + (int)session.getAttribute("userid");
                preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
            }
//            String sql = "select * from its_db.project;";
//            String sql = "select * from its_db.project_manage;";
//            preparedStatement = (PreparedStatement)connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();
        while(resultSet.next()){
            %>

        defaultData.push(
            {
                text:'<%=resultSet.getString(2)%>',
                href: 'tree.jsp', tags: ['3'],
                nodes: [
                    {
                        text: '主畫面',
                        href:"/view/main.jsp",
                        tags: ['0']
                    },
                    {
                        text: '議題',
                        href: '/view/issue.jsp',
                        tags: ['0']
                    },
                    {
                        text: '報表',
                        href: '/view/report.jsp',
                        tags: ['0']
                    }]
            });
        <%}

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