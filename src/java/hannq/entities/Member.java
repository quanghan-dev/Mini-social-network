package hannq.entities;

import java.io.Serializable;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.Collection;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.xml.bind.DatatypeConverter;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Han Quang
 */
@Entity
@Table(name = "Member", catalog = "MiniSocialNetwork", schema = "dbo")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Member.findAll", query = "SELECT m FROM Member m"),
    @NamedQuery(name = "Member.findByMemberID", query = "SELECT m FROM Member m WHERE m.memberID = :memberID"),
    @NamedQuery(name = "Member.findByMemberPassword", query = "SELECT m FROM Member m WHERE m.memberPassword = :memberPassword"),
    @NamedQuery(name = "Member.findByMemberFullname", query = "SELECT m FROM Member m WHERE m.memberFullname = :memberFullname"),
    @NamedQuery(name = "Member.findByRoleName", query = "SELECT m FROM Member m WHERE m.roleName = :roleName"),
    @NamedQuery(name = "Member.findByMemberStatus", query = "SELECT m FROM Member m WHERE m.memberStatus = :memberStatus")})
public class Member implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "memberID", nullable = false, length = 50)
    private String memberID;
    @Basic(optional = false)
    @Column(name = "memberPassword", nullable = false, length = 100)
    private String memberPassword;
    @Basic(optional = false)
    @Column(name = "memberFullname", nullable = false, length = 100)
    private String memberFullname;
    @Basic(optional = false)
    @Column(name = "roleName", nullable = false, length = 100)
    private String roleName;
    @Basic(optional = false)
    @Column(name = "memberStatus", nullable = false, length = 100)
    private String memberStatus;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "memberID")
    private Collection<Comment> commentCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "memberID")
    private Collection<Article> articleCollection;

    public Member() {
    }

    public Member(String memberID) {
        this.memberID = memberID;
    }

    public Member(String memberID, String memberPassword, String memberFullname, String roleName, String memberStatus) {
        this.memberID = memberID;
        this.memberPassword = memberPassword;
        this.memberFullname = memberFullname;
        this.roleName = roleName;
        this.memberStatus = memberStatus;
    }

    public String getMemberID() {
        return memberID;
    }

    public void setMemberID(String memberID) {
        this.memberID = memberID;
    }

    public String getMemberPassword() {
        return memberPassword;
    }

    public void setMemberPassword(String memberPassword) {
        this.memberPassword = memberPassword;
    }

    public String getMemberFullname() {
        return memberFullname;
    }

    public void setMemberFullname(String memberFullname) {
        this.memberFullname = memberFullname;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getMemberStatus() {
        return memberStatus;
    }

    public void setMemberStatus(String memberStatus) {
        this.memberStatus = memberStatus;
    }

    @XmlTransient
    public Collection<Comment> getCommentCollection() {
        return commentCollection;
    }

    public void setCommentCollection(Collection<Comment> commentCollection) {
        this.commentCollection = commentCollection;
    }

    @XmlTransient
    public Collection<Article> getArticleCollection() {
        return articleCollection;
    }

    public void setArticleCollection(Collection<Article> articleCollection) {
        this.articleCollection = articleCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (memberID != null ? memberID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Member)) {
            return false;
        }
        Member other = (Member) object;
        if ((this.memberID == null && other.memberID != null) || (this.memberID != null && !this.memberID.equals(other.memberID))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return memberID;
    }
    
    public String encode(String s) throws Exception {
        String result = "";
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] hash = digest.digest(s.getBytes(StandardCharsets.UTF_8));
        result = DatatypeConverter.printHexBinary(hash);
        return result; 
    }
    
}
