<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Mini Social Network</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!--===============================================================================================-->	
        <link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
        <!--===============================================================================================-->	
        <link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="css/util.css">
        <link rel="stylesheet" type="text/css" href="css/main.css">
        <!--===============================================================================================-->
    </head>
    <body>
        <nav class="navbar navbar-expand-sm fixed-top" style="background: linear-gradient(-135deg, #D884D2, #7A8ADE);">
            <div class="container-fluid">
                <div class="navbar-header">
                    <c:url var="LoadList" value="MainController">
                        <c:param name="action" value= "Search"/>
                        <c:param name="txtSearch" value=""/>
                        <c:param name="pageID" value="1"/>
                    </c:url>
                    <a href="${LoadList}"><span class="fa fa-home"></span> Home</a>
                </div>
                <div class="nav navbar-nav">
                    <form class="navbar-form" method="POST" action="MainController">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Search" name="txtSearch" style="border-radius: 25px;">
                            <div class="input-group-btn">
                                <button class="btn btn-default" type="submit" name="action" value="Search">
                                    <i class="fa fa-search" 
                                       style="color: #ffffff; outline: none;"></i>
                                </button>
                                <input type="hidden" value="1" name="pageID">
                            </div>
                        </div>
                    </form>
                    <c:if test="${sessionScope.ROLE eq 'member'}">
                        <form class="navbar-form" style="margin-left: 40px;" method="POST" action="MainController">
                            <button class="btn post-form-btn navbar-btn" name="action" value="ShowPostForm">POST</button>
                        </form>
                    </c:if>
                </div>

                <div class="nav navbar-nav navbar-right">
                    <c:url var="Notification" value="MainController">
                        <c:param name="action" value="Notification"/>
                    </c:url>
                    <div style="margin-right: 10px;"><a href="${Notification}"><span class="fa fa-bell"></span> Notification</a></div>
                    <c:url var="Logout" value="MainController">
                        <c:param name="action" value="Logout"/>
                    </c:url>
                    <div class="dropdown">
                        <button class="dropdown-toggle" data-toggle="dropdown" type="button" 
                                style="color: #ffffff; font-size: 14px; line-height: 1.7;">
                            <i class="fa fa-user"></i>
                            ${sessionScope.MEMBERID}
                            <span class="caret"></span>
                        </button>
                        <a href="${Logout}" class="dropdown-menu"><span class="fa fa-sign-out"></span> Logout</a>
                    </div>
                </div>
            </div>
        </nav>
        <c:choose>
            <c:when test="${requestScope.ADD_FORM eq 'POST_FORM'}" >
                <%@include file="postArticle.jsp" %>
            </c:when>
            <c:when test="${requestScope.ADD_FORM eq 'ARTICLE_DETAIL'}" >
                <%@include file="articleDetail.jsp" %>
            </c:when>
            <c:when test="${requestScope.ADD_FORM eq 'NOTIFICATION'}" >
                <%@include file="notification.jsp" %>
            </c:when>
            <c:when test="${not empty requestScope.LIST_ARTICLE}">
                <div class="limiter" style="margin-top: 54px;">
                    <div class="container-home100">
                        <c:forEach var="article" items="${requestScope.LIST_ARTICLE}">
                            <form method="POST" action="MainController" style="display: flex;">
                                <button class="wrap-post100" name="action" value="ShowDetail">
                                    <c:if test="${article.articleImage != null}">
                                        <img src="images/${article.articleImage}" style="width: 100%;"/>
                                    </c:if>
                                    <div style="width: 100%; margin-top: 10px; text-align: left; padding: 0 30px 0 30px;">
                                        <font class="author">${article.memberID}</font>&nbsp;
                                        <font class="title">${article.articleTitle}</font>
                                        <p style="font-size: 11px; text-align: left"><fmt:formatDate value="${article.articleDate}" pattern="yyyy-MM-dd"/></p> 
                                    </div>
                                    <!--                                    <div style="width: 100%; padding: 0 30px 0 30px;">
                                                                            
                                                                        </div>-->
                                    <div style="width: 100%; padding: 0 30px 0 30px;">
                                        <p style="font-size: 16px; text-align: left;">${article.articleDescription}</p>
                                    </div>
                                    <div style="width: 100%; padding: 0 30px 0 30px;">

                                    </div>
                                    <input type="hidden" name="articleID" value="${article.articleID}"/>
                                </button>
                            </form>
                        </c:forEach>

                    </div>
                    <!--<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>-->

                </div>
            </c:when>
            <c:otherwise>
                <div class="limiter">
                    <div class="container-home100">
                        <div class="alert-warning error">
                            No Article Found
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
        <c:if test="${not empty requestScope.LIST_ARTICLE}">
            <ul class="pagination justify-content-center">
                <c:forEach begin="1" end="${requestScope.ARTICLE_COUNT}" varStatus="counter">
                    <c:url value="MainController" var="pageNum">
                        <c:param name="action" value="Search"/>
                        <c:param name="pageID" value="${counter.count}"/>
                        <c:param name="txtSearch" value="${param.txtSearch}"/>
                    </c:url>
                    <li class="page-item
                        <c:if test="${requestScope.CURRENT_PAGE == counter.count}">
                            active
                        </c:if>">
                        <a class="page-link" href="${pageNum}">${counter.count}</a>
                    </li>
                </c:forEach>
            </ul>
        </c:if>
        <!--<a href="#top" class="back-to-top-link" aria-label="Scroll to Top">Top</a>-->


        <!--===============================================================================================-->	
        <script src="vendor/jquery/jquery-3.2.1.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/bootstrap/js/popper.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/select2/select2.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/tilt/tilt.jquery.min.js"></script>
        <script >
            $('.js-tilt').tilt({
                scale: 1.1
            })
        </script>
        <!--===============================================================================================-->
        <!--        <script>
        //Get the button
                    var mybutton = document.getElementById("myBtn");
        
        // When the user scrolls down 20px from the top of the document, show the button
                    window.onscroll = function () {
                        scrollFunction()
                    };
        
                    function scrollFunction() {
                        if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
                            mybutton.style.display = "block";
                        } else {
                            mybutton.style.display = "none";
                        }
                    }
        
        // When the user clicks on the button, scroll to the top of the document
                    function topFunction() {
                        document.body.scrollTop = 0;
                        document.documentElement.scrollTop = 0;
                    }
                </script>-->
    </body>

</html>