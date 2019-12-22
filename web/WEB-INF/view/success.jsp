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
    <jsp:include page="bar.jsp"></jsp:include>
    <title>登錄成功頁面</title>
    <link rel="stylesheet" href="/styles/successStyle.css" />
</head>
<body>
<h1>
    <div style="font-family:DFKai-sb;margin-top: 50px">
        hello ${username}
        <br>
        登錄成功
    </div>
</h1>
<hr>
</body>
</html>