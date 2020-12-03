package hannq.blos;

import hannq.entities.Article;
import java.io.Serializable;
import java.math.BigDecimal;
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
public class ArticleBLO implements Serializable {

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

    public BigDecimal nextArticleID() {
        EntityManager em = emf.createEntityManager();
        String sql = "SELECT IDENT_CURRENT('Article') + 1";
        Query query = em.createNativeQuery(sql);
        em.getTransaction().begin();
        BigDecimal id = (BigDecimal) query.getResultList().get(0);
        em.getTransaction().commit();
        return id;
    }

    public boolean insert(String articleTitle, String articleDescription, String articleImage, String memberID) throws Exception {
        EntityManager em = emf.createEntityManager();
        Calendar c = Calendar.getInstance();
        Date date = c.getTime();
        String sql = "INSERT INTO Article (articleTitle, articleDescription, articleImage, articleDate, articleStatus, memberID) VALUES (?, ?, ?, ?, ?, ?)";
        Query query = em.createNativeQuery(sql);
        em.getTransaction().begin();
        query.setParameter("1", articleTitle);
        query.setParameter("2", articleDescription);
        query.setParameter("3", articleImage);
        query.setParameter("4", date);
        query.setParameter("5", "Active");
        query.setParameter("6", memberID);
        boolean check = query.executeUpdate() > 0;
        em.getTransaction().commit();
        return check;
    }

    public List searchByLikeDescription(String searchValue, int pageNumber, int pageSize) throws Exception {
        EntityManager em = emf.createEntityManager();
//        String jpql = "SELECT new hannq.entities.Article(a.articleTitle, a.articleDescription, a.articleImage, a.articleDate) FROM Article a\n"
//                + "WHERE articleStatus = 'Active' AND articleDescription LIKE ?1\n"
//                + "ORDER BY articleDate DESC\n"
//                + "OFFSET ?2 ROWS\n"
//                + "FETCH NEXT ?3 ROWS ONLY";
        String jpql = "SELECT a FROM Article a\n"
                + "WHERE a.articleDescription LIKE :articleDescription AND a.articleStatus='Active'\n"
                + "ORDER BY a.articleDate DESC";
        Query query = em.createQuery(jpql);
        query.setParameter("articleDescription", "%" + searchValue + "%");
        query.setFirstResult((pageNumber - 1) * pageSize);
        query.setMaxResults(pageSize);
        List result = query.getResultList();
        return result;
    }
    
    public int getAmountOfFindByLikeName(String searchValue, int pageSize) throws Exception{
        int amount = 0;
        EntityManager em = emf.createEntityManager();
        String sql = "SELECT COUNT(articleID) FROM Article WHERE articleDescription LIKE ? AND articleStatus='Active'";
        Query query = em.createNativeQuery(sql);
        em.getTransaction().begin();
        query.setParameter("1", "%" + searchValue + "%");
        amount = (int)query.getSingleResult();
        em.getTransaction().commit();
        if(amount % pageSize == 0)
            return amount / pageSize;
        return amount / pageSize + 1;
    }
    
    public boolean deleteArticle(int articleID) {
        EntityManager em = emf.createEntityManager();
        Article article = em.find(Article.class, articleID);
        if(article != null){
            article.setArticleStatus("Delete");
            em.getTransaction().begin();
            em.merge(article);
            em.getTransaction().commit();
            return true;
        }
        return false;
    }
    
    public Article getArticleByArticleID(int articleID){
        EntityManager em = emf.createEntityManager();
        Article a;
        Query query = em.createNamedQuery("Article.findByArticleID");
        query.setParameter("articleID", articleID);
        try{
            a = (Article) query.getSingleResult();
        } catch(Exception e){
            return null;
        }
        return a;
    }
}
