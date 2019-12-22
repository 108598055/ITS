<%--
  Created by IntelliJ IDEA.
  User: leo
  Date: 2019/12/19
  Time: 下午 05:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>ITS</title>
    <style>
        body {
            background-image: url("/images/background66.jpg");
            background-repeat: no-repeat;
            background-size: cover;
        }
    </style>
</head>
<body >
<h1>
    <div style="font-family:DFKai-sb;font-size:100px;vertical-align:center;text-align:center;margin-top: 400px">
        <%if(session.getAttribute("projectname")!=null) { %>
        專案<%out.print(session.getAttribute("projectname"));}
        else {%>
        看左邊啦!!!
        <%} %>
        <%--        <input type="button" value="test" onclick="alert('test!!')">--%>
    </div>
</h1>
</body>
</html>
