package servlets;

import hibernate.dao.Pupil;
import hibernate.dao.Teacher;
import hibernate.dao.UsersEntity;
import hibernate.utils.Operation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Alex on 05.04.2017.
 */
@WebServlet("/login/Regestration")
public class RegestrationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String login= request.getParameter("login");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        Operation op = new Operation();
        op.connect();
        if(op.findList(UsersEntity.class,"login",login).isEmpty()){
            UsersEntity user;
            if (role.equals("teacher")){
                user = new Teacher();

            }
            else {
                user = new Pupil();
            }
            user.setLogin(login);
            user.setPassword(password);
            op.beginTransaction();
            op.create(user);
            op.commit();
            op.disconnect();
            response.sendRedirect("../index.jsp");
        } else {
            op.disconnect();
            response.sendRedirect("invalidLogin.jsp");
        }



    }


}
