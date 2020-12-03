/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hannq.entities;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Han Quang
 */
@Entity
@Table(name = "Article", catalog = "MiniSocialNetwork", schema = "dbo")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Article.findAll", query = "SELECT a FROM Article a"),
    @NamedQuery(name = "Article.findByArticleID", query = "SELECT a FROM Article a WHERE a.articleID = :articleID AND a.articleStatus = 'Active'"),
    @NamedQuery(name = "Article.findByArticleTitle", query = "SELECT a FROM Article a WHERE a.articleTitle = :articleTitle"),
    @NamedQuery(name = "Article.findByArticleDescription", query = "SELECT a FROM Article a WHERE a.articleDescription = :articleDescription"),
    @NamedQuery(name = "Article.findByArticleImage", query = "SELECT a FROM Article a WHERE a.articleImage = :articleImage"),
    @NamedQuery(name = "Article.findByArticleDate", query = "SELECT a FROM Article a WHERE a.articleDate = :articleDate"),
    @NamedQuery(name = "Article.findByArticleStatus", query = "SELECT a FROM Article a WHERE a.articleStatus = :articleStatus")})
public class Article implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "articleID", nullable = false)
    private Integer articleID;
    @Basic(optional = false)
    @Column(name = "articleTitle", nullable = false, length = 100)
    private String articleTitle;
    @Basic(optional = false)
    @Column(name = "articleDescription", nullable = false, length = 1073741823)
    private String articleDescription;
    @Column(name = "articleImage", length = 1073741823)
    private String articleImage;
    @Basic(optional = false)
    @Column(name = "articleDate", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date articleDate;
    @Basic(optional = false)
    @Column(name = "articleStatus", nullable = false, length = 50)
    private String articleStatus;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "articleID")
    private Collection<Comment> commentCollection;
    @JoinColumn(name = "memberID", referencedColumnName = "memberID", nullable = false)
    @ManyToOne(optional = false)
    private Member memberID;

    public Article() {
    }

    public Article(Integer articleID) {
        this.articleID = articleID;
    }

    public Article(Integer articleID, String articleTitle, String articleDescription, Date articleDate, String articleStatus) {
        this.articleID = articleID;
        this.articleTitle = articleTitle;
        this.articleDescription = articleDescription;
        this.articleDate = articleDate;
        this.articleStatus = articleStatus;
    }

    public Integer getArticleID() {
        return articleID;
    }

    public void setArticleID(Integer articleID) {
        this.articleID = articleID;
    }

    public String getArticleTitle() {
        return articleTitle;
    }

    public void setArticleTitle(String articleTitle) {
        this.articleTitle = articleTitle;
    }

    public String getArticleDescription() {
        return articleDescription;
    }

    public void setArticleDescription(String articleDescription) {
        this.articleDescription = articleDescription;
    }

    public String getArticleImage() {
        return articleImage;
    }

    public void setArticleImage(String articleImage) {
        this.articleImage = articleImage;
    }

    public Date getArticleDate() {
        return articleDate;
    }

    public void setArticleDate(Date articleDate) {
        this.articleDate = articleDate;
    }

    public String getArticleStatus() {
        return articleStatus;
    }

    public void setArticleStatus(String articleStatus) {
        this.articleStatus = articleStatus;
    }

    @XmlTransient
    public Collection<Comment> getCommentCollection() {
        return commentCollection;
    }

    public void setCommentCollection(Collection<Comment> commentCollection) {
        this.commentCollection = commentCollection;
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
        hash += (articleID != null ? articleID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Article)) {
            return false;
        }
        Article other = (Article) object;
        if ((this.articleID == null && other.articleID != null) || (this.articleID != null && !this.articleID.equals(other.articleID))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "hannq.entities.Article[ articleID=" + articleID + " ]";
    }
    
}
