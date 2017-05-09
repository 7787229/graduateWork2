<%@ page import="hibernate.utils.Operation" %>
<%@ page import="hibernate.dao.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %><%--
  Created by IntelliJ IDEA.
  User: Alex
  Date: 05.04.2017
  Time: 16:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%
    UsersEntity currentUser =   (UsersEntity) (session.getAttribute("currentSessionUser"));
    Operation op = new Operation();
    op.connect();
    Pupil pupil = (Pupil) op.getById(currentUser.getId(),Pupil.class);
%>
<head>
    <title>Профиль ученика <%=currentUser.getLogin()%></title>
</head>
<body>
<%@ include file="head.jsp" %>

<div class="container">
    <form  method="post" action="SelectTest" >
    <table id="groups" class="table pull-left" style="width: 200px;>
        <%
            for (GroupsEntity group : pupil.getGroups() ) {
                int idGroup = group.getId();
        %>
        <tr class="group">
            <th class="text-center" colspan="2">
                <span><b><%=group.getTitle() %></b></span>
            </th>

        </tr>

            <%
                for(TestsEntity test: group.getTests()) {
                    int idTest=test.getId();
            %>
            <tr class="test">
                <td>
                    <a href="${pageContext.request.contextPath}/SelectTest?idTest=<%=idTest %>"><%=test.getTitle() %></a>
                </td>
            </tr>


            <%} %>




        <%} %>
    </table>
        <table  id="start_test" class="pull-left table" style="width: 300px;margin-left: 50px">
            <%
                if (request.getSession().getAttribute("test")!=null) {
                    HttpSession ses =request.getSession();
                    TestsEntity test =    (TestsEntity) ses.getAttribute("test");
                    ArrayList <QuestionsEntity> questions = new ArrayList<QuestionsEntity>();
                    questions.addAll(test.getQuestions());
                    int numberQuestion =  (Integer)  ses.getAttribute("numberQuestion");
                    QuestionsEntity question = questions.get(numberQuestion);
                    ArrayList <VariantsEntity> variants = new ArrayList<VariantsEntity>();
                    variants.addAll(question.getVariants());
                    ses.setAttribute("variants", variants);
                    ses.setAttribute("score", question.getScore());
                    HashMap<String, Object>[] historyAnswers =  (HashMap<String, Object>[]) ses.getAttribute("historyAnswers");
            %>
            <tr class="text-center" ><td ><b><%=test.getTitle() %></b></td></tr>
                <%
                    String type="";
                    if(question.getType().equals("r")) type="radio";
                    if(question.getType().equals("c")) type="checkbox";
                    if(question.getType().equals("n")) type="text";
                %>
                <tr class="no-border"><td><label><%=question.getText() %></label></td></tr>
                <%for (int i=0;i<variants.size();i++)  {%>

                <tr class="variant">
                    <%if(type.equals("radio")) {%>
                    <%
                        String checked = "";
                        if (historyAnswers[numberQuestion]!=null && historyAnswers[numberQuestion].get("radio").equals(i) )
                            checked = "checked";

                    %>
                    <td>
                        <input type='<%=type%>' name="answerRadio" value='<%=i %>' <%=checked %>>
                        <span><%=variants.get(i).getText() %></span>
                    </td>
                    <%}  if(type.equals("text")){ %>
                    <%
                        String value="";
                        if (historyAnswers[numberQuestion]!=null)
                            value =String.valueOf(historyAnswers[numberQuestion].get("text"));
                    %>
                    <td><input class="form-control" type='<%=type%>' name="answerText" value="<%=value%>"></td>
                    <%} if(type.equals("checkbox")){ %>
                    <%
                        String checked = "";
                        if (historyAnswers[numberQuestion]!=null) {
                            int [] selected = (int []) historyAnswers[numberQuestion].get("check");
                            if ( selected[i]!=-1 )
                                checked = "checked";
                        }
                    %>
                    <td>
                        <input  type='<%=type%>' name="answerCheck<%=i %>" <%=checked %> >
                        <span><%=variants.get(i).getText() %></span>
                    </td>
                    <%} %>

                </tr>
                <%} %>

            <%
                String disabledPrev="";
                if (numberQuestion==0) disabledPrev="disabled";
                String disabledNext="";
                if (numberQuestion==questions.size()-1) disabledNext="disabled";
            %>
            <tr>
            <td>
                <button class="btn btn-default" <%=disabledPrev%> name="prev" value="<%=numberQuestion%>">Назад</button>
                <button class="btn btn-default" <%=disabledNext%> name="next" value="<%=numberQuestion%>">Вперед</button>
                <button class="btn btn-default" name="send" value="<%=numberQuestion%>">Сдать</button>
            </td>
            </tr>
            <%} %>
        </table>
        <div class="modal fade" id="final_test" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <%
                        if(request.getAttribute("final_test")!=null){
                            Float result = (Float) request.getAttribute("final_test");
                    %>
                    <script>
                        $("#final_test").modal('show')
                    </script>
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >Результат </h4>
                    </div>
                    <div class="modal-body">
                        <table class="table modal-table">
                            <tr>
                                <td>Ваш результат</td>
                                <td><%=result%>%</td>
                            </tr>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                    <%}%>
                </div>
            </div>
        </div>
    </form>
    <%
        op.disconnect();
    %>

</div>
</body>
</html>
