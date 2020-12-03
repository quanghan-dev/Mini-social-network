package hannq.blos;

import java.util.logging.Level;
import java.util.logging.Logger;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import hannq.entities.Member;
import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.TypedQuery;

/**
 *
 * @author Han Quang
 */
public class MemberBLO implements Serializable {

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

    public Member checkLogin(String memberID, String password) throws Exception {
        Member member = null;
        EntityManager em = emf.createEntityManager();
        String jpql = "SELECT m FROM Member m WHERE m.memberID = :memberID And m.memberPassword = :memberPassword";
        TypedQuery<Member> query = em.createQuery(jpql, Member.class);
        query.setParameter("memberID", memberID);
        query.setParameter("memberPassword", password);
        try {
            member = query.getSingleResult();
        } catch (Exception e) {
            return null;
        }
        return member;
    }

    public boolean insertMember(Member mb) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(mb);
            em.getTransaction().commit();
            return true;
        } catch(Exception e){
            return false;
        }
    }

    public Member getMemberByMemberID(String memberID) {
        EntityManager em = emf.createEntityManager();
        String jpql = "Member.findByMemberID";
        Query query = em.createNamedQuery(jpql);
        query.setParameter("memberID", memberID);
        try {
            return (Member) query.getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }
}
