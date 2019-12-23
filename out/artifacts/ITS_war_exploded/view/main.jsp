<%--
  Created by IntelliJ IDEA.
  User: snowchappie
  Date: 2019/12/20
  Time: 上午 10:29
  To change this template use File | Settings | File Templates.
--%>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<link rel=stylesheet type="text/css" href="mainStyle.css">
<%@ page contentType="text/html;charset=UTF-8" language="Java" import="java.util.*" %>
<%@ page import="controller.MainDisplay" %>
<%@ page import="sun.awt.windows.WPrinterJob" %>
<%--<%@ page import="static sun.misc.MessageUtils.out" %>--%>
<%@ page import="java.util.ArrayList" %>

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
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">新增成員</h5>
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
                        <button type="button" class="btn btn-success pull-right" data-toggle="modal" data-target="#exampleModal">
                            新增成員
                        </button>
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
</html>
