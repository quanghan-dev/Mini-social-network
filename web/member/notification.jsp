<%-- 
    Document   : notification
    Created on : Sep 26, 2020, 7:58:05 PM
    Author     : Han Quang
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="limiter"  style="margin-top: 54px;">
            <div class="container-home100">
                <c:if test="${not empty requestScope.LIST_NOTIFICATION}" var="check">
                    <c:forEach var="notification" items="${requestScope.LIST_NOTIFICATION}">
                        <form method="POST" action="MainController" style="display: flex;">
                            <button class="wrap-post100" name="action" value="ShowDetail">
                                <div style="width: 100%; padding: 0 30px 0 30px;">
                                    <p style="font-size: 16px; text-align: left;">${notification.notificationDescription}</p>
                                </div>
                                <p style="font-size: 11px; text-align: left; padding: 0 30px 0 30px;"><fmt:formatDate value="${notification.notificationDate}" pattern="yyyy-MM-dd"/></p> 
                                <input type="hidden" name="articleID" value="${notification.articleID.articleID}"/> 
                            </button>
                        </form>
                    </c:forEach>
                </c:if>
                <c:if test="${!check}">
                    <div class="alert-warning error">
                        No Notification Found
                    </div>
                </c:if>
            </div>
        </div>
    </body>
</html>
