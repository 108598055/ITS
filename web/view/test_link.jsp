<%--
  Created by IntelliJ IDEA.
  User: HongDeLiu
  Date: 2019/12/19
  Time: 下午 09:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="/styles/usemain.css" rel="stylesheet">
</head>
<body>
<h1>hihi</h1>
<%out.print(session.getAttribute("projectname"));%>
<h1>hihi</h1>
<button onclick="showss()" class="new_project_botton">+</button>

<div id="haha" class="project_new_div" style="display:none; z-index: 999">
    <p id="qq" tagName="1"><p>
        <%out.print(session.getAttribute("projectname"));%>

    <input type="button" value="取消" onclick="hideeee()" >&nbsp;&nbsp;&nbsp;
</div>

<script>
    function showss() {
        document.getElementById('haha').style.display='block';
    }
    function hideeee() {
        document.getElementById('haha').style.display='none';
    }
    function myFunction (tarObj) {
        alert($(tarObj).children("div:nth-child(1)").text());
    }
</script>
</body>
</html>


