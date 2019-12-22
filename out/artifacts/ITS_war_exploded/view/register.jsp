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
    <title>註冊介面</title>
<%--    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">--%>
    <jsp:include page="bar.jsp"></jsp:include>
    <link rel="stylesheet" href="/styles/registerStyle.css" />
<%--    <style type="text/css">--%>
<%--        body{--%>
<%--            background-repeat: no-repeat;--%>
<%--            background-position: center;--%>
<%--        }--%>

<%--    </style>--%>
</head>
<body>
<div class="another-background" style="font-family:DFKai-sb;text-align:center;margin-top: 200px">
    <h2>使用者註冊</h2>
    <form action="" method="post">
        <table style="margin-left:45%">
<%--            <caption>使用者註冊</caption>--%>
            <tr><td><br></td></tr>
            <tr>
                <td>帳號：</td>
                <td><input name="name" type="text" size="20" required></td>
            </tr>
            <tr><td><br></td></tr>
            <tr>
                <td>密碼:</td>
                <td><input name="password" type="password" size="20" required></td>
            </tr>
            <tr><td><br></td></tr>
            <tr>
                <td>角色:</td>
                <%
                    String roleData[]={"Admin","Project Manager","Member"};
                %>
                <td>
                    <form id="formRole" name="formRole" method="post" action="">
                        <label for="role"></label>
                        <select name="role" id="role">
                            <%for(int i=0;i<roleData.length;i++){%>
                            <option value="<%out.print(roleData[i]);%>"><%out.print(roleData[i]);%></option>
                            <%}%>
                        </select>
                    </form>
                </td>
            </tr>
        </table>
        <br>
        <input type="submit" value="註冊" />
        <input type="reset" value="重置"  />
    </form>
    <br>
<%--    <a href="/login" style="font-size: 30px; text-decoration: none">返回登入頁</a>--%>
    </form>
</div>

</body>
</html>
