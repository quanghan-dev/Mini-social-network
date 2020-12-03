package hannq.blos;

import hannq.entities.Emotion;
import java.io.Serializable;
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
public class EmotionBLO implements Serializable{

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
    
    public long getAmountOfEachArticle(int article, String emotion) throws Exception{
        EntityManager em = emf.createEntityManager();
        String jpql = "Select count(e.emotion) From Emotion e Where e.articleID.articleID = :articleID AND e.emotion = :emotion";
        Query query = em.createQuery(jpql);
        query.setParameter("emotion", emotion);
        query.setParameter("articleID", article);
        return (long) query.getSingleResult();
    }
    
    public boolean insertEmotion(String emotion, int articleID, String memberID){
        EntityManager em = emf.createEntityManager();
        boolean check = false;
        String sql = "INSERT INTO EMOTION(articleID, memberID, emotion) VALUES (?, ?, ?)";
        Query query = em.createNativeQuery(sql);
        em.getTransaction().begin();
        query.setParameter("1", articleID);
        query.setParameter("2", memberID);
        query.setParameter("3", emotion);
        check = query.executeUpdate() > 0;
        em.getTransaction().commit();
        return check;
    }
    
    public boolean updateEmotion(int emotionID, String emotion){
        EntityManager em = emf.createEntityManager();
        Emotion e = em.find(Emotion.class, emotionID);
        if(emotion != null){
            em.getTransaction().begin();
            e.setEmotion(emotion);
            em.getTransaction().commit();
            return true;
        }
        return false;
    }
    
    public Emotion getEmotionByArticleIDAndMemberID(int articleID, String memberID){
        Emotion emotion = null;
        EntityManager em = emf.createEntityManager();
        String jpql = "SELECT e FROM Emotion e WHERE e.articleID.articleID = :articleID AND e.memberID.memberID = :memberID";
        Query query = em.createQuery(jpql);
        query.setParameter("articleID", articleID);
        query.setParameter("memberID", memberID);
        try {
            emotion = (Emotion) query.getSingleResult();
        } catch (Exception e) {
            return null;
        }
        return emotion;
    }
    
    public boolean removeEmotion(int articleID, String memberID){
        EntityManager em = emf.createEntityManager();
        Emotion emt = getEmotionByArticleIDAndMemberID(articleID, memberID);
        Emotion emotion = em.find(Emotion.class, emt.getEmotionID());
        if(emotion != null){
            em.getTransaction().begin();
            emotion.setEmotion("removed");
            em.getTransaction().commit();
            return true;
        }
        return false;
    }
}
