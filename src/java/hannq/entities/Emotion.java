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
@Table(name = "Emotion", catalog = "MiniSocialNetwork", schema = "dbo")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Emotion.findAll", query = "SELECT e FROM Emotion e"),
    @NamedQuery(name = "Emotion.findByEmotionID", query = "SELECT e FROM Emotion e WHERE e.emotionID = :emotionID"),
    @NamedQuery(name = "Emotion.findByEmotion", query = "SELECT e FROM Emotion e WHERE e.emotion = :emotion"),
    @NamedQuery(name = "Emotion.findByArticleID", query = "SELECT e FROM Emotion e WHERE e.articleID = :articleID"),
//    @NamedQuery(name = "Emotion.findByArticleIDAndMemberID", query = "SELECT e FROM Emotion e WHERE e.articleID = :articleID AND e.memberID = :memberID")
})
public class Emotion implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "emotionID", nullable = false)
    private Integer emotionID;
    @Basic(optional = false)
    @Column(name = "emotion", nullable = false, length = 100)
    private String emotion;
    @JoinColumn(name = "articleID", referencedColumnName = "articleID", nullable = false)
    @ManyToOne(optional = false)
    private Article articleID;
    @JoinColumn(name = "memberID", referencedColumnName = "memberID", nullable = false)
    @ManyToOne(optional = false)
    private Member memberID;

    public Emotion() {
    }

    public Emotion(Integer emotionID) {
        this.emotionID = emotionID;
    }

    public Emotion(Integer emotionID, String emotion) {
        this.emotionID = emotionID;
        this.emotion = emotion;
    }

    public Emotion(String emotion, Article articleID, Member memberID) {
        this.emotion = emotion;
        this.articleID = articleID;
        this.memberID = memberID;
    }
    
    

    public Integer getEmotionID() {
        return emotionID;
    }

    public void setEmotionID(Integer emotionID) {
        this.emotionID = emotionID;
    }

    public String getEmotion() {
        return emotion;
    }

    public void setEmotion(String emotion) {
        this.emotion = emotion;
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
        hash += (emotionID != null ? emotionID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Emotion)) {
            return false;
        }
        Emotion other = (Emotion) object;
        if ((this.emotionID == null && other.emotionID != null) || (this.emotionID != null && !this.emotionID.equals(other.emotionID))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "hannq.entities.Emotion[ emotionID=" + emotionID + " ]";
    }
    
}
