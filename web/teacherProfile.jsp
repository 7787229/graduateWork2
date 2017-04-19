<%@ page import="hibernate.utils.Operation" %>
<%@ page import="hibernate.dao.*" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.lang.reflect.Array" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: Alex
  Date: 05.04.2017
  Time: 16:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/operationWithTests.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/operationTeacher.js"></script>
</head>
<body>
<%@ include file="head.jsp" %>
<%
    Teacher currentUser =   (Teacher) (session.getAttribute("currentSessionUser"));
    Operation op = new Operation();
    op.connect();
    Teacher teacher = (Teacher)op.getById(currentUser.getId(),Teacher.class);
%>
<div class="content" style="position:relative">


    <form action="OperationTeacher" method="post">
        <ul style="display:inline-block">

            <li><button   onclick="showWindow($('#add_test'),$('#add_test form'))" type="button">Добавить тест  </button></li>
        </ul><br>

        <ul id = "tests">

            <li><h3>Мои тесты</h3></li>
            <%
                if (session.getAttribute("currentSessionUser")!=null) {
                    for(TestsEntity test :teacher.getTests() )  {

            %>
            <li class = "test"  >
                <button name="open_test" value="<%=test.getId()%>" title="время выполнения <%=test.getTime() %>" ><span><%=test.getTitle() %> </span></button>
                <button name="add_group" value="<%=test.getId()%>">Добавить в группу</button>
                <button name="open_results" value="<%=test.getId()%>">Просмотреть результаты</button>
                <button type="button" onclick="$(this).siblings('.groups').toggle()"> В какие группы входит </button>
                <ul class="groups" style="display: none">
                    <%for (GroupsEntity group:test.getGroups()) {%>
                    <li>
                        <button class="group" name="open_group" value="<%=group.getId()%>"><%=group.getTitle()%></button>
                    </li>
                    <%}%>
                </ul>
            </li>

            <%}  %>
        </ul>
    </form>


    <%} %>

</div>

<div id="add_test" style="display: none">
    <form action="OperationTeacher" method="post">
        <table>
            <tr>
                <td>Название</td>
                <td><input type="text" name="title_test"></td>
            </tr>
            <tr>
                <td>Время выполнения</td>
                <td><input type="text" name="time_test"></td>
            </tr>
            <tr>
                <td><button name="add_test" value="<%=teacher.getId()%>">OK</button></td>
            </tr>
        </table>
    </form>
</div>

<div id="add_group" style="display: none">
    <form action="OperationTeacher" method="post">
    <% if(request.getAttribute("id_test")!=null) {
        int idTest = (Integer)request.getAttribute("id_test");
        TestsEntity test = (TestsEntity)op.getById(idTest,TestsEntity.class) ;
    %>
        <script>
            showWindow($("#add_group"),$("#add_group form"));
        </script>
        <h1>Добавить в группу</h1>
        <table>
            <tr>
               <th>В новую</th>
                <th>В существующую</th>
            </tr>
            <% for (GroupsEntity group :teacher.getGroups()) {%>
                <tr>
                    <td>
                        <td><%=group.getTitle()%></td>
                        <td><input type="radio" name="id_group" value="<%=group.getId()%>"></td>
                    </td>
                </tr>
            <%}%>
            <tr>
                <td>
                    <td>Очистить</td>
                    <td><input type="radio" name="id_group" value="clear"></td>
                </td>
            </tr>
            <tr>
                <td><input type="text" name="new_title_group" ></td>
            </tr>
        </table>
        <button name="add_test_in_group" value="<%=test.getId()%>|<%=teacher.getId()%>">Ok</button>
    <%}%>
    </form>
</div>
<%
    op.disconnect();
%>
</body>
</html>
