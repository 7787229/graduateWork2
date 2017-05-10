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
<%
    Operation op = new Operation();
    op.connect();
    int idGroup = (Integer)request.getAttribute("id_group");
    GroupsEntity group = (GroupsEntity)op.getById(idGroup,GroupsEntity.class);
%>
<head>
    <title>Группа <%=group.getTitle()%></title>
</head>
<body>
<%@ include file="head.jsp" %>

<div class="container" >
    <form  method="post" action="OperationGroup">
        <table id="group" class="table">
            <tr>
                <td><h1><%=group.getTitle()%></h1></td>
                <td>
                    <div class="btn-group">
                        <button type="button" class ="toggle_options dropdown-toggle btn btn-default" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span class="caret"></span>
                        </button>
                        <ul class="options dropdown-menu">
                            <li>
                                <button class="btn btn-link option" type="button" data-toggle="modal" data-target="#add_pupil" >Добавить ученика</button>
                            </li>
                            <li>
                                <button  class="btn btn-link option" name="del_group" value="<%=group.getId()%>">Удалить группу</button>
                            </li>
                        </ul>
                    </div>
                </td>
            </tr>
            <%for (Pupil pupil:group.getPupils()){%>
                <tr class="pupil">
                    <td><span><%=pupil.getLogin()%></span></td>
                    <td><button class="btn btn-default" name="del_pupil" value="<%=pupil.getId()%>|<%=group.getId()%>">Удалить ученика</button></td>
                </tr>

            <%}%>

        </table>



        <div class="modal fade" id="add_pupil" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <%
                        String loginPupil="";
                        if(request.getAttribute("no-pupil")!=null) {
                          loginPupil = (String) request.getAttribute("no-pupil");
                    %>
                        <script>
                            $("#add_pupil").modal('show')
                        </script>
                    <%}%>
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >Добавить ученика</h4>
                    </div>
                    <div class="modal-body">
                        <table class="table modal-table">
                            <%if (!loginPupil.equals("")){%>
                                <tr>
                                    <td class="color-red">
                                        Пользоателя с логином <%=loginPupil%> не существует
                                    </td>
                                </tr>
                            <%}%>
                            <tr >
                                <td ><label class="control-label">Логин ученика</label></td>
                                <td ><input type="text" class="form-control"  placeholder="Логин ученика" name="login_pupil"></td>
                            </tr>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button name="add_pupil" value="<%=group.getId()%>"  class="btn btn-primary">OK</button>
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
