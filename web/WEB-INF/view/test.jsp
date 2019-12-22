<%--
  Created by IntelliJ IDEA.
  User: leo
  Date: 2019/10/4
  Time: 下午 04:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%--<link href="styles/loginStyle.css" rel="stylesheet" type="text/css">--%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<head>
    <title>Title</title>
</head>
<body>
Hello ${content} Welcome to my index.
<form action="" method="POST">
    <input type="text" name="content" id="content" placeholder="請輸入..." required>
    <input type="submit" value="送出留言">
</form>
</body>
</html>
