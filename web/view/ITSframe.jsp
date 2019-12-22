<%--
  Created by IntelliJ IDEA.
  User: HongDeLiu
  Date: 2019/12/15
  Time: 下午 04:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <%--    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">--%>
    <%--    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>--%>
    <%--    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>--%>
</head>
<frameset rows="5%,*" frameborder="0">
    <frame src="/view/bar.jsp" name="bar" noresize="noresize" scrolling="no">
    <frameset cols="20%,*" frameborder="yes">
        <frame src="/view/tree_view.jsp" name="tree_view" noresize="noresize">
        <frame src="/view/tree.jsp" name="issue" noresize="noresize">
    </frameset>
</frameset>
</html>
