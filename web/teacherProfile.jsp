<%@ page import="hibernate.utils.Operation" %>
<%@ page import="hibernate.dao.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%
    Teacher currentUser =   (Teacher) (session.getAttribute("currentSessionUser"));
    Operation op = new Operation();
    op.connect();
    Teacher teacher = (Teacher)op.getById(currentUser.getId(),Teacher.class);
%>
<head>
    <title>Профиль учителя <%=currentUser.getLogin()%></title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/operationTeacher.js"></script>
</head>
<body>
<%@ include file="head.jsp" %>

    <form action="OperationTeacher" method="post">
        <div class="content" >
            <button   onclick="showWindow($('#add_test'),$('#add_test table'))" type="button">Добавить тест  </button>


        <ul id = "tests">

            <li><h3>Мои тесты</h3></li>
            <%
                if (session.getAttribute("currentSessionUser")!=null) {
                    for(TestsEntity test :teacher.getTests() )  {

            %>
            <li class = "test"  >
                <button name="open_test" value="<%=test.getId()%>" title="время выполнения <%=test.getTime() %>" ><span><%=test.getTitle() %> </span></button>
                <button type="button" class ="toggle_options" onclick="$(this).siblings('.options').toggle()">|||</button>
                <ul class="options" style="display: none">
                    <li class="option"><button name="add_group" value="<%=test.getId()%>">Добавить в группу</button></li>
                    <li class="option"><button name="open_results" value="<%=test.getId()%>">Просмотреть результаты</button></li>
                    <li class="option"><button type="button" onclick="$(this).parent().parent().siblings('.groups').toggle()"> В какие группы входит </button></li>
                </ul>
                <ul class="groups" style="display: none">
                    <%for (GroupsEntity group:test.getGroups()) {%>
                    <li>
                        <button class="group" name="open_group" value="<%=group.getId()%>"><%=group.getTitle()%></button>
                    </li>
                    <%}%>
                </ul>
            </li>

            <%} } %>
        </ul>
        </div>

        <div id="add_test" style="display: none">
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
        </div>

        <div id="add_group" style="display: none">

                <% if(request.getAttribute("id_test")!=null) {
                    int idTest = (Integer)request.getAttribute("id_test");
                    TestsEntity test = (TestsEntity)op.getById(idTest,TestsEntity.class) ;
                %>
                <table>
                    <script>
                        showWindow($("#add_group"),$("#add_group table"));
                    </script>
                    <tr><td><h1>Добавить в группу</h1></td></tr>
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
                    <tr><td><button name="add_test_in_group" value="<%=test.getId()%>|<%=teacher.getId()%>">Ok</button></td></tr>
                </table>
                <%}%>

        </div>


    </form>







<%
    op.disconnect();
%>
</body>
</html>
