package servlets;

import hibernate.dao.GroupsEntity;
import hibernate.dao.Pupil;
import hibernate.dao.Teacher;
import hibernate.dao.TestsEntity;
import hibernate.utils.Operation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Iterator;



/**
 * Created by Alex on 09.04.2017.
 */
@WebServlet("/OperationWithGroup")
public class OperationWithGroupServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Teacher currentUser =   (Teacher) (session.getAttribute("currentSessionUser"));
        request.setCharacterEncoding("UTF-8");
        int id_teacher = currentUser.getId();
        Operation op = new Operation();
        op.connect();
        op.beginTransaction();
        Teacher teacher =(Teacher)op.getById(currentUser.getId(),Teacher.class);
            if (request.getParameter("add_test_in_group")!=null) {
                int idGroup = Integer.parseInt( request.getParameter("id_group"));
                int idTest = Integer.parseInt(request.getParameter("id_test_group"));
                GroupsEntity group = (GroupsEntity) op.getById(idGroup,GroupsEntity.class);
                TestsEntity test = (TestsEntity)op.getById(idTest,TestsEntity.class);
                group.addTest(test);
            }
            if (request.getParameter("add_pupil_in_group")!=null) {
                int idGroup = Integer.parseInt( request.getParameter("id_group"));
                String loginPupil = request.getParameter("login_pupil");
                Pupil pupil = (Pupil) op.findList(Pupil.class,"login",loginPupil).get(0);
                GroupsEntity group = (GroupsEntity) op.getById(idGroup,GroupsEntity.class);
                group.addPupil(pupil);
            }
            if (request.getParameter("add_group")!=null){
                String titleGroup = request.getParameter("title_group");
                GroupsEntity group = new GroupsEntity();
                group.setTitle(titleGroup);
                teacher.addGroup(group);
            }

            if (request.getParameter("change_group")!=null){
                String titleGroup = request.getParameter("new_title_group");
                int idGroup = Integer.parseInt(request.getParameter("id_group"));
                GroupsEntity group = (GroupsEntity) op.getById(idGroup,GroupsEntity.class);
                group.setTitle(titleGroup);
            }
            if ( request.getParameter("del_test_in_group")!=null){
                String[] parts = request.getParameter("del_test_in_group").split("\\|");
                int idTest = Integer.parseInt(parts[0] );
                int idGroup = Integer.parseInt(parts[1] );
                GroupsEntity group = (GroupsEntity) op.getById(idGroup,GroupsEntity.class);
                TestsEntity test = (TestsEntity)op.getById(idTest,TestsEntity.class);
                Iterator <TestsEntity> it = group.getTests().iterator();

                while (it.hasNext()) {
                    TestsEntity testsEntity =it.next();
                    if(test.getId()==testsEntity.getId()) {
                        it.remove();
                    }
                }
            }

            if ( request.getParameter("del_pupil_in_group")!=null){
                String[] parts = request.getParameter("del_pupil_in_group").split("\\|");
                int idPupil = Integer.parseInt( parts[0]);
                int idGroup = Integer.parseInt(parts[1] );
                Pupil pupil = (Pupil) op.getById(idPupil,Pupil.class);
                GroupsEntity group = (GroupsEntity) op.getById(idGroup,GroupsEntity.class);
                Iterator <Pupil> it = group.getPupils().iterator();

                while (it.hasNext()) {
                    Pupil pupil1 =it.next();
                    if(pupil.getId()==pupil1.getId()) {
                        it.remove();
                    }
                }
            }

            if ( request.getParameter("del_group")!=null){
                int idGroup = Integer.parseInt( request.getParameter("del_group"));
                GroupsEntity group = (GroupsEntity)op.getById(idGroup,GroupsEntity.class);
                System.out.println(group.getPupils());
                System.out.println(group.getTests());
                group.clear();
               op.deleteById(idGroup,GroupsEntity.class);
            }



       op.commit();
        op.disconnect();
        response.sendRedirect("teacherProfile.jsp");

    }

}
