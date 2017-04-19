<%@ page import="hibernate.dao.GroupsEntity" %>
<%@ page import="hibernate.utils.Operation" %>
<%@ page import="hibernate.dao.Pupil" %><%--
  Created by IntelliJ IDEA.
  User: Alex
  Date: 11.04.2017
  Time: 19:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%@ include file="head.jsp" %>
<%
    Operation op = new Operation();
    op.connect();
    int idGroup = (Integer)request.getAttribute("id_group");
    GroupsEntity group = (GroupsEntity)op.getById(idGroup,GroupsEntity.class);
%>
<div class="content" >
    <h1><%=group.getTitle()%></h1>
    <ul id="group">
        <%for (Pupil pupil:group.getPupils()){%>
            <li class="pupil">
                <span><%=pupil.getLogin()%></span>
            </li>
            <form  method="post" action="OperationGroup">
                <button name="del_pupil" value="<%=pupil.getId()%>|<%=group.getId()%>">Удалить ученика</button>
            </form>
        <%}%>
        <li>
            <button onclick="showWindow($('#add_pupil'),$('#add_pupil form'))" type="button" >Добавить ученика</button>
        </li>
        <li>
            <form method="post" action="OperationGroup">
            <button  name="del_group" value="<%=group.getId()%>">Удалить группу</button>
            </form>
        </li>
    </ul>
</div>
<div id="add_pupil" style="display: none">
    <form method="post" action="OperationGroup">
        <table>
            <tr>
                <td>Логин ученика</td>
                <td><input type="text" name="login_pupil"></td>
            </tr>
            <tr>
                <td><button name="add_pupil" value="<%=group.getId()%>">OK </button></td>
            </tr>
        </table>
    </form>
</div>
<%op.disconnect();%>
</body>
</html>
