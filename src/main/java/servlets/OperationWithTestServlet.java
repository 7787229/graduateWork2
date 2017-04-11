package servlets;

import hibernate.dao.*;
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
@WebServlet("/OperationWithTest")
public class OperationWithTestServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Operation op = new Operation();
        op.connect();
        UsersEntity currentUser =   (UsersEntity) (session.getAttribute("currentSessionUser"));
        Teacher teacher =(Teacher)op.getById(currentUser.getId(),Teacher.class);
        op.beginTransaction();
        request.setCharacterEncoding("UTF-8");
        int id_teacher = teacher.getId();

            if (request.getParameter("exit")!=null){
                session.invalidate();
                response.sendRedirect("index.jsp");
                return;

            }


            if (request.getParameter("add_test")!=null){
                String titleTest = request.getParameter("title_test");
                int time = Integer.parseInt(request.getParameter("time"));
                TestsEntity test =new TestsEntity();
                test.setTitle(titleTest);
                test.setTime(time);
                teacher.addTest(test);

            }


            if (request.getParameter("change_test")!=null){
                String titleTest = request.getParameter("new_title_test");
                int time = Integer.parseInt(request.getParameter("new_time"));
                int idTest = Integer.parseInt(request.getParameter("id_test"));
                TestsEntity test =(TestsEntity)op.getById(idTest,TestsEntity.class);
                test.setTitle(titleTest);
                test.setTime(time);

            }



            if (request.getParameter("add_question")!=null){
                String textQuestion = request.getParameter("text_question");
                int score = Integer.parseInt( request.getParameter("score"));
                String type = request.getParameter("type");
                int idTest = Integer.parseInt(request.getParameter("id_test"));
                QuestionsEntity question = new QuestionsEntity();
                question.setText(textQuestion);
                question.setScore(score);
                question.setType(type);
                TestsEntity test =(TestsEntity)op.getById(idTest,TestsEntity.class);


                if (!type.equals("n")){
                    int countVariants = Integer.parseInt(request.getParameter("count_variants"));
                    for (int i=1;i<=countVariants;i++) {
                        boolean answer =false;
                        if (request.getParameter("answer"+i).equals("yes")) answer = true;
                        VariantsEntity variant = new VariantsEntity();
                        variant.setAnswer(answer);
                        variant.setText(request.getParameter("text_variant"+i));
                        question.addVariant(variant);
                    }
                }

                if (type.equals("n")){
                    VariantsEntity variant = new VariantsEntity();
                    variant.setAnswer(true);
                    variant.setText(request.getParameter("text_variant"));
                    question.addVariant(variant);
                }
                test.addQuestion(question);


            }

            if ( request.getParameter("del_question")!=null){
                int idQuestion = Integer.parseInt( request.getParameter("del_question"));
                op.deleteById(idQuestion,QuestionsEntity.class);



            }



            if ( request.getParameter("del_test")!=null) {

                int idTest = Integer.parseInt(request.getParameter("del_test"));
                op.deleteById(idTest,TestsEntity.class);

            }


        op.commit();
        op.disconnect();
        response.sendRedirect("teacherProfile.jsp");
    }


}
