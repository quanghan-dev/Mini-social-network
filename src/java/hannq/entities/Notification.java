package hannq.entities;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Han Quang
 */
@Entity
@Table(name = "Notification", catalog = "MiniSocialNetwork", schema = "dbo")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Notification.findAll", query = "SELECT n FROM Notification n"),
    @NamedQuery(name = "Notification.findByNotificationID", query = "SELECT n FROM Notification n WHERE n.notificationID = :notificationID"),
    @NamedQuery(name = "Notification.findByNotificationDate", query = "SELECT n FROM Notification n WHERE n.notificationDate = :notificationDate")})
public class Notification implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "notificationID", nullable = false)
    private Integer notificationID;
    @Basic(optional = false)
    @Column(name = "notificationDate", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date notificationDate;
    @Basic(optional = false)
    @Lob
    @Column(name = "notificationDescription", nullable = false, length = 2147483647)
    private String notificationDescription;
    @JoinColumn(name = "articleID", referencedColumnName = "articleID", nullable = false)
    @ManyToOne(optional = false)
    private Article articleID;
    @JoinColumn(name = "memberID", referencedColumnName = "memberID", nullable = false)
    @ManyToOne(optional = false)
    private Member memberID;

    public Notification() {
    }

    public Notification(Integer notificationID) {
        this.notificationID = notificationID;
    }

    public Notification(Integer notificationID, Date notificationDate, String notificationDescription) {
        this.notificationID = notificationID;
        this.notificationDate = notificationDate;
        this.notificationDescription = notificationDescription;
    }

    public Notification(Date notificationDate, String notificationDescription, Article articleID, Member memberID) {
        this.notificationDate = notificationDate;
        this.notificationDescription = notificationDescription;
        this.articleID = articleID;
        this.memberID = memberID;
    }


    public Integer getNotificationID() {
        return notificationID;
    }

    public void setNotificationID(Integer notificationID) {
        this.notificationID = notificationID;
    }

    public Date getNotificationDate() {
        return notificationDate;
    }

    public void setNotificationDate(Date notificationDate) {
        this.notificationDate = notificationDate;
    }

    public String getNotificationDescription() {
        return notificationDescription;
    }

    public void setNotificationDescription(String notificationDescription) {
        this.notificationDescription = notificationDescription;
    }

    public Article getArticleID() {
        return articleID;
    }

    public void setArticleID(Article articleID) {
        this.articleID = articleID;
    }

    public Member getMemberID() {
        return memberID;
    }

    public void setMemberID(Member memberID) {
        this.memberID = memberID;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (notificationID != null ? notificationID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Notification)) {
            return false;
        }
        Notification other = (Notification) object;
        if ((this.notificationID == null && other.notificationID != null) || (this.notificationID != null && !this.notificationID.equals(other.notificationID))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "hannq.entities.Notification[ notificationID=" + notificationID + " ]";
    }
    
}
