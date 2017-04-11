package hibernate.utils;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

import java.util.List;

/**
 * Created by Alex on 01.04.2017.
 */
public class Operation<T> {
    private    Session session;
    public  void connect(){
        session = HibernateSessionFactory.getSessionFactory().openSession();
    }
    public  void beginTransaction(){
        session.beginTransaction();
    }
    public  void commit(){
        session.getTransaction().commit();
    }
    public    void disconnect (){
        session.close();
    }

    public void create(T object){
        session.save(object);
    }
    public T getById(int id,Class<T> className){
        T object = (T)session.load(className,id);
        return object;
    }
    public List<T> findList(Class<T> className,String field,String value){
        Criteria cr = session.createCriteria(className);
        return  cr.add(Restrictions.eq(field,value)).list();
    }

    public T findOnce(Class<T> className,String field,String value){
        Criteria cr = session.createCriteria(className);
        cr.add(Restrictions.eq(field,value));
        return  (T)cr.uniqueResult();
    }

    public void deleteById(int id,Class<T> className){
        session.delete(getById(id,className));
    }
    public void deleteList (Class<T> className,String field,String value) {
        for (T object:findList(className,field,value)) {
            session.delete(object);
        }

    }

    public void deleteOnce (Class<T> className,String field,String value) {
        session.delete(findOnce(className,field,value));
    }
    public void delete(T object){
        session.delete(object);
    }
    public void update(T object){
        session.update(object);
    }
    public void merge(T object){session.merge(object);}

}

