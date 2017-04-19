package servlets;

import hibernate.dao.*;
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
@WebServlet("/OperationTest")
public class OperationTestServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        Operation op = new Operation();
        op.connect();
        op.beginTransaction();
        if ( request.getParameter("change_question")!=null){
            String[] parts = request.getParameter("change_question").split("\\|");
            int idQuestion = Integer.parseInt(parts[0]);
            int idTest = Integer.parseInt(parts[1]);
            request.setAttribute("id_question",idQuestion);
            request.setAttribute("id_test",idTest);
            op.disconnect();
            RequestDispatcher Dispatcher = getServletContext().getRequestDispatcher("/test.jsp");
            Dispatcher.forward(request, response);
        }

        if ( request.getParameter("edit_test")!=null){
            int idTest = Integer.parseInt(request.getParameter("edit_test"));
            String titleTest = request.getParameter("title_test");
            int time = Integer.parseInt(request.getParameter("time_test"));
            TestsEntity test =(TestsEntity)op.getById(idTest,TestsEntity.class);
            test.setTitle(titleTest);
            test.setTime(time);
            op.commit();
            op.disconnect();
            request.setAttribute("id_test",idTest);
            RequestDispatcher Dispatcher = getServletContext().getRequestDispatcher("/test.jsp");
            Dispatcher.forward(request, response);
        }

        if ( request.getParameter("add_question")!=null){
            int idTest = Integer.parseInt(request.getParameter("add_question"));
            TestsEntity test = (TestsEntity)op.getById(idTest,TestsEntity.class);
            QuestionsEntity question = new QuestionsEntity();
            question.setText( request.getParameter("new_text_question"));
            question.setType(request.getParameter("new_type"));
            question.setScore(Integer.parseInt(request.getParameter("new_score")));
            op.create(question);
            test.addQuestion(question);
            op.commit();
            op.disconnect();
            request.setAttribute("id_test",idTest);
            RequestDispatcher Dispatcher = getServletContext().getRequestDispatcher("/test.jsp");
            Dispatcher.forward(request, response);
        }
        if ( request.getParameter("add_variant")!=null){
            String[] parts = request.getParameter("add_variant").split("\\|");
            int idQuestion = Integer.parseInt(parts[0]);
            int idTest = Integer.parseInt(parts[1]);;
            QuestionsEntity question = (QuestionsEntity)op.getById(idQuestion,QuestionsEntity.class);
            String textVariant = request.getParameter("text_variant");
            boolean answer = false;
            if (request.getParameter("new_answer")!=null) answer=true;
            VariantsEntity variant = new VariantsEntity();
            variant.setText(textVariant);
            variant.setAnswer(answer);
            op.create(variant);
            question.addVariant(variant);
            op.commit();
            op.disconnect();
            request.setAttribute("id_question",idQuestion);
            request.setAttribute("id_test",idTest);
            RequestDispatcher Dispatcher = getServletContext().getRequestDispatcher("/test.jsp");
            Dispatcher.forward(request, response);
        }

        if ( request.getParameter("del_variant")!=null){
            String[] parts = request.getParameter("del_variant").split("\\|");
            int idVariant =Integer.parseInt(parts[0]);
            int idQuestion =Integer.parseInt(parts[1]);
            int idTest =Integer.parseInt(parts[2]);
            op.deleteById(idVariant,VariantsEntity.class);
            op.commit();
            op.disconnect();
            request.setAttribute("id_question",idQuestion);
            request.setAttribute("id_test",idTest);
            RequestDispatcher Dispatcher = getServletContext().getRequestDispatcher("/test.jsp");
            Dispatcher.forward(request, response);
        }
        if ( request.getParameter("del_question")!=null){
            String[] parts = request.getParameter("del_question").split("\\|");
            int idQuestion =Integer.parseInt(parts[0]);
            int idTest =Integer.parseInt(parts[1]);
            op.deleteById(idQuestion,QuestionsEntity.class);
            op.commit();
            op.disconnect();
            request.setAttribute("id_test",idTest);
            RequestDispatcher Dispatcher = getServletContext().getRequestDispatcher("/test.jsp");
            Dispatcher.forward(request, response);
        }

        if ( request.getParameter("edit")!=null){
            String[] parts = request.getParameter("edit").split("\\|");
            int idQuestion =Integer.parseInt(parts[0]);
            int idTest =Integer.parseInt(parts[1]);
            String textQuestion = request.getParameter("text_question");
            String type = request.getParameter("type");
            int score =Integer.parseInt(request.getParameter("score"));
            QuestionsEntity question = (QuestionsEntity)op.getById(idQuestion,QuestionsEntity.class);
            int i=1;
            for (VariantsEntity variant :question.getVariants()){
                variant.setText(request.getParameter("text_variant"+i));
                boolean answer = false;
                if (request.getParameter("answer"+i)!=null) answer=true;
                variant.setAnswer(answer);
                i++;
            }
            question.setText(textQuestion);
            question.setType(type);
            question.setScore(score);
            op.commit();
            op.disconnect();
            request.setAttribute("id_question",idQuestion);
            request.setAttribute("id_test",idTest);
            RequestDispatcher Dispatcher = getServletContext().getRequestDispatcher("/test.jsp");
            Dispatcher.forward(request, response);
        }

    }

}
