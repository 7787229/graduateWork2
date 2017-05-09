<%@ page import="hibernate.utils.Operation" %>
<%@ page import="hibernate.dao.TestsEntity" %>
<%@ page import="hibernate.dao.ResultsEntity" %><%--
  Created by IntelliJ IDEA.
  User: Alex
  Date: 12.04.2017
  Time: 20:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%
    Operation op = new Operation();
    op.connect();
    int idTest = (Integer)request.getAttribute("id_test");
    TestsEntity test = (TestsEntity) op.getById(idTest,TestsEntity.class);
%>
<head>
    <title>Результаты теста <%=test.getTitle()%></title>
</head>
<body>
<%@ include file="head.jsp" %>

<div class="container" >
    <form method="post" action="OperationResult">
        <table id="results" class="table">
            <tr>
                <th>Ученик</th>
                <th>Прогресс</th>
            </tr>
            <%for (ResultsEntity result:test.getResults()){%>
                <tr class="result">
                    <td><%=result.getPupil().getLogin()%></td>
                    <td><%=result.getProgress()%>%</td>
                </tr>
            <%}%>
        </table>
    </form>
</div>
<%op.disconnect();%>
</body>
</html>
