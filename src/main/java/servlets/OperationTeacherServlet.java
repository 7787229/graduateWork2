package servlets;

import hibernate.dao.GroupsEntity;
import hibernate.dao.Teacher;
import hibernate.dao.TestsEntity;
import hibernate.utils.Operation;
import sun.plugin.com.Dispatcher;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by Alex on 11.04.2017.
 */
@WebServlet("/OperationTeacher")
public class OperationTeacherServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        Operation op = new Operation();
        op.connect();
        op.beginTransaction();
        if ( request.getParameter("add_group")!=null){
            int idTest = Integer.parseInt(request.getParameter("add_group"));
            request.setAttribute("id_test",idTest);
            op.disconnect();
            RequestDispatcher Dispatcher = getServletContext().getRequestDispatcher("/teacherProfile.jsp");
            Dispatcher.forward(request, response);
        }

        if ( request.getParameter("add_test")!=null){
            int idTeacher= Integer.parseInt(request.getParameter("add_test"));
            Teacher teacher = (Teacher)op.getById(idTeacher,Teacher.class);
            String titleTest = request.getParameter("title_test");
            int timeTest = Integer.parseInt(request.getParameter("time_test"));
            TestsEntity test = new TestsEntity();
            test.setTime(timeTest);
            test.setTitle(titleTest);
            op.create(test);
            teacher.addTest(test);
            op.commit();
            op.disconnect();
            response.sendRedirect("/teacherProfile.jsp");
        }
        if(request.getParameter("add_test_in_group")!=null) {
            String[] parts = request.getParameter("add_test_in_group").split("\\|");
            int idTest = Integer.parseInt(parts[0]);
            int idTeacher = Integer.parseInt(parts[1]);
            TestsEntity test = (TestsEntity)op.getById(idTest,TestsEntity.class);
            Teacher teacher = (Teacher)op.getById(idTeacher,Teacher.class);
                int i=0;
                for(GroupsEntity group:teacher.getGroups())  {
                    if (request.getParameter("id_group"+i)!=null) {
                        group.addTest(test);
                    }
                    if (request.getParameter("id_group"+i)==null) {
                        group.getTests().remove(test);
                    }

                    i++;
                }
            if(request.getParameter("new_title_group")!="") {
                String titleGroup = request.getParameter("new_title_group");
                GroupsEntity group = new GroupsEntity();
                group.setTitle(titleGroup);
                group.addTest(test);
                op.create(group);
                teacher.addGroup(group);
            }
            request.setAttribute("id_test",idTest);
            op.commit();
            op.disconnect();
            RequestDispatcher Dispatcher = getServletContext().getRequestDispatcher("/teacherProfile.jsp");
            Dispatcher.forward(request, response);
        }

        if(request.getParameter("open_group")!=null){
            int idGroup = Integer.parseInt(request.getParameter("open_group"));
            op.disconnect();
            request.setAttribute("id_group",idGroup);
            RequestDispatcher Dispatcher = getServletContext().getRequestDispatcher("/group.jsp");
            Dispatcher.forward(request, response);
        }
        if(request.getParameter("open_test")!=null){
            int idTest = Integer.parseInt(request.getParameter("open_test"));
            op.disconnect();
            request.setAttribute("id_test",idTest);
            RequestDispatcher Dispatcher = getServletContext().getRequestDispatcher("/test.jsp");
            Dispatcher.forward(request, response);
        }
        if(request.getParameter("open_results")!=null){
            int idTest = Integer.parseInt(request.getParameter("open_results"));
            op.disconnect();
            request.setAttribute("id_test",idTest);
            RequestDispatcher Dispatcher = getServletContext().getRequestDispatcher("/results.jsp");
            Dispatcher.forward(request, response);
        }



    }


}
