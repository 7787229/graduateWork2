<%@ page import="hibernate.utils.Operation" %>
<%@ page import="hibernate.dao.*" %>
<%@ page import="java.util.ArrayList" %>
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
    <div class="container">
    <form action="OperationTeacher" method="post">
        <table class="table " id = "tests">

            <tr>
                <th><h3>Мои тесты</h3></th>
                <td ><button class="btn btn-default"     type="button" data-toggle="modal" data-target="#add_test">Добавить тест  </button></td>
            </tr>
            <%
                if (session.getAttribute("currentSessionUser")!=null) {
                    for(TestsEntity test :teacher.getTests() )  {

            %>
            <tr   >
               <td>
                   <div class="btn-group">
                       <button  name="open_test" class="btn btn-link test" value="<%=test.getId()%>" title="время выполнения <%=test.getTime() %>" ><span><%=test.getTitle() %> </span></button>
                       <button type="button" class ="toggle_options dropdown-toggle btn btn-default" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" >
                           <span class="caret"></span>
                       </button>
                       <ul class="options dropdown-menu pull-right" >
                           <li ><button class="btn btn-link option" name="add_group" value="<%=test.getId()%>">Менеджер групп</button></li>
                           <li ><button class="btn btn-link option" name="open_results" value="<%=test.getId()%>">Просмотреть результаты</button></li>
                       </ul>
                   </div>
               </td>
            </tr>

            <%} } %>
        </table>

        <!-- Modal -->
        <div style="display: none" class="modal fade" id="add_test" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >Добавить тест</h4>
                    </div>
                    <div class="modal-body">
                        <table class="table modal-table">
                            <tr >
                                <td ><label class="control-label">Название</label></td>
                                <td ><input type="text" class="form-control"  placeholder="Название" name="title_test"></td>
                            </tr>
                            <tr >
                                <td ><label class="control-label">Время выполнения</label></td>
                                <td ><input type="text" class="form-control int-value"  placeholder="Время выполнения" name="time_test"></td>
                            </tr>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button name="add_test" value="<%=teacher.getId()%>"  class="btn btn-primary">OK</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal -->

        <div style="display: none" class="modal fade" id="add_group" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <% if(request.getAttribute("id_test")!=null) {
                        int idTest = (Integer)request.getAttribute("id_test");
                        TestsEntity test = (TestsEntity)op.getById(idTest,TestsEntity.class) ;
                        ArrayList<GroupsEntity> groups= new ArrayList<GroupsEntity>();
                        groups.addAll(teacher.getGroups());
                    %>
                    <script>
                        $("#add_group").modal('show')
                    </script>
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >Добавить в группу тест <%=test.getTitle()%></h4>
                    </div>
                    <div class="modal-body">
                        <table class="table modal-table">

                            <tr>
                                <th >В новую</th>
                                <th>В существующую</th>
                            </tr>
                            <tr>
                                <td><input class="form-control"  placeholder="Название" type="text" name="new_title_group" ></td>
                                    <% if(groups.size()!=0) { %>
                                        <td><label class="control-label"><%=groups.get(0).getTitle()%></label></td>
                                        <%
                                            String checked = "";
                                            for(GroupsEntity group:test.getGroups()){
                                                if (group.getId()==groups.get(0).getId()) checked="checked";
                                            }
                                        %>
                                        <td><button class="group btn btn-link" name="open_group" value="<%=groups.get(0).getId()%>">Состав группы</button></td>
                                        <td><input <%=checked%>  type="checkbox" name="id_group0" value="<%=groups.get(0).getId()%>"></td>
                                    <%}%>
                            </tr>


                            <%
                                for (int i=1;i<groups.size();i++) {
                                    GroupsEntity group = groups.get(i);

                            %>
                            <tr>
                                <td></td>
                                <td><label class="control-label"><%=group.getTitle()%></label></td>

                                <%
                                    String checked2 = "";
                                    for(GroupsEntity group2:test.getGroups()){
                                        if (group2.getId()==group.getId()) checked2="checked";
                                    }
                                %>
                                <td><button class="group btn btn-link" name="open_group" value="<%=group.getId()%>">Состав группы</button></td>
                                <td><input <%=checked2%>  type="checkbox" name="id_group<%=i%>" value="<%=group.getId()%>"></td>

                            </tr>
                            <%}%>


                        </table>
                    </div>
                    <div class="modal-footer">
                        <button name="add_test_in_group"  class="btn btn-primary" value="<%=test.getId()%>|<%=teacher.getId()%>">Ok</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                    <%}%>
                </div>
            </div>
        </div>


    </form>
    </div>






<%
    op.disconnect();
%>
</body>
</html>
