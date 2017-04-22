<%@ page import="hibernate.dao.UsersEntity" %>
<%@ page import="hibernate.dao.Teacher" %><%--
  Created by IntelliJ IDEA.
  User: Alex
  Date: 05.04.2017
  Time: 14:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession sess = request.getSession(true);

    if (sess.isNew()) {
        Cookie cookie = new Cookie("JSESSIONID", sess.getId());
        cookie.setMaxAge(31536000);
        response.reset();
        response.setCharacterEncoding("UTF-8");
        response.addCookie(cookie);
    }


%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Title</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.1.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/check.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/lib.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="content">
    <header>
        <ul>
            <li><a href="${pageContext.request.contextPath}/index.jsp">Главная</a></li>
            <li><a href="${pageContext.request.contextPath}/login/LoginPage.jsp">Вход</a></li>
            <li><a href="${pageContext.request.contextPath}/login/regestration.jsp">Регестрация</a></li>
        </ul>
        <%
            if(session.getAttribute("currentSessionUser")!=null) {
                UsersEntity user  = (UsersEntity) (session.getAttribute("currentSessionUser"));
                if(user.getRole().equals("teacher")) {

        %>
        <span>Перейти к</span>	 <a style="display: inline" href='${pageContext.request.contextPath}/teacherProfile.jsp'> <%= user.getLogin()%></a>
        <% } if(user.getRole().equals("pupil")) {%>
        <span>Перейти к</span> <a style="display: inline" href='${pageContext.request.contextPath}/pupilProfile.jsp'> <%= user.getLogin()%></a>
        <%} %>
        <button onclick="window.location.href = '${pageContext.request.contextPath}/login/Login?exit=1 %>'"> Выход</button>
        <%}%>
    </header>
</div>
</body>
</html>
