<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <div class="limiter">
            <div class="container-login100">
                <div class="wrap-post-nohover" style="padding: 100px;">
                    <form action="MainController" method="POST" id="loginForm" style="width: 100%;">
                        <span class="login100-form-title" style="width: 100%;">
                            Verify Email
                        </span>
                        <c:if test="${requestScope.SUCCESS == null}" var="check">
                        <div style="width: 100%;">
                            <p style="text-align: center;">A verification code was sent to your email, please enter that code to finish register your account.</p>
                        </div>
                        <div style="width: 100%;">
                            <div class="wrap-input100">
                                <input class="input100" type="text" name="txtCode" placeholder="Verify Code" required>
                                <span class="focus-input100"></span>
                                <span class="symbol-input100">
                                    <i class="fa fa-envelope" aria-hidden="true"></i>
                                </span>
                            </div>
                        </div>
                        <c:if test="${requestScope.INVALID != null}">
                            <div class="alert alert-danger" style="width: 100%;"><span>${requestScope.INVALID}</span></div>
                                </c:if>
                        <div class="container-login100-form-btn" style="width: 100%;">
                            <button class="login100-form-btn" name="action" value="Register">
                                Confirm
                            </button>
                        </div>
                            </c:if>
                        <c:if test="${!check}">
                            <div class="alert alert-success" style="width: 100%;"><span>${requestScope.SUCCESS}</span></div>
                            <div style="width: 100%;">
                                <a class="login100-form-btn" href="login.jsp">
                                    Login Your Account
                                    <i class="fa fa-long-arrow-right m-l-5" aria-hidden="true"></i>
                                </a>
                            </div>  
                        </c:if>
                    </form>
                </div>
            </div>
        </div>




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


    </body>

</html>