/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hannq.entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Han Quang
 */
@Entity
@Table(name = "Comment", catalog = "MiniSocialNetwork", schema = "dbo")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Comment.findAll", query = "SELECT c FROM Comment c"),
    @NamedQuery(name = "Comment.findByCommentID", query = "SELECT c FROM Comment c WHERE c.commentID = :commentID"),
    @NamedQuery(name = "Comment.findByCommentContent", query = "SELECT c FROM Comment c WHERE c.commentContent = :commentContent"),
    @NamedQuery(name = "Comment.findByCommentStatus", query = "SELECT c FROM Comment c WHERE c.commentStatus = :commentStatus"),
    @NamedQuery(name = "Comment.findByArticleID", query = "SELECT c FROM Comment c WHERE c.articleID.articleID = :articleID AND c.commentStatus = 'true'"),
})
public class Comment implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "commentID", nullable = false)
    private Integer commentID;
    @Basic(optional = false)
    @Column(name = "commentContent", nullable = false, length = 1073741823)
    private String commentContent;
    @Column(name = "commentStatus")
    private Boolean commentStatus;
    @JoinColumn(name = "articleID", referencedColumnName = "articleID", nullable = false)
    @ManyToOne(optional = false)
    private Article articleID;
    @JoinColumn(name = "memberID", referencedColumnName = "memberID", nullable = false)
    @ManyToOne(optional = false)
    private Member memberID;

    public Comment() {
    }

    public Comment(Integer commentID) {
        this.commentID = commentID;
    }

    public Comment(Integer commentID, String commentContent) {
        this.commentID = commentID;
        this.commentContent = commentContent;
    }

    public Integer getCommentID() {
        return commentID;
    }

    public void setCommentID(Integer commentID) {
        this.commentID = commentID;
    }

    public String getCommentContent() {
        return commentContent;
    }

    public void setCommentContent(String commentContent) {
        this.commentContent = commentContent;
    }

    public Boolean getCommentStatus() {
        return commentStatus;
    }

    public void setCommentStatus(Boolean commentStatus) {
        this.commentStatus = commentStatus;
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
        hash += (commentID != null ? commentID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Comment)) {
            return false;
        }
        Comment other = (Comment) object;
        if ((this.commentID == null && other.commentID != null) || (this.commentID != null && !this.commentID.equals(other.commentID))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "hannq.entities.Comment[ commentID=" + commentID + " ]";
    }
    
}
