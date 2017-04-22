<%@ page import="hibernate.utils.Operation" %>
<%@ page import="hibernate.dao.*" %><%--
  Created by IntelliJ IDEA.
  User: Alex
  Date: 12.04.2017
  Time: 14:10
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
    <title>Тест <%=test.getTitle()%></title>
</head>
<body>
<%@ include file="head.jsp" %>

    <form method="post" action="OperationTest">
        <div class="content" >
    <h1><%=test.getTitle()%></h1>
    <ul id="test">
        <li><button type="button" onclick="showWindow($('#change_test'),$('#change_test table'))">Редактировать тест</button></li>
        <li><button type="button" onclick="showWindow($('#add_question'),$('#add_question table'));">Добавить вопрос</button></li>
        <%for (QuestionsEntity question:test.getQuestions()){%>
            <li class="question">
                <button name="change_question" value="<%=question.getId()%>|<%=test.getId()%>" >
                    <span><%=question.getText()%></span>
                </button>
                <button name="del_question" value="<%=question.getId()%>|<%=test.getId()%>">Удалить</button>
            </li>
        <%}%>
    </ul>
        </div>


        <div id="change_question">
            <%
                if(request.getAttribute("id_question")!=null){
                    int idQuestion = (Integer) request.getAttribute("id_question");
                    QuestionsEntity question = (QuestionsEntity)op.getById(idQuestion,QuestionsEntity.class);
            %>

            <blockquote>
                <script>
                    showWindow($("#change_question"),$("#change_question blockquote"));
                </script>
            <table id="fields_question">
                <tr>
                    <td>Текст</td>
                    <td><input type="text" name="text_question" value="<%=question.getText()%>"></td>
                </tr>
                <tr>
                    <td>Тип</td>
                    <td>
                        <select name="type">
                            <%
                                String select1="";
                                if(question.getType().equals("c")) select1="selected";
                            %>
                            <option value="c" <%=select1%>> Множественный выбор</option>
                            <%
                                String select2="";
                                if(question.getType().equals("r")) select2="selected";
                            %>
                            <option value="r" <%=select2%>>Одиночный выбор</option>
                            <%
                                String select3="";
                                if(question.getType().equals("n")) select3="selected";
                            %>
                            <option value="n" <%=select3%>>Без выбора</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Очки</td>
                    <td><input type="text" name="score" value="<%=question.getScore()%>"></td>
                </tr>
            </table>
            <table id ="variants">
                <tr>
                    <th>Ответы</th>
                    <th>Правильность</th>
                </tr>
                <% int i =1;%>
                <%for (VariantsEntity variant:question.getVariants()){%>
                <tr>
                    <td>
                        <input type="text" name="text_variant<%=i%>" value="<%=variant.getText()%>">
                        <button name="del_variant" value="<%=variant.getId()%>|<%=question.getId()%>|<%=test.getId()%>">X</button>
                    </td>
                    <td>
                        <%
                            String checked="";
                            if (variant.getAnswer()) checked ="checked";
                        %>
                        <input type="checkbox" <%=checked%>  name="answer<%=i%>" value="true">
                    </td>
                </tr>
                <%
                        i++;
                    }
                %>
                <tr>
                    <td><button type="button" onclick="$('#add_variant').css('display','table-row')">+</button></td>
                </tr>
                <tr style="display: none" id="add_variant">
                    <td><input type="text" name="text_variant"></td>
                    <td><input type="checkbox" name="new_answer"></td>
                    <td><button name="add_variant" value="<%=question.getId()%>|<%=test.getId()%>">OK</button></td>
                </tr>
            </table>

            <button name="edit" value="<%=question.getId()%>|<%=test.getId()%>" >Редактировать</button>
            </blockquote>
            <%}%>
        </div>
        <div style="display: none;" id="change_test">



            <table>
                <tr>
                    <td>Название</td>
                    <td><input type="text" name="title_test" value="<%=test.getTitle()%>"></td>
                </tr>
                <tr>
                    <td>Время выполнения</td>
                    <td><input type="text" name="time_test" value="<%=test.getTime()%>"></td>
                </tr>
                <tr>
                    <td><button name="edit_test" value="<%=test.getId()%>">OK</button></td>
                </tr>
            </table>


        </div>
        <div style="display: none" id="add_question">




            <table>
                <tr>
                    <td>Текст</td>
                    <td><input type="text" name="new_text_question"></td>
                </tr>
                <tr>
                    <td>тип</td>
                    <td>
                        <select name="new_type">
                            <option value="c" > Множественный выбор</option>
                            <option value="r" >>Одиночный выбор</option>
                            <option value="n" >Без выбора</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Очки</td>
                    <td><input type="text" name="new_score" ></td>
                </tr>
                <tr>
                    <td><button name="add_question" value="<%=test.getId()%>">OK</button></td>
                </tr>
            </table>


        </div>

    </form>


<%op.disconnect();%>
</body>
</html>
