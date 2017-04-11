package hibernate.utils;

/**
 * Created by Alex on 03.04.2017.
 */
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class HibernateSessionFactory {

    private static SessionFactory sessionFactory = buildSessionFactory();

    protected static SessionFactory buildSessionFactory() {

        SessionFactory sessionFactory;
        sessionFactory = new Configuration()
                .configure() // configures settings from hibernate.cfg.xml
                .buildSessionFactory();
        return sessionFactory;
    }

    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    public static void shutdown() {
        // Close caches and connection pools
        getSessionFactory().close();
    }

}
