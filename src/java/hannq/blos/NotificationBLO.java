package hannq.blos;

import hannq.entities.Article;
import hannq.entities.Member;
import hannq.entities.Notification;
import java.io.Serializable;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

/**
 *
 * @author Han Quang
 */
public class NotificationBLO implements Serializable{

    EntityManagerFactory emf = Persistence.createEntityManagerFactory("MiniSocialNetworkPU");

    public void persist(Object object) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(object);
            em.getTransaction().commit();
        } catch (Exception e) {
            Logger.getLogger(getClass().getName()).log(Level.SEVERE, "exception caught", e);
            em.getTransaction().rollback();
        } finally {
            em.close();
        }
    }
    
    public boolean insertNotification(String notificationDescription, int articleID, String memberID){
        EntityManager em = emf.createEntityManager();
        boolean check = false;
        Calendar c = Calendar.getInstance();
        Date date = c.getTime();
        String sql = "INSERT INTO NOTIFICATION(articleID, memberID, notificationDate, notificationDescription) VALUES (?, ?, ?, ?)";
        Query query = em.createNativeQuery(sql);
        em.getTransaction().begin();
        query.setParameter("1", articleID);
        query.setParameter("2", memberID);
        query.setParameter("3", date);
        query.setParameter("4", notificationDescription);
        check = query.executeUpdate() > 0;
        em.getTransaction().commit();
        return check;
    }
    
    public List<Notification> getNotificationByMemberID(String memberID){
        EntityManager em = emf.createEntityManager();
        String jpql = "SELECT n FROM Notification n Where n.memberID.memberID = :memberID ORDER BY n.notificationDate DESC";
        Query query = em.createQuery(jpql);
        query.setParameter("memberID", memberID);
        em.getTransaction().begin();
        List listNoti = query.getResultList();
        em.getTransaction().commit();
        return listNoti;
    }
}
