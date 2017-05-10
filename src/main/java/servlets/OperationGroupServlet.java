package servlets;

import hibernate.dao.GroupsEntity;
import hibernate.dao.Pupil;
import hibernate.utils.Operation;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Alex on 12.04.2017.
 */
@WebServlet("/OperationGroup")
public class OperationGroupServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        Operation op = new Operation();
        op.connect();
        op.beginTransaction();
        if ( request.getParameter("add_pupil")!=null){
            int idGroup = Integer.parseInt(request.getParameter("add_pupil"));
            String loginPupil = request.getParameter("login_pupil");
            GroupsEntity group = (GroupsEntity)op.getById(idGroup,GroupsEntity.class);
            if( op.findList(Pupil.class,"login",loginPupil).size()!=0 ) {
                Pupil pupil = (Pupil) op.findList(Pupil.class, "login", loginPupil).get(0);
                group.addPupil(pupil);
            } else {
                request.setAttribute("no-pupil",loginPupil);
            }
            op.commit();
            op.disconnect();
            request.setAttribute("id_group",idGroup);
            RequestDispatcher Dispatcher = getServletContext().getRequestDispatcher("/group.jsp");
            Dispatcher.forward(request, response);
        }
        if ( request.getParameter("del_group")!=null){
            int idGroup = Integer.parseInt(request.getParameter("del_group"));
            GroupsEntity group =(GroupsEntity)op.getById(idGroup,GroupsEntity.class);
            group.clear();
            op.deleteById(idGroup,GroupsEntity.class);
            op.commit();
            op.disconnect();
            response.sendRedirect("/teacherProfile.jsp");
        }
        if ( request.getParameter("del_pupil")!=null){
            String[] parts = request.getParameter("del_pupil").split("\\|");
            int idPupil = Integer.parseInt(parts[0]);
            int idGroup = Integer.parseInt(parts[1]);
            GroupsEntity group =(GroupsEntity)op.getById(idGroup,GroupsEntity.class);
            if(group.getPupils().size()!=0) {
                for (Pupil pupil : group.getPupils()) {
                    if (pupil.getId() == idPupil) {
                        group.getPupils().remove(pupil);
                    }
                }
            }
            op.commit();
            op.disconnect();
            request.setAttribute("id_group",idGroup);
            RequestDispatcher Dispatcher = getServletContext().getRequestDispatcher("/group.jsp");
            Dispatcher.forward(request, response);
        }
    }

}
