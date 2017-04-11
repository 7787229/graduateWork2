<%--
  Created by IntelliJ IDEA.
  User: Alex
  Date: 05.04.2017
  Time: 15:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%@ include file="../head.jsp" %>
<div id="content">
    <form action="Login">
        <table>
            <tr>
                <td><span>Please enter your username </span></td>
                <td><input type="text" name="login"/></td>
            </tr>
            <tr>
                <td><span>Please enter your password</span></td>
                <td><input type="text" name="password"/></td>
            </tr>
            <tr>
                <td><input type="submit" value="submit"></td>
            </tr>

        </table>
    </form>
</div>
</body>
</html>
