package hannq.blos;

import hannq.entities.Comment;
import java.io.Serializable;
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
public class CommentBLO implements Serializable{

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
    
    public boolean insertComment(String comment, int articleID, String memberID){
        EntityManager em = emf.createEntityManager();
        boolean check = false;
        String sql = "INSERT INTO COMMENT(articleID, memberID, commentContent, commentStatus) VALUES (?, ?, ?, ?)";
        Query query = em.createNativeQuery(sql);
        em.getTransaction().begin();
        query.setParameter("1", articleID);
        query.setParameter("2", memberID);
        query.setParameter("3", comment);
        query.setParameter("4", "true");
        check = query.executeUpdate() > 0;
        em.getTransaction().commit();
        return check;
    }
    
    public List<Comment> getCommentByArticleID(int articleID){
        EntityManager em = emf.createEntityManager();
        String jpql = "Comment.findByArticleID";
        Query query = em.createNamedQuery(jpql);
        query.setParameter("articleID", articleID);
        return  query.getResultList();
    }
    
    public boolean deleteComment(int commentID) {
        EntityManager em = emf.createEntityManager();
        Comment c = em.find(Comment.class, commentID);
        if(c != null){
            em.getTransaction().begin();
            c.setCommentStatus(false);
            em.getTransaction().commit();
            return true;
        }
        return false;
    }
}
