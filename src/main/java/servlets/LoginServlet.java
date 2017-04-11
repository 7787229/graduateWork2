package servlets;

import hibernate.dao.Teacher;
import hibernate.dao.UsersEntity;
import hibernate.utils.Operation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by Alex on 05.04.2017.
 */
@WebServlet("/login/Login")
public class LoginServlet extends HttpServlet {


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String login= request.getParameter("login");
        String password = request.getParameter("password");
        Operation op = new Operation();
        op.connect();
        if(  !op.findList(UsersEntity.class,"login",login).isEmpty() &&
                !op.findList(UsersEntity.class,"password",password).isEmpty() ){
            UsersEntity user =(UsersEntity) op.findList(UsersEntity.class,"login",login).get(0);
            String redirect;
            if (user.getRole().equals("teacher")){
                redirect="../teacherProfile.jsp";
            }
            else {
                redirect="../pupilProfile.jsp";
            }
            session.setAttribute("test",null);
            session.setAttribute("currentSessionUser",user);
            op.disconnect();
            response.sendRedirect(redirect);
        }
        else {
            op.disconnect();
            response.sendRedirect("invalidLogin.jsp"); //error page
        }







    }
}
