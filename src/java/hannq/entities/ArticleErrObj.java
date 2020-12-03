package hannq.entities;

import java.io.Serializable;

/**
 *
 * @author Han Quang
 */
public class ArticleErrObj implements Serializable{
    private String articleTitle, articleDescription, titleErr, descriptionErr, imageErr;

    public ArticleErrObj() {
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

    public String getTitleErr() {
        return titleErr;
    }

    public void setTitleErr(String titleErr) {
        this.titleErr = titleErr;
    }

    public String getDescriptionErr() {
        return descriptionErr;
    }

    public void setDescriptionErr(String descriptionErr) {
        this.descriptionErr = descriptionErr;
    }

    public String getImageErr() {
        return imageErr;
    }

    public void setImageErr(String imageErr) {
        this.imageErr = imageErr;
    }
    
}
