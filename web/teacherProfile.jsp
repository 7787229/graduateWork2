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
</head>
<body>
<%@ include file="head.jsp" %>
<%
    Teacher currentUser =   (Teacher) (session.getAttribute("currentSessionUser"));
    Operation op = new Operation();
    op.connect();
    Teacher teacher = (Teacher)op.getById(currentUser.getId(),Teacher.class);
%>
<div id="content">


    <form action="OperationWithTest" method="post">
        <ul style="display:inline-block">
            <li><button name="exit" value="exit">Выход  </button></li>
            <li><button   onclick="addTest()" type="button">Добавить тест  </button></li>
        </ul><br>

        <ul id = "tests">
            <li>
                <table id="add_test" class="hidden">
                    <tr>
                        <td><span>Название</span></td>
                        <td><input type="text" name="title_test"></td>
                    </tr>
                    <tr>
                        <td><span>Время выполнения</span></td>
                        <td><input type="text" name="time"></td>
                    </tr>
                    <tr> <td><button name="add_test" value="add_test">Добавить  </button> </td></tr>
                </table>
            </li>
            <li><h3>Мои тесты</h3></li>
            <%
                if (session.getAttribute("currentSessionUser")!=null) {
                    for(TestsEntity test :teacher.getTests() )  {

            %>
            <li class = "test"  >
                <label title="время выполнения <%=test.getTime() %>" onclick="showQuestions(this)"><span><%=test.getTitle() %> </span></label>
                <button type="button"  class="btn_change_test" onclick="changeTest(this,<%=test.getId()%>,<%=test.getTime()%>,'<%=test.getTitle()%>')">~</button>
                <button type="button" onclick="addQuestion(this,<%=test.getId()%>)">+</button>
                <button name="del_test" value=<%=test.getId() %> >-</button>
                <ul class="questions hidden">
                    <%
                        for (QuestionsEntity question:  test.getQuestions()  ) {
                    %>
                    <li class="question">
                        <%
                            String type ="тип неизвестен";
                            if (question.getType().equals("c")) type = "множественный выбор";
                            if (question.getType().equals("r")) type = "одиночный выбор";
                            if (question.getType().equals("n")) type = "без вариантов";
                        %>
                        <label onclick="showQuestions(this)" style="color:green" title="<%=question.getScore() %> очков, <%=type %>"     ><span><%=question.getText() %></span></label>
                        <button style="color:green" name="del_question" value=<%=question.getId() %>>x</button>
                        <ul class="variants hidden">
                            <%for (VariantsEntity variant:  question.getVariants()   ) {%>
                            <li class="variant">
                                <span ><%=variant.getText() %></span>
                                <%if (variant.getAnswer()) {%>
                                <input style="" disabled type ="checkbox" class="as" checked>
                                <% }else{ %>
                                <input disabled type ="checkbox" class="as">
                                <%} %>
                            </li>
                            <%} %>
                        </ul>
                    </li>
                    <% } %>
                </ul>
            </li>

            <%}  %>
        </ul>
    </form>
    <form action="OperationWithGroup" method="post">
        <ul id="groups">
            <li><h3>Мои группы</h3></li>
            <li><button   onclick="addGroup()" type="button">Добавить группу  </button></li>
            <li>
                <table id="add_group" class="hidden">
                    <tr>
                        <td><span>Название</span></td>
                        <td><input type="text" name="title_group"></td>
                    </tr>
                    <tr> <td><button name="add_group" value="add_group">Добавить  </button> </td></tr>
                </table>
            </li>
            <%
                for( GroupsEntity group : teacher.getGroups()) {
            %>
            <li class="group">
                <label onclick="showGroups(this)"><span><%=group.getTitle()%> </span></label>
                <button name="del_group" value=<%=group.getId()%> >-</button>
                <button type="button"   onclick="changeGroup(this,<%=group.getId()%>,'<%=group.getTitle()%>')">~</button>
                <table class="hidden">
                    <tr>
                        <th colspan="2">тесты </th>
                        <th colspan="2"> ученики</th>
                    </tr>
                    <%   //for(TestInGroup testInGroup: (ArrayList<TestInGroup>) Controller.find(new TestInGroup(group.getIdGroup(),0)) )

                        Set<TestsEntity> tests = group.getTests();


                        Set<Pupil> pupils = group.getPupils();
                        Iterator<TestsEntity> testIterator = tests.iterator();
                        Iterator<Pupil> pupilIterator =pupils.iterator();
                        //for(int i = 0; i< tests.size() || i< pupils.size(); i++,testIterator.next(),pupilIterator.next())
                            while (testIterator.hasNext() || pupilIterator.hasNext())
                        {
                            String titleTest="пусто";
                            int idTest =0;
                            if (testIterator.hasNext()) {
                                TestsEntity test = testIterator.next();

                                titleTest = test.getTitle();
                                idTest=test.getId();
                                //System.out.println(test);
                            }
                            String loginPupil="пусто";
                            int idPupil=0;
                            if (pupilIterator.hasNext()) {
                                Pupil pupil = pupilIterator.next();
                                //System.out.println(pupil);
                               loginPupil = pupil.getLogin();
                               idPupil=pupil.getId();
                            }
                    %>
                    <tr>
                        <td><%=titleTest %></td><td> <button style="color:green" name="del_test_in_group" value= <%= idTest+"|"+group.getId() %>>x</button>   </td>
                        <td><%=loginPupil %></td> <td><button style="color:green" name="del_pupil_in_group" value= <%= idPupil+"|"+group.getId() %>>x</button>  </td>
                    </tr>
                    <%} %>
                    <tr>
                        <td colspan="2"><button type="button" onclick="addTestInGroup(this,<%=group.getId()%>)">+</button> </td>
                        <td colspan="2"> <button type="button" onclick="addPupilInGroup(this,<%=group.getId()%>)">+</button></td>
                    </tr>

                </table>
            </li>
            <%} %>
        </ul>
    </form>

    <form action="OperationWithResult" method="post">
        <ul id="results">
            <li><h3>Мои Результаты</h3></li>
            <%
                //ArrayList<Result> results = (ArrayList<Result>) Controller.find(new Result(currentUser.getIdTeacher(),0,0,-1));
                //ResultsEntity [] results = (ResultsEntity[]) op.findList(ResultsEntity.class,"id_teacher",String.valueOf(teacher.getId())).toArray();
                ArrayList<ResultsEntity> results = new ArrayList<>();
                results.addAll( teacher.getResults());
                outer:for(int i=0;i<results.size();i++) {
                    for(int k=0;k<i;k++) {
                        //Iterator<ResultsEntity> resultIterator = results.iterator();
                        if(results.get(k).getTest().getId()==results.get(i).getTest().getId()) continue outer;
                    }
                    TestsEntity test = results.get(i).getTest();

            %>
            <li class="result">
                <label onclick="showResult(this)">
                    <span><%=test.getTitle() %></span>
                </label>
                <button name="del_result" value="<%=test.getId()%>">-</button>
                <table class="hidden" id="pupils" >
                    <%

                        for(ResultsEntity result: test.getResults()) {
                            Pupil pupil = result.getPupil();
                    %>
                    <tr class="pupil">
                        <td>
                            <%=pupil.getLogin() %>
                        </td>
                        <td>
                            <%=String.format("%.2f", result.getProgress())  %>
                        </td>
                        <td> <button name="del_result_pupil" value="<%=test.getId()+"|"+pupil.getId()%>">x</button> </td>
                    </tr>
                    <% }%>
                </table>
            </li>



            <%} %>
        </ul>
    </form>

    <%} %>
    <%
        op.disconnect();
    %>
</div>
</body>
</html>
