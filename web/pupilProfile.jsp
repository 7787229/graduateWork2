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
<head>
    <title>Title</title>
</head>
<body>
<%@ include file="head.jsp" %>
<%
    UsersEntity currentUser =   (UsersEntity) (session.getAttribute("currentSessionUser"));
    Operation op = new Operation();
    op.connect();
    Pupil pupil = (Pupil) op.getById(currentUser.getId(),Pupil.class);
%>
<div id="content">
    <ul id="groups">
        <%
            for (GroupsEntity group : pupil.getGroups() ) {
                int idGroup = group.getId();
        %>
        <li class="group">
            <label>
                <span><b><%=group.getTitle() %></b></span>
            </label>
            <ul id ="tests">
                <%
                    for(TestsEntity test: group.getTests()) {
                        int idTest=test.getId();
                %>
                <li class="test">
                    <label onclick="window.location.href = '${pageContext.request.contextPath}/SelectTest?idTest=<%=idTest %>'">
                        <span><%=test.getTitle() %></span>

                    </label>
                </li>


                <%} %>
            </ul>
        </li>



        <%} %>
    </ul>
    <form  method="post" action="SelectTest">
        <button name="exit" value="exit">exit</button>
        <div id="start_test">
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
            <span><%=test.getTitle() %></span>
            <div id="question">
                <%
                    String type="";
                    if(question.getType().equals("r")) type="radio";
                    if(question.getType().equals("c")) type="checkbox";
                    if(question.getType().equals("n")) type="text";
                %>
                <span><%=question.getText() %></span>
                <%for (int i=0;i<variants.size();i++)  {%>

                <div class="variant">
                    <%if(type.equals("radio")) {%>
                    <%
                        String checked = "";
                        if (historyAnswers[numberQuestion]!=null && historyAnswers[numberQuestion].get("radio").equals(i) )
                            checked = "checked";

                    %>
                    <input type='<%=type%>' name="answerRadio" value='<%=i %>' <%=checked %>>
                    <%}  if(type.equals("text")){ %>
                    <%
                        String value="";
                        if (historyAnswers[numberQuestion]!=null)
                            value =String.valueOf(historyAnswers[numberQuestion].get("text"));
                    %>
                    <input type='<%=type%>' name="answerText" value="<%=value%>">
                    <%} if(type.equals("checkbox")){ %>
                    <%
                        String checked = "";
                        if (historyAnswers[numberQuestion]!=null) {
                            int [] selected = (int []) historyAnswers[numberQuestion].get("check");
                            if ( selected[i]!=-1 )
                                checked = "checked";
                        }
                    %>
                    <input type='<%=type%>' name="answerCheck<%=i %>" <%=checked %> >
                    <%} %>
                    <%if(!type.equals("text")) {%>
                    <span><%=variants.get(i).getText() %></span>
                    <%} %>
                </div>
                <%} %>
            </div>
            <br>
            <%
                String disabledPrev="";
                if (numberQuestion==0) disabledPrev="disabled";
                String disabledNext="";
                if (numberQuestion==questions.size()-1) disabledNext="disabled";
            %>
            <button <%=disabledPrev%> name="prev" value="<%=numberQuestion%>">prev</button>
            <button <%=disabledNext%> name="next" value="<%=numberQuestion%>">next</button>
            <button name="send" value="<%=numberQuestion%>">send</button>
            <%} %>
        </div>
    </form>
    <%
        op.disconnect();
    %>

</div>
<div id="final_test">
    <table>
        <%
            if(request.getAttribute("final_test")!=null){
                Float result = (Float) request.getAttribute("final_test");
        %>
        <script>
            showWindow($("#final_test"),$("#final_test table"));
        </script>
        <tr>
            <td>Ваш результат</td>
            <td><%=result%>%</td>
        </tr>
        <tr>
            <td><button>OK</button></td>
        </tr>
        <%}%>
    </table>
</div>
</body>
</html>
