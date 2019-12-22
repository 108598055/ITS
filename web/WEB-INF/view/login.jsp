<%--
  Created by IntelliJ IDEA.
  User: leo
  Date: 2019/11/22
  Time: 下午 04:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登入介面</title>
    <jsp:include page="bar.jsp"></jsp:include>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet" href="/styles/loginStyle.css" />
</head>
<body>
<div style="font-family:DFKai-sb;text-align:center;vertical-align:center;margin-top:200px">
    <h2 class="another-background">ITS</h2>
    <p>
        <marquee width="200" scrolldelay="250">使用者登入</marquee>
    </p>
    <form action="" method="post">
        <table style="margin-left:45%">
            <tr>
                <td>使用者名稱：</td>
                <td><input type="text" size="20" name="username" required/></td>
            </tr>
            <tr><td><br></td></tr>
            <tr>
                <td>密碼：</td>
                <td><input type="password" name="password" size="20" required/></td>
            </tr>

        </table>
        <br>
        <input type="submit" value="登入"/>
        <input type="reset" value="重置"/>
    </form>
    <br>
<%--    <a href="/register" style="font-size: 30px; text-decoration: none">註冊帳號</a>--%>
</div>
</body>
</html>
