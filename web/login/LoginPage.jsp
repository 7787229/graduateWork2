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
    <title>Вход</title>
</head>
<body>
<%@ include file="../head.jsp" %>
<div class="container">
    <form class="form-horizontal" action="Login" method="post">
        <div class="form-group">
            <label for="inputLogin" class="col-sm-4 control-label">Логин</label>
            <div class="col-sm-8">
                <input type="text" class="form-control" id="inputLogin" placeholder="Логин" name="login">
            </div>
        </div>
        <div class="form-group">
            <label for="inputPassword" class="col-sm-4 control-label">Пароль</label>
            <div class="col-sm-8">
                <input type="text" class="form-control" id="inputPassword" placeholder="Пароль" name="password">
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-offset-4 col-sm-8">
                <button type="submit" class="btn btn-default">Вход</button>
            </div>
        </div>
    </form>
</div>
</body>
</html>
