<%-- 
    Document   : postArticle
    Created on : Sep 19, 2020, 4:27:22 PM
    Author     : Han Quang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
        <!--===============================================================================================-->
    </head>
</head>
<body>
    <div class="limiter" style="margin-top: 54px;">
        <div class="container-home100" style="min-height: 100vh;">
            <!--<div class="wrap-post100">-->
            <form class="post100-form" action="MainController" method="POST" enctype="multipart/form-data">
                <h1 class="post-form-title">
                    Create Article
                </h1>
                <div class="wrap-input100">
                    <input class="input-post" type="text" name="txtTitle" placeholder="Title" required value="${requestScope.INVALID.articleTitle}">
                    <span class="focus-input-post"></span>
                    <span class="symbol-input-post">
                        <i class="fa fa-bookmark" aria-hidden="true"></i>&nbsp;Title
                    </span>
                </div>
                <font class="alert-warning error">
                ${requestScope.INVALID.titleErr}
                </font><br/>
                <div class="wrap-input100">
                    <textarea class="input-post" type="text" name="txtDescription" placeholder="Content" required value="${requestScope.INVALID.articleDescription}" style="height: 250px; padding-top: 10px;"></textarea>
                    <span class="focus-input-post"></span>
                    <span class="symbol-input-post">
                        <i class="fa fa-edit" aria-hidden="true"></i>&nbsp;Content
                    </span>
                </div>
                <font class="alert-warning error">
                ${requestScope.INVALID.descriptionErr}
                </font><br/>
                <!--                    <div class="wrap-input100">
                                        <input class="input-post" type="file" name="txtImage" placeholder="Image (optional)">
                                        <span class="focus-input-post"></span>
                                        <span class="symbol-input-post">
                                            <i class="fa fa-image" aria-hidden="true"></i>&nbsp;Image
                                        </span>
                                    </div>
                -->
                <label for="file-upload" class="custom-file-upload">
                    <i class="fa fa-cloud-upload"></i>&nbsp;Image (Optional)
                </label>
                <input id="file-upload" type="file" name="txtImage" accept=".png, .jpeg, .jpg"/>
                <font class="alert-warning error">
                ${requestScope.INVALID.imageErr}
                </font><br/>
                <script>
                    $('#file-upload').change(function () {
                        var i = $(this).prev('label').clone();
                        var file = $('#file-upload')[0].files[0].name;
                        $(this).prev('label').text(file);
                    });
                </script>
                <c:if test="${requestScope.SUCCESS != null}">
                    <div class="alert alert-success" style="position: relative;"><span>${requestScope.SUCCESS}</span></div>
                </c:if>
                <div class="container-login100-form-btn">
                    <button class="login100-form-btn" name="action" value="Post">
                        POST
                    </button>
                </div>

            </form>
            <!--</div>-->
        </div>
    </div>
</body>
</html>
