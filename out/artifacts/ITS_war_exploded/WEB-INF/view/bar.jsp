<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: leo
  Date: 2019/12/19
  Time: 下午 05:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<html>
<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<%--    <style>--%>
<%--        body {--%>
<%--            background-image: url("../images/background8.jpg");--%>
<%--            background-size:cover;--%>
<%--            background-repeat: no-repeat;--%>
<%--        }--%>
<%--    </style>--%>
</head>
<body bgcolor="black">
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="/home">ITS</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse in" aria-expanded="true" style="">
            <ul class="nav navbar-nav navbar-right">
                <c:choose>
                    <c:when test="${empty username}">
                        <li><a href="/login" target="_top">登入</a></li>
                        <li><a href="/register" target="_top">註冊</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a>${username} 您好</a></li>
                        <li><a href="">更改密碼</a></li>
                        <li><a href="/login" target="_top">登出</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>
</body>
</html>