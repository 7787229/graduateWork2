package servlets;

import hibernate.dao.Pupil;
import hibernate.dao.ResultsEntity;
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
import java.util.ArrayList;

/**
 * Created by Alex on 10.04.2017.
 */
@WebServlet("/OperationWithResult")
public class OperationWithResultServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Operation op=new Operation();
        op.connect();
        op.beginTransaction();
        HttpSession session = request.getSession();
        Teacher currentUser =   (Teacher) (session.getAttribute("currentSessionUser"));
        request.setCharacterEncoding("UTF-8");
        int id_teacher = currentUser.getId();
            if ( request.getParameter("del_result_pupil")!=null){
                String[] parts = request.getParameter("del_result_pupil").split("\\|");
                int idTest = Integer.parseInt( parts[0]);
                int idPupil = Integer.parseInt(parts[1] );
                Pupil pupil =(Pupil)op.getById(idPupil,Pupil.class);
                System.out.println(pupil.getResults());
                ArrayList<ResultsEntity> results =new ArrayList<ResultsEntity>();
                results.addAll(pupil.getResults());
                for (ResultsEntity result: results){
                    if (result.getTest().getId()==idTest){
                        pupil.getResults().remove(result);
                    }
                }


            }
            if ( request.getParameter("del_result")!=null){

                int idTest = Integer.parseInt( request.getParameter("del_result"));
                TestsEntity test =(TestsEntity)op.getById(idTest,TestsEntity.class);
                test.getResults().clear();

            }
            op.commit();
            op.disconnect();
            response.sendRedirect("teacherProfile.jsp");
        }


    }



