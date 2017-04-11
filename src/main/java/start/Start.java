package start;

import hibernate.dao.*;
import hibernate.utils.Operation;

/**
 * Created by Alex on 03.04.2017.
 */
public class Start {
    public static void main(String[] args) {
        Operation op = new Operation();
        op.connect();
        op.beginTransaction();
        Pupil pupil = (Pupil) op.getById(3,Pupil.class);
        ResultsEntity result = (ResultsEntity)op.getById(1,ResultsEntity.class);
        TestsEntity test =(TestsEntity)op.getById(3,TestsEntity.class);

        test.addResult(result);
        System.out.println(test);
        System.out.println(result);
        System.out.println(pupil);
        op.commit();
        op.disconnect();
    }
}
