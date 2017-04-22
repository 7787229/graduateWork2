package servlets;

import hibernate.dao.*;
import hibernate.utils.Operation;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Set;

/**
 * Created by Alex on 10.04.2017.
 */
@WebServlet("/SelectTest")
public class SelectTestServlet extends HttpServlet {
    private void calcResults( HttpSession ses,ServletRequest request,ServletResponse response,int numberQuestion)  {

            int [] results = (int[]) ses.getAttribute("results");
            HashMap<String, Object> [] historyAnswers =  (HashMap<String, Object>[]) ses.getAttribute("historyAnswers");
            int score = (Integer) ses.getAttribute("score");
            ArrayList <VariantsEntity> variants = (ArrayList<VariantsEntity>) ses.getAttribute("variants");
            int countVariants = variants.size();

        if (request.getParameter("answerRadio")!=null) {
                int selectVariant = Integer.parseInt(request.getParameter("answerRadio"));
                historyAnswers[numberQuestion] = new HashMap<String, Object>();
                historyAnswers[numberQuestion].put("radio", selectVariant);
                if (variants.get(selectVariant).getAnswer()) {
                    results[numberQuestion]=score;
                } else{
                    results[numberQuestion]=0;
                }
            } else if (request.getParameter("answerText")!=null && request.getParameter("answerText")!=""){
                historyAnswers[numberQuestion] = new HashMap<String, Object>();
                historyAnswers[numberQuestion].put("text", request.getParameter("answerText"));
                if( variants.get(0).getText().equals( request.getParameter("answerText"))){
                    results[numberQuestion]=score;
                }
                else {
                    results[numberQuestion]=0;
                }
            } else {
                int countSelectVariants = 0;
                int countSelectRightVariants = 0;
                int countRightVariants=0;
                int [] answers = new int[countVariants];
                for (int i=0;i<countVariants;i++){
                    answers[i] =-1;
                    if (variants.get(i).getAnswer()) countRightVariants++;
                    if (request.getParameter("answerCheck"+i)!=null) {
                        answers[i]=i;
                        countSelectVariants++;
                        if(variants.get(i).getAnswer()){
                            countSelectRightVariants++;
                        }
                    }

                }

                if(countSelectVariants!=0) {

                    historyAnswers[numberQuestion] = new HashMap<String, Object>();
                    historyAnswers[numberQuestion].put("check", answers);
                    if(countSelectVariants==countSelectRightVariants && countSelectRightVariants==countRightVariants) {
                        results[numberQuestion]=score;
                    }

                    else if (  (countSelectVariants - countSelectRightVariants ==1  && countSelectRightVariants== countRightVariants)
                            || (  countRightVariants - countSelectVariants ==1 && countSelectVariants== countSelectRightVariants)){
                        results[numberQuestion]=(int) (score*0.2);
                    } else{
                        results[numberQuestion] = 0;
                    }
                }

            }

            for (int i=0;i<results.length;i++) {
                System.out.println(" results [ index = "+i+" element = "+results[i]+" ] ");
            }

            for (int i=0;i<historyAnswers.length;i++) {
                System.out.println(" history [ index = "+i+" element = "+historyAnswers[i]+" ] ");
            }
            ses.setAttribute("results",results);
            ses.setAttribute("historyAnswers", historyAnswers);

        }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
             request.setCharacterEncoding("UTF-8");
            Operation op= new Operation();
            op.connect();
            op.beginTransaction();
            int idTest = Integer.parseInt( request.getParameter("idTest"));

            TestsEntity test =(TestsEntity)op.getById(idTest,TestsEntity.class);
            ArrayList<QuestionsEntity> questions = new ArrayList<QuestionsEntity>();
            questions.addAll(test.getQuestions());
            float sumScore=0;
            for (QuestionsEntity question:questions) {
                sumScore+=question.getScore();
            }
            HttpSession ses =request.getSession();
            ses.setAttribute("sumScore", sumScore);
            ses.setAttribute("numberQuestion", 0);
            ses.setAttribute("test", test);
            int [] results = new int[questions.size()];
            ses.setAttribute("results",results);
            HashMap<String, Object>[] historyAnswers = new HashMap[questions.size()];

            ses.setAttribute("historyAnswers", historyAnswers);
            op.commit();
            op.disconnect();
            //RequestDispatcher Dispatcher = getServletContext().getRequestDispatcher("/pupilProfile.jsp");
           // Dispatcher.forward(request, response);
            response.sendRedirect("/pupilProfile.jsp");

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession ses =request.getSession();
        int numberQuestion = 0;


        if ( request.getParameter("next")!=null ) {
            int current = Integer.parseInt(request.getParameter("next"));
            ses.setAttribute("numberQuestion", current+1);
            numberQuestion=current;
            calcResults(ses,request,response,numberQuestion);
            response.sendRedirect("/pupilProfile.jsp");
        }

        if ( request.getParameter("prev")!=null ) {
            int current = Integer.parseInt(request.getParameter("prev"));
            ses.setAttribute("numberQuestion", current-1);
            numberQuestion=current;
            calcResults(ses,request,response,numberQuestion);
            response.sendRedirect("/pupilProfile.jsp");
        }






        if ( request.getParameter("send")!=null ) {
            int current = Integer.parseInt(request.getParameter("send"));
            numberQuestion=current;
            calcResults(ses,request,response,numberQuestion);
            Operation op =new Operation();
            op.connect();
            op.beginTransaction();
            TestsEntity testSes =    (TestsEntity) ses.getAttribute("test");
            UsersEntity pupilSes =   (UsersEntity) (ses.getAttribute("currentSessionUser"));
            int [] results = (int[]) ses.getAttribute("results");
            float sumScore = (Float) ses.getAttribute("sumScore");
            double sumResult=0;

            for(int result:results) {
                sumResult+=result;
            }
            float progress = (float) ((sumResult/sumScore)*100);

            for (ResultsEntity resultsEntity:testSes.getResults()){
                if(resultsEntity.getPupil().getId()==pupilSes.getId()
                        && resultsEntity.getTest().getId()==testSes.getId()){
                    op.deleteById(resultsEntity.getId(),ResultsEntity.class);
                    op.commit();
                    op.disconnect();
                    op.connect();
                    op.beginTransaction();
                }
            }

            ResultsEntity result = new ResultsEntity();
            result.setProgress(progress);
            TestsEntity test = (TestsEntity) op.getById(testSes.getId(), TestsEntity.class);
            test.getTeacher().addResult(result);
            test.addResult(result);
            Pupil pupil = (Pupil) op.getById(pupilSes.getId(), Pupil.class);
            pupil.addResult(result);
            op.create(result);

            op.commit();
            op.disconnect();
            ses.setAttribute("test", null);
            request.setAttribute("final_test",progress);
            RequestDispatcher Dispatcher = getServletContext().getRequestDispatcher("/pupilProfile.jsp");
            Dispatcher.forward(request, response);
        }




    }


}
