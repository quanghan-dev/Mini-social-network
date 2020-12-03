<%-- 
    Document   : ArticleDetail
    Created on : Sep 23, 2020, 2:58:28 PM
    Author     : Han Quang
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

    </head>
    <body>
        <div class="limiter" style="margin-top: 54px;">
            <div class="container-home100" style="min-height: 90vh;">
                <div class="wrap-post-nohover">
                    <c:if test="${requestScope.ARTICLE.articleImage != null}">
                        <img src="images/${requestScope.ARTICLE.articleImage}" style="width: 100%;"/>
                    </c:if>
                    <div style="width: 100%; display: flex; margin-top: 10px; padding: 0 30px 0 30px;">
                        <div style="width: 95%;">
                            <font class="author">${requestScope.ARTICLE.memberID}</font>&nbsp;
                            <font class="title">${ARTICLE.articleTitle}</font>

                        </div>
                        <script type="text/javascript">
                            function checkDeleteArticle() {
                                let confirmed = confirm("Are you sure you want to delete this article?");
                                if (confirmed) {
                                    document.getElementById('deleteArticle').submit();
                                }
                            }
                        </script>
                        <form action="MainController" method="POST" style="display: flex; width: 5%;" id="deleteArticle">
                            <c:if test="${requestScope.DELETE_BUTTON != null}">
                                <button class="btn-delete" type="button" onclick="checkDeleteArticle();">
                                    <input type="hidden"  name="action" value="DeleteArticle"/>
                                    <i class="fa fa-trash"></i>
                                </button>
                            </c:if>
                            <input type="hidden" name="articleTitle" value="${ARTICLE.articleTitle}">
                            <input type="hidden" name="memberID" value="${requestScope.ARTICLE.memberID}">
                            <input type="hidden" name="articleID" value="${requestScope.ARTICLE.articleID}">
                        </form>

                    </div>
                    <div style="width: 100%; padding: 0 30px 0 30px;">
                        <p style="font-size: 11px; text-align: left"><fmt:formatDate value="${ARTICLE.articleDate}" pattern="yyyy-MM-dd"/></p>
                        <p style="font-size: 16px;">${requestScope.ARTICLE.articleDescription}</p>
                    </div>


                    <hr style="width:100%; text-align:center; margin-left: 30px; margin-right: 30px;">
                    
                        <div style="width: 100%; display: flex; padding: 0 30px 0 30px;">

                            <div style="width: 7%;">
                                <form method="POST" action="MainController" style="display: flex;">
                                    <button class="btn-like-dislike" type="submit" name="action" value="ChangeEmotion" style="
                                            <c:if test="${requestScope.EMOTION.emotion eq 'like'}">
                                                background: #C6CCF0; color: #4158d0;
                                            </c:if>
                                            " <c:if test="${sessionScope.ROLE eq 'admin'}">disabled="true"</c:if>>
                                        ${requestScope.LIKE_NUM} <i class="fa fa-thumbs-up"></i>
                                        <input type="hidden" name="newEmotion" value="like">
                                        <input type="hidden" name="currentEmotion" value="${requestScope.EMOTION.emotion}">
                                        <input type="hidden" name="articleID" value="${requestScope.ARTICLE.articleID}">
                                    </button>
                                </form>
                            </div>
                            <div style="width: 7%;">
                                <form method="POST" action="MainController" style="display: flex;">
                                    <button class="btn-like-dislike" type="submit" name="action" value="ChangeEmotion" style="
                                            <c:if test="${requestScope.EMOTION.emotion eq 'dislike'}">
                                                background: #FFD5D5; color: #FF7373;
                                            </c:if>" 
                                            <c:if test="${sessionScope.ROLE eq 'admin'}">disabled="true"</c:if>>
                                        ${requestScope.DISLIKE_NUM} <i class="fa fa-thumbs-down"></i>
                                        <input type="hidden" name="newEmotion" value="dislike">
                                        <input type="hidden" name="currentEmotion" value="${requestScope.EMOTION.emotion}">
                                        <input type="hidden" name="articleID" value="${requestScope.ARTICLE.articleID}">
                                    </button>
                                </form>
                            </div>
                            <div style="width: 86%;">
                                <form method="POST" action="MainController" style="display: flex; width: 100%;">
                                    <input class="input-comment" type="text" name="txtComment" placeholder="Write a comment..." <c:if test="${sessionScope.ROLE eq 'admin'}">disabled="true"</c:if>>
                                    <input type="hidden" name="articleID" value="${requestScope.ARTICLE.articleID}">
                                    <input type="submit" name="action" value="Comment" style="display: none;" <c:if test="${sessionScope.ROLE eq 'admin'}">disabled="true"</c:if>>
                                </form>
                            </div>
                        </div>

                    <div style="width: 100%; padding: 0 30px 0 30px;">
                        <c:if test="${not empty requestScope.LIST_COMMENT}">
                            <c:forEach var="comment" items="${requestScope.LIST_COMMENT}">
                                <div class="btn-like-dislike" style="width: 100%; background: #f5f5f5; display: flex; padding-left: 20px; ">
                                    <div style="width: 95%; display: flex;">
                                        <p style="font-weight: bold; margin-right: 10px; font-size: 16px;">${comment.memberID}</p>
                                        <p style="font-size: 16px;">${comment.commentContent}</p>
                                    </div>
                                        <c:if test="${(comment.memberID eq sessionScope.MEMBERID) or (sessionScope.ROLE eq 'admin')}">
                                        <script typ e="text/javascript">
                                            function checkDeleteComment() {
                                                let confirmed = confirm("Are you sure you want to delete this comment?");
                                                if (confirmed) {
                                                    document.getElementById('deleteComment').submit();
                                                }
                                            }
                                        </script>
                                        <form action="MainController" method="POST" style="display: flex; width: 5%;" id="deleteComment">
                                            <button style="width: 100%; color: #666666;" type="button" onclick="checkDeleteComment();">
                                                <i class="fa fa-trash"></i>
                                                <input type="hidden"  name="action" value="DeleteComment"/>
                                            </button>
                                            <input type="hidden" name="commentID" value="${comment.commentID}">
                                            <input type="hidden" name="memberID" value="${comment.memberID}">
                                            <input type="hidden" name="commentContent" value="${comment.commentContent}">
                                            <input type="hidden" name="articleID" value="${requestScope.ARTICLE.articleID}">
                                        </form>
                                    </c:if>
                                </div>
                            </c:forEach>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
