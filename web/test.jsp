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
    <div class="container">
    <form method="post" action="OperationTest">
    <table  id="test" class="table">
        <tr>
            <td><h1><%=test.getTitle()%></h1></td>
            <td>
                <div class="btn-group">
                    <button type="button" class ="toggle_options dropdown-toggle btn btn-default" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" >
                        <span class="caret"></span>
                    </button>
                    <ul class="options dropdown-menu" >
                        <li><button data-toggle="modal" data-target="#change_test" class="btn btn-link option" type="button" >Редактировать тест</button></li>
                        <li><button data-toggle="modal" data-target="#add_question" class="btn btn-link option" type="button" >Добавить вопрос</button></li>
                    </ul>
                </div>
            </td>
        </tr>
        <%for (QuestionsEntity question:test.getQuestions()){%>
            <tr class="question">
                <td>
                    <button class="btn btn-link" name="change_question" value="<%=question.getId()%>|<%=test.getId()%>" >
                        <span><%=question.getText()%></span>
                    </button>
                </td>
                <td>
                    <button class="btn btn-default" name="del_question" value="<%=question.getId()%>|<%=test.getId()%>">Удалить</button>
                </td>
            </tr>
        <%}%>
    </table>


        <div class="modal fade" id="change_question" style="display: none" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <%
                        if(request.getAttribute("id_question")!=null){
                            int idQuestion = (Integer) request.getAttribute("id_question");
                            QuestionsEntity question = (QuestionsEntity)op.getById(idQuestion,QuestionsEntity.class);
                    %>
                    <script>
                        $("#change_question").modal('show')
                    </script>
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >Редактировать вопрос</h4>
                    </div>
                    <div class="modal-body">
                        <table id="fields_question" class="table modal-table">
                            <tr>
                                <td><label class="control-label">Текст</label></td>
                                <td><input type="text" class="form-control"  placeholder="Текст" name="text_question" value="<%=question.getText()%>"></td>
                            </tr>
                            <tr>
                                <td><label class="control-label">Тип</label></td>
                                <td>
                                    <select class="form-control" name="type">
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
                                <td><label class="control-label">Очки</label></td>
                                <td><input type="text" class="form-control int-value"  placeholder="Очки" name="score" value="<%=question.getScore()%>"></td>
                            </tr>
                        </table>
                        <table class="table modal-table" id ="variants">
                            <tr>
                                <th><label class="control-label">Ответы</label></th>
                                <td></td>
                                <th><label class="control-label">Правильность</label></th>
                            </tr>
                            <% int i =1;%>
                            <%for (VariantsEntity variant:question.getVariants()){%>
                            <tr>
                                <td>
                                    <input type="text" class="form-control"  placeholder="Текст" name="text_variant<%=i%>" value="<%=variant.getText()%>">
                                </td>
                                <td><button name="del_variant" class="btn btn-default" value="<%=variant.getId()%>|<%=question.getId()%>|<%=test.getId()%>">X</button></td>
                                <td>
                                    <%
                                        String checked="";
                                        if (variant.getAnswer()) checked ="checked";
                                    %>
                                    <input class="form-control" type="checkbox" <%=checked%>  name="answer<%=i%>" value="true">
                                </td>
                            </tr>
                            <%
                                    i++;
                                }
                            %>
                            <tr>
                                <td><button  class="btn btn-default" type="button" onclick="$('#add_variant').css('display','table-row')">+</button></td>
                            </tr>
                            <tr style="display: none" id="add_variant">
                                <td><input type="text" class="form-control"  placeholder="Текст" name="text_variant"></td>
                                <td></td>
                                <td><input type="checkbox" class="form-control"  name="new_answer"></td>
                                <td><button type="button" onclick="addVariant(this)" class="btn btn-default" name="add_variant" value="<%=question.getId()%>|<%=test.getId()%>">OK</button></td>
                            </tr>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" onclick="checkQuestion(this)" name="edit" value="<%=question.getId()%>|<%=test.getId()%>"  class="btn btn-primary">OK</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                    <%}%>
                </div>
            </div>
        </div>








        <!-- Modal -->
        <div class="modal fade" id="change_test" style="display: none" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >Изменить тест</h4>
                    </div>
                    <div class="modal-body">
                        <table class="table modal-table">
                            <tr>
                                <td><label class="control-label">Название</label></td>
                                <td><input type="text"  class="form-control"  placeholder="Название" name="title_test" value="<%=test.getTitle()%>"></td>
                            </tr>
                            <tr>
                                <td><label class="control-label">Время выполнения</label></td>
                                <td><input type="text"  class="form-control int-value"  placeholder="Время выполнения" name="time_test" value="<%=test.getTime()%>"></td>
                            </tr>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button name="edit_test" value="<%=test.getId()%>"  class="btn btn-primary">OK</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal -->
        <div class="modal fade" style="display: none" id="add_question" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >Добавить вопрос</h4>
                    </div>
                    <div class="modal-body">
                        <table class="table modal-table">
                            <tr>
                                <td><label class="control-label">Текст</label></td>
                                <td><input type="text"  class="form-control"  placeholder="Текст" name="new_text_question"></td>
                            </tr>
                            <tr>
                                <td><label class="control-label">тип</label></td>
                                <td>
                                    <select class="form-control" name="new_type">
                                        <option value="c" > Множественный выбор</option>
                                        <option value="r" >Одиночный выбор</option>
                                        <option value="n" >Без выбора</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td><label class="control-label">Очки</label></td>
                                <td><input type="text" class="form-control int-value"  placeholder="Очки" name="new_score" ></td>
                            </tr>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button name="add_question" value="<%=test.getId()%>"  class="btn btn-primary">OK</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

    </form>
    </div>

<%op.disconnect();%>
</body>
</html>
